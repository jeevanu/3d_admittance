% function to calculate Radial avaraging 
% Better to use squre grid.

%  % Copyright (C) 2016 Jeevan U Thayannur

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
% 2016 Jan 28 [Start] 
% Version 1.0
% --------------------------------------------------------------------
function [k, retval ] = radialavg ( input1 )
% Radial average of matrix 

[ m , n ]= size ( input1 ); 
wnum = wavenum3earth ( input1 ); % Wave num of input1 matrix
d_wnum = wnum(1: length(wnum));  % Choosing the first raw of the matrix
d_wnum = d_wnum( 1:floor(length(d_wnum)/2) ); % Taking the real part only
k = d_wnum;                      % Returnig the value of wave number
retval = zeros(1 , length ( d_wnum ));        % To write the value of radial
					      % -avg matrix
differ = (d_wnum(2) - d_wnum(1)) /2;	      % Choosing the resolution of 
					      % -differnce between two wavenumbers

for i = 1 : length ( d_wnum )

	wnum_temp = wnum ;
	 	
	wnum_temp ( abs(wnum_temp - d_wnum(i)) <= differ ) = NaN;       %  wnum_temp == d_wnum(i)) = NaN;
	wnum_locn = isnan ( wnum_temp );
	spct_slec = input1 ( wnum_locn );                               % Selecting spectrum
	retval(i) = mean ( spct_slec );					% Averaging

endfor
		
#endfunction
