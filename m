Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57170 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbbHQLGU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2015 07:06:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH v4 3/5] PCI: designware: implement multivector MSI irq setup
Date: Mon, 17 Aug 2015 13:06:16 +0200
Message-Id: <1439809578-13654-4-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1439809578-13654-1-git-send-email-l.stach@pengutronix.de>
References: <1439809578-13654-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allows to set up and use multiple MSI irqs per device.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
v3: use new MSI msg setup function.
---
 drivers/pci/host/pcie-designware.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 0ec435c56a8b..74034395cf2a 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -286,6 +286,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 	}
 
 	*pos = pos0;
+	desc->nvec_used = no_irqs;
+	desc->msi_attrib.multiple = order_base_2(no_irqs);
+
 	return irq;
 
 no_valid_irq:
@@ -329,6 +332,33 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 	return 0;
 }
 
+static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
+			     int nvec, int type)
+{
+#ifdef CONFIG_PCI_MSI
+	int irq, pos;
+	struct msi_desc *desc;
+	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
+
+	/* MSI-X interrupts are not supported */
+	if (type == PCI_CAP_ID_MSIX)
+		return -EINVAL;
+
+	WARN_ON(!list_is_singular(&pdev->msi_list));
+	desc = list_entry(pdev->msi_list.next, struct msi_desc, list);
+
+	irq = assign_irq(nvec, desc, &pos);
+	if (irq < 0)
+		return irq;
+
+	dw_msi_setup_msg(pp, irq, pos);
+
+	return 0;
+#else
+	return -ENOSYS;
+#endif
+}
+
 static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
@@ -340,6 +370,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 
 static struct msi_controller dw_pcie_msi_chip = {
 	.setup_irq = dw_msi_setup_irq,
+	.setup_irqs = dw_msi_setup_irqs,
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
-- 
2.4.6

