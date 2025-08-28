//---------------------------------------------------------------------------
// uvm_test Class: apb_sanity_test
//---------------------------------------------------------------------------
`ifndef APB_SANITY_TEST
`define APB_SANITY_TEST

class apb_sanity_test extends apb_base_test;
    
    `uvm_component_utils(apb_sanity_test)

    apb_base_sequence base_seq_h;

    function new(string name = "apb_sanity_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        base_seq_h = apb_base_sequence::type_id::create("base_seq_h");  
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        base_seq_h.randomize with {no_of_txn == 10;};
        base_seq_h.start(env_h.agent_h.seqr_h);
        phase.phase_done.set_drain_time(this, 250); 
        phase.drop_objection(this);
    endtask

endclass

`endif
