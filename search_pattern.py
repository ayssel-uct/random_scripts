#this script searches for a specific input patterns (provided in Pattern_in.txt) in a fasta file, and outputs fasta sequences with matching patterns to the output fasta
#!/usr/bin/env python
import sys
import os
from collections import defaultdict
import re

_INPUT_FILE1 = 'Pattern_in.txt'
_INPUT_FILE2 = 'Digitaria.transcripts.wgd.fasta'
_OUTPUT_FILE = 'TEST_Digitaria.fasta'
print (_INPUT_FILE2)
def main():
	p = open(_INPUT_FILE1, 'r') 
	o = open(_OUTPUT_FILE, 'w+')
	
	for line_file1 in p:
		line_file1 = line_file1.replace("\n","") #strip newlines
		line_file1 = line_file1.replace("\r","") #strip carriage returns
		#print(f"1: #{line_file1}#")
		f = open(_INPUT_FILE2, 'r')
		for line_file2 in f:
			#print(f"#{line_file2}#")
			if line_file1 in line_file2:
				#print (f"found {line_file2}")
				o.write(line_file2)
		f.close()
	o.close()
	p.close()
	#f.close()
print ("OK Done")
if __name__ == '__main__':
	main()
