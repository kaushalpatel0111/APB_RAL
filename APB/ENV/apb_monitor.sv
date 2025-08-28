//---------------------------------------------------------------------------
// uvm_monitor Class: apb_monitor
//---------------------------------------------------------------------------
`ifndef APB_MON
`define APB_MON

class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor)

    uvm_analysis_port #(apb_transaction) anlys_port;

    virtual apb_interface vif;

    apb_transaction item;

    function new(string name = "apb_monitor", uvm_component parent = null);
        super.new(name, parent);

        item = new();
        anlys_port = new("anlys_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if (!uvm_config_db #(virtual apb_interface)::get(this," ", "apb_interface", vif))
            `uvm_fatal("MON_FATAL", "Virtual interface Configuration is not set properly");
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(vif.MON.mon_cb);
            monitor();
            anlys_port.write(item);
        end
    endtask

    task monitor();
        if(item.pwrite == WRITE) begin
            wr_mon();
        end else begin
            rd_mon();
        end
    endtask

    task wr_mon();
        item.pwrite = apb_operation_t'(vif.MON.mon_cb.pwrite);
        item.paddr = vif.MON.mon_cb.paddr;
        item.pwdata = vif.MON.mon_cb.pwdata;
        //item.pslverr = vif.MON.mon_cb.pslverr;
    endtask

    task rd_mon();
        item.pwrite = apb_operation_t'(vif.MON.mon_cb.pwrite);
        item.paddr = vif.MON.mon_cb.paddr;
        item.prdata = vif.MON.mon_cb.prdata;
        //item.pslverr = vif.MON.mon_cb.pslverr;
    endtask
endclass

`endif
