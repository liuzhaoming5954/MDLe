function sigman = AlphabetAugmentation(sigmao, ui)
% INPUT
% sigmao: j*max(m,k)矩阵
% ui: 1*max(m.k)向量
% OUTPUT
% sigman: j*max(m,k)+1矩阵，并入了ui以后的新字母表

sigman = [sigmao;ui];