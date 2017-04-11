import mdtraj as md
import sys

dtau = 0.4 # timestep for VACF
selection = 'residue 399 and name NT'

traj = md.load_netcdf('ref_traj.mdcrd', top='../common/2agy_final_min.prmtop', stride=2)
dt = traj.timestep
dframes = round(dtau/dt)
if dframes < 1:
    sys.exit()
else:
    print('dt: {0}, dtau: {1}, dframes: {2}'.format(dt, dtau, dframes))

