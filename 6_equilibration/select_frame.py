import pandas as pd
import sys
target = sys.argv[1]
atleast = float(sys.argv[2])

vols = pd.read_table('summary.VOLUME',sep='  ', names=['time','volume'], index_col=1, engine='python')
vols.reset_index(inplace=True)
vols['diff'] = (vols['volume']-float(target)).abs()
vols['diff_pc'] = 100*vols['diff']/vols['volume']

vols.sort_values(by='diff', ascending=True, inplace=True)
print('Volume differences')
print(vols.ix[vols['time']>=atleast,:].head())
print('Last frames')
print(vols.sort_values(by='time', ascending=True).tail())

