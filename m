Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:51362
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732310AbeGLPAL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jul 2018 11:00:11 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
Date: Thu, 12 Jul 2018 20:15:19 +0530
Message-ID: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently PCI_BRIDGE_CTL_SERR is being enabled only in
ACPI flow.
This bit is required for forwarding errors reported
by EP devices to upstream device.
This patch enables SERR# for Type-1 PCI device.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..943e084 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return -EIO;
 
+	if (!IS_ENABLED(CONFIG_ACPI) &&
+	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/*
+		 * A Type-1 PCI bridge will not forward ERR_ messages coming
+		 * from an endpoint if SERR# forwarding is not enabled.
+		 */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control |= PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+	}
+
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
@@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
+	if (!IS_ENABLED(CONFIG_ACPI) &&
+	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/* Clear SERR Forwarding */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control &= ~PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+	}
+
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					  PCI_EXP_AER_FLAGS);
 }
-- 
1.7.1
