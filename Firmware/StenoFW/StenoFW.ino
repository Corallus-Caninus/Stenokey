/**
   StenoFW is the Stenokey firmware.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

   Copyright 2014 Emanuele Caruso.  See LICENSE.txt for details.
   Portions Copyright 2017, Michael Ady.
   Portions of Gemini encoding Copyright 2011, Joshua Lifton (OpenStenoProject).
   Portions of Procat encoding Copyright 2016, Ted Morin (OpenStenoProject).
*/
#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/multicore.h"

// Stenokey modification log:

// 1.  ROWS and COLS were changed to reflect the physical board layout which
// is 4 rows of 10 keys.
// 2.  rowPins and colPins were modified to reflect the pin assignments
// on the Teensy 2.0 board.
// 3.  In lieu of the function keys on the Stenoboard, the StenoKey has two
// BCD encoded rotary switches.  Switch 1 is used to select the protocol,
// while switch 2 is used to vary the power LED brightness.  These switches
// are wired to an extra "row", to simplify decoding.  The function key
// handling routines were replaced with a single options handling routine.
// 4.  A parenthesis error in the debounce logic was corrected.
// 5.  The NKRO, Gemini and TxBolt protocol functions were simplified.
// 6.  The Procat and Diagnostic protocols were added.

#define ROWS			4
#define COLS			10
//TODO: PIO all rows and the 4 columns that make the irregular matrix (last rows columns)

// Protocols

#define DIAGNOSTIC		0
#define NKRO			1
#define GEMINI			2
#define TXBOLT			3
#define PROCAT			4
#define MAX_PROTOCOL	5				// one more than last protocol

// The following matrix is for reference only.
// It shows which rows and columns the keys are wired to.
// ' ' marks an empty location.

//char keys[ROWS][COLS] = {
//	{'#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},	// upper consonant row
//	{'S', 'T', 'P', 'H', '*', 'F', 'P', 'L', 'T', 'D'},	// middle consonant row
//	{'S', 'K', 'W', 'R', '*', 'R', 'B', 'G', 'S', 'Z'},	// lower consonant row
//	{'A', 'O', ' ', ' ', ' ', 'E', 'U', ' ', ' ', ' '}	// vowel row
//};

// Configuration variables

int rowPins[ROWS] = {10, 11, 12, 13};
int colPins[COLS] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
//int ledPin = 10;
//unsigned long debounceMillis = 20; // TODO: 5
// the time it takes to press and release a chord. used for bounceTrigger detection in chords.
unsigned long debounceMillis = 20;
unsigned long chordInterval = 0;

//maximum number of reads until switch is done bouncing. depends
// on polling rate and switch characteristics (rate of variable capacitance).
//used to detect shunting
unsigned int bounceReadCount = 250; //TODO: this is just a less readable way to say debounceMillis and varies with polling rate (bad)
unsigned int bounceCount = 0; //number of reads during chord
//number of detected key releases in a chord. ensures press and release occures.
unsigned int bounceTrigger = 0;
boolean newReading = false;
// Keyboard state variables

boolean isStrokeInProgress = false;
boolean currentChord[ROWS][COLS]; //this should be maskedKeyReadings and @DEPRECATED
boolean currentKeyReadings[ROWS][COLS];			// key input buffer
boolean maskedKeyReadings[ROWS][COLS];
boolean debouncingKeys[ROWS][COLS]; //@DEPRECATED
unsigned long debouncingMicros[ROWS][COLS]; //@DEPRECATED

// Option states

byte Protocol = 3;
byte Brightness;
byte BrightnessLevels[8] =			// uniform CIE "lightness" levels
{
  0, 5, 14, 33, 64, 109, 172, 255
};

// Function prototypes

void Options();
void sendChord();
void clearBooleanMatrices();
void    checkAlreadyDebouncingKeys();
void    checkNewDebouncingKeys();
boolean recordCurrentKeys();

// This is called when the keyboard is connected

void setup()
{
  // TODO: test changed pinModes
  //  Keyboard.begin();
  Serial.begin(115200);
  chordInterval = millis();

  //  pinMode(ledPin, OUTPUT);
  clearBooleanMatrices();
}

