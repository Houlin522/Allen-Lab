#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul 27 11:19:11 2023

@author: houlin
"""


from selenium import webdriver
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pandas as pd


filenames = pd.read_csv("/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/missingvalues_aug.csv")
  
print('totalmissingfiles :'+str(len(filenames)))
driver = webdriver.Chrome()

namelist=filenames.filename.tolist()
typelist=filenames.type.tolist()

nofeature=['D20220826T040648', 'D20220827T142315', 'D20220827T144931', 'D20220828T100058', 'D20220828T133603', 'D20220828T142834', 'D20220829T042213', 'D20220829T054334', 'D20220829T060948', 'D20220829T165702', 'D20220829T184204']
for i in range(len(filenames)):
    filename=namelist[i]
    if filename not in nofeature:
        print(filename)
        
        filetypes=typelist[i].split('.')
        driver.get("https://ifcb.caloos.org/timeline?dataset=calcofi-cruises-underway&bin="+str(filename)+"_IFCB151")
        
        adc=driver.find_element(By.LINK_TEXT,"ADC")
        hdr=driver.find_element(By.LINK_TEXT,"HDR")
        roi=driver.find_element(By.LINK_TEXT,"ROI")
        
        
        if 'adc' not in filetypes:
            adc.click()
            print('ADC download')
        elif 'hdr' not in filetypes:
            hdr.click()
            print('HDR download')
        elif 'roi' not in filetypes:
            roi.click()
            print('ROI download')
            
        elif 'csv' not in filetypes:
            try: 
                features=driver.find_element(By.LINK_TEXT,"features")
                features.click()
                print('Features download')
            except:
                nofeature.append(filename)
                print("feature file doesn't exist")
            
        
    print('next')
    



        
    
    