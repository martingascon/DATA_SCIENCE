#! python
def freq(c):
    return [[x,c.count(x)] for x in set(c)]

def perc(f,c):
    return 100*float(f)/float(len(c))

def printline(l,f):
    print "Position:",l,"(",
    for k in range(0,len(f)):
	print "%c:%0.1f" % (f[k][0],perc(f[k][1],c)),
    print ")"

fi = open('textq1.txt')
a = [] 
c = []
l =[] 

for line in fi:
	a.append(list(line))  
	l.append(len(line)) 

for i in range(max(l)-1):
	c=[]
	for row in range(0,len(a)):
		if i<len(a[row])-1:		
			c.append(a[row][i])
	printline(i,freq(c))