// Read key states and handle all chord events
//TODO: prefer this to overclocking
void loop1(){
  int newReading = readKeys();
  bounceCount += newReading;
}
void loop()
{
  // Handle options switches first

  //Options();

  //TODO: split read addressing
//  int newReading = readLowerKeys();
  //@DEPRECATED
  //TODO this is the wrong way to solve non-shunted strokes
  //  int newRead = 0;
  //  //TODO inline with readKeys
  //  for (int i = 0; i < ROWS; i++) {
  //    for (int j = 0; j < COLS; j++) {
  //      //check for grounding where a false key release is detected
  //      if (currentKeyReadings[i][j] != 0) {
  //        newRead = 1;
  //      }
  //      maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || currentKeyReadings[i][j];
  //    }
  //  }
//  bounceCount += newReading;

  boolean isAnyKeyPressed = true;

  // If stroke is not in progress, check debouncing keys
  //  if (!isStrokeInProgress)
  //  {
  //    checkAlreadyDebouncingKeys();
  //    // TODO: bad logic due to globals
  //    if (!isStrokeInProgress)
  //		checkNewDebouncingKeys();
  //  }

  // If any key was pressed, record all pressed keys
  //TODO: need to read rising and falling edges
  //NOTE: this relies on bouncing to read keys since they ground out without diodes
  //   what is the address limit where bouncing creates interference and keys begin to not be read? at what polling rate? With what probability?
  //whats the minimum number of pins? N rows Y columns: square st N == Y. Can save 2 pins in this project by addressing 6x6.
  //TODO: since we are filtering true positives we can
  //      just mask || along rising and falling edges
  //
  // rising edge is any keypress falling edge is no keys read and more than one reading has been read since rising edge.   //
  //  time between readings = debounce: rising edge is read any keypress falling edge is no keys read and more than one debounce_reading has been read since rising edge.
  //OR
  //CURRENTLY BEST:
  //set limit on reads instead of bounce time. doesnt make too much of a difference
  //1. if > 20-30 readings dont wait for falling edge but still send on falling edge.
  //2. two falling edges detected (release of ground pins)
  // || mask everything between edges then send chord when no keys are pressed and bounce condition is met.
  // CLOSED_LOOP: num_readings vs OPEN_LOOP: micros
  //
  // (observed two states 1. keys always reading 2. bounce on release)
  // | take two readings and || them together halt until 2
  // this also closes the loop on bounce/chord.
  // this is a workaround but will work
  isAnyKeyPressed = recordCurrentKeys();

  //TODO may need to filter maskedKeyReadings as well
  // ensure previous chord has been released
  if (millis() - chordInterval > debounceMillis) {
    isStrokeInProgress = isStrokeInProgress || isAnyKeyPressed;
  }

  //read bounce trigger condition, two edges must trigger: one for press and one for release
  //TODO: this should be a switch but mama didn raise me rite
  // Really this should be a 3 bit shifter but dad went out for smokes
  //    bounceTrigger << !isAnyKeyPressed && isStrokeInProgress;
  //    isStrokeInProgress = (!isAnyKeyPressed && isStrokeInProgress);

  //TODO this is causing bad edges rework the signal is there for this read rate just need to find it
  // chordInterval to prevent bounce on release.
  if (bounceTrigger == 0 && isAnyKeyPressed == 0 && isStrokeInProgress) {
    bounceTrigger = 1;
    isStrokeInProgress = 0;
    //      Serial.println("first edge");
    chordInterval = millis();
  }
  else if (bounceTrigger == 1 && isAnyKeyPressed == 0 && isStrokeInProgress) {
    bounceTrigger = 2;
    isStrokeInProgress = 0;
//          Serial.println("second edge");
  }

  // If all keys have been released, send the chord and reset the global state
  if ((!isAnyKeyPressed && (bounceCount > bounceReadCount)) || (bounceTrigger == 2/*bounce read condition*/))
  {
    //Read one more time for release bounce
//    for (int z = 0; z < bounceReadCount; z++) {
//      readKeys();
//      for (int i = 0; i < ROWS; i++) {
//        for (int j = 0; j < COLS; j++) {
//          maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || currentKeyReadings[i][j];
//        }
//      }
//    }
//    recordCurrentKeys();

    sendChord();
    //reset for next chord
    clearBooleanMatrices();
    bounceCount = 0;
    bounceTrigger = 0;
    //filter chord release bounce
    chordInterval = millis();
  }
}

