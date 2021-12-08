import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv('ca_pTMs.csv')
df.plot(x="ResID", y=["pTM1", "pTM2", "pTM3", "pTM4", "pTM5"])
plt.ylabel('predicted TM score')
plt.savefig('ca_pTMs_all.png')
#plt.show()

