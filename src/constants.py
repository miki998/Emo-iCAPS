"""
Copyright © 2023 Chun Hei Michael Chan, MIPLab EPFL
"""

import os
import csv
import glob
import pickle

import mat73
import hdf5storage
from tqdm import tqdm
from scipy.io import loadmat
from scipy.stats import zscore

import numpy as np
import nibabel as nib
from nilearn import plotting

from copy import deepcopy
import matplotlib.pyplot as plt



PALETTES      = ['PuOr', 'hsv', 'hsv', 'Spectral']
TR            = 1.3 # seconds
FILM2DURATION = {'AfterTheRain': 496, 
                 'BetweenViewing': 808,
                 'BigBuckBunny': 490, 
                 'Chatter': 405, 
                 'FirstBite': 599, 
                 'LessonLearned': 667, 
                 'Payload': 1008, 
                 'Sintel': 722, 
                 'Spaceman': 805, 
                 'Superhero': 1028, 
                 'TearsOfSteel': 588, 
                 'TheSecretNumber': 784, 
                 'ToClaireFromSonny': 402, 
                 'YouAgain': 798}

ANNOT_TR_FILM = {'Rest': 460,
                 'ToClaireFromSonny': 464, 
                 'Chatter': 467, 
                 'BigBuckBunny': 536,
                 'AfterTheRain': 555,
                 'TearsOfSteel': 608,
                 'FirstBite': 615,
                 'LessonLearned': 668,
                 'Sintel': 710,
                 'TheSecretNumber': 744,
                 'YouAgain': 759,
                 'Spaceman': 771,
                 'BetweenViewing': 777,
                 'Payload': 930,
                 'Superhero': 946
                 }

# trim the washimg time for movies before and after
WASH  = 93.9/ TR # duration in seconds for wash is 93.9 sec
ONSET = 6 / TR # duration of onset is assumed to be 6 sec

### saving and loading made-easy
def save(pickle_file, array):
    """
    Pickle array
    """
    with open(pickle_file, 'wb') as handle:
        pickle.dump(array, handle, protocol=pickle.HIGHEST_PROTOCOL)
def load(pickle_file):
    """
    Loading pickled array
    """
    with open(pickle_file, 'rb') as handle:
        b = pickle.load(handle)
    return b

onset_dur = load('./data/run_onsets.pkl')
