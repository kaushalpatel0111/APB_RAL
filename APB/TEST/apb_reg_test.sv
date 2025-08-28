//---------------------------------------------------------------------------
// uvm_test Class: apb_reg_test
//---------------------------------------------------------------------------
`ifndef APB_REG_TEST
`define APB_REG_TEST

class apb_reg_test extends apb_base_test;
    
    `uvm_component_utils(apb_reg_test)

    reg_sequence reg_seq_h; 
          
    function new(string name = "apb_reg_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        reg_seq_h = reg_sequence::type_id::create("reg_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        reg_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-1: default_read_test
//---------------------------------------------------------------------------
class default_read_test extends apb_base_test;
    
    `uvm_component_utils(default_read_test)

    default_reg_read default_reg_seq_h; 
          
    function new(string name = "default_read_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        default_reg_seq_h = default_reg_read::type_id::create("default_reg_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        default_reg_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-2: frontdoor_access_test
//---------------------------------------------------------------------------
class frontdoor_access_test extends apb_base_test;
    
    `uvm_component_utils(frontdoor_access_test)

    frontdoor_access frontdoor_access_seq_h; 
          
    function new(string name = "frontdoor_access_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        frontdoor_access_seq_h = frontdoor_access::type_id::create("frontdoor_access_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        frontdoor_access_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-3: ro_reg_prot_test
//---------------------------------------------------------------------------
class ro_reg_prot_test extends apb_base_test;
    
    `uvm_component_utils(ro_reg_prot_test)

    ro_reg_protection ro_reg_protection_seq_h; 
          
    function new(string name = "ro_reg_prot_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        ro_reg_protection_seq_h = ro_reg_protection::type_id::create("ro_reg_protection_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        ro_reg_protection_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-4: wo_reg_prot_test
// (Apply this test to verify all the reg-field access policy)
//---------------------------------------------------------------------------
class wo_reg_prot_test extends apb_base_test;
    
    `uvm_component_utils(wo_reg_prot_test)

    wo_reg_protection wo_reg_protection_seq_h; 
          
    function new(string name = "wo_reg_prot_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        wo_reg_protection_seq_h = wo_reg_protection::type_id::create("wo_reg_protection_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        wo_reg_protection_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-5: field_level_test
//---------------------------------------------------------------------------
class field_level_test extends apb_base_test;
    
    `uvm_component_utils(field_level_test)

    field_level_access field_level_access_seq_h; 
          
    function new(string name = "field_level_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        field_level_access_seq_h = field_level_access::type_id::create("field_level_access_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        field_level_access_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-6: reg_mirror_test
//---------------------------------------------------------------------------
class reg_mirror_test extends apb_base_test;
    
    `uvm_component_utils(reg_mirror_test)

    mirror_api_access mirror_api_access_seq_h; 
          
    function new(string name = "reg_mirror_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        mirror_api_access_seq_h = mirror_api_access::type_id::create("mirror_api_access_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        mirror_api_access_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-7: reg_prediction_test
//---------------------------------------------------------------------------
class reg_prediction_test extends apb_base_test;
    
    `uvm_component_utils(reg_prediction_test)

    predict_api_access predict_api_access_seq_h; 
          
    function new(string name = "reg_prediction_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        predict_api_access_seq_h = predict_api_access::type_id::create("predict_api_access_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        predict_api_access_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

//---------------------------------------------------------------------------
// Testcase-8: backdoor_test
//---------------------------------------------------------------------------
class backdoor_test extends apb_base_test;
    
    `uvm_component_utils(backdoor_test)

    backdoor_access backdoor_access_seq_h; 
          
    function new(string name = "backdoor_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        backdoor_access_seq_h = backdoor_access::type_id::create("backdoor_access_seq_h");
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        backdoor_access_seq_h.start(env_h.agent_h.seqr_h);
        
        phase.drop_objection(this);
    endtask

endclass

`endif
