#!/usr/bin/env python
# -*- coding: utf-8 -*-
import random

guesses=10
secret_number = random.randint(0,100)
guess = -1
while ((secret_number != guess) & (guesses>0)):
    guess = int(raw_input("Enter your guess: "))
    guesses -=1    
    if guess < secret_number:
        print "your guess is low"    
    elif guess > secret_number:    
        print "your guess is high"   
    else:   
        print "you guessed right!"
        secret_number = guess    
if secret_number==guess:
    print "player has won"
else:
    print "player has lost"