//this causes lots of writes but should be
//sufficiently fast but look to loop1 logic if necessary
//would prefer to save extra core and pins for next versions features like
//SD card and plover lookup etc.
//Does this need to be done n! times to find which keys are pressed?

//PIO
//assign each PIO a partition of the matrix
void pioConfigKeys(){
  for (int i=0; i < ROWS i+=2){
    for (int j=0; j<COLS; j+=2){
      //config SM with 2 rows and cols
      //config SM with 2 TX FIFOs since ISR is used as a scratch
      // setup DMA (the new currentKeyReadings matrix to be indexed for )
    }
    
  }
}
//TODO: State machines cant change configuration but can use them to read in parallel
//read col and row on two switches with each SM and write to DMA synchronized by IRQs
//NOTE not doing FIFOS since SMs dont produce a word and dedicated core is idle
// all SMs are the same .program with different pin configurations
// TODO: how much faster is this than a fully dedicated bit banging core?
int pioReadKeys(){
  //would prefer to have a specific interrupt between each SM but unrolling enables is simpler
  //TODO |_ do this we have 8 IRQ flags
  //SM reads 4 switches and || their row col readings for true positives then pushes to DMA'd FIFO
  //enable SM 1
  //wait for finish IRQ
  //enable SM 2
  //wait for finish IRQ
  //...
  //enable SM 8
  //wait for finish IRQ
  //end
}
//END OF PIO


