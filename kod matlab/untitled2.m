clc, clear all, close all

obr1 = imread("obraz1.jpg");



%% Operacje morfologiczne
close all;
obr3 = imread('obraz3.png');

% Tworzenie struktur elementarnych
prostokat = strel('rectangle',[16,16])
diament = strel('diamond',8)
dysk = strel('disk',8)
oktagon = strel('octagon',9)
figure();
subplot(2, 2, 1),imshow(getnhood(prostokat),'InitialMagnification', 'fit'), title('prostokat');
subplot(2, 2, 2),imshow(getnhood(diament),'InitialMagnification', 'fit');title('diament');
subplot(2, 2, 3),imshow(getnhood(dysk),'InitialMagnification', 'fit');title('dysk');
subplot(2, 2, 4),imshow(getnhood(oktagon),'InitialMagnification', 'fit');title('oktagon');

%% Tworzenie operacji erozji, dylatacji, zamknięcia i otwarcia
close all, clc;
obr2 = imread('obraz3.png'); % Wczytanie obrazu "obr2"

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

figure(),imshow(obr2), title('Obraz "obr2"');
figure(),imshow(ero_obr2), title('Erozja');
figure(),imshow(dyl_obr2), title('Dylatacja');
figure(),imshow(zamk_obr2), title('Zamknięcie');
figure(),imshow(otw_obr2), title('Otwarcie');

%% Wyznaczanie gradientu morfologicznego

inicjaly = imcrop(obr3, [1150, 40, 400 , 210]);
%1152,40 - 1550,250
figure; imshow(inicjaly); title('Obraz oryginalny')
inicjaly_e = imerode(inicjaly, dysk);
inicjaly_d = imdilate(inicjaly, dysk);

figure()
imshow(inicjaly_d), title('dylatacja');
figure()
imshow(inicjaly_e), title('erozja')

A = inicjaly - inicjaly_e;
B = inicjaly_d - inicjaly;
C = 0.5 * (inicjaly_d - inicjaly_e);
figure; imshow(A); title(' wej - erozja ')
figure; imshow(B); title(' dylatacja - wej ')
figure; imshow(C); title(' dylatacja - erozja ')