Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:44294 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756Ab3FFQll (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 12:41:41 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: [PATCH v2 3/8] irqchip: armada-370-xp: properly request resources
Date: Thu,  6 Jun 2013 18:41:23 +0200
Message-Id: <1370536888-8871-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of using of_iomap(), we now use of_address_to_resource(),
request_mem_region() and ioremap(). This allows the corresponding I/O
regions to be properly requested and visible in /proc/iomem.

The main motivation for this change is that the introduction of the
MSI support requires us to get the physical address of the main
interrupt controller registers, so we will need the corresponding
'struct resource' anyway.

We also take this opportunity to change a panic() to BUG_ON(), in
order to be consistent with the rest of the driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index bb328a3..26adc74 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -248,12 +248,25 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 					     struct device_node *parent)
 {
+	struct resource main_int_res, per_cpu_int_res;
 	u32 control;
 
-	main_int_base = of_iomap(node, 0);
-	per_cpu_int_base = of_iomap(node, 1);
+	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
+	BUG_ON(of_address_to_resource(node, 1, &per_cpu_int_res));
 
+	BUG_ON(!request_mem_region(main_int_res.start,
+				   resource_size(&main_int_res),
+				   node->full_name));
+	BUG_ON(!request_mem_region(per_cpu_int_res.start,
+				   resource_size(&per_cpu_int_res),
+				   node->full_name));
+
+	main_int_base = ioremap(main_int_res.start,
+				resource_size(&main_int_res));
 	BUG_ON(!main_int_base);
+
+	per_cpu_int_base = ioremap(per_cpu_int_res.start,
+				   resource_size(&per_cpu_int_res));
 	BUG_ON(!per_cpu_int_base);
 
 	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
@@ -262,8 +275,7 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 		irq_domain_add_linear(node, (control >> 2) & 0x3ff,
 				&armada_370_xp_mpic_irq_ops, NULL);
 
-	if (!armada_370_xp_mpic_domain)
-		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
+	BUG_ON(!armada_370_xp_mpic_domain);
 
 	irq_set_default_host(armada_370_xp_mpic_domain);
 
-- 
1.8.1.2

