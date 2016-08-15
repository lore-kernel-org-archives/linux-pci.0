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
	Sinan Kaya <okaya@codeaurora.org>,
	Nate Watterson <nwatters@codeaurora.org>,
	Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/15] ACPI IORT ARM SMMU v3 support
Date: Mon, 15 Aug 2016 16:23:25 +0100
Message-Id: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series is v4 of a previous posting:

https://lkml.org/lkml/2016/7/20/248

v3 -> v4
	- Added single mapping API (for IORT named components)
	- Fixed arm_smmu_iort_xlate() return value
	- Reworked fwnode registration and platform device creation
	  ordering to fix probe ordering dependencies
	- Added code to keep device_node ref count with new iommu
	  fwspec API
	- Added patch to make iommu_fwspec arch agnostic
	- Dropped RFC status
	- Rebased against v4.8-rc2

v2 -> v3
	- Rebased on top of dependencies series [1][2][3](v4.7-rc3)
	- Added back reliance on ACPI early probing infrastructure
	- Patch[1-3] merged through other dependent series
	- Added back IOMMU fwnode generalization
	- Move SMMU v3 static functions configuration to IORT code
	- Implemented generic IOMMU fwspec API
	- Added code to implement fwnode platform device look-up

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

Building on basic IORT support, available through [2],
this patchset enables ARM SMMU v3 support on ACPI systems.

Most of the code is aimed at building the required generic ACPI
infrastructure to create and enable IOMMU components and to bring
the IOMMU infrastructure for ACPI on par with DT, which is going to
make future ARM SMMU components easier to integrate.

PATCH (1) adds a FWNODE_IOMMU type to the struct fwnode_handle type.
          It is required to attach a fwnode identifier to platform
          devices allocated/detected through IORT tables entries;
          IOMMU devices have to have an identifier to look them up
          eg IOMMU core layer carrying out id translation. This can be
          done through a fwnode_handle (ie IOMMU platform devices created
          out of IORT tables are not ACPI devices hence they can't be
          allocated as such, otherwise they would have a fwnode_handle of
          type FWNODE_ACPI).

PATCH (2) Add kernel infrastructure to make the struct iommu_fwspec
          handling arch agnostic and generic.

PATCH (3) makes use of the ACPI early probing API to add a linker script
          section for probing devices via IORT ACPI kernel code.

PATCH (4) provides IORT support for registering IOMMU IORT node through
          their fwnode handle.

PATCH (5) implements core code fwnode based platform devices look-up.

PATCH (6) extends iommu_fwspec so that it can be used on ACPI based
          system by creating a generic IOMMU fwspec kernel layer.

PATCH (7) implements the of_dma_configure() API in ACPI world -
          acpi_dma_configure() - and patches PCI and ACPI core code to
          start making use of it.

PATCH (8) provides an IORT function to detect existence of specific type
          of IORT components.

PATCH (9) creates the kernel infrastructure required to create ARM SMMU
          platform devices for IORT nodes.

PATCH (10) refactors the ARM SMMU v3 driver so that the init functions are
           split in a way that groups together code that probes through DT
           and code that carries out HW registers FW agnostic probing, in
           preparation for adding the ACPI probing path.

PATCH (11) rework ARM SMMU v3 platform driver registration to make it work
           on ACPI systems.

PATCH (12) Building on patch (9), it adds ARM SMMU v3 IORT IOMMU
           operations to create and probe ARM SMMU v3 components.

PATCH (13) Extend the IORT iort_node_map_rid() to work on a type mask
           instead of a single type so that the translation API can
           be used on a range of components.

PATCH (14) Add IORT API to carry out id mappings for components that do
           do not have an input identifier/RIDs (ie named components).

PATCH (15) provides IORT infrastructure to carry out IOMMU configuration
           for devices and hook it up to the previously introduced ACPI
           DMA configure API.

This patchset is built on top and depends on these two patch series:

[1] R.Murphy "Generic DT bindings for PCI and ARM SMMU v3" v4
    https://marc.info/?l=devicetree&m=146739193215518&w=2

[2] T.Nowicki "Introduce ACPI world to ITS irqchip" v8
    https://marc.info/?l=linux-kernel&m=147091000919640&w=2

and is provided for early review/testing purposes here:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v4

Tested on FVP models for ARM SMMU v3 probing path.

Lorenzo Pieralisi (15):
  drivers: iommu: add FWNODE_IOMMU fwnode type
  drivers: iommu: implement arch_{set/get}_iommu_fwspec API
  drivers: acpi: iort: introduce linker section for IORT entries probing
  drivers: acpi: iort: add support for IOMMU fwnode registration
  drivers: platform: add fwnode base platform devices retrieval
  drivers: iommu: make iommu_fwspec OF agnostic
  drivers: acpi: implement acpi_dma_configure
  drivers: acpi: iort: add node match function
  drivers: acpi: iort: add support for ARM SMMU platform devices
    creation
  drivers: iommu: arm-smmu-v3: split probe functions into DT/generic
    portions
  drivers: iommu: arm-smmu-v3: enable ACPI driver initialization
  drivers: iommu: arm-smmu-v3: add IORT configuration
  drivers: acpi: iort: replace rid map type with type mask
  drivers: acpi: iort: add single mapping function
  drivers: acpi: iort: introduce iort_iommu_configure

 arch/arm/Kconfig                      |   1 +
 arch/arm/include/asm/iommu-fwspec.h   |  30 +++
 arch/arm64/Kconfig                    |   1 +
 arch/arm64/include/asm/iommu-fwspec.h |  30 +++
 drivers/acpi/arm64/iort.c             | 481 +++++++++++++++++++++++++++++++++-
 drivers/acpi/glue.c                   |   4 +-
 drivers/acpi/scan.c                   |  29 ++
 drivers/base/platform.c               |  23 ++
 drivers/iommu/Kconfig                 |   7 +
 drivers/iommu/Makefile                |   1 +
 drivers/iommu/arm-smmu-v3.c           | 150 +++++++++--
 drivers/iommu/iommu-fwspec.c          | 126 +++++++++
 drivers/iommu/of_iommu.c              |  91 -------
 drivers/pci/probe.c                   |   3 +-
 include/acpi/acpi_bus.h               |   2 +
 include/asm-generic/vmlinux.lds.h     |   1 +
 include/linux/acpi.h                  |   5 +
 include/linux/fwnode.h                |   1 +
 include/linux/iommu-fwspec.h          |  70 +++++
 include/linux/iommu.h                 |  25 ++
 include/linux/iort.h                  |  18 ++
 include/linux/of_iommu.h              |  28 +-
 include/linux/platform_device.h       |   3 +
 23 files changed, 995 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm/include/asm/iommu-fwspec.h
 create mode 100644 arch/arm64/include/asm/iommu-fwspec.h
 create mode 100644 drivers/iommu/iommu-fwspec.c
 create mode 100644 include/linux/iommu-fwspec.h

-- 
2.6.4

