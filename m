Return-Path: <linux-kernel-owner@vger.kernel.org>
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <Catalin.Marinas@arm.com>,
	<Will.Deacon@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH 0/2] Introduce ARM GICv2m MSI(-X) support
Date: Mon, 23 Jun 2014 19:32:58 -0500
Message-ID: <1403569980-12913-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400.

This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
(https://lkml.org/lkml/2014/3/14/320).

Suravee Suthikulpanit (2):
  arm/gic: Add binding probe for GIC400
  arm/gic: Add supports for GICv2m MSI(-X)

 Documentation/devicetree/bindings/arm/gic.txt |  18 +-
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/gic-msi-v2m.c                 | 249 ++++++++++++++++++++++++++
 drivers/irqchip/gic-msi-v2m.h                 |  20 +++
 drivers/irqchip/irq-gic.c                     |  23 ++-
 6 files changed, 313 insertions(+), 4 deletions(-)
 create mode 100644 drivers/irqchip/gic-msi-v2m.c
 create mode 100644 drivers/irqchip/gic-msi-v2m.h

-- 
1.9.0

