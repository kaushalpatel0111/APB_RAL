//---------------------------------------------------------------------------
// uvm_sequence_item Class: apb_transaction
//---------------------------------------------------------------------------
`ifndef APB_TXN
`define APB_TXN

typedef enum bit {WRITE = 1'b1, READ = 1'b0} apb_operation_t;

class apb_transaction extends uvm_sequence_item;
    // Randomizable signals
    rand apb_operation_t         pwrite;       // Enum for write or read operation
    rand logic [`ADDRWIDTH-1:0]  paddr;        // APB address
    rand logic [`DATAWIDTH-1:0]  pwdata;       // APB input data
 
    // Sampling signals
    bit  [`DATAWIDTH-1:0] prdata;              // APB output data
    //bit                   pslverr;             // APB error signal

    `uvm_object_utils_begin(apb_transaction)
       `uvm_field_enum(apb_operation_t,pwrite,UVM_ALL_ON)
       `uvm_field_int(paddr, UVM_ALL_ON)
       `uvm_field_int(pwdata, UVM_ALL_ON)
       `uvm_field_int(prdata, UVM_ALL_ON)
       //`uvm_field_int(pslverr, UVM_ALL_ON) 
    `uvm_object_utils_end

    //constraint mem_depth_ctrl{paddr[`ADDRWIDTH-1:0]>=`ADDRWIDTH'd0; paddr[`ADDRWIDTH-1:0]<=32'd31;};
    constraint c_paddr { 
      paddr inside {0, 4, 8, 12, 16};
    }

    function new(string name = "apb_transaction");
        super.new(name);
    endfunction
endclass

`endif
