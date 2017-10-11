'''This is the deep learning implementation in Keras for graph classification based on FGSD graph features.'''

from keras import activations, initializers
from keras import regularizers
import keras.backend as K
from keras.engine.topology import Layer
from keras.layers import Input, Dense, Activation, Dropout
from keras.models import Model,Sequential



import numpy as np
import scipy.io
from sklearn.preprocessing import OneHotEncoder
from sklearn.utils import shuffle


########### LOAD DATA ###########

mat = scipy.io.loadmat('MATLAB\data\G_mutag.mat')
graphs_data=mat['G_mutag'][0]

mat = scipy.io.loadmat('MATLAB\data\Y_mutag.mat')
data_labels=np.concatenate(mat['Y'])

data_labels_binary=[]
for label in data_labels:
    if label==1:
        new_label=1
    else:
        new_label=0
    data_labels_binary.append(new_label)

data_labels_binary=np.array(data_labels_binary)



########### SET PARAMETERS ###########

feature_matrix=[]
nbins=200
range_hist=(0,20)

########### CONSTRUCT FEATURE MATRIX ###########


for A in graphs_data:

    A=A.astype(np.float32)
    D=np.sum(A,axis=0)
    L=np.diag(D)-A

    ones_vector=np.ones(L.shape[0])
    fL=np.linalg.pinv(L) #See MATLAB version for faster implementation.

    S=np.outer(np.diag(fL),ones_vector)+np.outer(ones_vector,np.diag(fL))-2*fL

    hist, bin_edges = np.histogram(S.flatten(),bins=nbins,range=range_hist)

    feature_matrix.append(hist)

feature_matrix=np.array(feature_matrix)
feature_matrix,data_labels_binary=shuffle(feature_matrix, data_labels_binary)


########### TRAIN AND VALIDATE MODEL ###########


model=Sequential()
model.add(Dense(4500, activation='relu',input_shape=(feature_matrix.shape[1],)))
model.add(Dropout(0.2))
model.add(Dense(1024, activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(64, activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(1, activation='sigmoid'))


model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
model.fit(feature_matrix, data_labels_binary, validation_split=0.1, epochs=100, batch_size=50)








