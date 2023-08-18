"""
Copyright © 2023 Chun Hei Michael Chan, MIPLab EPFL
"""


from src.utils import *

###################################################### 
################### FUNC-CONNECTIV ###################
######################################################

def null_score(null_distrib, sample):
    """
    Information:
    ------------
    Give the p-value of estimated value against a null distribution

    Parameters
    ----------
    null_distrib::[1darray<float>]
    sample      ::[float]


    Returns
    -------
    score::[float]
        p-value
    """

    # single tail
    # flip if we care about the left tail
    # score = np.mean(null_distrib < sample) 
    score = np.mean(null_distrib > sample)
    
    return score
