Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44067 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaFEOqU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 10:46:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de
Subject: [PATCH 4/4] PCI: designware: implement multiple MSI irq setup
Date: Thu,  5 Jun 2014 16:46:12 +0200
Message-Id: <1401979572-32101-5-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allows to properly set up multiple MSI irqs per
device.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
The ifdef is needed to avoid a compile error on
!CONFIG_PCI_MSI, as msi_list is only part of pci_dev
when the kernel is compiled with MSI support.
---
 drivers/pci/host/pcie-designware.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index ed54b24e264d..985eb89fae94 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -252,6 +252,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
 	}
 
 	*pos = pos0;
+	desc->nvec_used = no_irqs;
+	desc->msi_attrib.multiple = order_base_2(no_irqs);
+
 	return irq;
 
 no_valid_irq:
@@ -282,6 +285,43 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 
 	return 0;
 }
+#ifdef CONFIG_PCI_MSI
+static int dw_msi_setup_irqs(struct msi_chip *chip, struct pci_dev *pdev,
+			     int nvec, int type)
+{
+	int irq, pos;
+	struct msi_desc *desc;
+	struct msi_msg msg;
+	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
+
+	if (!pp)
+		return -EINVAL;
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
+	msg.address_lo = virt_to_phys((void *)pp->msi_data);
+	msg.address_hi = 0x0;
+	msg.data = pos;
+	write_msi_msg(irq, &msg);
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
 
 static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
 {
@@ -302,6 +342,7 @@ static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
 
 static struct msi_chip dw_pcie_msi_chip = {
 	.setup_irq = dw_msi_setup_irq,
+	.setup_irqs = dw_msi_setup_irqs,
 	.teardown_irq = dw_msi_teardown_irq,
 };
 
-- 
2.0.0.rc2

