module top();


   import  counter_package::*;

   parameter cycle = 10;

   reg clock;


   count_if DUV_IF(clock);


   count_test base_test_h;


   mod12_counter counter (.clock(clock),
                 .data_in(DUV_IF.data_in),
                 .count(DUV_IF.count),
                 .load(DUV_IF.load),
                 .mode(DUV_IF.mode),
                 .resetn(DUV_IF.resetn)
                );


   initial
      begin
         clock = 1'b0;
         forever #(cycle/2) clock = ~clock;
      end

   initial
      begin

        `ifdef VCS
         $vcdpluson(0, counter_top);
        `endif


         if($test$plusargs("TEST1"))
            begin
               base_test_h = new(DUV_IF,DUV_IF, DUV_IF);
               number_of_transactions = 50;
               base_test_h.build();
               base_test_h.run();
               $finish;
            end

      end
endmodule
