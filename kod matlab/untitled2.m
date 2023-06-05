% Usuwanie wszystkich zmiennych z przestrzeni roboczej, czyszczenie konsoli i zamknięcie wszystkich otwartych okien
clc; clear all; close all;

% Wczytanie obrazu
obr1 = imread("Im.jpg");

%% Operacje morfologiczne
close all;
obr3 = imread('Bez tytułu.png');

% Tworzenie struktur elementarnych
prostokat = strel('rectangle',[16,16]);
diament = strel('diamond',8);
dysk = strel('disk',8);
oktagon = strel('octagon',9);

% Wyświetlanie struktur elementarnych
figure(20);
subplot(2, 2, 1), imshow(getnhood(prostokat), 'InitialMagnification', 'fit') , title('prostokat');
subplot(2, 2, 2), imshow(getnhood(diament), 'InitialMagnification', 'fit') ;title('diament');
subplot(2, 2, 3), imshow(getnhood(dysk), 'InitialMagnification', 'fit') ;title('dysk');
subplot(2, 2, 4), imshow(getnhood(oktagon), 'InitialMagnification', 'fit') ;title('oktagon');
disp('exportgraphics');exportgraphics(gcf,'myVectorFile20.pdf','BackgroundColor','none','ContentType','vector');
%% Tworzenie operacji erozji, dylatacji, zamknięcia i otwarcia
close all; clc;
obr2 = imread('Bez tytułu.png'); % Wczytanie obrazu "obr2"

% Tworzenie struktury elementarnej typu "disk" o rozmiarze 3
se = strel('disk', 3);

% Erozja
ero_obr2 = imerode(obr2, se);

% Dylatacja
dyl_obr2 = imdilate(obr2, se);

% Zamknięcie
zamk_obr2 = imclose(obr2, se);

% Otwarcie
otw_obr2 = imopen(obr2, se);

% Wyświetlanie obrazów i ich operacji
figure(21),imshow(obr2), title('Obraz "obr2"');disp('exportgraphics');exportgraphics(gcf,'myVectorFile21.pdf','BackgroundColor','none','ContentType','vector');
figure(22),imshow(ero_obr2), title('Erozja');disp('exportgraphics');exportgraphics(gcf,'myVectorFile22.pdf','BackgroundColor','none','ContentType','vector');
figure(23),imshow(dyl_obr2), title('Dylatacja');disp('exportgraphics');exportgraphics(gcf,'myVectorFile23.pdf','BackgroundColor','none','ContentType','vector');
figure(24),imshow(zamk_obr2), title('Zamknięcie');disp('exportgraphics');exportgraphics(gcf,'myVectorFile24.pdf','BackgroundColor','none','ContentType','vector');
figure(25),imshow(otw_obr2), title('Otwarcie');disp('exportgraphics');exportgraphics(gcf,'myVectorFile25.pdf','BackgroundColor','none','ContentType','vector');

%% Wyznaczanie gradientu morfologicznego
inicjaly = imcrop(obr3, [778,38, 200 , 100]);
%778,38 - 928,146
figure(26); imshow(inicjaly); title('Obraz oryginalny')

% Erozja
inicjaly_e = imerode(inicjaly, dysk);

% Dylatacja
inicjaly_d = imdilate(inicjaly, dysk);
disp('exportgraphics');exportgraphics(gcf,'myVectorFile26.pdf','BackgroundColor','none','ContentType','vector');
% Wyświetlanie obrazów po erozji i dylatacji
figure(27); imshow(inicjaly_d), title('dylatacja');disp('exportgraphics');exportgraphics(gcf,'myVectorFile27.pdf','BackgroundColor','none','ContentType','vector');
figure(28); imshow(inicjaly_e), title('erozja');disp('exportgraphics');exportgraphics(gcf,'myVectorFile28.pdf','BackgroundColor','none','ContentType','vector');

% Obliczanie gradientu morfologicznego różnymi metodami
A = inicjaly - inicjaly_e;
B = inicjaly_d - inicjaly;
C = 0.5 * (inicjaly_d - inicjaly_e);

% Wyświetlanie gradientów morfologicznych
figure(29); imshow(A); title(' wej - erozja ');disp('exportgraphics');exportgraphics(gcf,'myVectorFile29.pdf','BackgroundColor','none','ContentType','vector');
figure(30); imshow(B); title(' dylatacja - wej ');disp('exportgraphics');exportgraphics(gcf,'myVectorFile30.pdf','BackgroundColor','none','ContentType','vector');
figure(31); imshow(C); title(' dylatacja - erozja ');disp('exportgraphics');exportgraphics(gcf,'myVectorFile31.pdf','BackgroundColor','none','ContentType','vector');