//TODO: this improved bounce detection. consider an async read thread
int readKeys() {
  //SETUP:
  //NOTE this is inlined in SM pio
  for (int i = 0; i < ROWS; i++) {
    pinMode(rowPins[i], OUTPUT);
    digitalWrite(rowPins[i], HIGH);
  }
  for (int i = 0; i < COLS; i++)
  {
    pinMode(colPins[i], OUTPUT);
    digitalWrite(colPins[i], HIGH);

  }

  int newRead = 0;
  //LOOP
  for (int j = 0; j < COLS; j++)
  {

    for (int i = 0; i < ROWS; i++) {
      //READ ON COLUMN
      digitalWrite(rowPins[i], LOW);
      pinMode(colPins[j], INPUT_PULLUP);
      currentKeyReadings[i][j] = !digitalRead(colPins[j]);

      //reset to prevent grounding
      pinMode(colPins[j], OUTPUT);
      digitalWrite(colPins[j], HIGH);
      digitalWrite(rowPins[i], HIGH);

      //READ ON ROW
      digitalWrite(colPins[j], LOW);
      pinMode(rowPins[i], INPUT_PULLUP);
      //mask out false positives
      //      currentKeyReadings[i][j] = (currentKeyReadings[i][j] && (!digitalRead(rowPins[i])));
//      if (currentKeyReadings[i][j] != 0) {
//        newRead = 1;
//      }
      newRead = newRead || currentKeyReadings[i][j];
      maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || (currentKeyReadings[i][j] && (!digitalRead(rowPins[i])));
//      if (currentKeyReadings[i][j] != 0){
//Serial.print("i:");Serial.print(i);Serial.print(" ");Serial.print("j:");Serial.println(j);
////      Serial.println(currentKeyReadings[i][j]);
//        }

      //reset to prevent grounding
      pinMode(rowPins[i], OUTPUT);
      digitalWrite(rowPins[i], HIGH);
      digitalWrite(colPins[j], HIGH);
    }
  }

  //  //TODO inline with readKeys
  //  for (int i = 0; i < ROWS; i++) {
  //    for (int j = 0; j < COLS; j++) {
  //      //check for grounding where a false key release is detected
  //      if (currentKeyReadings[i][j] != 0) {
  //        newRead = 1;
  //      }
  //      maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || currentKeyReadings[i][j];
  //    }
  return newRead;

}
int readLowerKeys() {
  //SETUP:
  for (int i = 0; i < ROWS/2; i++) {
    pinMode(rowPins[i], OUTPUT);
    digitalWrite(rowPins[i], HIGH);
  }
  for (int i = 0; i < COLS/2; i++)
  {
    pinMode(colPins[i], OUTPUT);
    digitalWrite(colPins[i], HIGH);

  }

  int newRead = 0;
  //LOOP
  for (int j = 0; j < COLS; j++)
  {

    for (int i = 0; i < ROWS; i++) {
      //READ ON COLUMN
      digitalWrite(rowPins[i], LOW);
      pinMode(colPins[j], INPUT_PULLUP);
      currentKeyReadings[i][j] = !digitalRead(colPins[j]);

      //reset to prevent grounding
      pinMode(colPins[j], OUTPUT);
      digitalWrite(colPins[j], HIGH);
      digitalWrite(rowPins[i], HIGH);

      //READ ON ROW
      digitalWrite(colPins[j], LOW);
      pinMode(rowPins[i], INPUT_PULLUP);
      //mask out false positives
      //      currentKeyReadings[i][j] = (currentKeyReadings[i][j] && (!digitalRead(rowPins[i])));
//      if (currentKeyReadings[i][j] != 0) {
//        newRead = 1;
//      }
      
      newRead = newRead || currentKeyReadings[i][j];
      maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || (currentKeyReadings[i][j] && (!digitalRead(rowPins[i])));

      //reset to prevent grounding
      pinMode(rowPins[i], OUTPUT);
      digitalWrite(rowPins[i], HIGH);
      digitalWrite(colPins[j], HIGH);
    }
  }

  //  //TODO inline with readKeys
  //  for (int i = 0; i < ROWS; i++) {
  //    for (int j = 0; j < COLS; j++) {
  //      //check for grounding where a false key release is detected
  //      if (currentKeyReadings[i][j] != 0) {
  //        newRead = 1;
  //      }
  //      maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || currentKeyReadings[i][j];
  //    }
  return newRead;

}
int readUpperKeys() {
  //SETUP:
  for (int i = ROWS/2; i < ROWS; i++) {
    pinMode(rowPins[i], OUTPUT);
    digitalWrite(rowPins[i], HIGH);
  }
  for (int i = COLS/2; i < COLS; i++)
  {
    pinMode(colPins[i], OUTPUT);
    digitalWrite(colPins[i], HIGH);

  }

  int newRead = 0;
  //LOOP
  for (int j = 0; j < COLS; j++)
  {

    for (int i = 0; i < ROWS; i++) {
      //READ ON COLUMN
      digitalWrite(rowPins[i], LOW);
      pinMode(colPins[j], INPUT_PULLUP);
      currentKeyReadings[i][j] = !digitalRead(colPins[j]);

      //reset to prevent grounding
      pinMode(colPins[j], OUTPUT);
      digitalWrite(colPins[j], HIGH);
      digitalWrite(rowPins[i], HIGH);

      //READ ON ROW
      digitalWrite(colPins[j], LOW);
      pinMode(rowPins[i], INPUT_PULLUP);
      //mask out false positives
      //      currentKeyReadings[i][j] = (currentKeyReadings[i][j] && (!digitalRead(rowPins[i])));
//      if (currentKeyReadings[i][j] != 0) {
//        newRead = 1;
//      }
      newRead = newRead || currentKeyReadings[i][j];
      maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || (currentKeyReadings[i][j] && (!digitalRead(rowPins[i])));

      //reset to prevent grounding
      pinMode(rowPins[i], OUTPUT);
      digitalWrite(rowPins[i], HIGH);
      digitalWrite(colPins[j], HIGH);
    }
  }

  //  //TODO inline with readKeys
  //  for (int i = 0; i < ROWS; i++) {
  //    for (int j = 0; j < COLS; j++) {
  //      //check for grounding where a false key release is detected
  //      if (currentKeyReadings[i][j] != 0) {
  //        newRead = 1;
  //      }
  //      maskedKeyReadings[i][j] = maskedKeyReadings[i][j] || currentKeyReadings[i][j];
  //    }
  return newRead;

}

void bounceRead()
{
  for (int i = 0; i < ROWS; i++)
  {
    for (int j = 0; j < COLS; j++)
    {
      currentChord[i][j] = true;

    }
  }
}
// Check already debouncing keys. If a key debounces, start chord recording.

void checkAlreadyDebouncingKeys()
{
  for (int i = 0; i < ROWS; i++)
  {
    for (int j = 0; j < COLS; j++)
    {
      //if (debouncingKeys[i][j] == true && currentKeyReadings[i][j] == false)
      if (debouncingKeys[i][j] == true && maskedKeyReadings[i][j] == false)
      {
        debouncingKeys[i][j] = false;
        continue;
      }
      if (debouncingKeys[i][j] == true && (micros() - debouncingMicros[i][j]) / 1000 > debounceMillis)
      {
        isStrokeInProgress = true;
        currentChord[i][j] = true;
        return;
      }
    }
  }
}

