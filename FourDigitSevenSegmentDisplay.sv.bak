module FourDigitSevenSegmentDisplay (
    input logic [31:0] number,       // Input: 4-digit number (16 bits, max value 9999)
    output logic [6:0] seg0,         // Output for rightmost digit
    output logic [6:0] seg1,         // Output for second digit
    output logic [6:0] seg2,         // Output for third digit
    output logic [6:0] seg3          // Output for leftmost digit
);

    // Internal signals for individual digits
    logic [3:0] digit0, digit1, digit2, digit3;

    // Extract digits from the input number
    always_comb begin
        digit0 = number % 10;        // Rightmost digit
        digit1 = (number / 10) % 10; // Second digit
        digit2 = (number / 100) % 10;// Third digit
        digit3 = (number / 1000) % 10;// Leftmost digit
    end

    // Instantiate the seven-segment decoder for each digit
    SevenSegmentDisplay decoder0 (.number(digit0), .segments(seg0));
    SevenSegmentDisplay decoder1 (.number(digit1), .segments(seg1));
    SevenSegmentDisplay decoder2 (.number(digit2), .segments(seg2));
    SevenSegmentDisplay decoder3 (.number(digit3), .segments(seg3));

endmodule
