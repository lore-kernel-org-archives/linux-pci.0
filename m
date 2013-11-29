Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.domeneshop.no ([194.63.252.54]:55401 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab3K2N6I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 08:58:08 -0500
From: =?UTF-8?q?Bj=C3=B8rn=20Erik=20Nilsen?= <ben@datarespons.no>
To: jg1.han@samsung.com
Cc: marex@denx.de, pratyush.anand@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, kishon@ti.com, Mohit.KUMAR@st.com,
	ajay.khandelwal@st.com, tharvey@gateworks.com,
	Eric.Nelson@boundarydevices.com, troy.kisky@boundarydevices.com,
	=?UTF-8?q?Bj=C3=B8rn=20Erik=20Nilsen?= <ben@datarespons.no>
Subject: [PATCH v5 1/2] PCI: designware: Fix crash in dw_msi_teardown_irq
Date: Fri, 29 Nov 2013 14:35:24 +0100
Message-Id: <1385732125-28630-2-git-send-email-ben@datarespons.no>
In-Reply-To: <1385732125-28630-1-git-send-email-ben@datarespons.no>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
 <1385732125-28630-1-git-send-email-ben@datarespons.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

"PCI: designware: Add irq_create_mapping()" resulted
in pre-allocated irq descs. Problem was that in assign_irq()
these descs were explicitly allocated and hence also freed,
resulting in a crash. We also need to clear the entire irq
range in teardown. With this commit the teardown basically
does exactly the opposite of what was done in setup.

Signed-off-by: Bjørn Erik Nilsen <ben@datarespons.no>
---
 drivers/pci/host/pcie-designware.c | 49 ++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index e33b68b..61345a1 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -209,6 +209,25 @@ static int find_valid_pos0(struct pcie_port *pp, int msgvec, int pos, int *pos0)
 	return 0;
 }
 
+static void clear_irq_range(struct pcie_port *pp, unsigned int irq_base,
+                            unsigned int nvec, unsigned int pos)
+{
+	unsigned int i, res, bit, val;
+
+	i = 0;
+	while (i < nvec) {
+		irq_set_msi_desc_off(irq_base, i, NULL);
+		clear_bit(pos + i, pp->msi_irq_in_use);
+		/* Disable corresponding interrupt on MSI interrupt controller */
+		res = ((pos + i) / 32) * 12;
+		bit = (pos + i) % 32;
+		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
+		val &= ~(1 << bit);
+		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+		++i;
+	}
+}
+
 static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 {
 	int res, bit, irq, pos0, pos1, i;
@@ -242,11 +261,20 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 	if (!irq)
 		goto no_valid_irq;
 
+	/*
+	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
+	 * descs so there is no need to allocate descs here. We can therefore
+	 * assume that if irq_find_mapping above returns non-zero, then the
+	 * descs are also successfully allocated.
+	 */
+
 	i = 0;
 	while (i < no_irqs) {
+		if (irq_set_msi_desc_off(irq, i, desc) != 0) {
+			clear_irq_range(pp, irq, i, pos0);
+			goto no_valid_irq;
+		}
 		set_bit(pos0 + i, pp->msi_irq_in_use);
-		irq_alloc_descs((irq + i), (irq + i), 1, 0);
-		irq_set_msi_desc(irq + i, desc);
 		/*Enable corresponding interrupt in MSI interrupt controller */
 		res = ((pos0 + i) / 32) * 12;
 		bit = (pos0 + i) % 32;
@@ -266,7 +294,7 @@ no_valid_irq:
 
 static void clear_irq(unsigned int irq)
 {
-	int res, bit, val, pos;
+	unsigned int pos, nvec;
 	struct irq_desc *desc;
 	struct msi_desc *msi;
 	struct pcie_port *pp;
@@ -281,18 +309,15 @@ static void clear_irq(unsigned int irq)
 		return;
 	}
 
+	/* undo what was done in assign_irq */
 	pos = data->hwirq;
+	nvec = 1 << msi->msi_attrib.multiple;
 
-	irq_free_desc(irq);
-
-	clear_bit(pos, pp->msi_irq_in_use);
+	clear_irq_range(pp, irq, nvec, pos);
 
-	/* Disable corresponding interrupt on MSI interrupt controller */
-	res = (pos / 32) * 12;
-	bit = pos % 32;
-	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
-	val &= ~(1 << bit);
-	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+	/* all irqs cleared; reset attributes */
+	msi->irq = 0;
+	msi->msi_attrib.multiple = 0;
 }
 
 static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
-- 
1.8.4.4

