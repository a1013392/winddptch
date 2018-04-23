# Gnuplot script generates charts illustrating wind generation in South 
# Australia

reset
#set term epslatex size 14.4cm, 8.9cm 
set term epslatex size 14.4cm, 9.6cm font ',10'
set size 1.0, 1.0
#set size ratio 0.6180
#------------------------------------------------------------------------------#

roff_tol = 1e-12
set style line 1 linecolor rgb 'yellow' linewidth 1
set style line 2 linecolor rgb 'dark-yellow' linewidth 1
set style line 3 linecolor rgb 'gold' linewidth 1
set style line 4 linecolor rgb 'goldenrod' linewidth 1
set style line 5 linecolor rgb 'bisque' linewidth 1
set style line 6 linecolor rgb 'salmon' linewidth 1
set style line 7 linecolor rgb 'coral' linewidth 1
set style line 8 linecolor rgb 'orange' linewidth 1
set style line 9 linecolor rgb 'dark-orange' linewidth 1
set style line 10 linecolor rgb 'orange-red' linewidth 1
set style line 11 linecolor rgb 'red' linewidth 1
set style line 12 linecolor rgb 'light-pink' linewidth 1
set style line 13 linecolor rgb 'dark-pink' linewidth 1
set style line 14 linecolor rgb 'brown' linewidth 1
set style line 15 linecolor rgb 'cyan' linewidth 1
set style line 16 linecolor rgb 'skyblue' linewidth 1
set style line 17 linecolor rgb 'royalblue' linewidth 1
set style line 18 linecolor rgb 'steelblue' linewidth 1
set style line 19 linecolor rgb 'navy' linewidth 1
set style line 20 linecolor rgb 'turquoise' linewidth 1
set style line 21 linecolor rgb 'aquamarine' linewidth 1
set style line 22 linecolor rgb 'sea-green' linewidth 1
set style line 23 linecolor rgb 'forest-green' linewidth 1
set style line 24 linecolor rgb 'olive' linewidth 1
set style line 25 linecolor rgb 'greenyellow' linewidth 1
set style line 26 linecolor rgb 'orchid' linewidth 1
set style line 27 linecolor rgb 'magenta' linewidth 1
set style line 28 linecolor rgb 'purple' linewidth 1
set style line 29 linecolor rgb 'slategrey' linewidth 1
set style line 30 linecolor rgb 'light-grey' linewidth 1
set style line 31 linecolor rgb 'dark-grey' linewidth 1
set style line 32 linecolor rgb 'black' linewidth 4

#------------------------------------------------------------------------------#
# Plots wind generation in South Australia at five-minute intervals for each day 
# in December 2015. 
#
set output 'plot_wind_gen_1512.tex'
#set title 'SA wind generation at five-minute intervals for each day in December 2015'
#unset key
set key inside left top Left reverse nobox
#set key at '2015-12-01 02:00:00',100 nobox font ',8'
set xdata time
set timefmt '%Y-%m-%d %H:%M:%S'
#set xrange ['2015-12-01 00:00:00':'2015-12-31 23:55:00']
set yrange [0.0:120.0]
set format x '%H:%M'
set format y '%.0f'
set xtics #font ',1'
set ytics 0.0, 20.0, 120.0 #font ',1'
set mytics 2
unset xlabel
set ylabel 'MWh'
plot	'./data/sa_wind_gen_1512.dat' using 1:3 notitle with lines ls 1, \
		'./data/sa_wind_gen_1512.dat' using 1:4 notitle with lines ls 2, \
		'./data/sa_wind_gen_1512.dat' using 1:5 notitle with lines ls 3, \
		'./data/sa_wind_gen_1512.dat' using 1:6 notitle with lines ls 4, \
		'./data/sa_wind_gen_1512.dat' using 1:7 notitle with lines ls 5, \
		'./data/sa_wind_gen_1512.dat' using 1:8 notitle with lines ls 6, \
		'./data/sa_wind_gen_1512.dat' using 1:9 notitle with lines ls 7, \
		'./data/sa_wind_gen_1512.dat' using 1:10 notitle with lines ls 8, \
		'./data/sa_wind_gen_1512.dat' using 1:11 notitle with lines ls 9, \
		'./data/sa_wind_gen_1512.dat' using 1:12 notitle with lines ls 10, \
		'./data/sa_wind_gen_1512.dat' using 1:13 notitle with lines ls 11, \
		'./data/sa_wind_gen_1512.dat' using 1:14 notitle with lines ls 12, \
		'./data/sa_wind_gen_1512.dat' using 1:15 notitle with lines ls 13, \
		'./data/sa_wind_gen_1512.dat' using 1:16 notitle with lines ls 14, \
		'./data/sa_wind_gen_1512.dat' using 1:17 notitle with lines ls 15, \
		'./data/sa_wind_gen_1512.dat' using 1:18 notitle with lines ls 16, \
		'./data/sa_wind_gen_1512.dat' using 1:19 notitle with lines ls 17, \
		'./data/sa_wind_gen_1512.dat' using 1:20 notitle with lines ls 18, \
		'./data/sa_wind_gen_1512.dat' using 1:21 notitle with lines ls 19, \
		'./data/sa_wind_gen_1512.dat' using 1:22 notitle with lines ls 20, \
		'./data/sa_wind_gen_1512.dat' using 1:23 notitle with lines ls 21, \
		'./data/sa_wind_gen_1512.dat' using 1:24 notitle with lines ls 22, \
		'./data/sa_wind_gen_1512.dat' using 1:25 notitle with lines ls 23, \
		'./data/sa_wind_gen_1512.dat' using 1:26 notitle with lines ls 24, \
		'./data/sa_wind_gen_1512.dat' using 1:27 notitle with lines ls 25, \
		'./data/sa_wind_gen_1512.dat' using 1:28 notitle with lines ls 26, \
		'./data/sa_wind_gen_1512.dat' using 1:29 notitle with lines ls 27, \
		'./data/sa_wind_gen_1512.dat' using 1:30 notitle with lines ls 28, \
		'./data/sa_wind_gen_1512.dat' using 1:31 notitle with lines ls 29, \
		'./data/sa_wind_gen_1512.dat' using 1:32 notitle with lines ls 30, \
		'./data/sa_wind_gen_1512.dat' using 1:33 notitle with lines ls 31, \
		'./data/sa_wind_gen_1512.dat' using 1:34 title 'Average' with lines ls 32
pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
reset
set output 'plot_dummy.tex'
plot	 sin(x)
#------------------------------------------------------------------------------#