// If a key is pressed, add it to debouncing keys and record the time

void checkNewDebouncingKeys()
{
  for (int i = 0; i < ROWS; i++)
  {
    for (int j = 0; j < COLS; j++)
    {
      //if (currentKeyReadings[i][j] == true && debouncingKeys[i][j] == false)
      if (maskedKeyReadings[i][j] == true && debouncingKeys[i][j] == false)
      {
        debouncingKeys[i][j] = true;
        debouncingMicros[i][j] = micros();
      }
    }
  }
}

// Record all pressed keys into current chord. Return false if no key is currently pressed

boolean recordCurrentKeys()
{
  //TODO not sending on isAnyKeyPressed condition
  boolean isAnyKeyPressed = false;

  for (int i = 0; i < ROWS; i++)
  {
    for (int j = 0; j < COLS; j++)
    {
      //if (currentKeyReadings[i][j] == true)
      //TODO masked keys is rolled over this doesnt make sense now
      //     maskedKeys should be currentChord since not debouncing now

      if (currentKeyReadings[i][j] == true)
      {
        isAnyKeyPressed = true;
      }
      currentChord[i][j] = maskedKeyReadings[i][j];
    }
  }
  return isAnyKeyPressed;
}

// Set all values of all boolean Matrices to false

void clearBooleanMatrices()
{
  clearBooleanMatrix(currentChord, false);
  clearBooleanMatrix(currentKeyReadings, false);
  clearBooleanMatrix(debouncingKeys, false);
  clearBooleanMatrix(maskedKeyReadings, false);
}

// Set all values of the passed matrix to the given value

void clearBooleanMatrix(boolean booleanMatrix[][COLS], boolean value)
{
  for (int i = 0; i < ROWS; i++)
  {
    for (int j = 0; j < COLS; j++)
    {
      booleanMatrix[i][j] = value;
    }
  }
}

// Diagnostic Protocol

// Each key pressed results in 3 characters being sent, which consists of
// the row number, followed by the column number and a blank.  The chord
// is terminated with a newline.

void sendChordDiagnostic()
{
  int k = 0;							// chord byte index
  char chordBytes[34 * 3 + 1];				// chord buffer

  // Fill in chord buffer

  for (int i = 0; i < ROWS; i++)
    for (int j = 0; j < COLS; j++)
      if (currentChord[i][j])
      {
        chordBytes[k++] = '1' + i;		// row
        if (j == 9)						// column
          chordBytes[k++] = 'A';
        else
          chordBytes[k++] = '1' + j;
        chordBytes[k++] = ' ';
      }
  chordBytes[k - 1] = '\n';				// terminate chord

  // Send the packet

  for (int i = 0; i < k; i++)
    Serial.write(chordBytes[i]);
}

// NKRO Keyboard Emulation

#define ISNUM(x)	((x)>='0'&&(x)<='9')
//
//void sendChordNkro()
//{
//  // US keyboard mapping
//
//  static const char NkroMapping[ROWS][COLS] =
//  {
//    {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'},		// upper row
//    {'q', 'w', 'e', 'r', 't', 'u', 'i', 'o', 'p', '['},		// middle row
//    {'a', 's', 'd', 'f', 'g', 'j', 'k', 'l', ';', '\''},	// lower row
//    {'c', 'v',  0,   0,   0,  'n', 'm',  0,   0,   0}		// vowel row
// };
//
//  int keyCounter = 0;							// chord index
//  char NkroKeys[ROWS * COLS];					// chord buffer
////  int k;										// loop index
//
//  // Calculate NKRO keys array using NkroMapping[][]
//  // Do not include nulls in the chord, to simplify processing below.
//  // Due to a Plover quirk, do not include more than one number key in the chord.
//
//  for (int i = 0; i < ROWS; i++)
//    for (int j = 0; j < COLS; j++)
//      if (currentChord[i][j])
//	  {
////        for (k = 0; k < keyCounter; k++)
////        {
////        	if (ISNUM(NkroKeys[k]) && ISNUM(NkroMapping[i][j]))
////                break;
////        }
////        if (k != keyCounter)
////        	continue;
//        NkroKeys[keyCounter] = NkroMapping[i][j];
//        if(NkroKeys[keyCounter])				// if mapped key
//          keyCounter++;
//      }
//
//  // Emulate keyboard key presses
//  // Because the Arduino USB library adheres to the version 1 USB spec, it
//  // only supports 6KRO.  To get around this, the first character is pressed,
//  // then each subsequent character is pressed and released and finally all
//  // characters are released.  Plover knows to reassemble this sequence into
//  // a single chord.
//
//  for (int i = 0; i < keyCounter; i++)
//  {
//    Keyboard.press(NkroKeys[i]);
//    if(i)
//	  Keyboard.release(NkroKeys[i]);
//  }
//  Keyboard.releaseAll();
//}
//
// Gemini Protocol

