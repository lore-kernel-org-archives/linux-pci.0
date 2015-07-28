Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59029 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbbG1Nqd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 09:46:33 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>, Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v6 00/19] Per-device MSI domain & platform MSI
Date: Tue, 28 Jul 2015 14:46:07 +0100
Message-Id: <1438091186-10244-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

MSI-like interrupts are starting to creep out of the PCI world, and
can now be seen into a number of "platform"-type busses. The
introduction of the MSI domains feature in v3.19 recognised that fact,
and started providing a way to implement this.

Another step in this direction is Jiang Liu's msi_desc series:

https://github.com/jiangliu/linux.git msi_desc_v1

which moves the msi_list from being specific to PCI devices into the
generic device structure.

A problem we have to solve is to identify which MSI domain a device is
"connected" to. Currently, PCI gets away with a mixture of
arch-specific callbacks, and a msi_controller structure that can
optionally carry a pointer to an MSI domain. As we add new bus types
and start dealing with topologies that do not map to what PCI does,
this doesn't scale anymore.

This patch series tries to address some of it by providing a basic
link between 'struct device' and an MSI domain. It also adds :

- a way to "tag" domains according to the "type" of interrupt it
  provides (PCI/MSI, platform MSI...), allowing a driver for a piece
  of HW identified by its device_node to provide several IRQ domains

- (yet another) way for PCI to propagate the domain pointer through
  the PCI device hierarchy, providing a method for OF to kick-start
  the propagation process, and finally allowing the PCI/MSI layer to
  use that information

- a similar way to hook an MSI domain to a platform device.

- a generic implementation of MSI for platform devices that can be
  supported by interrupt controllers.

- support code for platform MSI for both GICv2m and GICv3 ITS.

This makes implementing MSI support in platform devices a relatively
trivial task.

Additionally, a few patches use most of the above to remove any trace
of the msi_controller structure from the three MSI controllers that
are currently in use on arm64, so that they solely rely on the above
infrastructure, leading to some interesting improvements (also known
as "gross hack prevention measures"). We also take this opportunity to
kill the domain pointer from the msi_controller structure.

My hope is to eventually kill msi_controller entirely, and only rely
on the msi_domain contained in the device structure (any help
welcomed, as I already have cleaned up Tegra, and Lorenzo has scrubbed
Designware).

This has been tested on arm64 with GICv2m (AMD Seattle) and GICv3 ITS
(FVP model), and use of platform MSI has been tested with the ARM
SMMUv3.

Patches are on top of 4.2-rc2 and Jiang Liu's series, and available
at:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/npci-msi-v3

It also applies on tip/irq/core with a couple of trivial conflicts.

As always, comments most welcome...

* From v5:
  - Fixed a few nits noticed by Bjorn
  - Removed spurious comments
  - Collected Acked- and Reviewed-bys

* From v4:
  - Nice cleanups in the PCI code after review from Bjorn
  - Platform MSI now gets its own namespace in struct msi_desc
  - Fixed bisectability issue caught by the 01.org folks

Marc Zyngier (19):
  genirq: irqdomain: Allow irq domain aliasing
  PCI: MSI: Register irq domain with specific token
  device core: Introduce per-device MSI domain pointer
  PCI/MSI: Add hooks to populate the msi_domain field
  PCI/MSI: of: Add support for OF-provided msi_domain
  PCI/MSI: of: Allow msi_domain lookup using the host bridge node
  PCI/MSI: Let pci_msi_get_domain use struct device's msi_domain
  platform: of: Assign MSI domain to platform device
  drivers: base: Add MSI domain support for non-PCI devices
  genirq: Add DOMAIN_BUS_NEXUS irqdomain property
  irqchip: gicv3-its: Split PCI/MSI code from the core ITS driver
  irqchip: gicv3-its: Register irq domain with NEXUS token
  irqchip: gicv3-its: Get rid of struct msi_controller
  irqchip: gicv3-its: Make the PCI/MSI code standalone
  irqchip: gicv3-its: Add platform MSI support
  irqchip: GICv2m: Get rid of struct msi_controller
  irqchip: GICv2m: Add platform MSI support
  PCI/MSI: pci-xgene-msi: Get rid of struct msi_controller
  PCI/MSI: Drop domain field from msi_controller

 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |   3 +-
 arch/powerpc/platforms/cell/interrupt.c          |   3 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |   3 +-
 arch/powerpc/platforms/powermac/pic.c            |   3 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c    |   3 +-
 arch/powerpc/platforms/ps3/interrupt.c           |   3 +-
 arch/powerpc/sysdev/ehv_pic.c                    |   3 +-
 arch/powerpc/sysdev/i8259.c                      |   3 +-
 arch/powerpc/sysdev/ipic.c                       |   3 +-
 arch/powerpc/sysdev/mpic.c                       |   3 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c               |   3 +-
 arch/powerpc/sysdev/xics/xics-common.c           |   3 +-
 drivers/base/Makefile                            |   1 +
 drivers/base/platform-msi.c                      | 282 +++++++++++++++++++++++
 drivers/irqchip/Makefile                         |   2 +-
 drivers/irqchip/irq-gic-v2m.c                    |  52 +++--
 drivers/irqchip/irq-gic-v3-its-pci-msi.c         | 140 +++++++++++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c    |  93 ++++++++
 drivers/irqchip/irq-gic-v3-its.c                 | 140 ++++-------
 drivers/of/irq.c                                 |  21 ++
 drivers/of/platform.c                            |   1 +
 drivers/pci/host/pci-xgene-msi.c                 |  41 ++--
 drivers/pci/msi.c                                |  19 +-
 drivers/pci/of.c                                 |  30 +++
 drivers/pci/probe.c                              |  45 ++++
 include/linux/device.h                           |  20 ++
 include/linux/irqchip/arm-gic-v3.h               |   1 +
 include/linux/irqdomain.h                        |  26 ++-
 include/linux/msi.h                              |  18 +-
 include/linux/of_irq.h                           |   1 +
 include/linux/pci.h                              |   4 +
 kernel/irq/irqdomain.c                           |  18 +-
 32 files changed, 815 insertions(+), 176 deletions(-)
 create mode 100644 drivers/base/platform-msi.c
 create mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c
 create mode 100644 drivers/irqchip/irq-gic-v3-its-platform-msi.c

