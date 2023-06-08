# Two input files must be used, one contains a list of all UMIS from the NT files
#the other all the UMIS from the AA fasta files (generate it using grep ">" *.fasta on individual folders containn AA and NT fasta files)


#Convert the files into lists (really I should turn this into a function) and use less lines of code
File1 = open("/mnt/c/Users/User/Downloads/Run_new_pipeline/Ansie_remove_Amino_Acids/List1_NT_UMIs.txt", "r")
List1 = [(line.strip()).split() for line in File1]
File1.close()
#print(List1)

File2 = open("/mnt/c/Users/User/Downloads/Run_new_pipeline/Ansie_remove_Amino_Acids/List2_amino_acid_UMIs.txt", "r")
List2 = [(line.strip()).split() for line in File2]
File2.close()
#print(List2)

#To make sure that the AA files do not contain extra UMIs that is not in the NT files use all()
#Note to AY: If HXB2 is present in the AA alignmnet it will give an output, modify code so that it does not report on HXB2 
check =  all(item in List1 for item in List2)
if check is True:
   print (" LOOKS OK \n List1 {} contains all elements of List2 {}" .format(File1,File2))#text output is a bit ugly, clean this up
   #print("The list {} contains all elements of the list {}".format(List1, List2))    
else :
   print("No, NOT OK \n List1 {} doesn't have all elements of the List2 {}".format(File1,File2))
  
