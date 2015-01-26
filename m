Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55491 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbbAZKyv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 05:54:51 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: designware: reject MSI-X irqs
Date: Mon, 26 Jan 2015 11:54:44 +0100
Message-Id: <1422269684-11527-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The DW PCIe MSI hardware does not support MSI-X irqs. Setting those up
failed as a side effect of a bug which was fixed by 91f8ae823f2b
(PCI: designware: Setup and clear exactly one MSI at a time).

Now that this bug is fixed MSI-X irqs need to be rejected explicitly,
otherwise devices trying to use them may end up with incorrectly working
interrupts.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Cc: <stable@vger.kernel.org> # 3.18
---
 drivers/pci/host/pcie-designware.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index df781cdf13c1..17ca98657a28 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -283,6 +283,9 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 	struct msi_msg msg;
 	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
 
+	if (desc->msi_attrib.is_msix)
+		return -EINVAL;
+
 	irq = assign_irq(1, desc, &pos);
 	if (irq < 0)
 		return irq;
-- 
2.1.4

