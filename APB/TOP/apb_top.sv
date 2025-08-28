//---------------------------------------------------------------------------
// Top Module: apb_top
//---------------------------------------------------------------------------
`ifndef APB_TOP
`define APB_TOP

`include "apb_define.sv"
`include "../ENV/apb_interface.sv"

module apb_top;
    import uvm_pkg::*;
    import apb_pkg::*;
    `include "uvm_macros.svh"

    // Declaring global signals
    bit pclk, presetn;

    // Variable to hold the frequency from $plusargs
    real freq = 100.0; // Default frequency in MHz

    // Compute clock period & duty cycle based on frequency
    real clk_period;
    real duty_cycle;
    real tclk_high; 
    real tclk_low;

    // Clock generation
    initial begin
        // Read clock frequency from $plusargs
        if ($value$plusargs("clk_freq=%f", freq)) begin
            $display("Clock frequency set to %f MHz", freq);
        end else begin
            $display("Using default clock frequency %f MHz", freq);
        end

        // Compute clock period, duty cycle, and jitter
        clk_period = 1.0 / freq * 1000; // Clock period in ns
        duty_cycle = 0.5; // 50% Duty cycle
        tclk_high = clk_period * duty_cycle;
        tclk_low = clk_period - tclk_high;

        // Generate clock
        forever begin
            #tclk_low;
            pclk = 1;
            #tclk_high;
            pclk = 0;
        end
    end

    // Initial Reset
    task init_rst();
      presetn = 0;
      @(posedge pclk); 
      presetn = 1;      
    endtask

    // Initiate the reset
    initial begin
        // Initiate initial reset from $plusargs
        if ($test$plusargs("init_rst")) begin
            $display("Applying initial reset");
            init_rst();
        end
    end

    // APB Interface instantiation
    apb_interface intf(pclk, presetn);
 
    // DUT Instantiation
    APB SLAVE_DUT (
        .PCLK(pclk),
        .PRESETn(presetn),
        .PSEL(intf.psel),
        .PENABLE(intf.penable),
        .PWRITE(intf.pwrite),
        .PADDR(intf.paddr),
        .PWDATA(intf.pwdata),
        .PRDATA(intf.prdata)
        //.PREADY(intf.pready),
        //.PSLVERR(intf.pslverr)
    );

    initial begin
        fork
            uvm_config_db#(virtual apb_interface)::set(uvm_root::get(), "*","apb_interface", intf);
            run_test("apb_base_test");
        join
    end
endmodule

`endif
