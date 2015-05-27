/* Program: CleanCSV
   Author: Jonathan Duff <jonathan@dufffamily>
   Version: 1.0
*/

#include <fstream>
#include <iostream>
#include <string>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

const int LOCATION_IN_FILE = 7;

int main(int argc, char* argv[]) {
  // if nothing is given exit with error:
  if (argc != 2) {
    cout << "\n";
    cout << "USAGE:\n";
    cout << argv[0] << " [file-to-clean]\n";
    cout << endl;
    cout << "Expects to have two columbs like:\n";
    cout << "\"aaa\",\"aa\"";
    cout << endl;
    cout << "If columb " << LOCATION_IN_FILE << " is a \" then don't print\n";
    exit(1);
  }

  string buff;
  ifstream input_file;

  // if successful open:
  input_file.open(argv[1]);

  if (input_file.fail()) {
    cout << "FILE_ERROR!";
  }

  // do while not end of file:
  while(!input_file.eof()) {
    getline(input_file,buff);
    if (buff.length() >= LOCATION_IN_FILE) {
      if (buff.at(LOCATION_IN_FILE) == '\"') {
	// don't print to screen
      }
      else {
	cout << buff << endl;
      }
    }
  }


  input_file.close();
  return 0;
}
