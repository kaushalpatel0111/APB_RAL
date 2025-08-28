//---------------------------------------------------------------------------
// uvm_test Class: apb_base_test
//---------------------------------------------------------------------------
`ifndef APB_BASE_TEST
`define APB_BASE_TEST

class apb_base_test extends uvm_test;
    `uvm_component_utils(apb_base_test)

    apb_env env_h;

    function new(string name = "apb_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        env_h = apb_env::type_id::create("env_h", this);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction
endclass

`endif
