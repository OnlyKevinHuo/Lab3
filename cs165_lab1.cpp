/* Lab1 written by TEAM13 Kevin Huo and Elise Lin */

#include "hashlib2plus/trunk/src/hashlibpp.h"
// #include <codecvt>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <thread>
#include <iostream>
#include <sstream>
using namespace std;

const string ascii64 = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

string checkBytes(string input){
	std::ostringstream os;
        
        for(int i=0; i<16; ++i)
	{
		/*
		 * set the width to 2
		 */
		os.width(2);

		/*
		 * fill with 0
		 */
		os.fill('0');

		/*
		 * conv to hex
		 */
		os << std::hex << static_cast<unsigned int>((unsigned char)(input[i]));
	}
	return os.str();
}

// Converts to base64 human-readable character
string to64(int v, int n) {
	string convChar;
	int blah = 0; 
	
	while(--n >= 0) {
		convChar += ascii64.at(v & 0x3f); // reserves most left's 2 bits for some shiet
		v >>= 6;
	}	
	return convChar;
}

string to64_single(string input, int uno) {
	int v = (int)(input.at(uno));
	return to64(v, 2);
}

// Extracts pattern from 4 bits
string to64_triplet(string input, int uno, int dos, int tres) {
	// Convert input type from char to int for bit shift processing feasibility
	int v = ((int)(input.at(uno)) << 16 | 
				(int)(input.at(dos)) << 8 | 
				(int)(input.at(tres)) ); // send last triplet bc it has first four bits of pattern
	return to64(v, 4);
}

int main () {
	/*1. Read the hash from /etc/shadow, extract the salt*/
	string algorithm = "1";
	string salt = "hfT7jp2q";
	string hash = "KqcshpOfHc7VFTtiIZHPe1";

	hashwrapper *myWrapper = new md5wrapper();

	// 2. Run the algorithm(initalization, loop, finalization) on this salt and the candidate password 
    //	a. INIT: Generate a simple md5 hash based on the salt and password
	//	    i. Let “password” be the user’s ascii password, “salt” the ascii salt (truncated to 8 chars), and “magic” the string 
	//	    ii. Start by computing the Alternate sum, md5(password + salt + password)
			string password = "zhgnnd";
			string intermediate = password+"$1$"+salt;
			string alternateSum = myWrapper->getHashFromString(password + salt + password);
			
			cout << endl;
			cout << "Intermediate initially pw+$1$+salt: " << intermediate << endl << endl;
			cout << "Alternate Sum MD5(pw+salt+pw) HEX: " << alternateSum << endl;
			cout << "Human Readable Format of Alternate Sum: " << checkBytes(alternateSum) << endl << endl;

	/*		iii. Compute the Intermediate0 sum by hashing the concatenation of the following strings:
			 Password + Magic + Salt + length(password) bytes of the Alternate sum, repeated as necessary*/			 
			int pl = password.length();
			// Append 6 bytes of Alternate sum (alternateSum)
			for(int i = 0; i < pl; i++){
				intermediate += alternateSum.at(i);
			}
			/* For each bit in length(password), from low to high and stopping after the most significant set bit */
			// for(int i = password.length(); i != 0; i >> 1) {
			int i = password.length();
			while(i != 0) {
				// If the bit is set, append a NUL byte
				if (i & 1) {
					intermediate += '\0';
				}
				// If it’s unset, append the first byte of the password 
				else {
					intermediate += password.at(0);
				}

				i = i/2;
			}
			/* Hashing concatenation */
			intermediate = myWrapper->getHashFromString(intermediate);
			cout << "Intermediate0 hashed: " << intermediate << endl;
			cout << "Human Readable Format of Intermediate0: " << checkBytes(intermediate) << endl << endl;
			

/*		b. Loop 1000 times, calculating a new md5 hash based on the previous hash concatenated with alternatingly the password and the salt.
			i. For i = 0 to 999 (inclusive), compute Intermediatei+1 by concatenating and hashing the following:
			    If i is even, Intermediatei
			    If i is odd, password
			    If i is not divisible by 3, salt
			    If i is not divisible by 7, password
			    If i is even, password
			    If i is odd, Intermediatei */

			for( int i = 0; i < 1000; i++) {
				alternateSum = "";
				if (i & 1) {
					alternateSum += password;
				} else {
					alternateSum = intermediate;
				}

				if (i%3) {
					alternateSum += salt;
				}

				if (i%7) {
					alternateSum += password;
				}

				if(i & 1) {
					alternateSum += intermediate;
				} else {
					alternateSum += password;
				}

				intermediate = myWrapper->getHashFromString(alternateSum);
			}

			cout << "CTX after 1000 loop: " << intermediate << endl;
			cout << "Human Readable Format of CTX after 1000: " << checkBytes(intermediate) << endl << endl;

			// At this point you don’t need Intermediatei anymore. 
/*		c. Use a special base64 encoding on the final hash to create the password hash string
			//i. Output the magic
			//ii. Output the salt
			//iii. Output a “$” to separate the salt from the encrypted section
			//iv. Pick out the 16 bytes in this order: 11 4 10 5 3 9 15 2 8 14 1 7 13 0 6 12.
				//     For each group of 6 bits (there are 22 groups), starting with the least significant
	    		   			Output the corresponding base64 character with this index */

			// @Kevin, I don't think we need to reorder the bytes anymore because the triplet function will take care of it
			// intermediate = reorderBytes(intermediate); 
			string finalHash = "$1$" + salt + "$";
			finalHash += to64_triplet(intermediate, 0, 6, 12) + to64_triplet(intermediate, 1, 7, 13) + to64_triplet(intermediate, 2, 8, 14) + to64_triplet(intermediate, 3, 9, 15) + to64_triplet(intermediate, 4, 10, 5) + to64_single(intermediate, 11);

			cout << "THE FINAL HASHHHHH: " << finalHash << endl;

	delete myWrapper;
	myWrapper = NULL;

	return 0;
}
