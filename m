Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54203 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3CZQwe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:52:34 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFCv1 04/11] irqchip: armada-370-xp: slightly cleanup irq controller driver
Date: Tue, 26 Mar 2013 17:52:19 +0100
Message-Id: <1364316746-8702-5-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In preparation for the introduction of MSI support in the IRQ
controller driver, we clarify the implementation of IPI using
additional defines for the manipulation of doorbells. Just like IPIs
are implemented using doorbells, MSIs will also use doorbells, so it
makes sense to do this preparatory cleanup first.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 1115bf8..ad1e642 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -48,7 +48,9 @@
 
 #define ARMADA_370_XP_TIMER0_PER_CPU_IRQ	(5)
 
-#define ACTIVE_DOORBELLS			(8)
+#define IPI_DOORBELL_START                      (0)
+#define IPI_DOORBELL_END                        (8)
+#define IPI_DOORBELL_MASK                       0xFF
 
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
@@ -192,7 +194,7 @@ void armada_xp_mpic_smp_cpu_init(void)
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
 	/* Enable first 8 IPIs */
-	writel((1 << ACTIVE_DOORBELLS) - 1, per_cpu_int_base +
+	writel(IPI_DOORBELL_MASK, per_cpu_int_base +
 		ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
 
 	/* Unmask IPI interrupt */
@@ -231,13 +233,14 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 
 			ipimask = readl_relaxed(per_cpu_int_base +
 						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
-				& 0xFF;
+				& IPI_DOORBELL_MASK;
 
-			writel(0x0, per_cpu_int_base +
+			writel(~IPI_DOORBELL_MASK, per_cpu_int_base +
 				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
 
 			/* Handle all pending doorbells */
-			for (ipinr = 0; ipinr < ACTIVE_DOORBELLS; ipinr++) {
+			for (ipinr = IPI_DOORBELL_START;
+			     ipinr < IPI_DOORBELL_END; ipinr++) {
 				if (ipimask & (0x1 << ipinr))
 					handle_IPI(ipinr, regs);
 			}
-- 
1.7.9.5

