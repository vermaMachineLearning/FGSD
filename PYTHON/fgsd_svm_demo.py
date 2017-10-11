import pandas as pd
import numpy as np
np.random.seed(163) 
from sklearn.svm import SVC
from sklearn.cross_validation import StratifiedKFold


# Load the precomputed X mutag feature matrix.
print "Loading Feature Matrix..."
df=pd.read_csv('X_mutag.csv',header=None)
X=np.array(df)

# Load the precomputed Y mutag feature matrix.
print "Loading Class labels Matrix..."
df=pd.read_csv('Y_mutag.csv',header=None)
Y=np.array(df)

# Create the 10-fold cross validation indices.
idx = np.arange(len(Y))
np.random.shuffle(idx)
kfold = StratifiedKFold(y=Y[:,0], n_folds=10)
cvscores = []
error_labels_index=[]
X=X[idx];
Y=Y[idx];

#Perform 10-fold cross validation
print "Performing 10-fold cross validation..."
for i, (train, test) in enumerate(kfold):
	 # Fit the SVM model
    clf2 = SVC(C=20, gamma=1.5e-04) 
    clf2.fit(X[train], np.ravel(Y[train]))
    accuracy=clf2.score(X[test],np.ravel(Y[test]))
    predicted_labels=clf2.predict(X[test])
    test_labels=np.reshape(Y[test],(len(Y[test])))
    error=predicted_labels-test_labels
    print "Test Fold "+str(i)
    print("Accuracy= %.2f%%" % (accuracy*100)) 
    cvscores.append(accuracy * 100)

#Report average classification accuracy.
print "Average Accuracy= %.2f%%" % (np.mean(cvscores))



