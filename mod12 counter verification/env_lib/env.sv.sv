class env;
        virtual interface count_if.WR_DRV_MP wr_drv_if;
        virtual interface count_if.RD_MON_MP rd_mon_if;
        virtual interface count_if.WR_MON_MP wr_mon_if;

        mailbox #(count_trans) gen2wd = new();
        mailbox #(count_trans) wm2rm = new();
        mailbox #(count_trans) rm2sb  = new();
        mailbox #(count_trans) rdmon2sb = new();


        count_gen gen_h;
        wr_driver dr_h;
        write_mon wrmon_h;
        read_mon rdmon_h;
        ref_model ref_h;
        scoreboard sb_h;

        function new (virtual count_if.WR_DRV_MP wr_drv_if,
                virtual count_if.WR_MON_MP wr_mon_if,
                virtual count_if.RD_MON_MP rd_mon_if);
                this.wr_drv_if = wr_drv_if;
                this.wr_mon_if = wr_mon_if;
                this.rd_mon_if = rd_mon_if;
        endfunction: new


        virtual task build();
                gen_h   = new(gen2wd);
                dr_h    = new(wr_drv_if, gen2wd);
                wrmon_h = new(wr_mon_if, wm2rm);
                rdmon_h = new(rd_mon_if, rdmon2sb);
                ref_h   = new(wm2rm, rm2sb);
                sb_h    = new(rdmon2sb, rm2sb);

         endtask: build


         virtual task start();
          fork
                gen_h.start();
                dr_h.start();
                wrmon_h.start();
                rdmon_h.start();
                ref_h.start();
                sb_h.start();
          join_none
         endtask: start


         virtual task stop();
                  wait(sb_h.DONE.triggered);
         endtask: stop


         virtual task reset_dut();
                @(wr_drv_if.wr_drv_cb)
                        wr_drv_if.wr_drv_cb.resetn <= 0;

                        @(wr_drv_if.wr_drv_cb)
                        wr_drv_if.wr_drv_cb.resetn <= 1;
         endtask: reset_dut

        virtual task run();

                reset_dut();
                start();
                stop();
                sb_h.report();

        endtask: run




endclass
