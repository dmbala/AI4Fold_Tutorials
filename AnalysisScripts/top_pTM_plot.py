import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('ca_pTMs.csv')
df.plot(x="ResID", y=["pTM1"])
plt.ylabel('predicted TM score')
plt.savefig('ca_pTM_top.png')
#plt.show()

