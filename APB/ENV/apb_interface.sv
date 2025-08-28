//---------------------------------------------------------------------------
// Interface: apb_interface
//---------------------------------------------------------------------------
`ifndef APB_INTERFACE
`define APB_INTERFACE

`timescale 1ns/1ns

interface apb_interface(input logic pclk, presetn);
  logic                    psel;
  logic                    penable;
  logic                    pwrite;
  logic [`ADDRWIDTH-1:0]   paddr;
  logic [`DATAWIDTH-1:0]   pwdata;
  logic [`DATAWIDTH-1:0]   prdata;
  //logic                    pready;
  //logic                    pslverr;

  // Clocking block for driver
  clocking drv_cb @(posedge pclk);
    default input #`IN_SKEW output #`OUT_SKEW;
    output psel;
    output penable;
    output pwrite;
    output paddr;
    output pwdata;
    input  prdata;
    //input  pready;
    //input  pslverr;
  endclocking
  
  // Clocking block for monitor
  clocking mon_cb @(posedge pclk);
    default input #`IN_SKEW output #`OUT_SKEW;
    input psel;
    input penable;
    input pwrite;
    input paddr;
    input pwdata;
    input prdata;
    //input pready;
    //input pslverr;
  endclocking
  
  // Modports
  modport DRV (clocking drv_cb, input pclk, presetn);
  modport MON (clocking mon_cb, input pclk, presetn);
endinterface 

`endif
