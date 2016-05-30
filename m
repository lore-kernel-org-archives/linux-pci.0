Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V8 0/9] Support for ARM64 ACPI based PCI host controller
Date: Mon, 30 May 2016 17:14:13 +0200
Message-Id: <1464621262-26770-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

>From the functionality point of view this series may be split into the
following logic parts:
1. Export ECAM API and add parent device to pci_config_window
2. Add IO resources handling to PCI core code
3. Support for generic domain assignment based on ACPI
4. New MCFG driver
5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/

Patches has been built on top of 4.7-rc1 and can be found here:
git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v8)

This has been tested on Cavium ThunderX server. Any help in reviewing and
testing is very appreciated.

v7 -> v8
- move code from drivers/acpi/pci_root_generic.c to arch/arm64/kernel/pci.c
- minor changes around domain assignment
- pci_mcfg.c improvements for parsing MCFG tables and lookup its entries

v6 -> v7
- drop quirks handling
- changes for ACPI companion and domain number assignment approach
- implement arch pcibios_{add|remove}_bus and call acpi_pci_{add|remove}_bus from there
- cleanups around nomenclature
- use resources oriented API for ECAM
- fix for based address calculation before mapping ECAM region
- remove useless lock for MCFG lookup
- move MCFG stuff to separated file pci_mcfg.c
- drop MCFG entries caching
- rebase against 4.6-rc7

v5 -> v6
- drop idea of x86 MMCONFIG code refactoring
- integrate JC's patches which introduce new ECAM API:
  https://lkml.org/lkml/2016/4/11/907
  git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
- integrate Sinan's fix for releasing IO resources, see patch [06/13]
- added ACPI support for ThunderX ECAM and PEM drivers
- rebase against 4.6-rc2

v4 -> v5
- drop MCFG refactoring group patches 1-6 from series v4 and integrate Jayachandran's patch
  https://patchwork.ozlabs.org/patch/575525/
- rewrite PCI legacy IRQs allocation
- squash two patches 11 and 12 from series v4, fixed bisection issue
- changelog improvements
- rebase against 4.5-rc3

v3 -> v4
- drop Jiang's fix http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04318.html
- add Lorenzo's fix patch 19/24
- ACPI PCI bus domain number assigning cleanup
- change resource management, we now claim and reassign resources
- improvements for applying quirks
- drop Matthew's http://www.spinics.net/lists/linux-pci/msg45950.html dependency
- rebase against 4.5-rc1

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
- rebase against 4.4

v1 -> v2
- move non-arch specific piece of code to dirver/acpi/ directory
- fix IO resource handling
- introduce PCI config accessors quirks matching
- moved ACPI_COMPANION_SET to generic code

v1 - https://lkml.org/lkml/2015/10/27/504
v2 - https://lkml.org/lkml/2015/12/16/246
v3 - http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04308.html
v4 - https://lkml.org/lkml/2016/2/4/646
v5 - https://lkml.org/lkml/2016/2/16/426
v6 - https://lkml.org/lkml/2016/4/15/594

Jayachandran C (2):
  PCI: ecam: move ecam.h to linux/include/pci-ecam.h
  PCI: ecam: Add parent device field to pci_config_window

Tomasz Nowicki (7):
  pci: Add new function to unmap IO resources.
  acpi, pci: Support IO resources when parsing PCI host bridge
    resources.
  pci, acpi: add acpi hook to assign domain number.
  arm64, pci, acpi: ACPI support for legacy IRQs parsing and
    consolidation with DT code.
  acpi: Add generic MCFG table handling
  arm64, pci, acpi: Provide ACPI-specific prerequisites for PCI bus
    enumeration.
  pci, acpi: ARM64 support for ACPI based generic PCI host controller

 arch/arm64/Kconfig                  |   2 +
 arch/arm64/kernel/pci.c             | 143 ++++++++++++++++++++++++++++++++++--
 drivers/acpi/Kconfig                |   3 +
 drivers/acpi/Makefile               |   1 +
 drivers/acpi/pci_mcfg.c             |  94 ++++++++++++++++++++++++
 drivers/acpi/pci_root.c             |  39 ++++++++++
 drivers/pci/ecam.c                  |   6 +-
 drivers/pci/ecam.h                  |  67 -----------------
 drivers/pci/host/pci-host-common.c  |   3 +-
 drivers/pci/host/pci-host-generic.c |   3 +-
 drivers/pci/host/pci-thunder-ecam.c |   3 +-
 drivers/pci/host/pci-thunder-pem.c  |   6 +-
 drivers/pci/pci.c                   |  29 +++++++-
 include/linux/pci-acpi.h            |   2 +
 include/linux/pci-ecam.h            |  67 +++++++++++++++++
 include/linux/pci.h                 |   9 ++-
 16 files changed, 387 insertions(+), 90 deletions(-)
 create mode 100644 drivers/acpi/pci_mcfg.c
 delete mode 100644 drivers/pci/ecam.h
 create mode 100644 include/linux/pci-ecam.h

-- 
1.9.1
