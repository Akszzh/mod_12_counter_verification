module mod12_counter(input load,mode,resetn,clock,
                        input [3:0] data_in,
                        output reg [3:0]count);

always @(posedge clock)
        begin
        if(!resetn) begin
                count <= 0;
        end

        else if(load) begin
                count <= data_in;
        end

        else begin
                if(mode == 1) begin
                    if(count == 11) begin
                                count <= 0;
                        end
                        else begin
                                count <= count + 1;
                        end
                end
                else if(mode == 0)begin
                        if(count == 0) begin
                                count <= 11;
                        end
                        else begin
                                count <= count - 1;
                        end
                end
                else
                        count <= count;


        end

end



endmodule
