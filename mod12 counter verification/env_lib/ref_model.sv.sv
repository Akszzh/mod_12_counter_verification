class ref_model;
        mailbox #(count_trans) rm2sb;
        mailbox #(count_trans) wm2rm;
        count_trans data2sb;
        count_trans data2rm;

        logic [3:0] ref_arr = 0;

        function new(mailbox #(count_trans) wm2rm,
                mailbox #(count_trans) rm2sb);
                this.wm2rm = wm2rm;
                this.rm2sb = rm2sb;
        endfunction: new

        virtual task start();
                fork
                        forever begin
                                wm2rm.get(data2rm);
                                count_model(data2rm);
                                data2rm.count=ref_arr;
                                data2sb = new data2rm;
                                rm2sb.put(data2sb);
                        end
                join_none

        endtask

        virtual task count_model(count_trans data2rm);
                if(!(data2rm.resetn))
                        ref_arr <= 0;
                else if(data2rm.load == 1)
                        ref_arr <= data2rm.data_in;
                else
                        begin
                        if(data2rm.mode == 1) begin
                                if(ref_arr == 12)
                                        ref_arr <= 0;
                                else
                                        ref_arr <= ref_arr + 1;
                        end
                        else begin
                                if(ref_arr == 0)
                                        ref_arr <= 12;
                                else
                                        ref_arr <= ref_arr - 1;
                                end
                        end
        endtask


endclass
