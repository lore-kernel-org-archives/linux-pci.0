Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34177 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbcGZU6x (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2016 16:58:53 -0400
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Jul 2016 22:58:50 +0200
Message-ID: <CAJZ5v0hEnbf2YeL4moe_Yy+XWq5WrnxJ9Gx=cb_BNQYdHvHpOg@mail.gmail.com>
Subject: [GIT PULL] ACPI changes for v4.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.8-rc1

to receive core ACPI code updates for v4.8-rc1 with top-most commit
54d0b14ad7cc4ff3c710f092a93638f359c1b14b

 Merge branches 'acpi-drivers', 'acpi-misc' and 'acpi-tools'

on top of commit 523d939ef98fd712632d93a5a2b588e477a7565e

 Linux 4.7

The new feaures here are the support for ACPI overlays (allowing
ACPI tables to be loaded at any time from EFI variables or via
configfs) and the LPI (Low-Power Idle) support.  Also notable
is the ACPI-based NUMA support for ARM64.

Apart from that we have two new drivers, for the DPTF (Dynamic
Power and Thermal Framework) power participant device and for the
Intel Broxton WhiskeyCove PMIC, some more PMIC-related changes,
support for the Boot Error Record Table (BERT) in APEI and support
for platform-initiated graceful shutdown.

Plus two new pieces of documentation and usual assorted fixes and
cleanups in quite a few places.

Specifics:

 - Support for ACPI SSDT overlays allowing Secondary System
   Description Tables (SSDTs) to be loaded at any time from EFI
   variables or via configfs (Octavian Purdila, Mika Westerberg).

 - Support for the ACPI LPI (Low-Power Idle) feature introduced in
   ACPI 6.0 and allowing processor idle states to be represented in
   ACPI tables in a hierarchical way (with the help of Processor
   Container objects) and support for ACPI idle states management
   on ARM64, based on LPI (Sudeep Holla).

 - General improvements of ACPI support for NUMA and ARM64 support
   for ACPI-based NUMA (Hanjun Guo, David Daney, Robert Richter).

 - General improvements of the ACPI table upgrade mechanism and
   ARM64 support for that feature (Aleksey Makarov, Jon Masters).

 - Support for the Boot Error Record Table (BERT) in APEI and
   improvements of kernel messages printed by the error injection
   code (Huang Ying, Borislav Petkov).

 - New driver for the Intel Broxton WhiskeyCove PMIC operation
   region and support for the REGS operation region on Broxton,
   PMIC code cleanups (Bin Gao, Felipe Balbi, Paul Gortmaker).

 - New driver for the power participant device which is part of the
   Dynamic Power and Thermal Framework (DPTF) and DPTF-related code
   reorganization (Srinivas Pandruvada).

 - Support for the platform-initiated graceful shutdown feature
   introduced in ACPI 6.1 (Prashanth Prakash).

 - ACPI button driver update related to lid input events generated
   automatically on initialization and system resume that have been
   problematic for some time (Lv Zheng).

 - ACPI EC driver cleanups (Lv Zheng).

 - Documentation of the ACPICA release automation process and the
   in-kernel ACPI AML debugger (Lv Zheng).

 - New blacklist entry and two fixes for the ACPI backlight driver
   (Alex Hung, Arvind Yadav, Ralf Gerbig).

 - Cleanups of the ACPI pci_slot driver (Joe Perches, Paul Gortmaker).

 - ACPI CPPC code changes to make it more robust against possible
   defects in ACPI tables and new symbol definitions for PCC (Hoan
   Tran).

 - System reboot code modification to execute the ACPI _PTS (Prepare
   To Sleep) method in addition to _TTS (Ocean He).

 - ACPICA-related change to carry out lock ordering checks in ACPICA
   if ACPICA debug is enabled in the kernel (Lv Zheng).

 - Assorted minor fixes and cleanups (Andy Shevchenko, Baoquan He,
   Bhaktipriya Shridhar, Paul Gortmaker, Rafael Wysocki).

Thanks!

---------------

Aleksey Makarov (4):
      ACPI / tables: table upgrade: use cacheable map for tables
      ACPI / tables: table upgrade: refactor function definitions
      ACPI / tables: move arch-specific symbol to asm/acpi.h
      ACPI / tables: introduce ARCH_HAS_ACPI_TABLE_UPGRADE

Alex Hung (1):
      ACPI / video: skip evaluating _DOD when it does not exist

Andy Shevchenko (1):
      tools/acpi: use CROSS_COMPILE to define prefix

Arvind Yadav (1):
      ACPI / video: Dummy acpi_video_register should return error code

Baoquan He (1):
      ACPI / bus: Correct the comments about acpi_subsystem_init()

Bhaktipriya Shridhar (1):
      ACPI / thermal: Remove create_workqueue()

Bin Gao (2):
      ACPI / PMIC: modify the pen function signature to take bit field
      ACPI / PMIC: Add opregion driver for Intel BXT WhiskeyCove PMIC

Borislav Petkov (2):
      ACPI / einj: Convert EINJ_PFX to proper pr_fmt
      ACPI / einj: Make error paths more talkative

David Daney (4):
      arm64, NUMA: Cleanup NUMA disabled messages
      ACPI / NUMA: move bad_srat() and srat_disabled() to drivers/acpi/numa.c
      ACPI / NUMA: Improve SRAT error detection and add messages
      ACPI / processor: Add acpi_map_madt_entry()

Felipe Balbi (2):
      ACPI / PMIC: intel: add REGS operation region support
      ACPI / PMIC: intel: initialize result to 0

Hanjun Guo (10):
      ACPI / NUMA: Use pr_fmt() instead of printk
      ACPI / NUMA: Replace ACPI_DEBUG_PRINT() with pr_debug()
      ACPI / NUMA: remove duplicate NULL check
      ACPI / NUMA: move acpi_numa_slit_init() to drivers/acpi/numa.c
      arm64, NUMA: rework numa_add_memblk()
      x86 / ACPI / NUMA: cleanup acpi_numa_processor_affinity_init()
      ACPI / NUMA: remove unneeded acpi_numa=1
      ACPI / NUMA: Move acpi_numa_memory_affinity_init() to drivers/acpi/numa.c
      arm64, ACPI, NUMA: NUMA support based on SRAT and SLIT
      ACPI / NUMA: Enable ACPI based NUMA on ARM64

Hoan Tran (3):
      ACPI: CPPC: Return error if _CPC is invalid on a CPU
      ACPI / CPPC: Prevent cpc_desc_ptr points to the invalid data
      mailbox: pcc: Add PCC request and free channel declarations

Huang Ying (1):
      ACPI / APEI: Add Boot Error Record Table (BERT) support

Joe Perches (2):
      ACPI / PCI: pci_slot: Use more common logging style
      ACPI / PCI: pci_slot: Use generic pr_debug utility

Jon Masters (1):
      ACPI: ARM64: support for ACPI_TABLE_UPGRADE

Lv Zheng (8):
      ACPI / button: Remove initial lid state notification
      ACPI / button: Refactor functions to eliminate redundant code
      ACPI / button: Add quirks for initial lid state notification
      ACPI / EC: Cleanup boot EC code using acpi_ec_alloc()
      ACPI / EC: Remove wrong ECDT correction quirks
      ACPI: Add documentation describing ACPICA release automation
      ACPI / debugger: Add AML debugger documentation
      ACPICA: Linux: Enable ACPI_MUTEX_DEBUG for Linux kernel

Mika Westerberg (1):
      ACPI: Rename configfs.c to acpi_configfs.c to prevent link error

Ocean He (1):
      ACPI: Execute _PTS before system reboot

Octavian Purdila (8):
      ACPI / documentation: add SSDT overlays documentation
      ACPI / scan: fix enumeration (visited) flags for bus rescans
      ACPI: add support for ACPI reconfiguration notifiers
      i2c / ACPI: add support for ACPI reconfigure notifications
      spi / ACPI: add support for ACPI reconfigure notifications
      efi / ACPI: load SSTDs from EFI variables
      ACPI: add support for configfs
      ACPI: add support for loading SSDTs via configfs

Paul Gortmaker (4):
      ACPI / PMIC: remove modular references from non-modular code
      ACPI / PCI: make pci_slot explicitly non-modular
      ACPI / dock: make dock explicitly non-modular
      ACPI / lpat: make it explicitly non-modular

Prakash, Prashanth (1):
      ACPI / bus: Support for platform initiated graceful shutdown

Rafael J. Wysocki (1):
      ACPI / bus: Use acpi_handle_debug() in acpi_print_osc_error()

Ralf Gerbig (1):
      ACPI / video: Thinkpad X201 Tablet needs video_detect_force_video

Robert Richter (1):
      ACPI / NUMA: Move acpi_numa_arch_fixup() to ia64 only

Srinivas Pandruvada (2):
      ACPI / DPTF: Add DPTF power participant driver
      ACPI / DPTF: move int340x_thermal.c to the DPTF folder

Sudeep Holla (7):
      ACPI / processor_idle: introduce ACPI_PROCESSOR_CSTATE
      ACPI / processor_idle: Add support for Low Power Idle(LPI) states
      arm64: cpuidle: drop __init section marker to arm_cpuidle_init
      cpuidle: introduce CPU_PM_CPU_IDLE_ENTER macro for ARM{32, 64}
      drivers: firmware: psci: initialise idle states using ACPI LPI
      arm64: add support for ACPI Low Power Idle(LPI)
      ACPI: enable ACPI_PROCESSOR_IDLE on ARM64

---------------

 Documentation/ABI/testing/configfs-acpi        |  36 ++
 Documentation/acpi/aml-debugger.txt            |  66 +++
 Documentation/acpi/linuxized-acpica.txt        | 262 ++++++++++++
 Documentation/acpi/ssdt-overlays.txt           | 172 ++++++++
 Documentation/kernel-parameters.txt            |  10 +
 MAINTAINERS                                    |   1 +
 arch/arm64/Kconfig                             |   1 +
 arch/arm64/include/asm/acpi.h                  |  10 +
 arch/arm64/include/asm/numa.h                  |   2 +
 arch/arm64/kernel/Makefile                     |   1 +
 arch/arm64/kernel/acpi_numa.c                  | 112 +++++
 arch/arm64/kernel/cpuidle.c                    |  20 +-
 arch/arm64/kernel/setup.c                      |   6 +-
 arch/arm64/kernel/smp.c                        |   2 +
 arch/arm64/mm/numa.c                           |  28 +-
 arch/ia64/include/asm/acpi.h                   |   3 +
 arch/ia64/kernel/acpi.c                        |   2 +-
 arch/ia64/kernel/setup.c                       |   1 +
 arch/x86/Kconfig                               |   1 +
 arch/x86/include/asm/acpi.h                    |   3 +-
 arch/x86/include/asm/topology.h                |  12 +-
 arch/x86/kernel/cpu/intel.c                    |   7 +-
 arch/x86/kernel/setup.c                        |   9 +-
 arch/x86/mm/numa.c                             |   2 +-
 arch/x86/mm/srat.c                             | 116 +-----
 arch/x86/platform/atom/punit_atom_debug.c      |   5 +-
 drivers/acpi/Kconfig                           |  30 +-
 drivers/acpi/Makefile                          |   5 +-
 drivers/acpi/acpi_configfs.c                   | 267 ++++++++++++
 drivers/acpi/acpi_lpat.c                       |   4 +-
 drivers/acpi/acpi_lpss.c                       |   5 +-
 drivers/acpi/acpi_video.c                      |   3 +
 drivers/acpi/apei/Makefile                     |   2 +-
 drivers/acpi/apei/apei-internal.h              |   2 +-
 drivers/acpi/apei/bert.c                       | 150 +++++++
 drivers/acpi/apei/einj.c                       |  57 ++-
 drivers/acpi/bus.c                             |  99 ++++-
 drivers/acpi/button.c                          | 149 +++++--
 drivers/acpi/cppc_acpi.c                       |  24 +-
 drivers/acpi/dock.c                            |   7 +-
 drivers/acpi/dptf/Kconfig                      |  15 +
 drivers/acpi/dptf/Makefile                     |   4 +
 drivers/acpi/dptf/dptf_power.c                 | 128 ++++++
 drivers/acpi/{ => dptf}/int340x_thermal.c      |   0
 drivers/acpi/ec.c                              | 106 ++---
 drivers/acpi/internal.h                        |   3 +
 drivers/acpi/numa.c                            | 226 ++++++++---
 drivers/acpi/pci_slot.c                        |  43 +-
 drivers/acpi/pmic/intel_pmic.c                 |  84 +++-
 drivers/acpi/pmic/intel_pmic.h                 |   4 +-
 drivers/acpi/pmic/intel_pmic_bxtwc.c           | 420 +++++++++++++++++++
 drivers/acpi/pmic/intel_pmic_crc.c             |   5 +-
 drivers/acpi/pmic/intel_pmic_xpower.c          |   7 +-
 drivers/acpi/processor_core.c                  |  26 +-
 drivers/acpi/processor_driver.c                |   2 +-
 drivers/acpi/processor_idle.c                  | 542 +++++++++++++++++++++----
 drivers/acpi/scan.c                            |  81 +++-
 drivers/acpi/sleep.c                           |  29 +-
 drivers/acpi/sysfs.c                           |   6 +-
 drivers/acpi/tables.c                          |  23 +-
 drivers/acpi/thermal.c                         |   3 +-
 drivers/acpi/video_detect.c                    |   8 +
 drivers/cpufreq/intel_pstate.c                 |  37 +-
 drivers/cpuidle/cpuidle-arm.c                  |  26 +-
 drivers/firmware/efi/efi.c                     |  96 +++++
 drivers/firmware/psci.c                        |  66 ++-
 drivers/i2c/i2c-core.c                         | 175 ++++++--
 drivers/idle/intel_idle.c                      |  71 ++--
 drivers/mmc/host/sdhci-acpi.c                  |   3 +-
 drivers/of/of_numa.c                           |   4 +-
 drivers/platform/x86/intel_telemetry_debugfs.c |   3 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c  |   3 +-
 drivers/powercap/intel_rapl.c                  |  50 +--
 drivers/spi/spi.c                              | 100 ++++-
 drivers/thermal/intel_soc_dts_thermal.c        |   4 +-
 include/acpi/acpi_numa.h                       |   4 +
 include/acpi/cppc_acpi.h                       |   7 +-
 include/acpi/pcc.h                             |  29 ++
 include/acpi/platform/aclinux.h                |   4 +
 include/acpi/processor.h                       |  27 +-
 include/acpi/video.h                           |   2 +-
 include/linux/acpi.h                           |  66 ++-
 include/linux/cpuidle.h                        |  18 +
 tools/power/acpi/Makefile.config               |   7 +-
 84 files changed, 3551 insertions(+), 710 deletions(-)
