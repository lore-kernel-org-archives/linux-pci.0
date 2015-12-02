Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59803 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758909AbbLBQuy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Dec 2015 11:50:54 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, izumi.taku@jp.fujitsu.com, jcm@redhat.com,
	helgaas@kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/AER: enable SERR# forwarding for bridges and switches
Date: Wed,  2 Dec 2015 11:49:56 -0500
Message-Id: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A PCIe card behind a switch is unable to report its errors when SERR#
forwarding is not enabled on the PCIe# switch's secondary interface
according to the spec. This patch enables SERR# forwarding when the PCI
header type is bridge.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aer/aerdrv_core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 9803e3d..f248c17 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -37,21 +37,53 @@ module_param(nosourceid, bool, 0);
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
+	u8 header_type;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
 	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
 		return -EIO;
 
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	/* needs to be a bridge/switch */
+	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/*
+		 * A switch will not forward ERR_ messages coming from an
+		 * endpoint if SERR# forwarding is not enabled.
+		 * AER driver is checking the errors at the root only.
+		 */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control |= PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+	}
+
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
+	u8 header_type;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	/* needs to be a bridge/switch */
+	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/* clear serr forwarding */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control &= ~PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+	}
+
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					  PCI_EXP_AER_FLAGS);
 }
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