// The Gemini protocol sends a packet of 6 bytes.  The first byte
// has its sign bit set, while the remaining bytes do not.

// Following table is from OpenStenoProject.  Entries are in
// msb to lsb order.

// "Fn",  "#1",  "#2", "#3", "#4", "#5",   "#6",
// "S1-", "S2-", "T-", "K-", "P-", "W-",   "H-",
// "R-",  "A-",  "O-", "*1", "*2", "res1", "res2",
// "pwr", "*3",  "*4", "-E", "-U", "-F",   "-R",
// "-P",  "-B",  "-L", "-G", "-T", "-S",   "-D",
// "#7",  "#8",  "#9", "#A", "#B", "#C",   "-Z"

#define GEMINI_BYTES	6

void sendChordGemini()
{
  static const byte GeminiBits[ROWS][COLS] =
  {
    {0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01},
    {0x40, 0x10, 0x04, 0x01, 0x08, 0x02, 0x40, 0x10, 0x04, 0x01},
    {0x40, 0x08, 0x02, 0x40, 0x08, 0x01, 0x20, 0x08, 0x02, 0x01},
    {0x20, 0x10, 0x00, 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00}
  };
  static const byte GeminiBytes[ROWS][COLS] =
  {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 2, 3, 4, 4, 4, 4},
    {1, 1, 1, 2, 2, 3, 4, 4, 4, 5},
    {2, 2, 0, 0, 0, 3, 3, 0, 0, 0}
  };

  // Initialize chord bytes

  byte chordBytes[GEMINI_BYTES] = {0x80, 0x00, 0x00, 0x00, 0x00, 0x00};

  // Calculate Gemini bytes using GeminiBits and GeminiBytes

  for (int i = 0; i < ROWS; i++)
    for (int j = 0; j < COLS; j++)
      if (currentChord[i][j])
        chordBytes[GeminiBytes[i][j]] |= GeminiBits[i][j];

  // Send the packet

  for (int i = 0; i < GEMINI_BYTES; i++)
    Serial.write(chordBytes[i]);
}

// TX Bolt Protocol

// TX Bolt uses a variable length packet. Only those bytes that have active
// keys are sent. The header bits indicate which keys are being sent. They
// must be sent in order.  A zero byte is sent after every packet.

// 00XXXXXX 01XXXXXX 10XXXXXX 110XXXXX
//   HWPKTS   UE*OAR   GLBPRF    #ZDST

#define TXBOLT_BYTES	4

