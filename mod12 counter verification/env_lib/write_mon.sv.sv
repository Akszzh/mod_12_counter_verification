class write_mon;
        virtual interface count_if.WR_MON_MP wr_mon_if;
        mailbox #(count_trans) wm2rm;
        count_trans wrdata;
        count_trans data2rm;

        function new(virtual interface count_if.WR_MON_MP wr_mon_if,
        mailbox #(count_trans) wm2rm);
                this.wr_mon_if=wr_mon_if;
                this.wm2rm = wm2rm;
                this.wrdata = new();
        endfunction

        virtual task start();
                fork begin
                        forever begin
                        monitor();
                        data2rm = new wrdata;
                        wm2rm.put(data2rm);
                        end
                end
                join_none
        endtask

        virtual task monitor();
                @(wr_mon_if.wr_mon_cb);
                wrdata.load = wr_mon_if.wr_mon_cb.load;
                wrdata.mode = wr_mon_if.wr_mon_cb.mode;
                wrdata.data_in = wr_mon_if.wr_mon_cb.data_in;
                wrdata.resetn = wr_mon_if.wr_mon_cb.resetn;
                wrdata.display("DATA FROM WRITE MONITOR");
        endtask

endclass
