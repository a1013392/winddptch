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
cf = 0.379	# Capacity factor of SNOWTWN1 wind farm

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# Plots the probability of (wind and battery) power dispatched to the grid 
# equaling or exceeding the set point, or reference signal, representing the 
# target baseload power -- an average value over dispatch intervals where the
# set point follows the daily load profile of the season.  The chart illustrates
# the effect on dispatchability of the assumption of one-way charge/discharge
# efficiency of the battery.  
#
set output 'plot_disp_wind_bess_eff.tex'
set key at 0.25,30 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.70]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.70 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%' #offset 1.0,0.0
plot	'./data/baseload_bess_eff.dat' using 7:12 title '$\eta = 1.00$' with lines ls 3 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:14 title '$\eta = 0.96$' with lines ls 2 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:16 title '$\eta = 0.92$' with lines ls 1 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:18 title '$\eta = 0.88$' with lines ls 5 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:20 title '$\eta = 0.84$' with lines ls 6 smooth bezier
unset xlabel
unset ylabel

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Plots the probability of (wind and battery) power dispatched to the grid 
# equaling or exceeding the set point, or reference signal, representing the 
# target baseload power -- an average value over dispatch intervals where the
# set point follows the daily load profile of the season.  The chart illustrates
# the effect on dispatchability of the assumption of one-way charge/discharge
# efficiency of the battery.  
#
set output 'plot_disp_wind_bess_eff_2.tex'
set key at 0.35,40 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.70]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.70 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%' #offset 1.0,0.0
plot	'./data/baseload_bess_eff.dat' using 7:12 title '$\eta = 1.00$' with lines ls 2 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:22 title '$\eta = 0.80$' with lines ls 3 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:26 title '$\eta = 0.60$' with lines ls 4 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:30 title '$\eta = 0.40$' with lines ls 5 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:34 title '$\eta = 0.20$' with lines ls 6 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:36 title '$\eta = 0.10$' with lines ls 7 smooth bezier, \
		'./data/baseload_bess_eff.dat' using 7:10 title 'No energy storage' with lines ls 1 smooth bezier
unset xlabel
unset ylabel

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
reset
set output 'plot_dummy.tex'
plot	 sin(x)
#------------------------------------------------------------------------------#