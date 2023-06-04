clc; close all;

Im = imread('Im.jpg');
Im_gray = rgb2gray(Im);
[Im_ind, cmap] = rgb2ind(Im, 2048);

% a
histogram(Im_gray);

BW1 = im2bw(Im, 0.65); BW2 = im2bw(Im_ind, cmap, 0.65);
BW3 = im2bw(Im_gray, 0.65);

figure; imshow(BW1); title('(Im, 0.65)');
figure; imshow(BW2); title('(Im ind, cmap, 0.65)');
figure; imshow(BW3); title('(Im gray, 0.65)');

% b
BIN1 = imbinarize(Im);
BIN2 = imbinarize(Im, 'global'); BIN2_a = imbinarize(Im, 'adaptive');
BIN3 = imbinarize(Im, 0.6);
BIN4 = imbinarize(Im, 'adaptive', 'Sensitivity', 0.5, ...
    'ForegroundPolarity', 'dark');
BIN4_b = imbinarize(Im, 'adaptive', 'Sensitivity', 0.5, ...
    'ForegroundPolarity', 'bright');
BIN4_3 = imbinarize(Im, 'adaptive', 'Sensitivity', 0.3, ...
    'ForegroundPolarity', 'dark');
BIN4_7 = imbinarize(Im, 'adaptive', 'Sensitivity', 0.7, ...
    'ForegroundPolarity', 'dark');

figure; imshow(BIN1(:,:,1)); title(' domyslne dzialanie imbinarize');
figure; imshow(BIN2(:,:,1)); title(' metoda globalna ');
figure; imshow(BIN2_a(:,:,1)); title(' metoda adaptacyjna ');
figure; imshow(BIN3(:,:,1)); title(' granica 0.6');
figure; imshow(BIN4(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.5, piksele tla ciemne  ']);
figure; imshow(BIN4_b(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.5, piksele tla jasne  ']);
figure; imshow(BIN4_3(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.3, piksele tla ciemne  ']);
figure; imshow(BIN4_7(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.7, piksele tla ciemne  ']);
%%
% c
level = graythresh(Im_gray); % 0.635
BW_gray = imbinarize(Im_gray,level);

figure; imshow(BW_gray); title('z graythresh');

% d1
sizeim = size(Im_gray);
Im_gray_bin = Im_gray;
for i = 1:sizeim(1)
    for j = 1:sizeim(2)
        if(Im_gray_bin(i,j) > 100 && Im_gray_bin(i,j) < 200)
            for k=0:5
                kk = 5-k;
                if Im_gray_bin(i,j) > 100 + kk*20
                    Im_gray_bin(i,j) = 100 + kk*20;
                    break
                end
            end
        end
    end
end
figure; imshow(Im_gray_bin);
figure; histogram(Im_gray_bin); grid on
%%
% % d2
[pixelCounts, grayLevels] = imhist(Im_gray);
[~, idx] = max(pixelCounts(:));

l_lim = idx - (idx * 0.3); r_lim = idx + (idx * 0.3);

Im_gray_bin2 = Im_gray;
for i = 1:sizeim(1)
    for j = 1:sizeim(2)
        if(Im_gray_bin2(i,j) > l_lim && Im_gray_bin2(i,j) < r_lim)
            Im_gray_bin2(i,j) = 1;
        else
            Im_gray_bin2(i,j) = 0;
        end
    end
end
figure; imshow(Im_gray_bin2, [0 1]);
figure; histogram(Im_gray_bin2); grid on
%%
% 2
Im_wyr =  histeq(Im_gray);
figure; imshow(Im_gray); title('Orginal')
figure; imshow(Im_wyr); title('Po histeq')
figure; histogram(Im_wyr); grid on