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
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 00/16] ACPI IORT ARM SMMU support
Date: Wed, 16 Nov 2016 15:29:20 +0000
Message-Id: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series is v8 of a previous posting:

https://lkml.org/lkml/2016/11/9/422

v7 -> v8
	- Renamed fwnode iommu_ops registration API according to review
	- Minor change in ARM SMMU driver DT/ACPI split
	- Added review tags

v6 -> v7
	- Rebased against v4.9-rc4
	- Fixed IORT probing on ACPI systems with missing IORT table
	- Fixed SMMUv1/v2 global interrupt detection
	- Updated iommu_ops firmware look-up

v5 -> v6
	- Rebased against v4.9-rc1
	- Changed FWNODE_IOMMU to FWNODE_ACPI_STATIC
	- Moved platform devices creation into IORT code
	- Updated fwnode handling
	- Added default dma masks initialization

v4 -> v5
	- Added SMMUv1/v2 support
	- Rebased against v4.8-rc5 and dependencies series
	- Consolidated IORT platform devices creation

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

Building on basic IORT support, this patchset enables ARM SMMUs support
on ACPI systems.

Most of the code is aimed at building the required generic ACPI
infrastructure to create and enable IOMMU components and to bring
the IOMMU infrastructure for ACPI on par with DT, which is going to
make future ARM SMMU components easier to integrate.

PATCH (1) adds a FWNODE_ACPI_STATIC type to the struct fwnode_handle type.
          It is required to attach a fwnode identifier to platform
          devices allocated/detected through static ACPI table entries
          (ie IORT tables entries).
          IOMMU devices have to have an identifier to look them up
          eg IOMMU core layer carrying out id translation. This can be
          done through a fwnode_handle (ie IOMMU platform devices created
          out of IORT tables are not ACPI devices hence they can't be
          allocated as such, otherwise they would have a fwnode_handle of
          type FWNODE_ACPI).

PATCH (2) makes use of the ACPI early probing API to add a linker script
          section for probing devices via IORT ACPI kernel code.

PATCH (3) provides IORT support for registering IOMMU IORT node through
          their fwnode handle.

PATCH (4) make of_iommu_{set/get}_ops() functions DT agnostic and
          rename the registration API.

PATCH (5) convert ARM SMMU driver to use fwnode instead of of_node as
          look-up and iommu_ops retrieval token.

PATCH (6) convert ARM SMMU v3 driver to use fwnode instead of of_node as
          look-up and iommu_ops retrieval token.

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

PATCH (11) adds ARM SMMU v3 IORT IOMMU operations to create and probe
           ARM SMMU v3 components.

PATCH (12) refactors the ARM SMMU v1/v2 driver so that the init functions
           are split in a way that groups together code that probes
           through DT and code that carries out HW registers FW agnostic
           probing, in preparation for adding the ACPI probing path.

PATCH (13) adds ARM SMMU v1/v2 IORT IOMMU operations to create and
           probe ARM SMMU v1/v2 components.

PATCH (14) Extend the IORT iort_node_map_rid() to work on a type mask
           instead of a single type so that the translation API can
           be used on a range of components.

PATCH (15) Add IORT API to carry out id mappings for components that do
           do not have an input identifier/RIDs (ie named components).

PATCH (16) provides IORT infrastructure to carry out IOMMU configuration
           for devices and hook it up to the previously introduced ACPI
           DMA configure API.

This patchset is provided for review/testing purposes here:

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v8

Tested on Juno and FVP models for ARM SMMU v1 and v3 probing path.

Lorenzo Pieralisi (16):
  drivers: acpi: add FWNODE_ACPI_STATIC fwnode type
  drivers: acpi: iort: introduce linker section for IORT entries probing
  drivers: acpi: iort: add support for IOMMU fwnode registration
  drivers: iommu: make of_iommu_set/get_ops() DT agnostic
  drivers: iommu: arm-smmu: convert struct device of_node to fwnode
    usage
  drivers: iommu: arm-smmu-v3: convert struct device of_node to fwnode
    usage
  drivers: acpi: implement acpi_dma_configure
  drivers: acpi: iort: add node match function
  drivers: acpi: iort: add support for ARM SMMU platform devices
    creation
  drivers: iommu: arm-smmu-v3: split probe functions into DT/generic
    portions
  drivers: iommu: arm-smmu-v3: add IORT configuration
  drivers: iommu: arm-smmu: split probe functions into DT/generic
    portions
  drivers: iommu: arm-smmu: add IORT configuration
  drivers: acpi: iort: replace rid map type with type mask
  drivers: acpi: iort: add single mapping function
  drivers: acpi: iort: introduce iort_iommu_configure

 drivers/acpi/arm64/iort.c         | 595 +++++++++++++++++++++++++++++++++++++-
 drivers/acpi/glue.c               |   4 +-
 drivers/acpi/scan.c               |  45 +++
 drivers/iommu/arm-smmu-v3.c       | 105 +++++--
 drivers/iommu/arm-smmu.c          | 154 ++++++++--
 drivers/iommu/iommu.c             |  40 +++
 drivers/iommu/of_iommu.c          |  39 ---
 drivers/pci/probe.c               |   3 +-
 include/acpi/acpi_bus.h           |   2 +
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/acpi.h              |  26 ++
 include/linux/acpi_iort.h         |  14 +
 include/linux/fwnode.h            |   3 +-
 include/linux/iommu.h             |  14 +
 include/linux/of_iommu.h          |  12 +-
 15 files changed, 953 insertions(+), 104 deletions(-)

-- 
2.10.0

