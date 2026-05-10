interface count_if(input bit clock);

   logic [3:0] data_in;
   logic mode;
   logic load;
   logic [3:0] count;
   logic resetn;

   clocking wr_drv_cb @(posedge clock);
      default input #1 output #1;
      output data_in;
      output mode;
      output load;
      output resetn;
   endclocking: wr_drv_cb



   clocking wr_mon_cb @(posedge clock);
      default input #1 output #1;
      input data_in;
      input mode;
      input load;
      input resetn;
   endclocking: wr_mon_cb

   clocking rd_mon_cb @(posedge clock);
      default input #1 output #1;
      input count;
   endclocking: rd_mon_cb

   modport WR_DRV_MP (clocking wr_drv_cb);
   modport WR_MON_MP (clocking wr_mon_cb);
   modport RD_MON_MP (clocking rd_mon_cb);

endinterface: count_if
