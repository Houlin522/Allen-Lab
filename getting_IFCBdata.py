# -*- coding: utf-8 -*-
"""
Created on Wed Jul 12 09:10:43 2023

@author: houli
"""

import requests
URL = "https://ifcb.caloos.org/timeline?dataset=stearns-wharf&bin=D20220510T142708_IFCB159"
r = requests.get(URL)
print(r.content)