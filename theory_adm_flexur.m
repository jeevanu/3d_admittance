%-------------------------------------------------------
%-------------------------------------------------------
% Theoritical calculation of admittance.                |
% [ Fluxure Mode  Model ]		                |
% Reff : Isostaty and Flexure of Lithosphere            |
%      : A.B. Watts					|
%      : Page : 186-187					|
% 2016 May 9 [Start] Ver 1.0				|
% ------------------------------------------------------
% ------------------------------------------------------
 % Copyright (C) 2016 Jeevan U Thayannur
 
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.
 % Author: Jeevan U Thayannur <jeevanthanal@gmail.com>

clc
clear

if exist('OCTAVE_VERSION', 'builtin') ~= 0  % If it runs on matlab, Skip pkg load

	pkg load netcdf                     % For load netcdf pkg
	pkg load signal	                

end
%------------Constants----------------------------------
G  = 6.674*10^-11;    % Gradivitational constant.
dc = 2.8*10^3;        % Density of topgraphy.
dw = 1.03*10^3;       % Density of sea water.
ds = 1.8*10^3;        % Sub-Sea floor density.
dm = 3.35*10^3;        % Density of mantle
t  = 4000;            % Mean thickness of crust.

% ------------------------------------------------------
% ---Gebco bathimetry data loaded to data variable 

[data , pathname] = uigetfile ('*.grd','chose bathimetry Netcdf file');
[gdata , pathname2] = uigetfile ('*.grd','chose gravity Netcdf file');
lat  = ncread (data,"y");  
long = ncread (data,"x");
top  = ncread (data,"z"); % Depth from ocean surface
top  = top'; 


%-----------Gravity data loaded to data variable
%gdata   = 'satgrav62W66E3S7N.grd';
%lat2    = ncread (gdata,"lat");
%long2   = ncread (gdata,"lon");
%gravity = ncread (gdata,"z");
%gravity = gravity.*10^-5; % m/sec^2
%gravity = gravity';

%------------------------------------------------------

davg = mean (mean(top));          % Mean water depth


[kx , adm] = admitt3d(gdata,data);

% Wave Number 
x = 1:length(top)/2;
Lx    = 1*length(x)*1833.3; % Converting degree in to meter
Nx    = length(x)-1;
dFx   = 1/Lx;
freqx = 0:dFx:Nx/Lx;
freqx ( freqx>0.5.*Nx/Lx ) -= Nx/Lx; % To make -ve part 
kk    = 2*pi.*freqx; % Wave number for x

% Flexural rigidity D

E = 10^11; % Youngs Modulud in N/m^2
v = 0.25;  % Poisson's ratio
Te = 1000; % Elastic thickness
D = ( E * (Te^3) ) / ( 12 * (1-v^2) );  

% Wave number parameter

phi = 1./( ( D * kk.^4 ) ./ ((dm - dc) * 10 ) + 1);

Z = 2 * pi * G * (dc -dw) .* exp (  kk .* davg) .* (1- (phi .* exp(-1*kk*t))).* 1e5; % mgal/m


kk=kk(1:length(kk)/2); Z=Z(1:length(Z)/2);
plot(kk',abs(Z), 'r'); 
hold on; plot(kx*2*pi, abs(adm), 'b*'); 
title('Theoretical V/s Observed')
legend('Theoretical','Observed')
xlabel('k')
ylabel('Admittance')
% axis([0 5e-5])



hold off;
axis([0 0.0008])

%-------------------------------------------------------END-------







 

