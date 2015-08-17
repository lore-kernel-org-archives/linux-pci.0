Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37905 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbbHQLGU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 07:06:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH v4 2/5] PCI: designware: factor out MSI msg setup
Date: Mon, 17 Aug 2015 13:06:15 +0200
Message-Id: <1439809578-13654-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1439809578-13654-1-git-send-email-l.stach@pengutronix.de>
References: <1439809578-13654-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Factor out the PCI MSI message setup from the single MSI setup
function. This will be reused by the multivector MSI setup.

No functional change yet.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pcie-designware.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 69486be7181e..0ec435c56a8b 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -293,19 +293,9 @@ no_valid_irq:
 	return -ENOSPC;
 }
 
-static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
-			struct msi_desc *desc)
+static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
 {
-	int irq, pos;
 	struct msi_msg msg;
-	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
-
-	if (desc->msi_attrib.is_msix)
-		return -EINVAL;
-
-	irq = assign_irq(1, desc, &pos);
-	if (irq < 0)
-		return irq;
 
 	if (pp->ops->get_msi_addr)
 		msg.address_lo = pp->ops->get_msi_addr(pp);
@@ -319,6 +309,22 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 		msg.data = pos;
 
 	pci_write_msi_msg(irq, &msg);
+}
+
+static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
+			struct msi_desc *desc)
+{
+	int irq, pos;
+	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
+
+	if (desc->msi_attrib.is_msix)
+		return -EINVAL;
+
+	irq = assign_irq(1, desc, &pos);
+	if (irq < 0)
+		return irq;
+
+	dw_msi_setup_msg(pp, irq, pos);
 
 	return 0;
 }
-- 
2.4.6

