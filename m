Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40837 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbaI3Qgg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Sep 2014 12:36:36 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: designware: remove open-coded bitmap operations
Date: Tue, 30 Sep 2014 18:36:27 +0200
Message-Id: <1412094987-1894-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
References: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace them by using the standard kernel bitmap ops.
No functional change, but makes the code a lot cleaner.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pcie-designware.c | 51 ++++++--------------------------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 339296cbc823..dfed00aa3ac0 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -196,30 +196,6 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
 }
 
-static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
-{
-	int flag = 1;
-
-	do {
-		pos = find_next_zero_bit(pp->msi_irq_in_use,
-				MAX_MSI_IRQS, pos);
-		/*if you have reached to the end then get out from here.*/
-		if (pos == MAX_MSI_IRQS)
-			return -ENOSPC;
-		/*
-		 * Check if this position is at correct offset.nvec is always a
-		 * power of two. pos0 must be nvec bit aligned.
-		 */
-		if (pos % msgvec)
-			pos += msgvec - (pos % msgvec);
-		else
-			flag = 0;
-	} while (flag);
-
-	*pos0 = pos;
-	return 0;
-}
-
 static void dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 {
 	unsigned int res, bit, val;
@@ -238,13 +214,14 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 
 	for (i = 0; i < nvec; i++) {
 		irq_set_msi_desc_off(irq_base, i, NULL);
-		clear_bit(pos + i, pp->msi_irq_in_use);
 		/* Disable corresponding interrupt on MSI controller */
 		if (pp->ops->msi_clear_irq)
 			pp->ops->msi_clear_irq(pp, pos + i);
 		else
 			dw_pcie_msi_clear_irq(pp, pos + i);
 	}
+
+	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
 }
 
 static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
@@ -260,26 +237,13 @@ static void dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
-	int irq, pos0, pos1, i;
+	int irq, pos0, i;
 	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
 
-	pos0 = find_first_zero_bit(pp->msi_irq_in_use,
-			MAX_MSI_IRQS);
-	if (pos0 % no_irqs) {
-		if (find_valid_pos0(pp, no_irqs, pos0, &pos0))
-			goto no_valid_irq;
-	}
-	if (no_irqs > 1) {
-		pos1 = find_next_bit(pp->msi_irq_in_use,
-				MAX_MSI_IRQS, pos0);
-		/* there must be nvec number of consecutive free bits */
-		while ((pos1 - pos0) < no_irqs) {
-			if (find_valid_pos0(pp, no_irqs, pos1, &pos0))
-				goto no_valid_irq;
-			pos1 = find_next_bit(pp->msi_irq_in_use,
-					MAX_MSI_IRQS, pos0);
-		}
-	}
+	pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
+				       order_base_2(no_irqs));
+	if (pos0 < 0)
+		goto no_valid_irq;
 
 	irq = irq_find_mapping(pp->irq_domain, pos0);
 	if (!irq)
@@ -297,7 +261,6 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 			clear_irq_range(pp, irq, i, pos0);
 			goto no_valid_irq;
 		}
-		set_bit(pos0 + i, pp->msi_irq_in_use);
 		/*Enable corresponding interrupt in MSI interrupt controller */
 		if (pp->ops->msi_set_irq)
 			pp->ops->msi_set_irq(pp, pos0 + i);
-- 
2.1.0

