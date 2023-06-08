import re

import easygui
# This python script chops various amino _acid sequences into k_mers of different lengths
##Below you can declare the protein name and add the sequence between " "


#function cut_Kmers accepts a string and two integers as input and then cuts the string into Kmers that are the size of the first integer
#second integer is used as an index to indicate which protein is being cut
#output is writen to a file
#output is written in fasta format to make it easier to submit to CAMP website for evaluation
def cut_Kmers(outfile,x, y, prot_name ):
	length = len(x)
	for j in range(length):
		word=(x[j:j+y])
		if len(word) == y:
			outfile.write(">" + prot_name + "." + str(y) + "." + str(j+1) + "\n" + word +"\n")
#this function scans the k_mer file for duplicates and remove duplicated entris (and renames the remaining version of duplicated entries)
#def remove_duplicates()			

#Here you can add more cals to the function  cut_Kmers if you declared more proteins in the top of the program	
def main():
	
	f=easygui.fileopenbox()
	out_file=open("k_mers.fasta","w+")
	
	###here I have to read in the lines in the file, I have to convert all the charactters inbetween the first line of a fasta file and the next line of a  fasta file into a log string or something
	##then I have to cut each string into kmers of different legnths....car I work in arrays with super long strings? or Matrixes that contains [protein name, long string of amino acids]
	#kmer_size = [10,11,12,13,14,15,16,17,18,19,20,21,21,23,24,25,26,27,28,29,30]
	
	name=""
	with open(f) as in_file:	
		kmer_size=[9]	
		for line in in_file:
			if ">" in line:
				name = line[1:11]
			else:
				for i in range(len(kmer_size)):
					cut_Kmers(out_file,line,kmer_size[i],name)
					#i+=1
	out_file.close()
	
main()


