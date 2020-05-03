#!/usr/bin/python
import RPi.GPIO as GPIO
import time
import getch

GPIO.setmode(GPIO.BOARD)
GPIO.setwarnings(False)
led = 12
led2 = 18
trig = 7
echo = 11
motor = 13
motor2 =29
trig2 =15
echo2 = 16
GPIO.setup(trig2, GPIO.OUT)
GPIO.setup(echo2, GPIO.IN)
GPIO.setup(trig, GPIO.OUT)
GPIO.setup(echo, GPIO.IN)
GPIO.setup(led, GPIO.OUT)
GPIO.setup(motor, GPIO.OUT)
GPIO.setup(motor2, GPIO.OUT)
GPIO.setup(led2, GPIO.OUT)
print( "here we go!")

GPIO.output(led,True)
GPIO.output(led2, True)
time.sleep(1)
GPIO.output(led,False)
GPIO.output(led2, False)
maxtime = .004
#function takes in sensor number (1 or 2) and calculates distance object is from sensor
def distance(sensNum):
    GPIO.output(led, False)
    GPIO.output(led2,False)
    #for sensor 1
    if sensNum =='1':
        GPIO.output(trig, GPIO.HIGH)
        time.sleep(.00001)
        GPIO.output(trig, GPIO.LOW)
        startTime=time.time()
        #timeout is necessary to prevent from loop stalling
        #in case the pi is busy and misses the trigger pulse coming back
        timeout=maxtime+startTime
        while GPIO.input(echo)==0 and startTime<timeout:
            startTime = time.time()
        endTime = time.time()
        timeout = endTime+maxtime
        while GPIO.input(echo)==1 and endTime<timeout:
            endTime = time.time()
    #sensor 2
    if sensNum=='2':
        GPIO.output(trig2, GPIO.HIGH)
        time.sleep(.00001)
        GPIO.output(trig2, GPIO.LOW)
        startTime=time.time()
        timeout=maxtime+startTime
        while GPIO.input(echo2)==0 and startTime<timeout:
            startTime = time.time()
        endTime = time.time()
        timeout = endTime+maxtime
        while GPIO.input(echo2)==1 and endTime<timeout:
            endTime = time.time()
    elapsedTime= endTime - startTime
    #distance returned in cm
    distance = round(elapsedTime*17150,2)
    return distance
def main():
    count1 = 0

    GPIO.output(trig, GPIO.LOW)
    GPIO.output(trig2, GPIO.LOW)
    time.sleep(2)
    print("Press 'h' to toggle haptic feedback")
    toggle = getch.getch()
    #toggle to simulate user choosing audio or haptic fedback
    if toggle == 'h':
        try:
            while True:

                GPIO.output(led, False)
                GPIO.output(led2,False)
                #distance funciton called for each sensor
                dist1=distance('1')
                dist2=distance('2')
                #if the dist is within detect radius, turn on the motors
                if dist1 > 0 and dist1<=50:
                    GPIO.output(led, True)
                    GPIO.output(motor, True)
                else:
                    GPIO.output(motor, False)
                    GPIO.output(led, False)
                if dist2 > 0 and dist2<=50:
                    GPIO.output(led2, True)
                    GPIO.output(motor2, True)
                else:
                    GPIO.output(motor2, False)
                    GPIO.output(led2, False)

        except KeyboardInterrupt:
            GPIO.cleanup()

    else:
        try:
            while True:
                GPIO.output(led, False)
                GPIO.output(led2,False)
                #GPIO.output(motor, False)
                dist2=distance('2')
                dist1=distance('1')



                if dist1 > 0 and dist1<=50:
                    GPIO.output(led, True)

                else:

                    GPIO.output(led, False)
                if dist2 > 0 and dist2<=50:
                    GPIO.output(led2, True)

                else:

                    GPIO.output(led2, False)

        except KeyboardInterrupt:
            GPIO.cleanup()
    print("exit")
main()
