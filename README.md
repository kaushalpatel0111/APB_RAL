# 🧪 APB RAL Project – UVM Register Abstraction Layer

This project demonstrates the implementation of a **UVM Register Abstraction Layer (RAL)** model for a DUT based on the **AMBA APB (Advanced Peripheral Bus)** protocol.

As a Design Verification Engineer, I built this project to get hands-on experience with UVM RAL, focusing on modeling registers, integrating the model into a UVM testbench, and verifying register-level behavior.

---

## 📌 Project Objectives

- Understand and implement UVM RAL concepts
- Model registers and integrate them into a UVM testbench
- Connect RAL model with APB ENV and DUT
- Create test sequences for register operations
- Understand Frontdoor and Backdoor Access

---

## 🧱 Project Structure

APB/<br>
│<br>
├── ENV/&nbsp;&nbsp; # TB Environment<br>
├── RAL/&nbsp;&nbsp; # Register Model<br>
├── RTL/&nbsp;&nbsp; # APB Slave DUT<br>
├── SIM/&nbsp;&nbsp; # TB Simulation<br>
├── TEST/&nbsp; # Testcases<br>
└── TOP/&nbsp;&nbsp; # TB TOP Module<br>

---

## 🚀 Features

- UVM-based APB testbench
- Register model created using UVM RAL
- Adapter and predictor for APB-RAL connectivity
- Register tests: `set_reset()`, `get_reset()`, `reset()`, `set()`, `get()`, `get_mirrored_value()`, `write()`, `read()`, `poke()`, `peek()`, `predict()`
- Check with all the register field access policy

---

## 📋 Requirements

- SystemVerilog simulator (e.g., **QuestaSim**, **Synopsys VCS**, **Xcelium**)
- UVM library (IEEE 1800.2 or equivalent)
- Basic understanding of UVM and SystemVerilog

---

## 📚 What I Learned

- How to define and build UVM register models (`uvm_reg`, `uvm_reg_block`, etc.)
- Connecting RAL models with APB interface using `uvm_reg_adapter`
- Register testing using standard UVM RAL sequences
- Debugging register read/write mismatches via backdoor/frontdoor access
- Importance of using RAL for scalable verification environments

---

## 🛠️ How to Run

> Note: The makefile only compatible with **QuestaSim** tool. So, adjust simulation steps based on your simulator.

1. Compile all RTL, UVM TB, and RAL files
2. Run the simulation
3. Observe register test output (logs, coverage reports)

---

## 🤝 Feedback and Contributions

This project is part of my ongoing learning journey in advanced UVM concepts.  
Feel free to fork, clone, or suggest improvements. Feedback is always welcome!

---

## 📧 Contact

**Kaushal Patel**  
Design Verification Engineer  
[LinkedIn](https://www.linkedin.com/in/kaushal-patel-852520242?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app)

---
