//---------------------------------------------------------------------------
// uvm_sequence#(apb_transaction) Class: apb_sequence
//---------------------------------------------------------------------------
`ifndef APB_SEQ
`define APB_SEQ

// SANITY_SEQ
class apb_base_sequence extends uvm_sequence#(apb_transaction);
    
    int addr_tmp;
    rand int no_of_txn;

    `uvm_object_utils(apb_base_sequence)
    
    function new(string name = "apb_base_sequence");
        super.new(name);
    endfunction
    
    task body();
        repeat(no_of_txn) begin
            req = apb_transaction::type_id::create("req");
            
            start_item(req);
            assert(req.randomize with {pwrite==1;});
            addr_tmp = req.paddr;
            finish_item(req);

            req = apb_transaction::type_id::create("req");
            
            start_item(req);
            assert(req.randomize with {pwrite==0; paddr == addr_tmp;});
            finish_item(req);
        end
    endtask

endclass

// REG_SEQ
class reg_sequence extends uvm_sequence#(apb_transaction);
    `uvm_object_utils(reg_sequence)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "reg_sequence");
        super.new(name);
    endfunction

    task body();
        req = apb_transaction::type_id::create("req");
        
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");
/*
        // REG MODEL ACCESS
        reg_block.cntrl_inst.set('hF);
        `uvm_info("CNTRL_REG", "---------USING set() API METHOD---------", UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        reg_block.cntrl_inst.predict('hF);
        `uvm_info("CNTRL_REG", "---------USING predict() API METHOD---------", UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg1_inst.set('hCAFE);
        `uvm_info("REG1", "---------USING set() API METHOD---------", UVM_LOW)
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg1_inst.predict('hCAFE);
        `uvm_info("REG1", "---------USING predict() API METHOD---------", UVM_LOW)
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg2_inst.set('hFACE);
        `uvm_info("REG2", "---------USING set() API METHOD---------", UVM_LOW)
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg2_inst.predict('hFACE);
        `uvm_info("REG2", "---------USING predict() API METHOD---------", UVM_LOW)
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg3_inst.set('hFAAB);
        `uvm_info("REG3", "---------USING set() API METHOD---------", UVM_LOW)
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg3_inst.predict('hFAAB);
        `uvm_info("REG3", "---------USING predict() API METHOD---------", UVM_LOW)
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg4_inst.set('hFBBC);
        `uvm_info("REG4", "---------USING set() API METHOD---------", UVM_LOW)
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg4_inst.predict('hFBBC);
        `uvm_info("REG4", "---------USING predict() API METHOD---------", UVM_LOW)
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
*/
        // FRONTDOOR ACCESS
        reg_block.cntrl_inst.write(status, 'hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        reg_block.cntrl_inst.read(status, value);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg1_inst.write(status, 'hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg1_inst.read(status, value);
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg2_inst.write(status, 'hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg2_inst.read(status, value);
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg3_inst.write(status, 'hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg3_inst.read(status, value);
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg4_inst.write(status, 'hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg4_inst.read(status, value);
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
/*
        // RESET
        `uvm_info("REG_SEQ", "------------APPLYING RESET USING RAL API METHOD------------", UVM_LOW)
        reg_block.cntrl_inst.set_reset('hA);
        reg_block.cntrl_inst.get_reset();
        reg_block.cntrl_inst.reset();
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg1_inst.set_reset('hABCD);
        reg_block.reg1_inst.get_reset();
        reg_block.reg1_inst.reset();
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg2_inst.set_reset('hABCD);
        reg_block.reg2_inst.get_reset();
        reg_block.reg2_inst.reset();
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg3_inst.set_reset('hABCD);
        reg_block.reg3_inst.get_reset();
        reg_block.reg3_inst.reset();
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg4_inst.set_reset('hABCD);
        reg_block.reg4_inst.get_reset();
        reg_block.reg4_inst.reset();
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)

        // BACKDOOR ACCESS
        reg_block.cntrl_inst.poke(status, 'hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        reg_block.cntrl_inst.peek(status, value);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg1_inst.poke(status, 'hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg1_inst.peek(status, value);
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg2_inst.poke(status, 'hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg2_inst.peek(status, value);
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg3_inst.poke(status, 'hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg3_inst.peek(status, value);
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg4_inst.poke(status, 'hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg4_inst.peek(status, value);
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
*/
    endtask
endclass

// TC_01
class default_reg_read extends uvm_sequence;
    `uvm_object_utils(default_reg_read)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "default_reg_read");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");

        reg_block.cntrl_inst.read(status, value);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[GET RESET_VALUE] cntrl: %h", reg_block.cntrl_inst.get_reset()), UVM_LOW)

        reg_block.reg1_inst.read(status, value);
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[GET RESET_VALUE] reg1: %h", reg_block.reg1_inst.get_reset()), UVM_LOW)

        reg_block.reg2_inst.read(status, value);
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[GET RESET_VALUE] reg2: %h", reg_block.reg2_inst.get_reset()), UVM_LOW)

        reg_block.reg3_inst.read(status, value);
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[GET RESET_VALUE] reg3: %h", reg_block.reg3_inst.get_reset()), UVM_LOW)

        reg_block.reg4_inst.read(status, value);
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[GET RESET_VALUE] reg4: %h", reg_block.reg4_inst.get_reset()), UVM_LOW)
    endtask 
endclass

// TC_02
class frontdoor_access extends uvm_sequence;
    `uvm_object_utils(frontdoor_access)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "frontdoor_access");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");

        reg_block.cntrl_inst.write(status, 'hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        reg_block.cntrl_inst.read(status, value);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg1_inst.write(status, 'hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg1_inst.read(status, value);
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg2_inst.write(status, 'hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg2_inst.read(status, value);
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg3_inst.write(status, 'hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg3_inst.read(status, value);
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg4_inst.write(status, 'hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg4_inst.read(status, value);
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
    endtask 
endclass

// TC_03
class ro_reg_protection extends uvm_sequence;
    `uvm_object_utils(ro_reg_protection)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "ro_reg_protection");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");
/*
        reg_block.rtmp_inst.read(status, value);
        `uvm_info("REG_TMP", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.rtmp_inst.get()), UVM_LOW)
        `uvm_info("REG_TMP", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.rtmp_inst.get_mirrored_value()), UVM_LOW)
*/
        reg_block.rtmp_inst.write(status, 'hABCDEF);
        `uvm_info("REG_TMP", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.rtmp_inst.get()), UVM_LOW)
        `uvm_info("REG_TMP", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.rtmp_inst.get_mirrored_value()), UVM_LOW)
/*
        reg_block.rtmp_inst.read(status, value);
        `uvm_info("REG_TMP", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.rtmp_inst.get()), UVM_LOW)
        `uvm_info("REG_TMP", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.rtmp_inst.get_mirrored_value()), UVM_LOW)
*/
    endtask 
endclass

// TC_04
class wo_reg_protection extends uvm_sequence;
    `uvm_object_utils(wo_reg_protection)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "wo_reg_protection");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");

        `uvm_info("REG5", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg5_inst.write(status, 'hABCDEF);
        `uvm_info("REG5", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg5_inst.get()), UVM_LOW)
        `uvm_info("REG5", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg5_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG5", "---------USING read() API METHOD---------", UVM_LOW)
        reg_block.reg5_inst.read(status, value);
        `uvm_info("REG5", $sformatf("[DESIRED RD_VALUE] reg5: %h", reg_block.reg5_inst.get()), UVM_LOW)
        `uvm_info("REG5", $sformatf("[MIRRORED RD_VALUE] reg5: %h", reg_block.reg5_inst.get_mirrored_value()), UVM_LOW)

    endtask 
endclass

// TC_05
class field_level_access extends uvm_sequence;
    `uvm_object_utils(field_level_access)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "field_level_access");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");

        reg_block.cntrl_inst.cntrl.write(status, 'hF);
        `uvm_info("CNTRL_REG", "---------FIELD-LEVEL WRITE ACCESS---------", UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.cntrl.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.cntrl.get_mirrored_value()), UVM_LOW)
        reg_block.cntrl_inst.read(status, value);
        `uvm_info("CNTRL_REG", "---------REG-LEVEL READ ACCESS---------", UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg1_inst.reg1.write(status, 'hCAFE);
        `uvm_info("REG1", "---------FIELD-LEVEL WRITE ACCESS---------", UVM_LOW)
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.reg1.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.reg1.get_mirrored_value()), UVM_LOW)
        reg_block.reg1_inst.read(status, value);
        `uvm_info("REG1", "---------REG-LEVEL READ ACCESS---------", UVM_LOW)
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg2_inst.reg2.write(status, 'hFACE);
        `uvm_info("REG2", "---------FIELD-LEVEL WRITE ACCESS---------", UVM_LOW)
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.reg2.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.reg2.get_mirrored_value()), UVM_LOW)
        reg_block.reg2_inst.read(status, value);
        `uvm_info("REG2", "---------REG-LEVEL READ ACCESS---------", UVM_LOW)
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg3_inst.reg3.write(status, 'hFAAB);
        `uvm_info("REG3", "---------FIELD-LEVEL WRITE ACCESS---------", UVM_LOW)
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.reg3.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.reg3.get_mirrored_value()), UVM_LOW)
        reg_block.reg3_inst.read(status, value);
        `uvm_info("REG3", "---------REG-LEVEL READ ACCESS---------", UVM_LOW)
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg4_inst.reg4.write(status, 'hFBBC);
        `uvm_info("REG4", "---------FIELD-LEVEL WRITE ACCESS---------", UVM_LOW)
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.reg4.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.reg4.get_mirrored_value()), UVM_LOW)
        reg_block.reg4_inst.read(status, value);
        `uvm_info("REG4", "---------REG-LEVEL READ ACCESS---------", UVM_LOW)
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
    endtask 
endclass

// TODO: TC_06
class mirror_api_access extends uvm_sequence;
    `uvm_object_utils(mirror_api_access)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "mirror_api_access");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");

        `uvm_info("CNTRL_REG", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.cntrl_inst.write(status, 32'hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("CNTRL_REG", "---------USING read() API METHOD---------", UVM_LOW)
        reg_block.cntrl_inst.read(status, value);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        /*`uvm_info("CNTRL_REG", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.cntrl_inst.predict('hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)*/
        `uvm_info("CNTRL_REG", "---------USING mirror() API METHOD---------", UVM_LOW)
        reg_block.cntrl_inst.mirror(status, UVM_CHECK);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG1", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg1_inst.write(status, 32'hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG1", "---------USING read() API METHOD---------", UVM_LOW)
        reg_block.reg1_inst.read(status, value);
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        /*`uvm_info("REG1", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg1_inst.predict('hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)*/
        `uvm_info("REG1", "---------USING mirror() API METHOD---------", UVM_LOW)
        reg_block.reg1_inst.mirror(status, UVM_CHECK);
        `uvm_info("REG1", $sformatf("[DESIRED VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG2", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg2_inst.write(status, 32'hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG2", "---------USING read() API METHOD---------", UVM_LOW)
        reg_block.reg2_inst.read(status, value);
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        /*`uvm_info("REG2", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg2_inst.predict('hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)*/
        `uvm_info("REG2", "---------USING mirror() API METHOD---------", UVM_LOW)
        reg_block.reg2_inst.mirror(status, UVM_CHECK);
        `uvm_info("REG2", $sformatf("[DESIRED VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG3", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg3_inst.write(status, 32'hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG3", "---------USING read() API METHOD---------", UVM_LOW)
        reg_block.reg3_inst.read(status, value);
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        /*`uvm_info("REG3", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg3_inst.predict('hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)*/
        `uvm_info("REG3", "---------USING mirror() API METHOD---------", UVM_LOW)
        reg_block.reg3_inst.mirror(status, UVM_CHECK);
        `uvm_info("REG3", $sformatf("[DESIRED VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG4", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg4_inst.write(status, 32'hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG4", "---------USING read() API METHOD---------", UVM_LOW)
        reg_block.reg4_inst.read(status, value);
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        /*`uvm_info("REG4", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg4_inst.predict('hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)*/
        `uvm_info("REG4", "---------USING mirror() API METHOD---------", UVM_LOW)
        reg_block.reg4_inst.mirror(status, UVM_CHECK);
        `uvm_info("REG4", $sformatf("[DESIRED VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
    endtask 
endclass

// TC_07
class predict_api_access extends uvm_sequence;
    `uvm_object_utils(predict_api_access)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "predict_api_access");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");

        `uvm_info("CNTRL_REG", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.cntrl_inst.write(status, 'hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("CNTRL_REG", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.cntrl_inst.predict('hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG1", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg1_inst.write(status, 'hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG1", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg1_inst.predict('hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG2", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg2_inst.write(status, 'hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG2", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg2_inst.predict('hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG3", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg3_inst.write(status, 'hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG3", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg3_inst.predict('hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        `uvm_info("REG4", "---------USING write() API METHOD---------", UVM_LOW)
        reg_block.reg4_inst.write(status, 'hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        `uvm_info("REG4", "---------USING predict() API METHOD---------", UVM_LOW)
        reg_block.reg4_inst.predict('hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
    endtask 
endclass

// TC_08
class backdoor_access extends uvm_sequence;
    `uvm_object_utils(backdoor_access)

    apb_reg_block reg_block;
    uvm_status_e status;
    uvm_reg_data_t value;

    function new(string name = "backdoor_access");
        super.new(name);
    endfunction

    task body();
        if(!uvm_config_db#(apb_reg_block)::get(null, "*", "reg_block", reg_block))
            `uvm_fatal("REG_SEQ", "reg_block didn't set properly!");

        reg_block.cntrl_inst.poke(status, 'hF);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED WR_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)
        reg_block.cntrl_inst.peek(status, value);
        `uvm_info("CNTRL_REG", $sformatf("[DESIRED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get()), UVM_LOW)
        `uvm_info("CNTRL_REG", $sformatf("[MIRRORED RD_VALUE] cntrl: %h", reg_block.cntrl_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg1_inst.poke(status, 'hCAFE);
        `uvm_info("REG1", $sformatf("[DESIRED WR_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED WR_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg1_inst.peek(status, value);
        `uvm_info("REG1", $sformatf("[DESIRED RD_VALUE] reg1: %h", reg_block.reg1_inst.get()), UVM_LOW)
        `uvm_info("REG1", $sformatf("[MIRRORED RD_VALUE] reg1: %h", reg_block.reg1_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg2_inst.poke(status, 'hFACE);
        `uvm_info("REG2", $sformatf("[DESIRED WR_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED WR_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg2_inst.peek(status, value);
        `uvm_info("REG2", $sformatf("[DESIRED RD_VALUE] reg2: %h", reg_block.reg2_inst.get()), UVM_LOW)
        `uvm_info("REG2", $sformatf("[MIRRORED RD_VALUE] reg2: %h", reg_block.reg2_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg3_inst.poke(status, 'hFAAB);
        `uvm_info("REG3", $sformatf("[DESIRED WR_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED WR_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg3_inst.peek(status, value);
        `uvm_info("REG3", $sformatf("[DESIRED RD_VALUE] reg3: %h", reg_block.reg3_inst.get()), UVM_LOW)
        `uvm_info("REG3", $sformatf("[MIRRORED RD_VALUE] reg3: %h", reg_block.reg3_inst.get_mirrored_value()), UVM_LOW)

        reg_block.reg4_inst.poke(status, 'hFBBC);
        `uvm_info("REG4", $sformatf("[DESIRED WR_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED WR_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
        reg_block.reg4_inst.peek(status, value);
        `uvm_info("REG4", $sformatf("[DESIRED RD_VALUE] reg4: %h", reg_block.reg4_inst.get()), UVM_LOW)
        `uvm_info("REG4", $sformatf("[MIRRORED RD_VALUE] reg4: %h", reg_block.reg4_inst.get_mirrored_value()), UVM_LOW)
    endtask 
endclass

`endif
