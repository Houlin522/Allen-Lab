#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 12 16:24:33 2023

@author: houlin
"""

from selenium import webdriver
import time
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.common.exceptions import WebDriverException, StaleElementReferenceException
import csv
  
# Create the webdriver object. Here the 
# chromedriver is present in the driver 
# folder of the root directory.


  
# get https://www.geeksforgeeks.org/

  
month=8
months=[8,10,11]
nofeature=[]
location=[]

driver = webdriver.Chrome()
driver.get("https://ifcb.caloos.org/timeline?dataset=calcofi-cruises-underway&bin=D20220824T051120_IFCB151")
while month in months:
    
    driver.implicitly_wait(10)
    
    ifcb_date=''
    ifcb_date=  driver.find_element(by=By.ID, value="bin-header").text
    while ifcb_date=='':
        ifcb_date=  driver.find_element(by=By.ID, value="bin-header").text
    print(ifcb_date)
    if ifcb_date[5]==0:
        month=ifcb_date[6]
    else:
        ifcb_date[5:7] 
    
   
    lat=driver.find_element(by=By.ID, value="stat-lat").text
    lon=driver.find_element(by=By.ID, value="stat-lon").text
    attempt=0
    while lat=='' or lon=='':
        if attempt<100:
            lat=driver.find_element(by=By.ID, value="stat-lat").text
            lon=driver.find_element(by=By.ID, value="stat-lon").text
            attempt+=1
        else:
            break
    
    if lat=='':
        lat=0
    if lon=='':
        lon=0
    
    if location==[]:
        location=[{'filename':ifcb_date,'Lat':float(lat),'Lon':float(lon)}]
    else:
        location.append({'filename':ifcb_date,'Lat':float(lat),'Lon':float(lon)})
    print([lat,lon])
    
    # Obtain button by link text and click.
    # adc = driver.find_element(By.LINK_TEXT,"ADC")
    # hdr=driver.find_element(By.LINK_TEXT,"HDR")
    # roi=driver.find_element(By.LINK_TEXT,"ROI")
    # adc.click()
    # hdr.click()
    # roi.click()
    
    # try:
    #     features=driver.find_element(By.LINK_TEXT,"features")
    #     features.click()
    # except:
    #     nofeature.append(str(ifcb_date))
    #     print("feature file doesn't exist")
    
   
    while True:
        try:    
            nextbin=driver.find_element(By.ID,"next-bin")
            nextbin.click()
        except(WebDriverException,StaleElementReferenceException):
            print('Nextbin no longer clickable')
            break
        
# dirction of the file    

csv_file = '/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/CalCOFI_underway_location.csv'

#csv_file ="/Users/houli/OneDrive - UC San Diego/IFCB_data/CalCOFI_underway/CalCOFI_underway_location.csv"
field_names = ['filename', 'Lat', 'Lon']
# Write the data to the CSV file
with open(csv_file, mode='w', newline='') as file:
    writer = csv.DictWriter(file, fieldnames=field_names)

    # Write the header
    writer.writeheader()

    # Write the data
    writer.writerows(location)

print(f'{csv_file} created successfully.')
