% Usunięcie wszystkich zmiennych z przestrzeni roboczej, zamknięcie wszystkich otwartych okien
clc; close all;

% Wczytanie obrazu
Im = imread('Im.jpg');

% Konwersja obrazu do skali szarości
Im_gray = rgb2gray(Im);

% Konwersja obrazu RGB do obrazu indeksowanego
[Im_ind, cmap] = rgb2ind(Im, 2048);

% a
% Wykreślenie histogramu obrazu w skali szarości
histogram(Im_gray);

% Binaryzacja obrazu
BW1 = im2bw(Im, 0.65); BW2 = im2bw(Im_ind, cmap, 0.65);
BW3 = im2bw(Im_gray, 0.65);

% Wyświetlenie wyników binaryzacji
figure(1); imshow(BW1); title('(Im, 0.65)');disp('exportgraphics');exportgraphics(gcf,'myVectorFile1.pdf','BackgroundColor','none','ContentType','vector')
figure(2); imshow(BW2); title('(Im ind, cmap, 0.65)');disp('exportgraphics');exportgraphics(gcf,'myVectorFile2.pdf','BackgroundColor','none','ContentType','vector')
figure(3); imshow(BW3); title('(Im gray, 0.65)');disp('exportgraphics');exportgraphics(gcf,'myVectorFile3.pdf','BackgroundColor','none','ContentType','vector')

% b
% Binaryzacja obrazu za pomocą różnych metod
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

% Wyświetlenie wyników binaryzacji
figure(4); imshow(BIN1(:,:,1)); title(' domyslne dzialanie imbinarize');disp('exportgraphics');exportgraphics(gcf,'myVectorFile4.pdf','BackgroundColor','none','ContentType','vector')
figure(5); imshow(BIN2(:,:,1)); title(' metoda globalna ');disp('exportgraphics');exportgraphics(gcf,'myVectorFile5.pdf','BackgroundColor','none','ContentType','vector')
figure(6); imshow(BIN2_a(:,:,1)); title(' metoda adaptacyjna ');disp('exportgraphics');exportgraphics(gcf,'myVectorFile6.pdf','BackgroundColor','none','ContentType','vector')
figure(7); imshow(BIN3(:,:,1)); title(' granica 0.6');disp('exportgraphics');exportgraphics(gcf,'myVectorFile7.pdf','BackgroundColor','none','ContentType','vector')
figure(8); imshow(BIN4(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.5, piksele tla ciemne  ']);disp('exportgraphics');exportgraphics(gcf,'myVectorFile8.pdf','BackgroundColor','none','ContentType','vector')
figure(9); imshow(BIN4_b(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.5, piksele tla jasne  ']);disp('exportgraphics');exportgraphics(gcf,'myVectorFile9.pdf','BackgroundColor','none','ContentType','vector')
figure(10); imshow(BIN4_3(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.3, piksele tla ciemne  ']);disp('exportgraphics');exportgraphics(gcf,'myVectorFile10.pdf','BackgroundColor','none','ContentType','vector')
figure(11); imshow(BIN4_7(:,:,1)); title([' metoda adaptacyjna, wspolczynnik ' ...
    'czulosci 0.7, piksele tla ciemne  ']);disp('exportgraphics');exportgraphics(gcf,'myVectorFile11.pdf','BackgroundColor','none','ContentType','vector')

% c
% Wyznaczenie progu binaryzacji za pomocą metody Otsu
level = graythresh(Im_gray); % 0.635

% Binaryzacja obrazu z wykorzystaniem wyznaczonego progu
BW_gray = imbinarize(Im_gray,level);

% Wyświetlenie wyniku
figure(12); imshow(BW_gray); title('z graythresh');disp('exportgraphics');exportgraphics(gcf,'myVectorFile12.pdf','BackgroundColor','none','ContentType','vector')

% d1
% Modyfikacja obrazu w skali szarości za pomocą progowania na poziomie pikseli
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

% Wyświetlenie wyniku oraz histogramu
figure(13); imshow(Im_gray_bin);disp('exportgraphics');exportgraphics(gcf,'myVectorFile13.pdf','BackgroundColor','none','ContentType','vector')
figure(14); histogram(Im_gray_bin); grid on;disp('exportgraphics');exportgraphics(gcf,'myVectorFile14.pdf','BackgroundColor','none','ContentType','vector')

% d2
% Wyznaczenie histogramu oraz najczęściej występującej wartości natężenia
[pixelCounts, grayLevels] = imhist(Im_gray);
[~, idx] = max(pixelCounts(:));

% Progowanie obrazu na podstawie najczęściej występującej wartości natężenia
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

% Wyświetlenie wyniku oraz histogramu
figure(15); imshow(Im_gray_bin2, [0 1]);disp('exportgraphics');exportgraphics(gcf,'myVectorFile15.pdf','BackgroundColor','none','ContentType','vector')
figure(16); histogram(Im_gray_bin2); grid on;disp('exportgraphics');exportgraphics(gcf,'myVectorFile16.pdf','BackgroundColor','none','ContentType','vector')

% 2
% Wyrównanie histogramu
Im_wyr =  histeq(Im_gray);

% Wyświetlenie obrazu oryginalnego, po wyrównaniu histogramu oraz histogramu obrazu po wyrównaniu
figure(17); imshow(Im_gray); title('Orginal');disp('exportgraphics');exportgraphics(gcf,'myVectorFile17.pdf','BackgroundColor','none','ContentType','vector')
figure(18); imshow(Im_wyr); title('Po histeq');disp('exportgraphics');exportgraphics(gcf,'myVectorFile18.pdf','BackgroundColor','none','ContentType','vector')
figure(19); histogram(Im_wyr); grid on;disp('exportgraphics');exportgraphics(gcf,'myVectorFile19.pdf','BackgroundColor','none','ContentType','vector')