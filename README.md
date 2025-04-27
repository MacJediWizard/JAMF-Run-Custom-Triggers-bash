# run_custom_triggers.sh

---

### MacJediWizard Consulting, Inc.
**Copyright (c) 2025 MacJediWizard Consulting, Inc.**  
All rights reserved.  
Created by: **William Grzybowski**

---

### Description:
- This script sequentially calls **Jamf Pro custom triggers**.
- It **stops execution immediately** if any trigger fails.
- It **logs** all actions, results, warnings, errors, and debug information into a **customizable log file**.

---

### Features:
- **Strict mode**: Script will **halt immediately** if any trigger returns a failure.
- **Fully customizable**:
  - Change trigger names in one place.
  - Change log file name in one place.
- **Debug mode**:
  - Enable additional debug logging if needed.

---

### Configuration:
At the top of the script, the following variables must be configured:

| Variable | Description |
|:---------|:------------|
| `LOG_FILE` | Set the desired path and name of the log file (example: `/var/log/custom_triggers_update.log`) |
| `TRIGGERS_LIST` | Define your Jamf Pro trigger names here (example: `"install_app" "update_settings" "enforce_compliance"`) |
| `DEBUG_MODE` | Set `0` for standard logging, or `1` for verbose debug logging |

Example:
```bash
LOG_FILE="/var/log/custom_triggers_update.log"
TRIGGERS_LIST=(
    "install_app"
    "update_settings"
    "enforce_compliance"
)
DEBUG_MODE=0
```

---

### Usage Examples:
| Context | Example |
|:--------|:--------|
| **Jamf Pro Policy** | Attach script in a policy. No parameters required. |
| **Terminal** | `sudo ./run_custom_triggers.sh` |
| **Package postinstall script** | Embed inside a .pkg to chain multiple Jamf triggers after deployment. |

---

### Notes:
- Must be run as **root** (required for `/usr/local/bin/jamf` execution).
- Jamf Pro binary must exist at **`/usr/local/bin/jamf`**.
- If any trigger fails, the script **exits immediately** with error status 1.
- Internal logs are written to the specified log file **in real time**.

---

### Requirements:
- macOS 11 or newer (tested on macOS 15+)
- Jamf Pro-managed device
- Installed Jamf Binary (`/usr/local/bin/jamf`)

---

### License:
This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for details.

---

### Version:
`v2.1.0`

---

### Example Log Output:
```
[2025-04-26 18:30:01] [INFO] Starting custom triggers execution script version 2.1.0
[2025-04-26 18:30:01] [INFO] Jamf binary detected at /usr/local/bin/jamf.
[2025-04-26 18:30:01] [INFO] Executing custom trigger: install_app
[2025-04-26 18:30:20] [INFO] Successfully completed trigger: install_app
[2025-04-26 18:30:20] [INFO] Executing custom trigger: update_settings
[2025-04-26 18:30:32] [INFO] Successfully completed trigger: update_settings
[2025-04-26 18:30:32] [INFO] Executing custom trigger: enforce_compliance
[2025-04-26 18:30:47] [INFO] Successfully completed trigger: enforce_compliance
[2025-04-26 18:30:47] [INFO] All custom triggers executed successfully.
```

---

> End of README for **run_custom_triggers.sh**  
> © 2025 MacJediWizard Consulting, Inc. All rights reserved.