#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 12 13:59:12 2023

@author: houlin
Download IFCB data from the IFCB dashboard 
"""

import requests
from bs4 import BeautifulSoup

# Function to download a file from a given URL

def download_file(url, save_path):
    response = requests.get(url)
    with open(save_path, 'wb') as file:
        file.write(response.content)

# Function to get the URL of the next page
def get_next_page_url(url):
    response = requests.get(url)

    soup = BeautifulSoup(response.content, 'html.parser')
    
    # Find the next button and extract the URL
    next_button = soup.find('a', text='Next Bin')
    if next_button:
        return next_button['href']
    else:
        return None

# Main function
def main():
    # Initial URL
    location='stearns-wharf'
    initial_url = 'https://ifcb.caloos.org/timeline?dataset=stearns-wharf&bin=D20220630T001436_IFCB159'

    # Start flipping pages
    current_url = initial_url
    month='06'
    
    while month == '06':
        length = len(current_url)
        index= current_url[length - 24:]
        month=index[5:7]
        
        adc='https://ifcb.caloos.org/'+location+'/'+index+'.adc'
        hdr='https://ifcb.caloos.org/'+location+'/'+index+'.hdr'
        roi='https://ifcb.caloos.org/'+location+'/'+index+'.roi'
        features='https://ifcb.caloos.org/'+location+'/'+index+'_features.csv'
        
        file_urls=[adc,hdr,roi,features]
        
        for file_url in file_urls:
        # Get the URL of the next page
            file_name = file_url.split('/')[-1] 
            file_path = f'/Users/houlin/Downloads/{file_name}'  # Path to save the file
            download_file(file_url, file_path)
            print(f'Downloaded: {file_name}')
        
        current_url = get_next_page_url(current_url)
        print(current_url)
        
        # Decrement the number of pages to flip



if __name__ == '__main__':
    main()



# Function to scrape and download files from a webpage
# def scrape_and_download(url):
#     response = requests.get(url)
#     soup = BeautifulSoup(response.content, 'html.parser')

#     # Extract links from the webpage
#     links = soup.find_all('a')

#     # Display the available files
#     print("Available files:")
#     for i, link in enumerate(links):
#         file_url = link.get('href')
#         if file_url:
#             print(f"{i+1}. {file_url}")
#     file_to_download=['adc','hdr','roi','features']

#     # Download the selected files
#     for i in range(len(links)):
#         link = links[i]
#         file_url = link.get('href')
        
#         if file_url:
#             if [x for x in file_to_download if(x in file_url)]:
#                 file_name = file_url.split('/')[-1]  # Extract the filename from the URL
#                 file_path = f'downloads/{file_name}'  # Path to save the file
#                 download_file(file_url, file_path)
#                 print(f'Downloaded: {file_name}')


