# convert_step_to_sldprt_sldasm

This PowerShell script automates the batch conversion of `.STEP` files into native SOLIDWORKS formats: `.SLDPRT` (Part) or `.SLDASM` (Assembly).
It utilizes the official SOLIDWORKS API via COM Automation to ensure high-quality, native conversion — exactly as if done manually in SOLIDWORKS.

---

## 🧩 Features

- ✅ Detects whether a STEP file is a Part or Assembly
- ✅ Automatically saves it as `.sldprt` or `.sldasm`
- ✅ Batch converts all files in a given folder
- ✅ Works silently using SOLIDWORKS in the background
- ✅ No additional software required (aside from SOLIDWORKS)

---

## ⚙️ Requirements

| Requirement               | Details                                             |
|---------------------------|-----------------------------------------------------|
| Operating System          | Windows only                                        |
| SOLIDWORKS Installed      | Full desktop version (not Viewer or eDrawings)      |
| PowerShell                | Version 5 or newer (default in Windows 10+)         |
| Permissions               | Run PowerShell as Administrator (if needed)         |
| Execution Policy          | Set to allow script execution (`Bypass` or `Unrestricted`) |

To allow script execution:

```powershell
Set-ExecutionPolicy Bypass -Scope Process
```

## 🚀 How to Use

1. Place all your `.STEP` files inside the `Input` folder.
2. Open PowerShell and run the following command:
```powershell
   powershell -ExecutionPolicy Bypass -File convert_step_to_sldprt_sldasm.ps1
```
3. The script will:
    - Open SOLIDWORKS in the background
    - Detect file type (Part or Assembly)
    - Convert and save each file into the Output folder
    - Automatically close SOLIDWORKS after conversion
