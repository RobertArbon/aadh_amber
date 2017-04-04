import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import mdtraj as md

def add_beta(df):
    traj = md.load('2agy_solvated_min-step-2.pdb')
    table, bonds = traj.topology.to_dataframe()
    df = df.ix[:, ['Index', 'diff']]
    df['Index'] = df['Index'].astype(int)
    df = pd.merge(table, df, left_on='serial', right_on='Index')
    traj.save_pdb('force_diff.pdb', bfactors=np.array(df['diff']))
    return(df)

def load_data(fname):
    with open(fname) as fh:
        lines = fh.readlines()
        for i in range(100):
            if lines[i].startswith('  ENER'):
                energy = lines[i].split()[1].replace('D', 'E')
                energy = float(energy)
            if lines[i].startswith('FORCE'):
                fidx = i
                break
        df = []
        for line in lines[fidx+1:]:
            df.append([val.replace('D', 'E') for val in line.split()])

        df = pd.DataFrame(data=np.array(df), columns=['Index', 'Fx', 'Fy', 'Fz'], dtype='float')
        df['value'] = np.sqrt(df['Fx']**2 + df['Fy']**2 + df['Fz']**2)
        # df = pd.melt(df, id_vars=['Index'])
    return df, energy


df1, energy1 = load_data('charmm_gold_c42a1')
df2, energy2 = load_data('charmm_gold')

df = pd.merge(left=df1, right=df2, on=['Index'])
df['diff'] = np.abs((df['value_x'] - df['value_y']))
df.sort_values(by='diff', inplace=True, ascending=False)
print('Top 10 atomic force differences')
print(df[['Index', 'diff']].head(10))

#by_res = df.groupby(['segmentID', 'resSeq']).sum()
#by_res.sort_values(by='diff', ascending=False, inplace=True)
#print(by_res.head(30))

rmsd = np.sqrt(np.mean(df['diff']**2))
print('Energy difference {:8.5f}%'.format(100*(energy1-energy2)/energy1))
print('Force RMSD {:8.5f}'.format(rmsd))

plt.scatter(df['value_x'], df['value_y'])
plt.plot(np.arange(df['value_x'].max()), np.arange(df['value_x'].max()))
plt.xlabel('CHARMM force kcal/Ang/mol')
plt.ylabel('AMBER force kcal/Ang/mol')

plt.savefig('charmm_vs_amber.png')

plt.clf()

# fig, ax = plt.subplots(nrows=2, sharex=True, sharey=True)
# ax[0].plot(df['value_x'], label='CHARMM')
# ax[0].set_ylabel('CHARMM')
# ax[0].set_ylim((0,20))
# ax[1].plot(df['value_y'], label='Amber')
# ax[1].set_ylabel('Amber')
# ax[1].set_ylim((0,20))
#
# plt.savefig('charmm_and_amber.png')
# plt.clf()
#
#
# plt.scatter(np.arange(df.shape[0]), df['diff'])
# plt.savefig('forcediff_vs_index.png')