-- 
2.1.4

*** BLURB HERE ***

Marc Zyngier (19):
  genirq: irqdomain: Allow irq domain aliasing
  PCI: MSI: Register irq domain with specific token
  device core: Introduce per-device MSI domain pointer
  PCI/MSI: Add hooks to populate the msi_domain field
  PCI/MSI: of: Add support for OF-provided msi_domain
  PCI/MSI: of: Allow msi_domain lookup using the host bridge node
  PCI/MSI: Let pci_msi_get_domain use struct device's msi_domain
  platform: of: Assign MSI domain to platform device
  drivers: base: Add MSI domain support for non-PCI devices
  genirq: Add DOMAIN_BUS_NEXUS irqdomain property
  irqchip: gicv3-its: Split PCI/MSI code from the core ITS driver
  irqchip: gicv3-its: Register irq domain with NEXUS token
  irqchip: gicv3-its: Get rid of struct msi_controller
  irqchip: gicv3-its: Make the PCI/MSI code standalone
  irqchip: gicv3-its: Add platform MSI support
  irqchip: GICv2m: Get rid of struct msi_controller
  irqchip: GICv2m: Add platform MSI support
  PCI/MSI: pci-xgene-msi: Get rid of struct msi_controller
  PCI/MSI: Drop domain field from msi_controller

 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |   3 +-
 arch/powerpc/platforms/cell/interrupt.c          |   3 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |   3 +-
 arch/powerpc/platforms/powermac/pic.c            |   3 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c    |   3 +-
 arch/powerpc/platforms/ps3/interrupt.c           |   3 +-
 arch/powerpc/sysdev/ehv_pic.c                    |   3 +-
 arch/powerpc/sysdev/i8259.c                      |   3 +-
 arch/powerpc/sysdev/ipic.c                       |   3 +-
 arch/powerpc/sysdev/mpic.c                       |   3 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c               |   3 +-
 arch/powerpc/sysdev/xics/xics-common.c           |   3 +-
 drivers/base/Makefile                            |   1 +
 drivers/base/platform-msi.c                      | 282 +++++++++++++++++++++++
 drivers/irqchip/Makefile                         |   2 +-
 drivers/irqchip/irq-gic-v2m.c                    |  52 +++--
 drivers/irqchip/irq-gic-v3-its-pci-msi.c         | 140 +++++++++++
 drivers/irqchip/irq-gic-v3-its-platform-msi.c    |  93 ++++++++
 drivers/irqchip/irq-gic-v3-its.c                 | 140 ++++-------
 drivers/of/irq.c                                 |  21 ++
 drivers/of/platform.c                            |   1 +
 drivers/pci/host/pci-xgene-msi.c                 |  41 ++--
 drivers/pci/msi.c                                |  20 +-
 drivers/pci/of.c                                 |  30 +++
 drivers/pci/probe.c                              |  45 ++++
 include/linux/device.h                           |  20 ++
 include/linux/irqchip/arm-gic-v3.h               |   1 +
 include/linux/irqdomain.h                        |  26 ++-
 include/linux/msi.h                              |  18 +-
 include/linux/of_irq.h                           |   1 +
 include/linux/pci.h                              |   4 +
 kernel/irq/irqdomain.c                           |  18 +-
 32 files changed, 816 insertions(+), 176 deletions(-)
 create mode 100644 drivers/base/platform-msi.c
 create mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c
 create mode 100644 drivers/irqchip/irq-gic-v3-its-platform-msi.c

-- 
2.1.4

