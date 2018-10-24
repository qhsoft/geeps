rm log-data.*
../tools/extra/parse_log.py log-data ./

gnuplot plot_log.gnuplot
