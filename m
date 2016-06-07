Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 00/15] ACPI IORT ARM SMMU v3 support
Date: Tue,  7 Jun 2016 14:30:55 +0100
Message-Id: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This RFC patch series is v2 of a previous posting:

https://lkml.org/lkml/2016/4/14/702

v1 -> v2:
	- Rebased on top of dependencies series [1][2][3](v4.7-rc1)
	- Removed IOMMU fwnode generalization
	- Implemented ARM SMMU v3 ACPI probing instead of ARM SMMU v2
	  owing to patch series dependencies [1]
	- Moved platform device creation logic to IORT code to
	  generalize its usage for ARM SMMU v1-v2-v3 components
	- Removed reliance on ACPI early device probing
	- Created IORT specific iommu_xlate() translation hook leaving
	  OF code unchanged according to v1 reviews

The ACPI IORT table provides information that allows instantiating
ARM SMMU devices and carrying out id mappings between components on
ARM based systems (devices, IOMMUs, interrupt controllers).

http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf

Building on basic IORT support, available through [2]:

this patchset enables ARM SMMU v3 support on ACPI systems.

Most of the code is aimed at building the required generic ACPI
infrastructure to create and enable IOMMU components and to bring
the IOMMU infrastructure for ACPI on par with DT, which is going to
make future ARM SMMU components easier to integrate.

PATCH (1-2) fix compile warning/errors in [2]

PATCH (3) rework ARM64 IOMMU bus notifier to attach dma_ops.

PATCH (4) provides IORT support for registering IOMMU components.

PATCH (5) adds IORT based look-up for named components.

PATCH (6) improve IORT identifiers mapping API to make it work across
          all possible IORT components.

PATCH (7) provides an IORT function to detect existence of specific type
          of IORT components.

PATCH (8) refactors the ARM SMMU v3 driver so that the init functions are
          split in a way that groups together code that probes through DT
          and code that carries out HW registers FW agnostic probing, in
          preparation for adding the ACPI probing path.

PATCH (9) rework ARM SMMU v3 platform driver registration to make it work on
          ACPI systems.

PATCH (10) creates the kernel infrastructure required to create ARM SMMU
           platform devices for IORT nodes.

PATCH (11) Building on patch (10), it adds ARM SMMU v3 IORT IOMMU operations
           to create and probe ARM SMMU v3 components.

PATCH (12) implements the of_dma_configure() API in ACPI world -
           acpi_dma_configure() - and patches PCI and ACPI core code to start
           making use of it.

PATCH (13) provides IORT infrastructure to carry out IOMMU configuration
           for devices and hook it up to the previously introduced ACPI
           DMA configure API.

PATCH (14) define a function to look-up platform devices through their
           respective IORT nodes stored in platform_data. This patch is
           somewhat controversial and is provided as an initial solution
           to the problem pending further discussions.

PATCH (15) provides code to carry out ACPI IORT based device identifiers
           translation for ARM SMMU v3 components.

This patchset is built on top and depends on these three patch series:

[1] R.Murphy "Generic DT bindings for PCI and ARM SMMU v3"
    http://marc.info/?l=linux-arm-kernel&m=146497432413816&w=2

[2] T.Nowicki "Introduce ACPI world to ITS irqchip" v5
    http://marc.info/?l=linux-acpi&m=146469369703684&w=2

[3] T.Nowicki "Support for ARM64 ACPI based PCI host controller" v8
    http://marc.info/?l=linux-acpi&m=146462129816292&w=2

and is provided for early review/testing purposes here:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v2

Tested on FVP models for ARM SMMU v3 probing path.

Lorenzo Pieralisi (15):
  drivers: acpi: iort: fix struct pci_dev compiler warnings
  drivers: irqchip: its: fix its_acpi_probe() prototype
  arm64: mm: change IOMMU notifier action to attach DMA ops
  drivers: acpi: iort: add support for IOMMU registration
  drivers: acpi: iort: add support for named component look-up
  drivers: acpi: iort: enhance device identifiers mappings
  drivers: acpi: iort: add node match function
  drivers: acpi: iort: add support for ARM SMMU platform devices
    creation
  drivers: iommu: arm-smmu-v3: split probe functions into DT/generic
    portions
  drivers: iommu: arm-smmu-v3: enable ACPI driver initialization
  drivers: iommu: arm-smmu-v3: add IORT iommu configuration
  drivers: acpi: implement acpi_dma_configure
  drivers: acpi: iort: introduce iort_iommu_configure
  drivers: acpi: iort: add function to retrieve IOMMU platform devices
  drivers: iommu: arm-smmu-v3: allow ACPI based streamid translation

 arch/arm64/mm/dma-mapping.c      |   2 +-
 drivers/acpi/glue.c              |   4 +-
 drivers/acpi/iort.c              | 361 ++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/scan.c              |  29 ++++
 drivers/iommu/arm-smmu-v3.c      | 235 ++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3-its.c |   2 +-
 drivers/pci/probe.c              |   3 +-
 include/acpi/acpi_bus.h          |   2 +
 include/linux/acpi.h             |   5 +
 include/linux/iort.h             |  43 +++++
 10 files changed, 652 insertions(+), 34 deletions(-)

-- 
2.6.4

