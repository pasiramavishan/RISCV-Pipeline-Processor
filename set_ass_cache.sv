module set_ass_cache #(
    parameter DATA_WIDTH = 32,      // Word size
    parameter ADDR_WIDTH = 32,    // Address size
    parameter TAG_WIDTH = 28,     // Tag size
    parameter WAY_COUNT = 4,      // Associativity
    parameter SET_COUNT = 4,      // Number of sets
    parameter LINE_SIZE = 4       // Words per cache line
)(
    input  logic                  clk,
    input  logic                  rstn,
    input  logic                  ReadEn,
    input  logic                  WriteEn,
    input  logic [ADDR_WIDTH-1:0] Addr,
    input logic [2:0]             funct3,
    input  logic [DATA_WIDTH-1:0] WriteData,
    output logic [DATA_WIDTH-1:0] ReadData,
    output logic cacheReady
    // output logic                  MemReadEn,
    // output logic                  MemWriteEn,
    // output logic [ADDR_WIDTH-1:0] MemAddr,
    // output logic [DATA_WIDTH-1:0] MemWriteData,
    // input  logic [DATA_WIDTH-1:0] MemReadData
);

logic                  MemReadEn;
logic                  MemWriteEn;
logic [DATA_WIDTH-1:0] MemReadData[LINE_SIZE];

// Cache line definition
typedef struct {
    logic [TAG_WIDTH-1:0] tag;            // Tag
    logic [DATA_WIDTH-1:0] data[LINE_SIZE]; // Data array
} cache_line_t;

// Cache memory: 4 sets, 4 ways per set
cache_line_t cache[SET_COUNT][WAY_COUNT];

// Internal signals
logic [TAG_WIDTH-1:0] tag;
logic [$clog2(SET_COUNT)-1:0] index;
logic [$clog2(LINE_SIZE)-1:0] word_offset;
logic hit;
logic [1:0] hit_way;
logic [1:0] lru_way[SET_COUNT]; // LRU replacement policy per set

// Address decoding
assign tag         = Addr[ADDR_WIDTH-1:ADDR_WIDTH-TAG_WIDTH];
assign index       = Addr[$clog2(SET_COUNT) + $clog2(LINE_SIZE) - 1:$clog2(LINE_SIZE)];
assign word_offset = Addr[$clog2(LINE_SIZE)-1:0];

// Hit detection
always_comb begin
    hit = 0;
    hit_way = 0; // Default value
    for (int i = 0; i < WAY_COUNT; i++) begin
        if (cache[index][i].tag == tag) begin
            hit = 1;
            hit_way = i;
        end
    end
end


// Memory interface signals
assign MemReadEn   = ~hit & ReadEn;
// assign MemWriteEn  = ~hit & WriteEn & cache[index][lru_way[index]].dirty;
assign MemAddr     = {cache[index][lru_way[index]].tag, index, word_offset};  // adress
assign MemWriteData = cache[index][lru_way[index]].data[word_offset];

// LRU replacement policy (simple round-robin for now)
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        for (int set = 0; set < SET_COUNT; set++) begin
            lru_way[set] <= 0;
        end
    end else if (MemReadEn) begin
        lru_way[index] <= lru_way[index] + 1;
    end
end

// Cache operations
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        // // Reset cache: invalidate all lines
        // for (int set = 0; set < SET_COUNT; set++) begin
        //     for (int way = 0; way < WAY_COUNT; way++) begin
        //         // cache[set][way].valid <= 0;
        //         cache[set][way].dirty <= 0;
        //     end
        // end
        cacheReady <= 1'b0;
    end else begin
        if (ReadEn) begin
            if (hit) begin
                // Cache hit: Read data
                ReadData <= cache[index][hit_way].data[word_offset];
                cacheReady <= 1'b0;
            end else begin
                // Cache miss: Fetch from memory
                // cache[index][lru_way[index]].valid <= 1;
                // cache[index][lru_way[index]].dirty <= 0;
                cache[index][lru_way[index]].tag <= tag;
                // cache[index][lru_way[index]].data[word_offset] <= ReadData;
                cache[index][lru_way[index]].data <= MemReadData;
                ReadData <= MemReadData[word_offset];
                cacheReady <= 1'b1;
            end
        end

        if (WriteEn) begin
            if (hit) begin
                // Cache hit: Write data
                cache[index][hit_way].data[word_offset] <= WriteData;
                // cache[index][hit_way].dirty <= 1;
            end 
            // else begin
            //     // Cache miss: Fetch from memory and write
            //     cache[index][lru_way[index]].valid <= 1;
            //     cache[index][lru_way[index]].dirty <= 1;
            //     cache[index][lru_way[index]].tag <= tag;
            //     cache[index][lru_way[index]].data[word_offset] <= WriteData;
            // end
        end
    end
end


data_mem data_memory(
    .clk(clk),
    .rstn(rstn),
    .ReadEn(MemReadEn),
    .WriteEn(WriteEn),
    .Addr(Addr),
    .WriteData(WriteData),
    .data(MemReadData),
    .funct3(funct3)
);

endmodule
