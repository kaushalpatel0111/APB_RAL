`ifndef APB_REG_MODEL
`define APB_REG_MODEL

//---------------------------------------------------------------------------
// uvm_reg Class: cntrl_reg 
//---------------------------------------------------------------------------
class cntrl_reg extends uvm_reg;
    `uvm_object_utils(cntrl_reg)
    
    rand uvm_reg_field cntrl;
   
    function new(string name = "cntrl_reg");
      super.new(name, 4, build_coverage(UVM_NO_COVERAGE));
    endfunction
   
    virtual function void build();
        cntrl     = uvm_reg_field::type_id::create("cntrl");
        cntrl.configure(this, 4, 0, "RW", 1, 4'h0, 1, 1, 1);
    endfunction 
 
endclass

//---------------------------------------------------------------------------
// uvm_reg Class: reg1_reg
//---------------------------------------------------------------------------
class reg1_reg extends uvm_reg;
    `uvm_object_utils(reg1_reg)
    
    rand    uvm_reg_field   reg1;
   
    function new(string name = "reg1_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction : new
   
    virtual function void build();
        reg1     = uvm_reg_field::type_id::create("reg1");
        reg1.configure(this, 32, 0, "RW", 1, 32'h0, 1, 1, 1);
    endfunction 
 
endclass

//---------------------------------------------------------------------------
// uvm_reg Class: reg2_reg
//---------------------------------------------------------------------------
class reg2_reg extends uvm_reg;
  `uvm_object_utils(reg2_reg)
    
    rand    uvm_reg_field   reg2;
   
  function new(string name = "reg2_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction : new
   
    virtual function void build();
        reg2     = uvm_reg_field::type_id::create("reg2");
        reg2.configure(this, 32, 0, "RW", 1, 32'h0, 1, 1, 1);
    endfunction 
 
endclass

//---------------------------------------------------------------------------
// uvm_reg Class: reg3_reg
//---------------------------------------------------------------------------
class reg3_reg extends uvm_reg;
  `uvm_object_utils(reg3_reg)
    
    rand    uvm_reg_field   reg3;
   
  function new(string name = "reg3_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction : new
   
    virtual function void build();
        reg3     = uvm_reg_field::type_id::create("reg3");
        reg3.configure(this, 32, 0, "RW", 1, 32'h0, 1, 1, 1);
    endfunction 
 
endclass

//---------------------------------------------------------------------------
// uvm_reg Class: reg4_reg
//---------------------------------------------------------------------------
class reg4_reg extends uvm_reg;
   `uvm_object_utils(reg4_reg)
    
    rand    uvm_reg_field   reg4;
   
   function new(string name = "reg4_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction : new
   
    virtual function void build();
        reg4     = uvm_reg_field::type_id::create("reg4");
        reg4.configure(this, 32, 0, "RW", 1, 32'h0, 1, 1, 1);
    endfunction 
 
endclass

//---------------------------------------------------------------------------
// uvm_reg Class: reg5_reg
//---------------------------------------------------------------------------
class reg5_reg extends uvm_reg;
   `uvm_object_utils(reg5_reg)
    
    rand    uvm_reg_field   reg5;
   
   function new(string name = "reg5_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction : new
   
    virtual function void build();
        reg5     = uvm_reg_field::type_id::create("reg5");
        reg5.configure(this, 32, 0, "WO", 1, 32'h0, 1, 1, 1); // Use all types of access policy in this reg_field
    endfunction 
 
endclass

//---------------------------------------------------------------------------
// uvm_reg Class: read_tmp_reg
//---------------------------------------------------------------------------
class read_tmp_reg extends uvm_reg;
   `uvm_object_utils(read_tmp_reg)
    
    rand    uvm_reg_field   read_tmp;
   
   function new(string name = "read_tmp_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction : new
   
    virtual function void build();
        read_tmp     = uvm_reg_field::type_id::create("read_tmp");
        read_tmp.configure(this, 32, 0, "RO", 1, 32'h0, 1, 1, 1);
    endfunction 
 
endclass

//---------------------------------------------------------------------------
// uvm_reg_block Class: apb_reg_block
//---------------------------------------------------------------------------
class apb_reg_block extends uvm_reg_block;
    `uvm_object_utils(apb_reg_block)

    cntrl_reg cntrl_inst;
    reg1_reg  reg1_inst;
    reg2_reg  reg2_inst;
    reg3_reg  reg3_inst;
    reg4_reg  reg4_inst;
    reg5_reg  reg5_inst;
    read_tmp_reg  rtmp_inst;

    function new(string name = "apb_reg_block");
        super.new(name, build_coverage(UVM_NO_COVERAGE));
    endfunction : new 

   virtual function void build();
        add_hdl_path("apb_top.SLAVE_DUT", "RTL");

        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN,0); // name, base, nBytes

        cntrl_inst = cntrl_reg::type_id::create("cntrl_inst");
        cntrl_inst.build();
        cntrl_inst.configure(this,null);
        cntrl_inst.add_hdl_path_slice("cntrl", 0, 4);

        reg1_inst = reg1_reg::type_id::create("reg1_inst");
        reg1_inst.build();
        reg1_inst.configure(this,null);
        reg1_inst.add_hdl_path_slice("reg1", 0, 32);

        reg2_inst = reg2_reg::type_id::create("reg2_inst");
        reg2_inst.build();
        reg2_inst.configure(this,null);
        reg2_inst.add_hdl_path_slice("reg2", 0, 32);

        reg3_inst = reg3_reg::type_id::create("reg3_inst");
        reg3_inst.build();
        reg3_inst.configure(this,null);
        reg3_inst.add_hdl_path_slice("reg3", 0, 32);

        reg4_inst = reg4_reg::type_id::create("reg4_inst");
        reg4_inst.build();
        reg4_inst.configure(this,null);
        reg4_inst.add_hdl_path_slice("reg4", 0, 32);

        reg5_inst = reg5_reg::type_id::create("reg5_inst");
        reg5_inst.build();
        reg5_inst.configure(this,null);
        reg5_inst.add_hdl_path_slice("reg5", 0, 32);

        rtmp_inst = read_tmp_reg::type_id::create("rtmp_inst");
        rtmp_inst.build();
        rtmp_inst.configure(this,null);
        rtmp_inst.add_hdl_path_slice("reg4", 0, 32);

        default_map.add_reg(cntrl_inst	, 'h0, "RW");  // reg, offset, access
        default_map.add_reg(reg1_inst	, 'h4, "RW");  // reg, offset, access
        default_map.add_reg(reg2_inst	, 'h8, "RW");  // reg, offset, access
        default_map.add_reg(reg3_inst	, 'hc, "RW");  // reg, offset, access
        default_map.add_reg(reg4_inst	, 'h10, "RW");  // reg, offset, access
        default_map.add_reg(reg5_inst	, 'h14, "RW");  // reg, offset, access
        default_map.add_reg(rtmp_inst	, 'h18, "RO");  // reg, offset, access

        lock_model();
    endfunction
endclass

`endif
