module top #(
    parameter CYCLE_LEN = 2000000 // length of time each color should be on for 
    )(
    input logic clk, 
    output logic RGB_R, 
    output logic RGB_G, 
    output logic RGB_B
);

    localparam [2:0] RED        = 3'b100; // R
    localparam [2:0] YELLOW     = 3'b110; // R + G = Yellow
    localparam [2:0] GREEN      = 3'b010; // G
    localparam [2:0] CYAN       = 3'b011; // G + B = Cyan
    localparam [2:0] BLUE       = 3'b001; // B
    localparam [2:0] MAGENTA    = 3'b101; // R + B = Magenta

    // initializing state to RED so the cycle begins on RED
    logic [2:0] state = RED;
    // initializing count to begin at 2000000, to ensure RED is on for a full 1/6 of a second
    logic [21:0] count = CYCLE_LEN;

    /* always_ff procedural block with case multi-way branch structure.
    The count is decremented to 0 for each color cycle. At the next color, 
    the count is reinitialized and the cycle continues. */
    always_ff @(posedge clk) begin
        case (state)
            RED: begin
                if (count > 22'd0) begin
                    count <= count - 1;
                end
                else begin
     
                    count <= CYCLE_LEN;
                    state <= YELLOW;
                end
            end
            YELLOW: begin
                if (count > 22'd0) begin
                    count <= count - 1;
                end
                else begin

                    count <= CYCLE_LEN;
                    state <= GREEN;
                end
            end
            GREEN: begin
                if (count > 22'd0) begin
                    count <= count - 1;
                end
                else begin
                    count <= CYCLE_LEN;
                    state <= CYAN;
                end
            end
            CYAN: begin
                if (count > 22'd0) begin
                    count <= count - 1;
                end
                else begin
                    count <= CYCLE_LEN;
                    state <= BLUE;
                end
            end
            BLUE: begin
                if (count > 22'd0) begin
                    count <= count - 1;
                end
                else begin
                    count <= CYCLE_LEN;
                    state <= MAGENTA;
                end
            end
            MAGENTA: begin
                if (count > 22'd0) begin
                    count <= count - 1;
                end
                else begin
                    count <= CYCLE_LEN;
                    state <= RED;
                end
            end
        endcase
    end
// using bitwise NOT to invert color encodings, since RGB's are active low
assign{RGB_R, RGB_G, RGB_B} = ~state;
endmodule