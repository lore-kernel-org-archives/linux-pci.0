Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40835 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaI3Qgg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Sep 2014 12:36:36 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: designware: remove bogus multiple MSI setup
Date: Tue, 30 Sep 2014 18:36:26 +0200
Message-Id: <1412094987-1894-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
References: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
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
 drivers/pci/host/pcie-designware.c | 47 ++++++--------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 34e736601259..339296cbc823 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -313,54 +313,17 @@ no_valid_irq:
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
 	if (pp->ops->get_msi_addr)
 		msg.address_lo = pp->ops->get_msi_addr(pp);
 	else
@@ -379,7 +342,11 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 
 static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
 {
-	clear_irq(irq);
+	struct irq_data *data = irq_get_irq_data(irq);
+	struct msi_desc *msi = irq_data_get_msi(data);
+	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
+
+	clear_irq_range(pp, irq, 1, data->hwirq);
 }
 
 static struct msi_chip dw_pcie_msi_chip = {
-- 
2.1.0

