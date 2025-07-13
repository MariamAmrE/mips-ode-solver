
# 🧮 MIPS ODE Solver (First-Order ODE in MARS IDE)

## 📘 Overview
This project is a MIPS 32-bit assembly implementation of a **first-order ordinary differential equation (ODE) solver**, developed and tested using the **MARS IDE**. The program numerically approximates the solution of the ODE using methods such as **Euler’s Method** or a similar iterative technique.

It demonstrates how low-level programming and computer architecture concepts can be applied to solve mathematical problems typically handled in high-level languages.

---

## 🧮 Differential Equation

- The program solves the following **non-linear first-order ODE**:
dy/dx = 157x² - 78x + 408y³ - 34y² - 28y - 16
- Helper function used:
F(x) = 157x² - 78x + 408

# 📥 Inputs
Passed to the program using MARS IDE pa option:

- y(0) → initial value of y (float)

- h → step size (float)

- n → number of steps (integer)

# 📤 Output
- Final y value after n steps is:

-- Stored in register $v0

-- Written to memory at address 0x10010000

## 🛠 Tools & Technologies
- **MIPS Assembly (32-bit)**
- **MARS IDE** (MIPS Assembler and Runtime Simulator)

---

## 📈 Features
- Accepts initial conditions and step size from the user
- Iteratively solves a first-order ODE using numerical approximation
- Displays the computed values for each iteration
- Modular, readable assembly code with comments for clarity

---

## 📌 Numerical Method
The program uses **Euler’s Method** (or your chosen method) to solve ODEs of the form:

