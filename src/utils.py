"""
Copyright © 2023 Chun Hei Michael Chan, MIPLab EPFL
"""

import cv2
import random
import numpy as np
import pandas as pd
import seaborn as sns
from scipy import stats
import matplotlib.pyplot as plt

from tqdm.auto import tqdm


from src.constants import *

########################################################### 
###################  JUPYTER-NOTEBOOK  ####################
###########################################################
# https://stackoverflow.com/questions/31517194/how-to-hide-one-specific-cell-input-or-output-in-ipython-notebook
from IPython.display import HTML

def hide(for_next=False):
    """
    Hide Cell in jupyter notebooks both in local and downloaded/github rendered version
    """
    
    this_cell = """$('div.cell.code_cell.rendered.selected')"""
    next_cell = this_cell + '.next()'

    toggle_text = 'Toggle show/hide'  # text shown on toggle link
    target_cell = this_cell  # target cell to control with toggle
    js_hide_current = ''  # bit of JS to permanently hide code in current cell (only when toggling next cell)

    if for_next:
        target_cell = next_cell
        toggle_text += ' next cell'
        js_hide_current = this_cell + '.find("div.input").hide();'

    js_f_name = 'code_toggle_{}'.format(str(random.randint(1,2**64)))

    html = """
        <script>
            function {f_name}() {{
                {cell_selector}.find('div.input').toggle();
            }}

            {js_hide_current}
        </script>

        <a href="javascript:{f_name}()">{toggle_text}</a>
    """.format(
        f_name=js_f_name,
        cell_selector=target_cell,
        js_hide_current=js_hide_current, 
        toggle_text=toggle_text
    )

    return HTML(html)


###################################################### 
###################  SIG -- PROC  ####################
######################################################


### NI-EDU - copied code "GLM inference"
def design_variance(X, which_predictor=1):
    ''' Returns the design variance of a predictor (or contrast) in X.
    
    Parameters
    ----------
    X : numpy array
        Array of shape (N, P)
    which_predictor : int or list/array
        The index of the predictor you want the design var from.
        Note that 0 refers to the intercept!
        Alternatively, "which_predictor" can be a contrast-vector
        (which will be discussed later this lab).
        
    Returns
    -------
    des_var : float
        Design variance of the specified predictor/contrast from X.
    '''
    
    is_single = isinstance(which_predictor, int)
    if is_single:
        idx = which_predictor
    else:
        idx = np.array(which_predictor) != 0
    
    c = np.zeros(X.shape[1])
    c[idx] = 1 if is_single == 1 else which_predictor[idx]
    des_var = c.dot(np.linalg.inv(X.T.dot(X))).dot(c.T)
    return des_var

