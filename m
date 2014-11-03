Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0103.outbound.protection.outlook.com ([157.56.110.103]:55604
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752538AbaKCVQ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Nov 2014 16:16:29 -0500
From: <suravee.suthikulpanit@amd.com>
To: <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
	<jason@lakedaemon.net>, <tglx@linutronix.de>
CC: <Catalin.Marinas@arm.com>, <Will.Deacon@arm.com>,
	<liviu.dudau@arm.com>, <Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	"Suravee Suthikulpanit" <Suravee.Suthikulpanit@amd.com>
Subject: [V10 PATCH 0/2] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
Date: Mon, 3 Nov 2014 16:16:15 -0600
Message-ID: <1415052977-26036-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces support for MSI(-X) in GICv2m specification,
which is implemented in some variation of GIC400.

This patch adopt the new hierarchy irq domain, and is rebased from: 
    Git tree   : git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
    Git branch : domain_hierarchy
    Last commit: 97d4ea1f0922fb47dd1b09cd2694b7fa5b519db9

Changes in V10 includes:
  * Remove the alloc_msi_irq and integrate into gicv2m_setup_msi_irq
  * Clean up the error_out logic in gicv2m_init_one
  * Add comments in gic_irq_domain_alloc()
  * Removed v2m_list since no longer needed with the irqdomain hierachy framework
  * Rename variable in gicv2m_taredown_msi_irq to be consistent with other functions

History:
    V9: https://lkml.org/lkml/2014/10/31/111
    V8: https://lkml.org/lkml/2014/9/20/111
    V7: https://lkml.org/lkml/2014/9/17/751


Suravee Suthikulpanit (2):
  genirq: Add irq_chip_set_type_parent function
  irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)

 Documentation/devicetree/bindings/arm/gic.txt |  53 ++++
 arch/arm64/Kconfig                            |   1 +
 drivers/irqchip/Kconfig                       |   5 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-gic-v2m.c                 | 340 ++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-v2m.h                 |   6 +
 drivers/irqchip/irq-gic.c                     |  23 +-
 include/linux/irq.h                           |   1 +
 kernel/irq/chip.c                             |  10 +
 9 files changed, 436 insertions(+), 4 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v2m.c
 create mode 100644 drivers/irqchip/irq-gic-v2m.h

-- 
1.9.3

