# Changelog

All notable changes to **run_custom_triggers.sh** will be documented in this file.

---

## [2.1.0] - 2025-04-26
### Added
- Refactored script to be **generic** for any Jamf Pro custom triggers.
- Introduced configurable variables:
  - `LOG_FILE`
  - `TRIGGERS_LIST`
  - `DEBUG_MODE`
- Moved all configuration settings to the top of the script.
- Improved internal logging clarity and debug messaging.
- Enhanced error handling when Jamf binary is missing or inaccessible.

---

## [2.0.0] - 2025-04-26
### Changed
- Transitioned script structure to support **placeholder trigger names** and **custom log file**.
- Improved logging formatting for better Jamf Pro visibility.

---

## [1.0.0] - 2025-04-26
### Added
- Initial creation of **run_custom_triggers.sh**.
- Supported strict-mode execution of three predefined Jamf custom triggers.
- Implemented real-time logging to `/var/log/custom_triggers_update.log`.

---

# Versioning

This project uses **Semantic Versioning**:

- `MAJOR`.`MINOR`.`PATCH`
- Example: `2.1.0`

---

> End of **CHANGELOG.md** for run_custom_triggers.sh  
> © 2025 MacJediWizard Consulting, Inc. All rights reserved.