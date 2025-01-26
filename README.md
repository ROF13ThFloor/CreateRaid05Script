# RAID 0+5 and VHD Management Automation
This project provides a set of Bash scripts to automate the creation, configuration, and testing of **RAID 0+5** arrays and Virtual Hard Disks (VHDs) on Linux systems. The scripts simplify the process of setting up storage configurations, ensuring performance and redundancy.
## Features

- **Automated RAID 0+5 Setup:**
  The scripts configure a RAID 0+5 array using available storage devices.
- **Virtual Hard Disk (VHD) Creation:**
  Simplifies the process of creating and managing VHDs.
- **RAID Testing and Validation:**
  Ensures the RAID array is functioning correctly with integrity tests.
- **Logging and Monitoring:**
  Tracks operations and provides detailed status updates.

## Included Scripts

- `CreateRaid05.sh` – Automates the setup of a RAID 0+5 array.
- `Raid05.sh` – Handles management and monitoring of the RAID 0+5 array.
- `TestRaid05.sh` – Runs performance and integrity tests on the RAID array.
- `CreateVHD.sh` – Automates the creation of Virtual Hard Disks.

## Installation

Ensure scripts have execution permissions:

```
chmod +x *.sh
```

## Usage

### Creating a RAID 0+5 Array

Run the following command to initialize the RAID setup:

```
./CreateRaid05.sh
```

### Testing the RAID Array

To verify the integrity and performance of the RAID array, execute:

```
./TestRaid05.sh
```

### Creating a Virtual Hard Disk (VHD)

To create a new VHD, run:

```
./CreateVHD.sh
```

## Requirements

- Linux-based operating system
- `mdadm` (for RAID management)
- `qemu-img` (for VHD creation)
- Root privileges for RAID operations

## License

This project is licensed under the MIT License.
