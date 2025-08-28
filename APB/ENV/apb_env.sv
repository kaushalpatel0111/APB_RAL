//---------------------------------------------------------------------------
// uvm_env Class: apb_env
//---------------------------------------------------------------------------
`ifndef APB_ENV
`define APB_ENV

class apb_env extends uvm_env;
    `uvm_component_utils(apb_env)

    apb_agent agent_h;
    //apb_scoreboard scb_h;
    //apb_coverage fc_h;
    apb_reg_block reg_block;
    apb_reg_predictor reg_predictor;

    function new(string name = "apb_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        agent_h = apb_agent::type_id::create("agent_h", this);
        //scb_h = apb_scoreboard::type_id::create("scb_h", this);
        //fc_h = apb_coverage::type_id::create("fc_h", this);
        reg_block = apb_reg_block::type_id::create("reg_block", this);
        reg_block.build();
        reg_predictor = apb_reg_predictor::type_id::create("reg_predictor", this);
        uvm_config_db#(apb_reg_block)::set(null, "*", "reg_block", reg_block);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        //agent_h.ap.connect(scb_h.analysis_export); 
        //agent_h.ap.connect(fc_h.analysis_export);

        //reg_block.default_map.set_auto_predict(1);
        reg_block.default_map.set_sequencer(agent_h.seqr_h, agent_h.reg_adapter);
        reg_predictor.map = reg_block.default_map;
        reg_predictor.adapter = agent_h.reg_adapter;
 
        agent_h.ap.connect(reg_predictor.bus_in);
    endfunction

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        reg_block.print();
    endfunction
endclass

`endif
