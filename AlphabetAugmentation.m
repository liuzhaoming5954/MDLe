function sigman = AlphabetAugmentation(sigmao, ui)
% INPUT
% sigmao: j*max(m,k)����
% ui: 1*max(m.k)����
% OUTPUT
% sigman: j*max(m,k)+1���󣬲�����ui�Ժ������ĸ��

sigman = [sigmao;ui];