//---------------------------------------------------------------------------
// uvm_agent Class: apb_agent
//---------------------------------------------------------------------------
`ifndef APB_AGENT
`define APB_AGENT

class apb_agent extends uvm_agent;
    `uvm_component_utils(apb_agent)

    uvm_analysis_port #(apb_transaction) ap;

    apb_sequencer seqr_h;
    apb_driver drv_h;
    apb_monitor mon_h;
    apb_reg_adapter reg_adapter;

    function new(string name = "a_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap = new("ap", this);

        seqr_h = apb_sequencer::type_id::create("seqr_h", this);
        drv_h = apb_driver::type_id::create("drv_h", this);
        mon_h = apb_monitor::type_id::create("mon_h", this);
        reg_adapter = apb_reg_adapter::type_id::create("reg_adapter", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        drv_h.seq_item_port.connect(seqr_h.seq_item_export);
        mon_h.anlys_port.connect(ap);
    endfunction
endclass

`endif
