Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI hostbridge init based on ACPI
Date: Wed, 16 Dec 2015 16:16:10 +0100
Message-Id: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From the functionality point of view this series might be split into the
following logic parts:
1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
   PCI config regions and used when necessary.
2. Move non-arch specific bits to the core code.
3. Use MMCONFIG code and implement generic ACPI based PCI host
   controller driver.
4. Enable above driver on ARM64

Patches has been built on top of 4.4-rc4 and can be found here:
git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v2)

NOTE, this patch set depends on Matthew's patches:
http://www.spinics.net/lists/linux-pci/msg45950.html
https://github.com/Vality/linux/tree/pci-fixes

This has been tested on Cavium ThunderX 1 socket server and QEMU.
Any help in reviewing and testing is very appreciated.

v1 -> v2
- moved non-arch specific piece of code to dirver/acpi/ directory
- fixed IO resource handling
- introduced PCI config accessors quirks matching
- moved ACPI_COMPANION_SET to generic code

Liu Jiang (1):
  ACPI, PCI: Refine the way to handle translation_offset for ACPI
    resources

Tomasz Nowicki (22):
  x86, pci: Reorder logic of pci_mmconfig_insert() function
  x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
    out of arch/x86/ directory
  pci, acpi, mcfg: Provide generic implementation of MCFG code
    initialization.
  x86, pci: mmconfig_{32,64}.c code refactoring - remove code
    duplication.
  x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
    driver.
  XEN / PCI: Remove the dependence on arch x86 when PCI_MMCONFIG=y
  pci, acpi, mcfg: Provide default RAW ACPI PCI config space accessors.
  arm64, acpi: Use empty PCI config space accessors from mcfg.c file.
  pci, acpi, ecam: Add flag to indicate whether ECAM region was hot
    added or not.
  x86, pci: Cleanup platform specific MCFG data using previously added
    ECAM hot_added flag.
  arm64, pci: Remove useless boot time IRQ assignment when booting with
    DT.
  pci, acpi: Move ACPI host bridge device companion assignment to core
    code.
  x86, ia64, pci: Remove ACPI companion device from platform specific
    data.
  pci, acpi: Provide generic way to assign bus domain number.
  x86, ia64, pci: Convert arches to use PCI_DOMAINS_GENERIC.
  x86, ia64: Include acpi_pci_{add|remove}_bus to the default
    pcibios_{add|remove}_bus implementation.
  acpi, mcfg: Implement two calls that might be used to inject/remove
    MCFG region.
  x86, acpi, pci: Use equivalent function introduced in previous patch.
  acpi, mcfg: Add default PCI config accessors implementation and
    initial support for related quirks.
  pci, acpi: Support for ACPI based PCI hostbridge init
  pci, acpi: Match PCI config space accessors against platfrom specific
    quirks.
  arm64, pci, acpi: Start using ACPI based PCI host bridge driver for
    ARM64.

 arch/arm64/Kconfig                |  10 ++
 arch/arm64/kernel/pci.c           |  35 ------
 arch/ia64/Kconfig                 |   3 +
 arch/ia64/include/asm/pci.h       |   3 -
 arch/ia64/pci/pci.c               |  53 +++-----
 arch/x86/Kconfig                  |   7 ++
 arch/x86/include/asm/pci.h        |  10 --
 arch/x86/include/asm/pci_x86.h    |  28 +----
 arch/x86/pci/acpi.c               |  43 ++-----
 arch/x86/pci/common.c             |  10 --
 arch/x86/pci/irq.c                |  10 --
 arch/x86/pci/mmconfig-shared.c    | 250 ++++++--------------------------------
 arch/x86/pci/mmconfig_32.c        |  11 +-
 arch/x86/pci/mmconfig_64.c        |  67 +---------
 arch/x86/pci/numachip.c           |   1 +
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/mcfg.c               | 203 +++++++++++++++++++++++++++++++
 drivers/acpi/pci_root.c           |   5 +-
 drivers/acpi/resource.c           |  12 +-
 drivers/pci/Kconfig               |  10 ++
 drivers/pci/Makefile              |   5 +
 drivers/pci/ecam.c                | 234 +++++++++++++++++++++++++++++++++++
 drivers/pci/host/Kconfig          |   6 +
 drivers/pci/host/Makefile         |   1 +
 drivers/pci/host/pci-host-acpi.c  | 138 +++++++++++++++++++++
 drivers/pci/pci.c                 |  29 ++++-
 drivers/pci/probe.c               |   5 +
 drivers/xen/pci.c                 |   7 +-
 include/asm-generic/vmlinux.lds.h |   7 ++
 include/linux/acpi.h              |   2 +
 include/linux/ecam.h              |  61 ++++++++++
 include/linux/pci-acpi.h          |  17 +++
 32 files changed, 817 insertions(+), 467 deletions(-)
 create mode 100644 drivers/acpi/mcfg.c
 create mode 100644 drivers/pci/ecam.c
 create mode 100644 drivers/pci/host/pci-host-acpi.c
 create mode 100644 include/linux/ecam.h

-- 
1.9.1

