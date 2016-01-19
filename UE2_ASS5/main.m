%% Performs scene recognition (UE2 - Ass5)

% Init
folderTrain = './ass5_data/train';
folderTest = './ass5_data/test';

num_clusters = 50;

% Build vocabulary of visual words
C = BuildVocabulary(folderTrain, num_clusters);

% Build feature representation for every image in the traning set
[training, group] = BuildKNN(folderTrain,C);

% Classify images in the test set
conf_matrix = ClassifyImages(folderTest,C,training,group);