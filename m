Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53262 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbCIRdP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Mar 2015 13:33:15 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] PCI: designware: implement multiple MSI irq setup
Date: Mon,  9 Mar 2015 18:33:08 +0100
Message-Id: <1425922388-30464-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1425922388-30464-1-git-send-email-l.stach@pengutronix.de>
References: <1425922388-30464-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allows to properly set up multiple MSI irqs per device.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
The ifdef is needed to avoid a compile error on
!CONFIG_PCI_MSI, as msi_list is only part of pci_dev
when the kernel is compiled with MSI support.
---
 drivers/pci/host/pcie-designware.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1f4ea6f2d910..8a15ea2e8eab 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -269,6 +269,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 	}
 
 	*pos = pos0;
+	desc->nvec_used = no_irqs;
+	desc->msi_attrib.multiple = order_base_2(no_irqs);
+
 	return irq;
 
 no_valid_irq:
@@ -305,6 +308,48 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 
 	return 0;
 }
+#ifdef CONFIG_PCI_MSI
+static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
+			     int nvec, int type)
+{
+	int irq, pos;
+	struct msi_desc *desc;
+	struct msi_msg msg;
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
+	if (pp->ops->get_msi_addr)
+		msg.address_lo = pp->ops->get_msi_addr(pp);
+	else
+		msg.address_lo = virt_to_phys((void *)pp->msi_data);
+	msg.address_hi = 0x0;
+
+	if (pp->ops->get_msi_data)
+		msg.data = pp->ops->get_msi_data(pp, pos);
+	else
+		msg.data = pos;
+
+	pci_write_msi_msg(irq, &msg);
+
+	return 0;
+}
+#else
+static int dw_msi_setup_irqs(struct msi_chip *chip, struct pci_dev *pdev,
+			     int nvec, int type)
+{
+	return -ENOSYS;
+}
+#endif
 
 static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
@@ -317,6 +362,7 @@ static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 
 static struct msi_controller dw_pcie_msi_chip = {
 	.setup_irq = dw_msi_setup_irq,
+	.setup_irqs = dw_msi_setup_irqs,
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
-- 
2.1.4

