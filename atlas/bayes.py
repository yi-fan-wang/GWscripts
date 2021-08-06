import sys
filename = sys.argv[1]

import h5py
import numpy as np
f = h5py.File(filename,'r')

def evidence(f):
	return f.attrs['log_evidence'] - f['samples'].attrs['lognl']	

print(evidence(f))
