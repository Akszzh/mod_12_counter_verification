class count_trans;
        rand logic [3:0] data_in;
        rand logic mode;
        rand logic load;
        rand logic resetn;
        logic [3:0] count;
        static int trans_id;
        static int up_count;
        static int down_count;


        constraint C1 {data_in inside {[0:12]};}
        constraint C2 {mode  dist {0:=50 , 1:=50};}
        constraint C3 {load dist {0:=70 , 1 := 30};}
        constraint C4 {resetn dist {0 := 10 , 1:=90};}

        function void display(input string str);
                $display("########%s########",str);
                $display("data in value is : %d",data_in);
                $display("mode : %d, resetn : %d, load : %d",mode,resetn,load);
                $display("trans id : %d",trans_id);
                $display("up count : %d",up_count);
                $display("down count : %d",down_count);
        endfunction

        function void post_randomize();
                trans_id++;
                if (resetn && !load) begin
                  if (mode)
                    up_count++;
                  else
                    down_count++;
                end

                this.display("RANDOMIZED DATA");
        endfunction

endclass
