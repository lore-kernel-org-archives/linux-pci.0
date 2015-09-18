Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59926 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbbIRPMm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2015 11:12:42 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: [PATCH v5 3/5] PCI: designware: Implement multivector MSI IRQ setup
Date: Fri, 18 Sep 2015 17:12:37 +0200
Message-Id: <1442589159-28201-4-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
References: <1442589159-28201-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement multivector MSI IRQ setup.  This allows to set up and use multiple
MSI IRQs per device.

[bhelgaas: changelog, use -EINVAL instead of -ENOSYS]
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
---
 drivers/pci/host/pcie-designware.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 7a168ea25e2f..3a2b8bce27a6 100644
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
+	WARN_ON(!list_is_singular(&pdev->dev.msi_list));
+	desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
+
+	irq = assign_irq(nvec, desc, &pos);
+	if (irq < 0)
+		return irq;
+
+	dw_msi_setup_msg(pp, irq, pos);
+
+	return 0;
+#else
+	return -EINVAL;
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
2.5.1

