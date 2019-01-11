%% Copyright (C) 2016 Jeevan U
%% 
%% Author: Jeevan U <jeevanthanal@gmail.com>
%% 2016-02-01 [Start]
## 
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

function [k2 , adm] = admitt3d (gravin, topoin)
 % Function to calculate admittance 
 % -using radial avarage
 % Input names of two netcdf (In Single quot )
 % 1)Grvity grid 2)Bathimetry Grid
 % Output is [k,adm] 
 % k is wave number of this area and adm is admittance of this area.
 % The function also gives a plot of admittance vs wave number of the given area. 
 % 2016-01-28 : Compared the output result with gmt gravfft and result is almost
 % -maching. 
 % Gravity in mGal

if exist('OCTAVE_VERSION', 'builtin') ~= 0           % If it runs on matlab, Skip pkg load

	pkg load netcdf                 % For load netcdf pkg
	pkg load signal	                

end
%---------------------------------------------------------------------

data = topoin; % Bathimetry data  
lat  = ncread ( data,'y' );        % Lattitude
long = ncread ( data,'x' );        % Longitude
top  = ncread ( data,'z' ); 	   % Depth from ocean surface 
top  = top';		           % Matlab and Octave load netcdf as 
				   % -transpause of grid-(1)
top  = top - mean ( mean ( top ) );% Mean removing to fit the scale

%----------------------------------------------------------------------

gdata   = gravin; % sat gravity
gravity = ncread (gdata,'z');       % Free-Air Sat
gravity = gravity';	            % Reff -(1)
gravity = gravity - mean ( mean (gravity) ); % Mean - Removed

% --------------------------making squre matrix------------------------

[zx zy] = size(top);                   
if zx<zy 
    zy  = zx;		            % least size column or raw
end

top     = top (1:zy , 1:zy);     
gravity = gravity (1:zy , 1: zy);

%-------------------------------taking fft-----------------------------

topf     = fft2 (top);
gravityf = fft2 (gravity);

%-------raidal avging and calculation of admittance--------------------

[k1 num] = radialavg ((gravityf .* conj(topf)));  % radialavg is my fun'n
[k2 den] = radialavg ((topf .* conj(topf))); 

adm      = num./den;

%----------------------------Figures------------------------------------

plot ( k2,real(adm), 'r-*' )           % Admittance Calculated in this code
title 'Isostatic responce / Admittance'
grid on
xlabel 'k'
ylabel 'Admittence'

%-------------------END--------------------------------------------------
