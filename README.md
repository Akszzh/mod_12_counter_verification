# Mod-12 Counter Verification using QuestaSim

## 📌 Project Overview

This project implements and verifies a **Mod-12 Counter** using **Verilog HDL**. Functional verification and coverage analysis are performed using QuestaSim to ensure correctness of the design.

---

## 🛠️ Tools & Technologies

* Verilog HDL
* QuestaSim (Mentor Graphics)
* Makefile (for automation)
* Functional Coverage (Branches, Conditions, Toggles)

---

## 📂 Project Structure

* `src/` → Design files
* `tb/` → Testbench
* `sim/` → Simulation scripts
* `coverage/` → Coverage screenshots

---

## ▶️ How to Run

### Run regression:

```
make regress12
```

### Generate coverage report:

```
make covhtml
```

---

## 📊 Coverage Analysis

* Achieved **99.22% coverage**
* Coverage includes:

  * Branch Coverage
  * Condition Coverage
  * Toggle Coverage

### 📸 Coverage Reports

![Coverage Report](images/image (1).png)
![Coverage Report](images/image (2).png)

---

## ⚠️ Coverage Limitation (Remaining 0.78%)

The remaining **0.78% coverage** is due to the following condition:

```verilog id="4kqz9w"
if ($test$plusargs("TEST1"))
```

### Issue:

* Only the **TRUE condition** was executed
* The **FALSE condition was not covered**, leading to incomplete branch coverage

### Reason:

The simulation was executed only with:

```
+TEST1
```

So:

* `$test$plusargs("TEST1") == 1` → Covered ✅
* `$test$plusargs("TEST1") == 0` → Not Covered ❌

---

## 💡 How to Achieve 100% Coverage

To fully cover the design:

1. Run regression **with plusarg**
2. Run regression **without plusarg**
3. Merge both coverage results

---

## 🎯 Learning Outcomes

* RTL design of Mod-12 Counter
* Automated simulation using Makefile
* Functional verification techniques
* Coverage analysis and debugging
* Identifying uncovered branches

---

## 🚀 Future Improvements

* Add SystemVerilog Assertions (SVA)
* Implement constrained random testing
* Automate multiple test scenarios
* Achieve 100% functional coverage

---

## 📌 Conclusion

The project successfully verifies the Mod-12 Counter with **99.22% coverage**. The remaining uncovered portion is due to a **testbench-controlled condition**, which can be resolved by executing multiple simulation scenarios.
