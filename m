Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI hostbridge init based on ACPI
Date: Tue, 16 Feb 2016 14:53:30 +0100
Message-Id: <1455630825-27253-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From the functionality point of view this series might be split into the
following logic parts:
1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
   PCI config regions and used when necessary.
2. Move non-arch specific bits to the core code.
3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
4. Enable above driver on ARM64

Patches has been built on top of 4.5-rc3 and can be found here:
git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v5)

NOTE, this patch set depends on Lorenzo's fixes:
https://patchwork.ozlabs.org/patch/576450/
which can be found in pci-acpi-v5 branch.

This has been tested on Cavium ThunderX server, JunoR2, HP RX2660 IA64, x86,
Hip05, X-Gene and QEMU-aarch64. Any help in reviewing and testing is very appreciated.

v4 -> v5
- dropped MCFG refactoring group patches 1-6 from series v4 and integrated Jayachandran's patch
  https://patchwork.ozlabs.org/patch/575525/
- rewrite PCI legacy IRQs allocation
- squashed two patches 11 and 12 from series v4, fixed bisection issue
- changelog improvements
- rebased to 4.5-rc3

v3 -> v4
- dropped Jiang's fix http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04318.html
- added Lorenzo's fix patch 19/24
- ACPI PCI bus domain number assigning cleanup
- changed resource management, we now claim and reassign resources
- improvements for applying quirks
- dropped Matthew's http://www.spinics.net/lists/linux-pci/msg45950.html dependency
- rebased to 4.5-rc1

v2 -> v3
- fix legacy IRQ assigning and IO ports registration
- remove reference to arch specific companion device for ia64
- move ACPI PCI host controller driver to pci_root.c
- drop generic domain assignment for x86 and ia64 as I am not
  able to run all necessary test variants
- drop patch which cleaned legacy IRQ assignment since it belongs to
  Mathew's series:
  https://patchwork.ozlabs.org/patch/557504/
- extend MCFG quirk code
- rebased to 4.4

v1 -> v2
- moved non-arch specific piece of code to dirver/acpi/ directory
- fixed IO resource handling
- introduced PCI config accessors quirks matching
- moved ACPI_COMPANION_SET to generic code

v1 - https://lkml.org/lkml/2015/10/27/504
v2 - https://lkml.org/lkml/2015/12/16/246
v3 - http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04308.html
v4 - https://lkml.org/lkml/2016/2/4/646

Jayachandran C (1):
  ACPI: MCFG: Move mmcfg_list management to drivers/acpi

Lorenzo Pieralisi (1):
  drivers: pci: add generic code to claim bus resources

Tomasz Nowicki (13):
  acpi, pci, mcfg: Provide default RAW ACPI PCI config space accessors.
  arm64, acpi: Use MCFG library and empty PCI config space accessors
    from pci_mcfg.c file.
  pci, acpi, ecam: Add flag to indicate whether ECAM region was hot
    added or not.
  x86, pci: Cleanup platform specific MCFG data by using ECAM hot_added
    flag.
  pci, acpi, x86, ia64: Move ACPI host bridge device companion
    assignment to core code.
  pci, acpi: Provide generic way to assign bus domain number.
  x86, ia64: Include acpi_pci_{add|remove}_bus to the default
    pcibios_{add|remove}_bus implementation.
  acpi, mcfg: Add default PCI config accessors implementation and
    initial support for related quirks.
  pci, of: Move the PCI I/O space management to PCI core code.
  pci, acpi: Support for ACPI based generic PCI host controller
    initialization
  pci, acpi: Match PCI config space accessors against platfrom specific
    quirks.
  arm64, pci, acpi: Assign legacy IRQs once device is enable.
  arm64, pci, acpi: Start using ACPI based PCI host bridge driver for
    ARM64.

 arch/arm64/Kconfig                 |   5 +
 arch/arm64/kernel/pci.c            |  35 +---
 arch/ia64/hp/common/sba_iommu.c    |   2 +-
 arch/ia64/include/asm/pci.h        |   1 -
 arch/ia64/pci/pci.c                |  26 ---
 arch/ia64/sn/kernel/io_acpi_init.c |   4 +-
 arch/x86/include/asm/pci.h         |   3 -
 arch/x86/include/asm/pci_x86.h     |  24 +--
 arch/x86/pci/acpi.c                |  47 +----
 arch/x86/pci/common.c              |  10 -
 arch/x86/pci/mmconfig-shared.c     | 269 ++++---------------------
 arch/x86/pci/mmconfig_32.c         |   1 +
 arch/x86/pci/mmconfig_64.c         |   1 +
 arch/x86/pci/numachip.c            |   1 +
 drivers/acpi/Kconfig               |   7 +
 drivers/acpi/Makefile              |   1 +
 drivers/acpi/pci_mcfg.c            | 392 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/pci_root.c            | 154 ++++++++++++++-
 drivers/of/address.c               | 116 +----------
 drivers/pci/pci.c                  | 126 +++++++++++-
 drivers/pci/probe.c                |   5 +
 drivers/pci/setup-bus.c            |  63 ++++++
 drivers/xen/pci.c                  |   5 +-
 include/acpi/acpi_bus.h            |   1 +
 include/asm-generic/vmlinux.lds.h  |   7 +
 include/linux/of_address.h         |   9 -
 include/linux/pci-acpi.h           |  68 +++++++
 include/linux/pci.h                |   6 +
 28 files changed, 892 insertions(+), 497 deletions(-)
 create mode 100644 drivers/acpi/pci_mcfg.c

-- 
1.9.1

