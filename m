Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44086 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbaFEOq1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 10:46:27 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de
Subject: [PATCH 2/4] PCI: designware: remove bogus multiple MSI setup
Date: Thu,  5 Jun 2014 16:46:10 +0200
Message-Id: <1401979572-32101-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The setup_irq function is supposed to set up exactly one MSI
irq. Multiple IRQ setup is handled differently, to respect
the choices made by the upper layers.

Also only clear one MSI irq at a time, the PCI core will
call into this function multiple times if it has to tear
down more than one MSI irq.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pcie-designware.c | 59 ++++++++++----------------------------
 1 file changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1eaf4df3618a..1f04e978f877 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -296,37 +296,10 @@ no_valid_irq:
 	return -ENOSPC;
 }
 
-static void clear_irq(unsigned int irq)
-{
-	unsigned int pos, nvec;
-	struct msi_desc *msi;
-	struct pcie_port *pp;
-	struct irq_data *data = irq_get_irq_data(irq);
-
-	/* get the port structure */
-	msi = irq_data_get_msi(data);
-	pp = sys_to_pcie(msi->dev->bus->sysdata);
-	if (!pp) {
-		BUG();
-		return;
-	}
-
-	/* undo what was done in assign_irq */
-	pos = data->hwirq;
-	nvec = 1 << msi->msi_attrib.multiple;
-
-	clear_irq_range(pp, irq, nvec, pos);
-
-	/* all irqs cleared; reset attributes */
-	msi->irq = 0;
-	msi->msi_attrib.multiple = 0;
-}
-
 static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 			struct msi_desc *desc)
 {
-	int irq, pos, msgvec;
-	u16 msg_ctr;
+	int irq, pos;
 	struct msi_msg msg;
 	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
 
@@ -335,24 +308,10 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 		return -EINVAL;
 	}
 
-	pci_read_config_word(pdev, desc->msi_attrib.pos+PCI_MSI_FLAGS,
-				&msg_ctr);
-	msgvec = (msg_ctr&PCI_MSI_FLAGS_QSIZE) >> 4;
-	if (msgvec == 0)
-		msgvec = (msg_ctr & PCI_MSI_FLAGS_QMASK) >> 1;
-	if (msgvec > 5)
-		msgvec = 0;
-
-	irq = assign_irq((1 << msgvec), desc, &pos);
+	irq = assign_irq(1, desc, &pos);
 	if (irq < 0)
 		return irq;
 
-	/*
-	 * write_msi_msg() will update PCI_MSI_FLAGS so there is
-	 * no need to explicitly call pci_write_config_word().
-	 */
-	desc->msi_attrib.multiple = msgvec;
-
 	msg.address_lo = virt_to_phys((void *)pp->msi_data);
 	msg.address_hi = 0x0;
 	msg.data = pos;
@@ -363,7 +322,19 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 
 static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
 {
-	clear_irq(irq);
+	struct msi_desc *msi;
+	struct pcie_port *pp;
+	struct irq_data *data = irq_get_irq_data(irq);
+
+	/* get the port structure */
+	msi = irq_data_get_msi(data);
+	pp = sys_to_pcie(msi->dev->bus->sysdata);
+	if (!pp) {
+		BUG();
+		return;
+	}
+
+	clear_irq_range(pp, irq, 1, data->hwirq);
 }
 
 static struct msi_chip dw_pcie_msi_chip = {
-- 
2.0.0.rc2

