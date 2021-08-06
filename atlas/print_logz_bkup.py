import numpy as np
from pycbc.inference import io
import glob
fname = glob.glob('*.hdf.bkup')
print(fname)
fp = io.loadfile(fname[0],'r')
sampler = fp.read_pickled_data_from_checkpoint_file()
res = sampler.results
print('logzerr is:', res.logzerr[-10:])
print('np.diff logz:', np.diff(res['logz'])[-10:])