void sendChordTxBolt()
{
  static const byte TxBoltBits[ROWS][COLS] =
  {
    {0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10},
    {0x01, 0x02, 0x08, 0x20, 0x08, 0x01, 0x04, 0x10, 0x01, 0x04},
    {0x01, 0x04, 0x10, 0x01, 0x08, 0x02, 0x08, 0x20, 0x02, 0x08},
    {0x02, 0x04, 0x00, 0x00, 0x00, 0x10, 0x20, 0x00, 0x00, 0x00}
  };
  // TODO: this is redundant typecasting and incorrect?
  // this is not the same as the above
  static const byte TxBoltBytes[ROWS][COLS] =
  {
    {3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
    {0, 0, 0, 0, 1, 2, 2, 2, 3, 3},
    {0, 0, 0, 1, 1, 2, 2, 2, 3, 3},
    {1, 1, 0, 0, 0, 1, 1, 0, 0, 0}
  };

  byte chordBytes[TXBOLT_BYTES] = {0x00, 0x40, 0x80, 0xC0};

  // Calculate TxBolt bytes using TxBoltBits and TxBoltBytes

  for (int i = 0; i < ROWS; i++)
    for (int j = 0; j < COLS; j++)
      if (currentChord[i][j])
        // TODO: what happens if two are in the same index
        chordBytes[TxBoltBytes[i][j]] |= TxBoltBits[i][j];

  // Send the packet

  for (int i = 0; i < TXBOLT_BYTES; i++)
    // check if a row is not supposed to send
    if (chordBytes[i] & 0x3F)
      Serial.write(chordBytes[i]);
  Serial.write((byte)0);						// send terminating byte
}

// Send current chord over serial using the Procat protocol.

// The Procat protocol sends a packet of 4 bytes.  The first three
// bytes are bit encoded.  The first byte has its sign bit cleared.
// The last byte has a value of 0xFF.

// The following table is from the OpenStenoProject.  Entries are in
// msb to lsb order.

// "@",  "#",  "S-", "T-", "K-", "P-", "W-", "H-",
// "R-", "A-", "O-", "*",  "-E", "-U", "-F", "-R",
// "-P", "-B", "-L", "-G", "-T", "-S", "-D", "-Z"

#define PROCAT_BYTES	3

void sendChordProcat()
{
  static const byte ProcatBits[ROWS][COLS] =
  {
    {0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40},
    {0x20, 0x10, 0x04, 0x01, 0x10, 0x02, 0x80, 0x20, 0x08, 0x02},
    {0x20, 0x08, 0x02, 0x80, 0x10, 0x01, 0x40, 0x10, 0x04, 0x01},
    {0x40, 0x20, 0x00, 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00}
  };
  static const byte ProcatBytes[ROWS][COLS] =
  {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 2, 2, 2, 2},
    {0, 0, 0, 1, 1, 1, 2, 2, 2, 2},
    {1, 1, 0, 0, 0, 1, 1, 0, 0, 0}
  };

  // Initialize chord bytes

  byte chordBytes[PROCAT_BYTES] = {0x00, 0x00, 0x00};

  // Calculate Procat bytes using ProcatBits and ProcatBytes

  for (int i = 0; i < ROWS; i++)
    for (int j = 0; j < COLS; j++)
      if (currentChord[i][j])
        chordBytes[ProcatBytes[i][j]] |= ProcatBits[i][j];

  // Send the packet

  for (int i = 0; i < PROCAT_BYTES; i++)
    Serial.write(chordBytes[i]);
  Serial.write(0xFF);
}


// Send the chord using the current protocol.

void sendChord()
{
  sendChordTxBolt();

  //  if (Protocol == NKRO)
  //@DEPRECATED
  ////    sendChordNkro();
  //  if (Protocol == GEMINI)
  //    sendChordGemini();
  //  else if (Protocol == TXBOLT)
  //    sendChordTxBolt();
  //  else if (Protocol == PROCAT)
  //    sendChordProcat();
  //  else
  //    sendChordDiagnostic();				// default
}
/*
  // Blink (turn off the LED) the specified number of times

  // A count of 0 will cause the LED to turn off for a full second.

  void Blink
  (
	byte count							// number of times to blink power LED
  )
  {
	int i;								// loop index

	if(!count)
	{
		analogWrite(ledPin,0);
		delay(1000);
		analogWrite(ledPin,BrightnessLevels[Brightness]);
	}
	else
	{
		for(i=0;i<count;i++)
		{
			delay(250);
			analogWrite(ledPin,0);
			delay(250);
			analogWrite(ledPin,BrightnessLevels[Brightness]);
		}
	}
  }
*/
// Handle the options switches

//void Options()
//{
//	byte switchBytes[COLS];
//	byte switch1;						// protocol (SW35 or SW37)
//	byte switch2;						// brightness (SW36 OR SW38)
//
//	// read the switch values
//
//	digitalWrite(rowPins[4],LOW);
//	for(int i=0;i<COLS;i++)
//		switchBytes[i]=digitalRead(colPins[i])==LOW?1:0;
//	digitalWrite(rowPins[4],HIGH);
//
//	// decode the switch values
//
//	switch1=switchBytes[2]+2*switchBytes[3]+4*switchBytes[4];
//	switch2=switchBytes[7]+2*switchBytes[8]+4*switchBytes[9];
//
//	// update options
//
//	if(switch1<MAX_PROTOCOL)
//		Protocol=switch1;
//	else
//		Protocol=DIAGNOSTIC;			// default protocol
//
//	if(switch2!=Brightness)
//	{
//		Brightness=switch2;
//		analogWrite(ledPin,BrightnessLevels[Brightness]);
//	}
//}
//
//
