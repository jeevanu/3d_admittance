 % Copyright (C) 2016 Jeevan U Thayannur
 % Author: Jeevan U Thayannur <jeevanthanal@gmail.com>

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
 % 2016-01-8 [Start]
 % 2016-01-28 [ 2 pi removed for compare the result with gmt]
 % Ver 1.1

function [k] = wavenum3earth (input1)
 % Function to calculate wave number of a region in earth
 % Input must be Matrix
 % Assuming 1 min = 1833.3 ( Better works in Indian Ocean Region
x=input1(1,:); % Long
y=input1(:,1); % Lat


Lx=1*length(x)*1833.3; % Converting min in to meter
Nx=length(x)-1;
dFx=1/Lx;
freqx=0:dFx:Nx/Lx;
freqx(freqx>0.5.*Nx/Lx) -= Nx/Lx;
kx=freqx; %wavenum for x  ( 2 pi removed for compare the result with gmt )
kx1=repmat(kx,length(y),1);% Making wave num matrix


Ly=1*length(y)*1833.3;
Ny=length(y)-1;
dFy=1/Ly;
freqy=0:dFy:Ny/Ly;
freqy(freqy>0.5.*Ny/Ly) -= Ny/Ly;
ky=freqy;% ( 2 pi removed for compare the result with gmt )
kyt=ky';
ky1=repmat(kyt,1,length(x));

k=sqrt((kx1.^2).+(ky1.^2)); % Final wave num return 


