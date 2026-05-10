class count_gen;
        count_trans wrdata;
        count_trans data2send;
        mailbox #(count_trans) gen2wd;


        function new(mailbox #(count_trans) gen2wd);
                this.gen2wd = gen2wd;
                this.wrdata = new();
        endfunction


        virtual task start();
                fork begin
                        for(int i=0;i<number_of_transactions;i++) begin
                                assert(wrdata.randomize());
                                data2send = new wrdata;
                                gen2wd.put(data2send);
                        end
                end
                join_none
        endtask

endclass
