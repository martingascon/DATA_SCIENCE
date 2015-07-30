#!/usr/bin/env python
import random
import numpy as np 
import time
N = 32 #8,16,32
loops = 200000000
nsubsets = [0]*loops
start_time = time.time()
for val in range(loops):
    links = []
    sub = []
    M = 0
    #Chain with N Links numbered 1 through N.
    links = range(1,N+1,1)
    random.shuffle(links)
    while len(links)>0:
        # you draw a random link from a bag
        sub.append(links.pop(0))
        # add one subset
        M = M + 1
        # connect it to any other consecutively-numbered link 
        remove = []
        for a in range(0,len(links)):
            if (links[a]-max(sub) == 1) or (links[a]-min(sub) == -1): 
                remove.append(links[a])
                sub.append(links[a])
	# remove the subset from the bag
        for idx in remove:
            links.remove(idx)
    # save the M value         
    nsubsets[val] = M

print("Mean = %.10f" % np.mean(nsubsets))      
print("STD = %.10f" % np.std(nsubsets, dtype=np.float64)) 
elapsed_time = time.time() - start_time
print elapsed_time      
 

f = open('outN32_100M.txt', 'w')
f.write("Mean = %.10f \n" % np.mean(nsubsets))
f.write("STD = %.10f \n" % np.std(nsubsets, dtype=np.float64))
f.write("ET = %2.0f " % elapsed_time)
f.close()
