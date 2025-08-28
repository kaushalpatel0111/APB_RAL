//---------------------------------------------------------------------------
// uvm_sequencer Class: apb_sequencer
//---------------------------------------------------------------------------
`ifndef APB_SEQR
`define APB_SEQR

class apb_sequencer extends uvm_sequencer#(apb_transaction);
    `uvm_component_utils(apb_sequencer)

    function new(string name = "a_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass

`endif
