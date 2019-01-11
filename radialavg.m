% function to calculate Radial avaraging 
% Better to use squre grid.

%  % Copyright (C) 2016 Jeevan U Thayannur
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
