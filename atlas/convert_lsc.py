import h5py
from pycbc.io import FieldArray
from pycbc import transforms
from pycbc.transforms import CartesianToSpherical
import sys
import pycbc.catalog

c = pycbc.catalog.Catalog(source='gwtc-2')

eventname = sys.argv[1]

inputfn = '/work/yifan.wang/3ogcPE/gwtc2/all_posterior_samples/' + eventname + '_comoving.h5'
outputfn = 'lsccomoving-'+eventname+'.hdf'
#outputfn = 'lscposterior-nrsur.hdf'

fp = h5py.File(inputfn, 'r')
samples = fp['PublicationSamples/posterior_samples'][()].view(type=FieldArray)
fp.close()

# convert the cartesian spins to spherical
t1 = CartesianToSpherical('spin_1x', 'spin_1y', 'spin_1z',
                          'spin1_a', 'spin1_azimuthal', 'spin1_polar')
t2 = CartesianToSpherical('spin_2x', 'spin_2y', 'spin_2z',
                          'spin2_a', 'spin2_azimuthal', 'spin2_polar')
samples = transforms.apply_transforms(samples, [t1, t2])
# name map between what's in the lsc file and what we call it
param_map = {
    'mass_1_source' : 'srcmass1',
    'mass_2_source' : 'srcmass2',
    'chi_eff'       : 'chi_eff',
    'chi_p'         : 'chi_p',
    'luminosity_distance':'distance',
    'total_mass_source':'srcmtotal',  
    'chirp_mass_source':'srcmchirp',
    'mass_ratio'    : 'q',
    'spin1_a' : 'spin1_a',
    'spin1_azimuthal': 'spin1_azimuthal',
    'spin1_polar': 'spin1_polar',
    'spin2_a' : 'spin2_a',
    'spin2_azimuthal': 'spin2_azimuthal',
    'spin2_polar': 'spin2_polar',
    'cosmological_quantity_from_redshift(redshift, "comoving_volume")': 'comoving_volume',
    'iota': 'inclination',
    'ra': 'ra',
    'dec': 'dec',
    'geocent_time': 'tc',
    'psi': 'polarization',
    'phase': 'coa_phase',
    'log_likelihood': 'loglikelihood'}


fp = h5py.File(outputfn, 'w')
fp.create_group('samples')

for pin, pout in param_map.items():
    if pin is 'mass_ratio':
	    fp['samples'][pout] = 1./samples[pin]
    else:
	    fp['samples'][pout] = samples[pin]


fp.attrs['trigger_time'] = c[eventname].time
fp.attrs['filetype'] = 'posterior_file'
fp.attrs['static_params'] = []
fp.attrs['variable_params'] = [p for p in fp['samples'].keys()
                               if p != 'network_snr']

fp.close()
