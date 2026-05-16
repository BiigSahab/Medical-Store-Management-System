# COAL Lab Projects - 8086 Assembly

Welcome to my Computer Organization and Assembly Language (COAL) repository! This repository contains my assembly projects developed using the EMU8086 emulator. These projects demonstrate the practical implementation of low-level programming concepts, including direct memory and register interactions, loops, conditional statements, and DOS interrupts.

## 🛠️ Environment & Tools
* **Language:** 8086 Assembly Language
* **Simulator/Emulator:** EMU8086

---

## 💊 Project: Medical Store Management System

### Overview
A console-based menu-driven application designed to automate the basic operations of a medical store. It manages medicine purchasing, automated billing, and tracks daily sales statistics. 

### Key Features
* **Secure Access:** The system requires a password before allowing access to the main menu.
* **Medicine Purchase System:** Displays a predefined list of available medicines with their respective prices (e.g., Panadol, Paracetamol, Surbex Z, Pfizer Vaccine). Users can select an item and enter the desired quantity.
* **Automated Billing:** Automatically calculates the total cost of the purchased medicines using multiplication operations and updates the store's earnings.
* **Sales Tracking & Statistics:** Tracks the exact quantity of each medicine sold and displays a comprehensive sales report.
* **Amount Earned Tracking:** Displays the total cumulative revenue earned by the medical store in a given session.

### Technical Concepts Used
* **Data Processing:** Keyboard interrupts for input processing, ASCII to integer conversion, and arithmetic calculations.
* **Number Printing:** Utilizes stack operations to print multi-digit numbers to the console.
* **Architecture:** Uses procedures, loops, and conditional jumps to handle menu navigation and program flow.

### Future Enhancements
* Implement dynamic inventory management to reduce stock on each sale.
* Add features for generating detailed invoices and saving transaction history via data persistence (file handling).

