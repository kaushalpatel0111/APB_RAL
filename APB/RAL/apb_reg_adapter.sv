//---------------------------------------------------------------------------
// uvm_reg_adapter Class: apb_reg_adapter
//---------------------------------------------------------------------------
`ifndef APB_REG_ADAPTER
`define APB_REG_ADAPTER

class apb_reg_adapter extends uvm_reg_adapter;
    `uvm_object_utils(apb_reg_adapter)

    function new(string name = "apb_reg_adapter");
        super.new(name);
        //supports_byte_enable = 0;
        //provides_responses = 0;
    endfunction

    virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        apb_transaction tr;    
        tr = apb_transaction::type_id::create("tr");
    
        tr.pwrite    = (rw.kind == UVM_WRITE) ? WRITE : READ;
        tr.paddr     = rw.addr;
        tr.pwdata    = rw.data;
 
        return tr;
    endfunction

    virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        apb_transaction tr;

        assert($cast(tr, bus_item)) else `uvm_fatal("BUS2REG", "Failed to cast!");
 
        rw.kind = (tr.pwrite == WRITE) ? UVM_WRITE : UVM_READ;
        rw.data = (tr.pwrite == WRITE) ? tr.pwdata : tr.prdata;
        rw.addr = tr.paddr;
 
        rw.status = UVM_IS_OK;
    endfunction
endclass

`endif
