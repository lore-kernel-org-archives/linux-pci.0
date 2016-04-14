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
Subject: [RFC PATCH 00/11] ACPI IORT ARM SMMU support
Date: Thu, 14 Apr 2016 18:25:32 +0100
Message-Id: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI IORT table provides information that allows instantiating
ARM SMMU devices and carrying out id mappings between components on
ARM based systems (devices, IOMMUs, interrupt controllers).

http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf

Building on basic IORT support, available through this posting:

https://marc.info/?l=linux-acpi&m=145976009630179&w=2

this patchset enables ARM SMMU support on ACPI systems.

Most of the code is aimed at building the required generic ACPI
infrastructure to create and enable IOMMU components and to bring
the IOMMU infrastructure for ACPI on par with DT, which is going to
make ARM SMMUv3 and future IOMMU components easier to integrate.

PATCH [1] fixes a warning caused by a missing forward structure
          declaration.

PATCH [2] provides IORT support for registering IOMMU components.

PATCH [3] adds a FWNODE_IOMMU type to the struct fwnode_handle type.
          It is required to attach a fwnode identifier to platform
          devices allocated/detected through IORT tables entries;
          IOMMU devices have to have an identifier to look them up
          eg IOMMU core layer carrying out id translation. This can be
          done through a fwnode_handle (ie IOMMU platform devices created
          out of IORT tables are not ACPI devices hence they can't be
          allocated as such, otherwise they would have a fwnode_handle of
          type FWNODE_ACPI). This patch requires discussion and it is key
          to the RFC.

PATCH [4] makes use of the ACPI early probing API to add a linker script
          section for probing devices via IORT ACPI kernel code.

PATCH [5] refactors the ARM SMMU driver so that the init functions are
          split in a way that groups together code that probes through DT
          and code that carries out HW registers FW agnostic probing, in
          preparation for adding the ACPI probing path.

PATCH [6] makes the of_xlate() interface for IOMMUs DT agnostic by
          changing its API and making it work on ACPI systems too
          through the introduction of a generic IOMMU FW translation
          specifier.

PATCH [7] implements ARM SMMU streamid mapping based on the previously
          introduced infrastructure.

PATCH [8] enhances IORT kernel code to implement the full set of mappings
          allowed through the ACPI IORT table.

PATCH [9] implements the of_dma_configure() API in ACPI world -
          acpi_dma_configure() - and patches PCI and ACPI core code to start
          making use of it.

PATCH [10] implements and enables code for probing the ARM SMMU with ACPI,
           building on top of the previously introduced generic infrastructure.

PATCH [11] is a mechanical conversion of IRQ domain infrastructure to
           generalize its translation capabilities for other kernel
           subsystems, and it is there to prove that the approach taken
           to implement IOMMU translation in a DT agnostic way would lead
           to structure data duplication that may be deemed unnecessary
           and can therefore be avoided.

This patchset is built on top and depends on these two patch series:

R.Murphy "Generic DT bindings for PCI and ARM SMMU"
https://marc.info/?l=linux-arm-kernel&m=145675372917701&w=2

T.Nowicki "Introduce ACPI world to ITS irqchip"
https://marc.info/?l=linux-acpi&m=145976009630179&w=2

Tested on Juno-r2 board with both DT and ACPI probing paths.

Lorenzo Pieralisi (11):
  drivers: acpi: iort: fix struct pci_dev compiler warnings
  drivers: acpi: iort: add support for IOMMU registration
  drivers: iommu: add FWNODE_IOMMU fwnode type
  drivers: acpi: iort: introduce linker section for IORT entries probing
  drivers: iommu: arm-smmu: split probe functions into DT/generic
    portions
  drivers: iommu: make of_xlate() interface DT agnostic
  drivers: iommu: arm-smmu: allow ACPI based streamid translation
  drivers: acpi: iort: enhance mapping API
  drivers: acpi: implement acpi_dma_configure
  drivers: iommu: arm-smmu: implement ACPI probing
  drivers: irqchip: make struct irq_fwspec generic

 Documentation/IRQ-domain.txt         |   2 +-
 arch/arm/mach-exynos/suspend.c       |   6 +-
 arch/arm/mach-imx/gpc.c              |   6 +-
 arch/arm/mach-omap2/omap-wakeupgen.c |   6 +-
 drivers/acpi/glue.c                  |   4 +-
 drivers/acpi/gsi.c                   |   2 +-
 drivers/acpi/iort.c                  | 188 ++++++++++++++++++-
 drivers/acpi/scan.c                  |  29 +++
 drivers/gpio/gpio-xgene-sb.c         |   8 +-
 drivers/iommu/arm-smmu.c             | 346 ++++++++++++++++++++++++++++++-----
 drivers/iommu/exynos-iommu.c         |  11 +-
 drivers/iommu/mtk_iommu.c            |  13 +-
 drivers/iommu/of_iommu.c             |   8 +-
 drivers/irqchip/irq-alpine-msi.c     |   2 +-
 drivers/irqchip/irq-crossbar.c       |   6 +-
 drivers/irqchip/irq-gic-v2m.c        |   2 +-
 drivers/irqchip/irq-gic-v3-its.c     |   2 +-
 drivers/irqchip/irq-gic-v3.c         |   4 +-
 drivers/irqchip/irq-gic.c            |   4 +-
 drivers/irqchip/irq-imx-gpcv2.c      |   6 +-
 drivers/irqchip/irq-mbigen.c         |   4 +-
 drivers/irqchip/irq-mips-gic.c       |   2 +-
 drivers/irqchip/irq-mtk-sysirq.c     |   6 +-
 drivers/irqchip/irq-mvebu-odmi.c     |   2 +-
 drivers/irqchip/irq-nvic.c           |   4 +-
 drivers/irqchip/irq-tegra.c          |   6 +-
 drivers/irqchip/irq-vf610-mscm-ir.c  |   6 +-
 drivers/of/base.c                    |  24 +++
 drivers/pci/probe.c                  |   3 +-
 include/acpi/acpi_bus.h              |   2 +
 include/asm-generic/vmlinux.lds.h    |   1 +
 include/linux/acpi.h                 |   5 +
 include/linux/fwnode.h               |  21 +++
 include/linux/iommu.h                |  31 +++-
 include/linux/iort.h                 |  18 ++
 include/linux/irqdomain.h            |  22 +--
 include/linux/of.h                   |   7 +
 kernel/irq/irqdomain.c               |  17 +-
 38 files changed, 692 insertions(+), 144 deletions(-)

-- 
2.6.4

