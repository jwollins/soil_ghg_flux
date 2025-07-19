# soil_ghg_flux
Scripts to analyse soil GHG emissions taken using the static chamber method. 

# My Project

This is an R project using `renv` for package management.

## Setup

1. Clone the repo
2. Open in RStudio
3. Run `renv::restore()` to install packages

## 📂 Data folder setup (with symlink)
This project expects the raw data to be available in a data/ folder inside the project directory.

Since the data is not stored in the repo, create a symbolic link (symlink) so that the project can access it without copying the files.

💥 How to create the symlink
1️⃣ Open Terminal.

2️⃣ Navigate to the project folder:

bash
Copy
Edit
cd /path/to/your/repo
3️⃣ Run this command to create the symlink:

bash
Copy
Edit
ln -s "/path/to/your/data"
✅ This will create a data/ link inside the project folder pointing to the actualdata folder.


Enjoy!
