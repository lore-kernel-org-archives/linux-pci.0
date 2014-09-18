Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<jason@lakedaemon.net>
CC: <pawel.moll@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>, <liviu.dudau@arm.com>, <tglx@linutronix.de>,
	<Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	"Suravee Suthikulpanit" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 0/2 V7] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
Date: Wed, 17 Sep 2014 19:08:24 -0700
Message-ID: <1411006106-17339-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400.

This depends on and has been tested with the following patch set which
implements PCI supports for ARM64:

    [PATCH v10 00/10] Support for creating generic PCI host bridges from DT
    https://lkml.org/lkml/2014/9/8/333

    [PATCH v10] Add support for PCI in AArch64
    https://lkml.org/lkml/2014/9/8/325
 
Changes in V7:
    * Fix error handling logic in gicv2m_of_init() and gicv2m_init_one().
      per Marc suggestions.
    * Restructure the patch to integrate the multi-MSI support for V2m
      into the patch 2/2.
    * Introduce "arm,gic-v2m-frame" compatible ID for the v2m DT binding.
    * Introduce "arm,msi-base-spi" and "arm,msi-num-spi" property in the
      v2m DT binding for overwriting value in MSI_TYPER register.
    * Add irq-gic-v2m.c: is_msi_spi_valid() to validate the SPI base and
      number of SPIs.
    * Fix various comments from Marc (Many thanks).
    * Add the missing CONFIG_ARM_GICV2M (per Marcin Juszkiewicz comment)

Suravee Suthikulpanit (2):
  irqchip: gic: Add support for multiple MSI for ARM64
  irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)

 Documentation/devicetree/bindings/arm/gic.txt |  55 ++++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/msi.c                       |  41 +++
 drivers/irqchip/Kconfig                       |   7 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-common.c              |  12 +
 drivers/irqchip/irq-gic-common.h              |   4 +
 drivers/irqchip/irq-gic-v2m.c                 | 356 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c                     |  82 +++---
 drivers/irqchip/irq-gic.h                     |  54 ++++
 11 files changed, 584 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/kernel/msi.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic.h

-- 
1.9.3

