import math
import numpy as np

PI = math.pi
E = math.e

degrees = False
to_rad = lambda a: a if not degrees else math.radians(a)
from_rad = lambda a: a if not degrees else math.degrees(a)
sin = lambda a: math.sin(to_rad(a))
cos = lambda a: math.cos(to_rad(a))
tan = lambda a: math.tan(to_rad(a))
asin = lambda a: from_rad(math.asin(a))
acos = lambda a: from_rad(math.acos(a))
atan = lambda a: from_rad(math.atan(a))
def deg():
    global degrees
    degrees = True

def rad(): 
    global degrees
    degrees = False

mat = np.array

def square(array):
    arr = array.flatten()
    n = len(array)
    if int(n ** 0.5)**2 != n:
        print("please give an array with a square number of elements")
        return
    n = int(n**.5)
    return arr.reshape(n,n)


