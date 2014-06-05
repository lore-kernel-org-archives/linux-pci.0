Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44065 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbaFEOqU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 10:46:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de
Subject: [PATCH 3/4] PCI: designware: remove open-coded bitmap operations
Date: Thu,  5 Jun 2014 16:46:11 +0200
Message-Id: <1401979572-32101-4-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace them by using the standard kernel bitmap ops.
No functional change, but makes the code a lot cleaner.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pcie-designware.c | 51 ++++++--------------------------------
 1 file changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1f04e978f877..ed54b24e264d 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -193,30 +193,6 @@ void dw_pcie_msi_init(struct pcie_port *pp)
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
 static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 			    unsigned int nvec, unsigned int pos)
 {
@@ -224,7 +200,6 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 
 	for (i = 0; i < nvec; i++) {
 		irq_set_msi_desc_off(irq_base, i, NULL);
-		clear_bit(pos + i, pp->msi_irq_in_use);
 		/* Disable corresponding interrupt on MSI controller */
 		res = ((pos + i) / 32) * 12;
 		bit = (pos + i) % 32;
@@ -232,11 +207,13 @@ static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
 		val &= ~(1 << bit);
 		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
 	}
+
+	bitmap_release_region(pp->msi_irq_in_use, pos, order_base_2(nvec));
 }
 
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
-	int res, bit, irq, pos0, pos1, i;
+	int res, bit, irq, pos0, i;
 	u32 val;
 	struct pcie_port *pp = sys_to_pcie(desc->dev->bus->sysdata);
 
@@ -245,23 +222,10 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 		return -EINVAL;
 	}
 
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
@@ -279,7 +243,6 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 			clear_irq_range(pp, irq, i, pos0);
 			goto no_valid_irq;
 		}
-		set_bit(pos0 + i, pp->msi_irq_in_use);
 		/*Enable corresponding interrupt in MSI interrupt controller */
 		res = ((pos0 + i) / 32) * 12;
 		bit = (pos0 + i) % 32;
-- 
2.0.0.rc2

