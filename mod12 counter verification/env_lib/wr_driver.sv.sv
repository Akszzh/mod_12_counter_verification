class wr_driver;
        virtual interface count_if.WR_DRV_MP wr_drv_if;
        mailbox #(count_trans) gen2wd;
        count_trans data2duv;

        function new(virtual interface count_if.WR_DRV_MP wr_drv_if,mailbox #(count_trans) gen2wd);
                this.wr_drv_if = wr_drv_if;
                this.gen2wd = gen2wd;
                this.data2duv = new();
        endfunction

        virtual task start();
                fork
                        forever begin
                                gen2wd.get(data2duv);
                                drive();
                        end
                join_none
        endtask

        virtual task drive();
                        @(wr_drv_if.wr_drv_cb);
                        data2duv.display("DATA FROM DRIVER");
                        wr_drv_if.wr_drv_cb.data_in <= data2duv.data_in;
                        wr_drv_if.wr_drv_cb.mode <= data2duv.mode;
                        wr_drv_if.wr_drv_cb.load <= data2duv.load;
                        wr_drv_if.wr_drv_cb.resetn <= data2duv.resetn;

                        repeat(2)
                                @(wr_drv_if.wr_drv_cb);
        endtask

endclass
