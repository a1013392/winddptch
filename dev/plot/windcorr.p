# Gnuplot script generates charts illustating the dispatchability of intermittent
# renewable energy with battery energy storage.

reset
set term epslatex size 14.4cm, 9.6cm
set size 1.0, 1.0

#------------------------------------------------------------------------------#
roff_tol = 1e-12
set style line 1 linecolor rgb 'black' linewidth 1 dashtype 1 pointtype 1
set style line 2 linecolor rgb 'forest-green' linewidth 1 dashtype 6 pointtype 6
set style line 3 linecolor rgb 'medium-blue' linewidth 1 dashtype 4 pointtype 4
set style line 4 linecolor rgb 'dark-violet' linewidth 1 dashtype 2 pointtype 2

set style line 5 linecolor rgb 'red' linewidth 1 dashtype 6 pointtype 6
set style line 6 linecolor rgb 'dark-orange' linewidth 1 dashtype 4 pointtype 4
set style line 7 linecolor rgb 'gold' linewidth 1 dashtype 2 pointtype 2

set style line 8 linecolor rgb 'dark-gray' linewidth 1 dashtype 6 pointtype 6
set style line 9 linecolor rgb 'red' linewidth 1 dashtype 1 pointtype 1

set style line 10 linecolor rgb 'black' linewidth 2 dashtype 1 pointtype 1
set style line 11 linecolor rgb 'skyblue' linewidth 2 dashtype 1 pointtype 1

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# Plots the probability of wind power equaling or exceeding the set point, or
# reference signal, representing the target baseload power -- an average value 
# over dispatch intervals where the reference signal follows the daily load 
# profile of the season.  Dispatchability of baseload power is plotted for wind
# farms the mid-north and south-east of South Australia.
#
set output 'plot_disp_wind_snowtwn1_lkbonny2.tex'
set key at 0.40,20 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.75]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.75 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%'
plot	'./data/baseload_correlation.dat' using 7:8 title 'SNOWTWN1' with lines ls 2 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:10 title 'LKBONNY2' with lines ls 3 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:11 title 'SNOWTWN1 + LKBONNY2' with lines ls 1 smooth bezier
unset xlabel
unset ylabel

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Plots the probability of wind power equaling or exceeding the set point, or
# reference signal, representing the target baseload power -- an average value 
# over dispatch intervals where the reference signal follows the daily load 
# profile of the season.  Dispatchability of baseload power is plotted for wind
# farms the mid-north and south-east of South Australia.
#
set output 'plot_disp_wind_waterlwf_lkbonny2.tex'
set key at 0.40,20 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.75]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.75 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%'
plot	'./data/baseload_correlation.dat' using 7:9 title 'WATERLWF' with lines ls 2 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:10 title 'LKBONNY2' with lines ls 3 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:12 title 'WATERLWF + LKBONNY2' with lines ls 1 smooth bezier
unset xlabel
unset ylabel

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Plots the probability of (wind and battery) power dispatched to the grid 
# equaling or exceeding the set point, or reference signal, representing the 
# target baseload power -- an average value over dispatch intervals where the 
# set point follows the daily load profile fo the season.  Dispatchability 
# of baseload power is plotted for wind farms in the mid-north and south-east of 
# South Australia.
#
set output 'plot_disp_wind_bess_snowtwn1_lkbonny2.tex'
set key at 0.40,20 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.75]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.75 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%'
plot	'./data/baseload_correlation.dat' using 7:13 title 'SNOWTWN1' with lines ls 2 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:15 title 'LKBONNY2' with lines ls 3 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:16 title 'SNOWTWN1 + LKBONNY2' with lines ls 1 smooth bezier
unset xlabel
unset ylabel

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Plots the probability of (wind and battery) power dispatched to the grid 
# equaling or exceeding the set point, or reference signal, representing the 
# target baseload power -- an average value over dispatch intervals where the 
# set point follows the daily load profile fo the season.  Dispatchability 
# of baseload power is plotted for wind farms in the mid-north and south-east of 
# South Australia.
#
set output 'plot_disp_wind_bess_waterlwf_lkbonny2.tex'
set key at 0.40,20 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.75]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.75 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%'
plot	'./data/baseload_correlation.dat' using 7:14 title 'WATERLWF' with lines ls 2 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:15 title 'LKBONNY2' with lines ls 3 smooth bezier, \
		'./data/baseload_correlation.dat' using 7:17 title 'WATERLWF + LKBONNY2' with lines ls 1 smooth bezier
unset xlabel
unset ylabel

pause -1 'Hit any key to continue'


#------------------------------------------------------------------------------#
reset
set output 'plot_dummy.tex'
plot	 sin(x)
#------------------------------------------------------------------------------#