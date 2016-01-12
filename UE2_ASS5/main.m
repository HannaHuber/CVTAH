%% Performs scene recognition (UE2 - Ass5)

% Init
folder = './ass5_data/train';
num_clusters = 50;

% Build vocabulary of visual words
C = BuildVocabulary(folder, num_clusters);

% Build feature representation for every image in the traning set
[training, group] = BuildKNN(folder,C);

% Classify images in the test set
conf_matrix = ClassifyImages(folder,C,training,group);