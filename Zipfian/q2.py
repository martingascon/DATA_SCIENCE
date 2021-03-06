#! python

def freq(c):
    count = [[x,c.count(x)] for x in set(c)]
    return count 

f = open('textq2.txt')
words, uwords, sentences = 0, 0, 0    # set counters to 0

text = f.read()     # read the file

words = len(text.split(' '))          #count words
sentences = len(text.split('.')) -1   #count sentences

noperiod = text.replace('.','')
twop =  noperiod.split(' ')
uwords= len(freq(twop))			#count unique words

print "Total word count: ", words
print "Unique words: ", uwords
print "Sentences  : ", sentences

#1. The ability to calculate the average sentence length in words
print "Average sentence lengt: ", float(words/sentences), " words"

#2. The ability to find often used phrases (a phrase of 3 or more words used over 3 times)
# that would take me more time 


#3. A list of words used, in order of descending frequency
print "words used, in order of descending frequency"
print sorted(freq(twop), key=lambda twop_entry: twop_entry[1], reverse=True )
 
#4. The ability to accept input from STDIN, or from a file specified on the command line.
# almost did it.