def local_average(signal,ks):
    """
    Information:
    ------------
    Compute local average per timepoint

    Parameters
    ----------
    signal  ::[1darray<float>]
    
    ks      ::[int]
        Kernel size for averaging


    Returns
    -------
    res  ::[1darray<float>]
        locally averaged signal
    """

    size = len(signal)
    res  = np.zeros((size // ks+1))
    for idx,k in enumerate(range(0,len(signal), ks)):
        res[idx] = signal[k:k+ks].mean()
    return res


from sklearn.preprocessing import PowerTransformer
from sklearn.preprocessing import QuantileTransformer
def map2normal(signal):
    """
    Information:
    ------------
    Map to a normal distribution the current distribution

    Parameters
    ----------
    signal  ::[1darray<float>]

    Returns
    -------
    reshaped::[1darray<float>]
    """
    
    bc = PowerTransformer(method="yeo-johnson")
    tmp = np.asarray(signal).flatten()
    tmp_rescaled = bc.fit_transform(tmp.reshape(-1,1))
    reshaped = tmp_rescaled.reshape(np.asarray(signal).shape)
    return reshaped


def sscore(signal):
    """
    Information:
    ------------
    Shift and Scale signal

    Parameters
    ----------
    signal::[ndarray<float>]
        Signal shift and scale

    Returns
    -------
    score::[ndarray<float>]
    """    
    signal = (signal - signal.min())
    score  = signal / signal.max()
    return score

def zscore(signal, ret_param=False):
    """
    Information:
    ------------
    Remove mean and normalize by standard deviation on any array size

    Parameters
    ----------
    signal    ::[ndarray<float>]
        Signal remove mean and normalize

    ret_params::[Bool]
        Whether we return the mean and standard deviation of original signal
    Returns
    -------
    score::[ndarray<float>]
    """    
    m, s  = signal.mean(), signal.std()
    score = (signal - m) / s
    if ret_param:
        return score, m, s
    return score


def overlap_add(signal, wsize=3, pad=False):
    """
    Information:
    ------------
    Smoothen a signal by adding to part of itself to other intervals

    Parameters
    ----------
    signal::[1darray<float>]
        Signal to do rolling average on 

    ws    ::[int]
        Window size to do rolling average on

    pad   ::[Bool]
        If true then pad the boundaries to return an array of same size as input
        If false then leave boundaries not computed

    Returns
    -------
    overlapped::[1darray<float>]
    """

    if pad:
        overlapped = np.concatenate([np.convolve(signal, np.ones(wsize)/wsize, mode='valid'),signal[-(wsize-1):]])
    else:
        overlapped = np.convolve(signal, np.ones(wsize)/wsize, mode='valid')
    return overlapped

def low_pass(signal, ks=10):
    """
    Information:
    ------------
    Smoothen a signal by adding to part of itself to other intervals

    Parameters
    ----------
    signal::[1darray<float>]
        Signal to do local average / smooth on 
        
    ks    ::[int]
        Kernel size

    Returns
    -------
    convolved::[1darray<float>]
    """    
    convolved = np.convolve(signal, np.ones(ks)/ks, 'same')
    return convolved


###################################################### 
################### VISUALISATION ####################
######################################################

def plot_spectrum(sig, sampling_rate=1/TR, ls=0, rs=1):
    """
    Information:
    ------------
    Plot power spectrum of a signal

    Parameters
    ----------
    sig           ::[1darray<float>]
    sampling_rate ::[int]

    Returns
    -------
    None::[None]
    """    
    fourier_transform = np.fft.rfft(sig)
    abs_fourier_transform = np.abs(fourier_transform)
    power_spectrum = np.square(abs_fourier_transform)

    frequency = np.linspace(0, sampling_rate/2, len(power_spectrum))

    plt.plot(frequency, power_spectrum, label='spectre')
    plt.legend()
    plt.xlabel('Freq')
    plt.title("Power spectrum")
    plt.xlim(ls,rs)
    plt.show()


def compare_videos(arr1, arr2):
    """
    Information:
    ------------
    Read our formatted dataframes to obtain timeseries 
    in (time,voxels) format of a specific acquisition

    Parameters
    ----------
    arr1::[4darray<uint8>]
        First Stream of images (to be concatenated in the left side)
    
    arr2::[4darray<uint8>]
        Second Stream of images (to be concatenated in the right side)

    Returns
    -------
    concat::[4darray<uint8>]
        Stream of images that were concatenated horizontally together
    """
        
    arr1 = np.asarray(arr1)
    arr2 = np.asarray(arr2)

    # same number of timepoints: we take the minimum
    t_min = min(arr1.shape[0], arr2.shape[0])
    # put a vertical separator of arbitrary color
    spacer = 255 * np.ones((t_min,arr1.shape[1], 50,3), dtype=np.uint8)
    concat = np.concatenate([arr1[:t_min],spacer,arr2[:t_min]],axis=2)

    return concat

###################################################### 
################### OS-LEVEL FUNC ####################
######################################################

def loadimg_in_order(unordered_img):
    """
    Information:
    ------------
    Specifically working for our format of TYPE_FRAMENUMBER.jpg files
    we extract the numbers to reorder them in increasing order.

    Parameters
    ----------
    unordered_img::[list<string>]
        list of unordered filenames (of images) in the format shown above
        very specific to our use case

    Returns
    -------
    ordered_img::[list<string>]
        ordered filenames (of images)
    """


    numbers      = [int(r.strip('.jpg').split('_')[1]) for r in unordered_img]
    sorted_index = np.argsort(numbers)
    ordered_img  = np.array(unordered_img)[sorted_index]

    return ordered_img
    
def video2img(video_path, start_idx, end_idx):
    """
    Information:
    ------------
    Convert mp4 video into stream of numpy arrays

    Parameters
    ----------
    video_path::[string]
        Path to the video to read

    start_idx ::[int]
        frame of the video to start reading from

    end_idx   ::[int]
        frame of the video to stop reading at

    Returns
    -------
    frames::[4darray<uint8>]
        Stream of images (most of times RGB) that we obtain from reading the video
    """        
    frames = []

    # Create a VideoCapture object and read from input file
    # If the input is the camera, pass 0 instead of the video file name
    cap            = cv2.VideoCapture(video_path)
    total_nb_frame = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))    
    fps            = cap.get(cv2.CAP_PROP_FPS)

    print("Display FPS is: {}".format(fps))
    # Check if camera opened successfully
    if (cap.isOpened()== False):
        print("Error opening video stream or file")

    # Set to last frames if -1 is encodeds
    if end_idx == -1:
        end_idx = total_nb_frame

    for frame_id in range(start_idx,end_idx):
        # Capture frame-by-frame
        cap.set(cv2.CAP_PROP_POS_FRAMES, frame_id)
        ret, frame = cap.read()
        if ret == True:
            frames.append(frame)

    # When everything done, release the video capture object
    cap.release()

    frames = np.asarray(frames)
    return frames


def img2video(img_array, fps, outpath_name="out.mp4"):
    """
    Information:
    ------------
    Convert a stream of RGB images into mp4 video

    Parameters
    ----------
    img_array   ::[4darray<uint8>]
        Stream of images (most of times RGB) that we want to link as a video
    
    fps         ::[int]
        Encoding/Displaying fps
    
    outpath_name::[string]
        Path and name of the video file to output

    Returns
    -------
    None::[None]
    """    
    height, width, layers = img_array[0].shape
    size = (width,height)

    out = cv2.VideoWriter(outpath_name,cv2.VideoWriter_fourcc(*'MP4V'), fps, size)
    
    for i in range(len(img_array)):
        out.write(img_array[i])
    out.release()


###################################################### 
################### TEXT RENDERING ###################
######################################################
