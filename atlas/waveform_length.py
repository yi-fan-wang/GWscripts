from pycbc import waveform
from pycbc import conversions as con
mchirp=20
q = 6
m1 = con.mass1_from_mchirp_q(mchirp,q)
m2 = con.mass2_from_mchirp_q(mchirp,q)
t = waveform.get_waveform_filter_length_in_time(approximant='IMRPhenomXPHM', mass1=m1,mass2=m2,f_lower=20)
print(t)
