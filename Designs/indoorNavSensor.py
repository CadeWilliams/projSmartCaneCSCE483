##accelerometer and gyro test
import time
import math
import board
import digitalio
import busio
from adafruit_lsm6ds import LSM6DSOX, Rate
import RPi.GPIO as GPIO
import numpy as np
import getch
#set up i2c connection
i2c = busio.I2C(board.SCL, board.SDA)
sensor = LSM6DSOX(i2c)
def sensorDataProcessing ():
    print("getting data...waiting")

    accelBeginX = sensor.acceleration[0]#initial accel in x-axis
    accelBeginY = sensor.acceleration[1]#initial accel in y-axis
    accelsX = np.array([accelBeginX])#created arrays of accel values
    accelsY = np.array([accelBeginY])
    finalAngle =0# initial orientation is set to 0
    startTime = time.time()
    try:
        #the while loop has the accel arrays constantly updating  with new values
        while True:
            accelsX= np.append(accelsX,sensor.acceleration[0])
            accelsY=np.append(accelsY,sensor.acceleration[1])
            finalAngle = finalAngle + sensor.gyro[2]
    #a keyboard interrupt was used because we didn't have a button available
    except KeyboardInterrupt:
        #once the measurement was stopped, the distance was
        # calculated using average accelerations and elapsed time
        elapsedTime = time.time()-startTime
        avgX = np.mean(accelsX)
        avgY = np.mean(accelsY)
        xDist = avgX*(elapsedTime**2)
        yDist = avgY*(elapsedTime**2)
        radius = math.sqrt(xDist**2 + yDist**2)/100
        #final angle calculated
        finalAngle=finalAngle/elapsedTime
        finalAngle=finalAngle*(180/math.pi)/1000
        #print statements sued to verify readings
        print("----------------------------------------")
        print("*** RADIUS and THETA data to be sent***")
        print("radius length indicating distances travelled: %.4f m"% (radius))
        print("theta in degrees: %.4f degrees" %(finalAngle))
        print("----------------------------------------")
def getAccelData():
    #loop allows user to set more than one anchor
    print("press b to set anchor")
    while True:
        char = getch.getch()

        if char == "b":
            print("setting anchor")
            averages()


        if char =="x":
            break
    print("break")
def main():
    print("press g to start")
    start = getch.getch()
    while start != "g":
        start = getch.getch()
        print("not started")
    if start == "g":
        print("START")
        getAccelData()
    GPIO.cleanup()
main()
