# Gnuplot script generates charts illustating the dispatchability of intermittent
# renewable energy with battery energy storage.

reset
set term epslatex size 14.4cm, 9.6cm
set size 1.0, 1.0

#------------------------------------------------------------------------------#
roff_tol = 1e-12
set style line 1 linecolor rgb 'black' linewidth 2 dashtype 1 pointtype 1
set style line 2 linecolor rgb 'forest-green' linewidth 2 dashtype 6 pointtype 6
set style line 3 linecolor rgb 'medium-blue' linewidth 2 dashtype 4 pointtype 4
set style line 4 linecolor rgb 'dark-violet' linewidth 2 dashtype 2 pointtype 2

set style line 5 linecolor rgb 'red' linewidth 1 dashtype 6 pointtype 6
set style line 6 linecolor rgb 'dark-orange' linewidth 1 dashtype 4 pointtype 4
set style line 7 linecolor rgb 'gold' linewidth 1 dashtype 2 pointtype 2

set style line 8 linecolor rgb 'dark-gray' linewidth 1 dashtype 6 pointtype 6
set style line 9 linecolor rgb 'red' linewidth 2 dashtype 1 pointtype 1

set style line 10 linecolor rgb 'black' linewidth 2 dashtype 1 pointtype 1
set style line 11 linecolor rgb 'skyblue' linewidth 2 dashtype 1 pointtype 1

#------------------------------------------------------------------------------#
cf = 0.379	# Capacity factor of SNOWTWN1 wind farm

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# Plots the probability of (wind and battery) power dispatched to the grid 
# equaling or exceeding the set point, or reference signal, representing the 
# target baseload power -- a constant value for each dispatch interval.
#
set output 'plot_disp_wind_bess_flat.tex'
set key at 0.54,25 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.70]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.70 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Set point for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%' 
set arrow from cf,0 to cf,100 nohead ls 5
set label at 0.40,90 sprintf("Capacity factor = %.2f", cf) left
plot	'./data/baseload_flat_e50.dat' using 7:10 title 'No energy storage' with lines ls 1 smooth bezier, \
		'./data/baseload_flat_e50.dat' using 7:12 title 'Battery (1), capacity = 0.50 p.u.' with lines ls 2 smooth bezier, \
		'./data/baseload_flat_e75.dat' using 7:12 title 'Battery (2), capacity = 0.75 p.u.' with lines ls 3 smooth bezier, \
		'./data/baseload_flat_e100.dat' using 7:12 title 'Battery (3), capacity = 1.00 p.u.' with lines ls 6 smooth bezier
unset xlabel
unset ylabel
unset arrow
unset label

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Plots the probability of (wind and battery) power dispatched to the grid 
# equaling or exceeding the set point, or reference signal, representing the 
# target baseload power -- an average value over dispatch intervals where the
# set point follows the daily load profile of the season.
#
set output 'plot_disp_wind_bess.tex'
set key at 0.685,30 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:0.75]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 0.75 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%' #offset 1.0,0.0
set object rectangle from 0.15,0 to 0.60,100 behind fillcolor rgb 'yellow' fillstyle transparent solid 0.25 noborder
set arrow 1 from cf,0 to cf,100 nohead ls 8
set arrow 2 from cf,85 rto 0.04,0 backhead filled ls 1
#set label 2 at (cf+0.05),90 sprintf("Registered capacity = 1.0 p.u.") left front
set label 1 at (cf+0.05),85 sprintf("Capacity factor = %.2f", cf) left front
plot	'./data/baseload_snowtwn1_e25.dat' using 7:10 title 'No energy storage' with lines ls 1 smooth bezier, \
		'./data/baseload_snowtwn1_e25.dat' using 7:12 title 'Battery (1), energy capacity = 0.25 p.u.' with lines ls 2 smooth bezier, \
		'./data/baseload_snowtwn1_e50.dat' using 7:12 title 'Battery (2), 0.50 p.u.' with lines ls 3 smooth bezier, \
		'./data/baseload_snowtwn1_e75.dat' using 7:12 title 'Battery (3), 0.75 p.u.' with lines ls 4 smooth bezier, \
		'./data/baseload_snowtwn1_e100.dat' using 7:12 title 'Battery (4), 1.00 p.u.' with lines ls 9 smooth bezier
unset xlabel
unset ylabel
unset arrow
unset label
unset object

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# SA normalised load profile (50% POE maximum demand) on typical summer days 
# during 2014-15 -- the average load during a typical summer day is equal to 1.0
#
set output 'plot_load_prof_summer_norm.tex'
#set title 'Normalised summer load profile'
#set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['OO:00':'23:30']
set yrange [0.00:1.40]
set xtics out '00:00', 7200, '23:30' format '%H:%M'
set ytics out 0.00, 0.20, 1.40 format '%.1f'
unset xlabel
unset ylabel
plot	'./data/load_prof_norm.dat' using 2:4 notitle with filledcurves x1 fs pattern 3 ls 11, \
		'./data/load_prof_norm.dat' using 2:($4/$4) notitle with lines ls 10

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# SA normalised load profile (50% POE maximum demand) on typical winter days 
# during 2014-15 -- the average load during a typical winter day is equal to 1.0
#
set output 'plot_load_prof_winter_norm.tex'
set title 'Normalised winter load profile'
#set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['O0:00':'23:30']
set yrange [0.00:1.40]
set xtics out '00:00', 7200, '23:30' format '%H:%M'
set ytics out 0.00, 0.20, 1.40 format '%.1f'
unset xlabel
unset ylabel
plot	'./data/load_prof_norm.dat' using 2:5 notitle with filledcurves x1 fs pattern 3 ls 11, \
		'./data/load_prof_norm.dat' using 2:($5/$5) notitle with lines ls 10
		
unset title
unset xdata
unset timefmt

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
# Plots the probability of (wind and battery) power dispatched to the grid 
# equaling or exceeding the set point, or reference signal, representing the 
# target baseload power -- a constant value for each dispatch interval.  The
# set point range spans the full generation capacity of the wind farm  
# (0.0 - 1.0 p.u.).
# 
set output 'plot_disp_wind_bess_full_ref.tex'
set key at 0.55,25 Left reverse nobox
#set key inside left bottom Left reverse nobox
set xrange [0.00:1.00]
set yrange [0.0:100.0]
set xtics 0.00, 0.10, 1.00 format '%.2f'
set mxtics 2
set ytics 0.0, 10.0, 100 format '%.0f'
set mytics 2
set xlabel 'Average of set points for power dispatched to the grid, p.u.'
set ylabel '$\P\left(\text{power dispatched} \geq \text{set point}\right)$, \%' #offset 1.0,0.0
set arrow from cf,0 to cf,100 nohead ls 2
set label at 0.40,90 sprintf("Capacity factor = %.2f", cf) left
plot	'./data/baseload_full_ref_flat.dat' using 7:12 notitle with linespoints ls 1
unset xlabel
unset ylabel
unset arrow
unset label

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
reset
set output 'plot_dummy.tex'
plot	 sin(x)
#------------------------------------------------------------------------------#