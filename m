Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58472 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbbJZVZo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2015 17:25:44 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, jcm@redhat.com
Cc: Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER: enable SERR# forwarding and role-based error reporting
Date: Mon, 26 Oct 2015 17:25:02 -0400
Message-Id: <1445894704-28277-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A PCIe card behind a PCIe switch is unable to report its errors
when SERR# forwarding is not enabled on the PCIe switch's
secondary interface. This is required by the PCIe  spec. This patch
enables SERR# forwarding and also cleans out compatibility
mode so that AER reporting is enabled.

Tested with PEX8749-CA RDK.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aer/aerdrv_core.c | 56 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 9803e3d..acd22d7 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -37,21 +37,75 @@ module_param(nosourceid, bool, 0);
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
+	u8 header_type;
+	int pos;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
 		return -EIO;
 
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	/* needs to be a bridge/switch */
+	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
+		u32 status;
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
+
+		/*
+		 * Need to inform hardware that we support
+		 * Role-Based Error Reporting.
+		 */
+		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &status);
+		status &= ~PCI_ERR_COR_ADV_NFAT;
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, status);
+	}
+
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
+	int pos;
+	u8 header_type;
+
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return -EIO;
+
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
+
+	/* needs to be a bridge/switch */
+	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
+		u32 status;
+		u16 control;
+
+		/* clear serr forwarding */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control &= ~PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+
+		/* set compatibility mode */
+		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &status);
+		status |= PCI_ERR_COR_ADV_NFAT;
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, status);
+	}
+
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					  PCI_EXP_AER_FLAGS);
 }
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

