class read_mon;
        virtual interface count_if.RD_MON_MP rd_mon_if;
        mailbox #(count_trans) rdmon2sb;
        count_trans duv2mon;
        count_trans mon2sb;

        function new(virtual interface count_if.RD_MON_MP rd_mon_if,
        mailbox #(count_trans) rdmon2sb);
                this.rd_mon_if=rd_mon_if;
                this.rdmon2sb=rdmon2sb;
                this.duv2mon=new();
        endfunction

        virtual task start();
                fork begin
                        forever begin
                                monitor();
                                mon2sb = new duv2mon;
                                rdmon2sb.put(mon2sb);
                        end
                end
                join_none
        endtask

        virtual task monitor();
                @(rd_mon_if.rd_mon_cb);
                duv2mon.count = rd_mon_if.rd_mon_cb.count;
                $display($time, "DATA FROM READ MONITOR: Count = %0d", duv2mon.count);
        endtask

endclass
