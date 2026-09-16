-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/eing/Documents/GitHub/e155-lab2/fpga/lab2_ei/source/impl_1/lab2_counter.sv" 
"C:/Users/eing/Documents/GitHub/e155-lab2/fpga/lab2_ei/source/impl_1/lab2_scanning.sv" 
"C:/Users/eing/Documents/GitHub/e155-lab2/fpga/lab2_ei/source/impl_1/lab2_scanning_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top lab2_scanning_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run -all"
