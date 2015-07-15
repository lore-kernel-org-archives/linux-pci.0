Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36776 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbbGOQy6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 12:54:58 -0400
From: David Daney <ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, Robert Richter <rrichter@cavium.com>,
	David Daney <david.daney@cavium.com>
Subject: [PATCH 4/5] irqchip: gic-v3: Add gic_get_irq_domain() to get the irqdomain of the GIC.
Date: Wed, 15 Jul 2015 09:54:44 -0700
Message-Id: <1436979285-8177-5-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

Needed to map SPI interrupt sources.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/irqchip/irq-gic-v3.c       | 5 +++++
 include/linux/irqchip/arm-gic-v3.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c52f7ba..0019fed 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -58,6 +58,11 @@ static struct gic_chip_data gic_data __read_mostly;
 /* Our default, arbitrary priority value. Linux only uses one anyway. */
 #define DEFAULT_PMR_VALUE	0xf0
 
+struct irq_domain *gic_get_irq_domain(void)
+{
+	return gic_data.domain;
+}
+
 static inline unsigned int gic_irq(struct irq_data *d)
 {
 	return d->hwirq;
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 18e3757..5992224 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -391,6 +391,7 @@ int its_init(struct device_node *node, struct rdists *rdists,
 
 typedef u32 (*its_pci_requester_id_t)(struct pci_dev *, u16);
 void set_its_pci_requester_id(its_pci_requester_id_t fn);
+struct irq_domain *gic_get_irq_domain(void);
 #endif
 
 #endif
-- 
1.9.1

