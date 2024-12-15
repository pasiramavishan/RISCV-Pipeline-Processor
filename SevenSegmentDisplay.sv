module SevenSegmentDisplay (
    input logic [3:0] number,       // Input: 4-bit number (0–9)
    output logic [6:0] segments    // Output: 7 segments (a-g)
);

    always_comb begin
        case (number)
            4'd0: segments = 7'b1111110; // Display 0
            4'd1: segments = 7'b0110000; // Display 1
            4'd2: segments = 7'b1101101; // Display 2
            4'd3: segments = 7'b1111001; // Display 3
            4'd4: segments = 7'b0110011; // Display 4
            4'd5: segments = 7'b1011011; // Display 5
            4'd6: segments = 7'b1011111; // Display 6
            4'd7: segments = 7'b1110000; // Display 7
            4'd8: segments = 7'b1111111; // Display 8
            4'd9: segments = 7'b1111011; // Display 9
            default: segments = 7'b0000000; // Blank display for invalid input
        endcase
    end

endmodule
