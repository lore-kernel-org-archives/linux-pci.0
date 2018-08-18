Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbeHTCck (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Aug 2018 22:32:40 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if hotplug is enabled
Date: Fri, 17 Aug 2018 23:51:10 -0700
Message-Id: <20180818065126.77912-2-okaya@kernel.org>
In-Reply-To: <20180818065126.77912-1-okaya@kernel.org>
References: <20180818065126.77912-1-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe Spec 3.0. 7.10.2. Uncorrectable Error Status Register (Offset 04h)
defines link down errors as an AER error as bit 5 Surprise Down Error
Status.

If hotplug is supported by a particular port, we want hotplug driver
to handle the link down/up conditions via Data Link Layer Active
interrupt rather than the AER error interrupt. Mask the Surprise Down
Error during hotplug driver and re-enable it during remove.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/hotplug/pciehp_core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ec48c9433ae5..8322db8f369a 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -229,6 +229,29 @@ static void pciehp_check_presence(struct controller *ctrl)
 	up_read(&ctrl->reset_lock);
 }
 
+static int pciehp_control_surprise_error(struct controller *ctrl, bool enable)
+{
+	struct pci_dev *pdev = ctrl->pcie->port;
+	u32 reg32;
+	int pos;
+
+	if (!pci_is_pcie(pdev))
+		return -ENODEV;
+
+	pos = pdev->aer_cap;
+	if (!pos)
+		return -ENODEV;
+
+	pci_read_config_dword(pdev, pos + PCI_ERR_UNCOR_MASK, &reg32);
+	if (enable)
+		reg32 &= ~PCI_ERR_UNC_SURPDN;
+	else
+		reg32 |= PCI_ERR_UNC_SURPDN;
+	pci_write_config_dword(pdev, pos + PCI_ERR_UNCOR_MASK, reg32);
+
+	return 0;
+}
+
 static int pciehp_probe(struct pcie_device *dev)
 {
 	int rc;
@@ -280,6 +303,9 @@ static int pciehp_probe(struct pcie_device *dev)
 
 	pciehp_check_presence(ctrl);
 
+	/* We want exclusive control of link down events in hotplug driver */
+	pciehp_control_surprise_error(ctrl, false);
+
 	return 0;
 
 err_out_shutdown_notification:
@@ -298,6 +324,7 @@ static void pciehp_remove(struct pcie_device *dev)
 	pci_hp_del(ctrl->slot->hotplug_slot);
 	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
+	pciehp_control_surprise_error(ctrl, true);
 	pciehp_release_ctrl(ctrl);
 }
 
-- 
2.17.1
