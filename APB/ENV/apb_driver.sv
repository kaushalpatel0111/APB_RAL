//---------------------------------------------------------------------------
// uvm_driver Class: apb_driver
//---------------------------------------------------------------------------
`ifndef APB_DRV
`define APB_DRV

class apb_driver extends uvm_driver#(apb_transaction);
    `uvm_component_utils(apb_driver)

    virtual apb_interface vif;

    function new(string name = "apb_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db #(virtual apb_interface)::get(this," ", "apb_interface", vif))
            `uvm_fatal("DRV_FATAL", "Virtual interface Configuration is not set properly");
    endfunction

    task run_phase(uvm_phase phase);  
        wait(!vif.DRV.presetn);
        drv_reset();
        wait(vif.DRV.presetn);
        
        forever begin
            fork
            begin
                wait(!vif.DRV.presetn);
            end

            forever begin
                @(vif.DRV.drv_cb);
                seq_item_port.get_next_item(req);
                drive();
                seq_item_port.item_done();
            end
            join_any
            disable fork;
            drv_reset();
            wait(vif.DRV.presetn);
        end
    endtask
    
    task drv_reset();
        vif.DRV.drv_cb.psel <= 1'b0;
        vif.DRV.drv_cb.penable <= 1'b0;
        vif.DRV.drv_cb.pwrite <= 1'b0;
        vif.DRV.drv_cb.paddr <= '0;
        vif.DRV.drv_cb.pwdata <= '0;
    endtask

    task drive();
        if(req.pwrite == WRITE) begin
            wr_drv();
        end else begin
            rd_drv();
        end
    endtask

    task wr_drv(); 
        vif.DRV.drv_cb.psel   <= 1'b1;
        vif.DRV.drv_cb.penable<= 1'b0;
        vif.DRV.drv_cb.pwrite <= req.pwrite;
        vif.DRV.drv_cb.paddr  <= req.paddr;
        vif.DRV.drv_cb.pwdata <= req.pwdata;
        @(vif.DRV.drv_cb);
        vif.DRV.drv_cb.penable<= 1'b1;
        @(vif.DRV.drv_cb);
        vif.DRV.drv_cb.psel   <= 1'b0;
        vif.DRV.drv_cb.penable<= 1'b0;
    endtask

    task rd_drv();
        vif.DRV.drv_cb.psel   <= 1'b1;
        vif.DRV.drv_cb.penable<= 1'b0;
        vif.DRV.drv_cb.pwrite <= req.pwrite;
        vif.DRV.drv_cb.paddr  <= req.paddr;
        @(vif.DRV.drv_cb);
        vif.DRV.drv_cb.penable<= 1'b1;
        @(vif.DRV.drv_cb);
        vif.DRV.drv_cb.psel   <= 1'b0;
        vif.DRV.drv_cb.penable<= 1'b0;
    endtask
endclass

`endif
