import os

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

BASE_PATH = '/home/zubair/Documents/Work/Acads/Semester7/subjects/cogsci/Project/tfinal/'
filename = 'prp.2020-10-04-2055.data.e6d981aa-2324-4971-8bb5-6776eb48e63e.txt'

expdatapath = os.path.join(BASE_PATH, filename)
expdata = pd.read_csv(
        expdatapath,
        header = None,
        sep = ' ',
#        prefix = 'col')
        names = [
            'training',
            'tone',
            'color',
            'difft1',
            'tone_num',
            'color_num',
            'soa',
            'rt1',
            'rt2',
            'status1',
            'status2'
            ])

RT1 = expdata['rt1']
SOA = expdata['soa']
RT2 = expdata['rt2'] + RT1 - SOA

print(RT2)
