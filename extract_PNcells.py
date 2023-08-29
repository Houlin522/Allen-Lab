#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 29 09:35:09 2023

@author: houlin
"""

import os
import pandas as pd
import shutil
import scipy.io


mat_file_path = '/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_data/manual/D20220826T002151_IFCB151.mat'
data = scipy.io.loadmat(mat_file_path)

dataset = 'CalCOFI_data'
feature_path = f'/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/{dataset}/features_withclass/class2022_v1/'
feature_bins = [f for f in os.listdir(feature_path) if f.startswith('D')]

image_path = '/Users/houlin/Desktop/PN_training/'
dest = '/Users/houlin/Desktop/PN_training/PN_images/'
image_bins = [f for f in os.listdir(image_path) if f.startswith('D')]

# Create DataFrame from classlist (assuming classlist is defined)
classlist = data['classlist']
classtable = pd.DataFrame(classlist, columns=['roi_number', 'class', 'xxx'])

# Filter rows with class 28
pn = classtable[classtable['class'] == 28]

# Using manual classification
for bin_folder in image_bins:
    current = os.path.join(image_path, bin_folder)
    images = [f for f in os.listdir(current) if f.startswith('D')]
    
    pn_roi = pn['roi_number']
    for n in pn_roi:
        ind  = '{:05d}'.format(int(n))
        image_name = f'{bin_folder}_{ind}.png'
        shutil.move(os.path.join(current, image_name), dest)