package counter_package;

   int number_of_transactions = 2;

   `include "trans.sv"
   `include "gen.sv"
   `include "wr_driver.sv"
   `include "wr_monitor.sv"
   `include "rd_monitor.sv"
   `include "ref_mod.sv"
   `include "sb.sv"
   `include "env.sv"
   `include "test.sv"


endpackage
