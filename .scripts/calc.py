from math import *  # noqa: F403
import numpy as np


def mat(*args):
    return np.array(args)


def vec(*args):
    return mat(args)


def sqmat(*args):
    array = None
    if len(args) == 1 and isinstance(args[0], np.ndarray):
        array = args[0]
    else:
        array = np.array(args)
    arr = array.flatten()
    n = len(array)
    if int(n**0.5) ** 2 != n:
        print("please give an array with a square number of elements")
        return
    n = int(n**0.5)
    return arr.reshape(n, n)
