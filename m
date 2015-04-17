Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de,
	hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net,
	al.stone@linaro.org, lorenzo.pieralisi@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v5 0/9] PCI: MMCONFIG clean up
Date: Fri, 17 Apr 2015 09:14:49 +0200
Message-Id: <1429254898-32743-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MCFG ACPI table and PCI ECAM standard have no arch dependencies so it can be
used across all architectures. Currently MMCONFIG related code resides in
arch/x86 directories. This patch set is going to isolate non-architecture
specific code and make it accessible for all architectures.

v4 -> v5 changes:
- improvements for Makefile logic
- provide arch-specific checks for MCFG entry
- fix MCFG injection logic (support absence of _CBA() method)

v3 -> v4 changes:
- bug fixes after kbuild test robot report
    - add asm/io.h header for ecam.c
    - rename mmcfg -> ecam for drivers/xen/pci.c and arch/x86/pci/numachip.c
- rework Kconfig logic

v2 -> v3 changes:
- rebase patch set v2 to v4.0-rc1

v1 -> v2 changes:
- use generic readb/readw etc. accessors instead of AMD Fam10h workaround
- separate ACPI and ECAM code
- improve ECAM code naming

Tomasz Nowicki (9):
  x86, pci: Clean up comment about buggy MMIO config space access for
    AMD Fam10h CPUs.
  x86, pci: Abstract PCI config accessors and use AMD Fam10h workaround
    exclusively.
  x86, pci: Reorder logic of pci_mmconfig_insert() function
  x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
    out of arch/x86/ directory
  pci, acpi, mcfg: Provide generic implementation of MCFG code
    initialization.
  x86, pci: mmconfig_{32,64}.c code refactoring - remove code
    duplication.
  x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
    driver.
  pci, acpi, mcfg: Share ACPI PCI config space accessors.
  pci, ecam: Improve naming for ecam.c content and areas where it is
    used.

 arch/x86/Kconfig               |   4 +
 arch/x86/include/asm/pci_x86.h |  34 +---
 arch/x86/pci/Makefile          |   5 +-
 arch/x86/pci/acpi.c            |   3 +-
 arch/x86/pci/mmconfig-shared.c | 346 +++++++++++----------------------------
 arch/x86/pci/mmconfig_32.c     |  47 ++----
 arch/x86/pci/mmconfig_64.c     | 153 ------------------
 arch/x86/pci/numachip.c        |  29 +---
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/mcfg.c            | 121 ++++++++++++++
 drivers/pci/Kconfig            |  10 ++
 drivers/pci/Makefile           |   5 +
 drivers/pci/ecam.c             | 358 +++++++++++++++++++++++++++++++++++++++++
 drivers/xen/pci.c              |   7 +-
 include/linux/ecam.h           |  56 +++++++
 15 files changed, 679 insertions(+), 500 deletions(-)
 delete mode 100644 arch/x86/pci/mmconfig_64.c
 create mode 100644 drivers/acpi/mcfg.c
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 include/linux/ecam.h

-- 
1.9.1

