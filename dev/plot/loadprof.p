# Gnuplot script generates charts of the South Australian (electricity) load profile.

reset
set term epslatex size 14.4cm, 10.2cm #9.6cm
set size 1.0, 1.0
#set size ratio 0.6180

#------------------------------------------------------------------------------#
roff_tol = 1e-12
set style line 1 linecolor rgb 'dark-orange' linewidth 2	
set style line 2 linecolor rgb 'gold' linewidth 2			
set style line 3 linecolor rgb 'forest-green' linewidth 2	
set style line 4 linecolor rgb 'medium-blue' linewidth 2
set style line 5 linecolor rgb 'medium-blue' linewidth 1

#------------------------------------------------------------------------------#
# Decomposes the SA load profile (10% POE maximum demand) on peak summer days 
# during 2014-15 into load with rooftop PV (i.e., received by centralised 
# generators) and load supplied by rooftop PV
#
set output 'plot_load_prof_summer_peak_2015.tex'
#set title 'SA 2014--15 peak summer days load profile, 10\% POE maximum demand'
set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['OO:00':'23:30']
set yrange [0.0:3600.0]
set format x '%H:%M'
set xtics axis rotate by 90 offset 0.0, -1.6
set ytics out 0.0, 400.0, 3600.0 format '%.0f'
unset xlabel
set ylabel 'MW'
plot	'./data/sa_load_prof_summer_peak_2015.dat' using 7:8 title 'Load with PV' with filledcurves x1 fs pattern 3 ls 4, \
		'./data/sa_load_prof_summer_peak_2015.dat' using 7:8:($8+$14) title 'Rooftop PV' with filledcurves closed fs pattern 3 ls 2

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Decomposes the SA load profile (10% POE maximum demand) on typical summer 
# days during 2014-15 into load with rooftop PV (i.e., received by centralised
# generators) and load supplied by rooftop PV
#
set output 'plot_load_prof_summer_typ_2015.tex'
#set title 'SA 2014--15 typical summer days load profile, 10\% POE maximum demand'
set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['OO:00':'23:30']
set yrange [0.0:2500.0]
set format x '%H:%M'
set xtics axis rotate by 90 offset 0.0, -1.6
set ytics out 0.0, 250.0, 2500.0 format '%.0f'
unset xlabel
set ylabel 'MW' #offset 0.5,0.0
plot	'./data/sa_load_prof_summer_typ_2015.dat' using 7:8 title 'Load with PV' with filledcurves x1 fs pattern 3 ls 4, \
		'./data/sa_load_prof_summer_typ_2015.dat' using 7:8:($8+$14) title 'Rooftop PV' with filledcurves closed fs pattern 3 ls 2

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Decomposes forecast of 2024-25 SA load profile (10% POE maximum demand, medium
# scenario) on peak summer days into load with rooftop PV (i.e., received by 
# centralised generators) and load supplied by rooftop PV
#
set output 'plot_load_prof_summer_peak_2025.tex'
#set title 'SA 2024--25 peak summer days load profile, 10\% POE maximum demand'
set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['OO:00':'23:30']
set yrange [0.0:3600.0]
set format x '%H:%M'
set xtics axis rotate by 90 offset 0.0, -1.6
set ytics out 0.0, 400.0, 3600.0 format '%.0f'
unset xlabel
set ylabel 'MW'
plot	'./data/sa_load_prof_summer_peak_2025.dat' using 7:8 title 'Load with PV' with filledcurves x1 fs pattern 3 ls 4, \
		'./data/sa_load_prof_summer_peak_2025.dat' using 7:8:($8+$14) title 'Rooftop PV' with filledcurves closed fs pattern 3 ls 2

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Decomposes forecast of 2024-25 SA load profile (10% POE maximum demand, medium
# scenario) on typical summer days into load with rooftop PV (i.e., received by
# centralised generators) and load supplied by rooftop PV
#
set output 'plot_load_prof_summer_typ_2025.tex'
set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['OO:00':'23:30']
set yrange [0.0:2500.0]
set format x '%H:%M'
set xtics axis rotate by 90 offset 0.0, -1.6
set ytics out 0.0, 250.0, 2500.0 format '%.0f'
unset xlabel
set ylabel 'MW' #offset 0.5,0.0
plot	'./data/sa_load_prof_summer_typ_2025.dat' using 7:8 title 'Load with PV' with filledcurves x1 fs pattern 3 ls 4, \
		'./data/sa_load_prof_summer_typ_2025.dat' using 7:8:($8+$14) title 'Rooftop PV' with filledcurves 
		
pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Decomposes forecast of 2024-25 SA load profile (10% POE maximum demand, medium
# scenario) on peak summer days into load with rooftop PV and residential 
# batteries (i.e., electricity drawn from the grid), load supplied by 
# discharging batteries, and load supplied by rooftop PV.  Assumes no limit on 
# number of households with batteries installed
#
set output 'plot_load_prof_peak_ess.tex'
set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['OO:00':'23:30']
set yrange [0.0:4000.0]
set format x '%H:%M'
set xtics axis rotate by 90 offset 0.0, -1.6
set ytics out 0.0, 500.0, 4000.0 format '%.0f'
unset xlabel
set ylabel 'MW'
plot	\
	'./data/sa_load_prof_summer_peak_ess.dat' using 8:15 title 'Load with PV and batteries' with filledcurves x1 fs pattern 3 ls 4, \
	'./data/sa_load_prof_summer_peak_ess.dat' using 8:15:($15+$14) title 'Residential batteries' with filledcurves x1 fs pattern 3 ls 3,	\
	'./data/sa_load_prof_summer_peak_ess.dat' using 8:($15+$14):($15+$14+$13+$12) title 'Rooftop PV' with filledcurves x1 fs pattern 3 ls 2

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Decomposes forecast of 2024-25 SA load profile (10% POE maximum demand, medium
# scenario) on peak summer days into load with rooftop PV and residential 
# batteries (i.e., electricity drawn from the grid), load supplied by 
# discharging batteries, and load supplied by rooftop PV.  Assumes 200,000 
# households have batteries installed
#
set output 'plot_load_prof_peak_ess_hh.tex'
set key inside left top Left reverse nobox
set xdata time
set timefmt '%H:%M'
set xrange ['OO:00':'23:30']
set yrange [0.0:4000.0]
set format x '%H:%M'
set xtics axis rotate by 90 offset 0.0, -1.6
set ytics out 0.0, 500.0, 4000.0 format '%.0f'
unset xlabel
set ylabel 'MW'
plot	\
	'./data/sa_load_prof_summer_peak_ess.dat' using 8:19 title 'Load with PV and batteries' with filledcurves x1 fs pattern 3 ls 4, \
	'./data/sa_load_prof_summer_peak_ess.dat' using 8:19:($19+$18) title 'Residential batteries' with filledcurves x1 fs pattern 3 ls 3,	\
	'./data/sa_load_prof_summer_peak_ess.dat' using 8:($19+$18):($19+$18+$17+$16) title 'Rooftop PV' with filledcurves x1 fs pattern 3 ls 2	
		
unset tics
pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
# Plots forecast of 2024-25 operational maximum demand (10% POE, medium
# scenario) on peak summer days in SA as a function of the number of households
# with rooftop PV and residential batteries.
#
set output 'plot_oper_md_ess_hh.tex'
#set key inside left top Left reverse nobox
unset xdata
set xrange [0:450]
set yrange [2600.0:3400.0]
set xtics 0, 50, 450 format '%.0f'
set xtics axis #rotate by 90 offset 0.0, -1.0
set mxtics 2
set ytics border nomirror 2600.0, 100.0, 3400 format '%.0f'
set mytics 2
set y2tics border nomirror \
	( '0.0' 3303, '2.0' 3237, '4.0' 3171, '6.0' 3105, '8.0' 3039,	\
	'10.0' 2973, '12.0' 2907, '14.0' 2841, '16.0' 2775, '18.0' 2708, '20.0' 2642)
set xlabel 'Number of households with batteries installed, thousands' #offset 0.0, -1.5
set ylabel 'Operational maximum demand, MW'
set y2label 'Reduction in operational maximum demand, \%'
plot	'./data/sa_max_demand_hh_ess.dat' using ($7/1000):9 notitle with lines ls 5 smooth bezier
unset xlabel
unset ylabel

pause -1 'Hit any key to continue'

#------------------------------------------------------------------------------#
reset
set output 'plot_dummy.tex'
plot	 sin(x)
#------------------------------------------------------------------------------#