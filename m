Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
Date: Thu, 9 Aug 2018 20:27:37 +0530
Message-ID: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages
will be forwarded from the secondary interface to the primary interface,
if the SERR# Enable bit in the Bridge Control register is set.
Currently PCI_BRIDGE_CTL_SERR is being enabled only in
ACPI flow.
This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..4fb0d24 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -343,6 +343,20 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return -EIO;
 
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/*
+		 * A Type-1 PCI bridge will not forward ERR_ messages coming
+		 * from an endpoint if SERR# forwarding is not enabled.
+		 */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		if (!(control & PCI_BRIDGE_CTL_SERR)) {
+			control |= PCI_BRIDGE_CTL_SERR;
+			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+		}
+	}
+
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
@@ -352,6 +366,15 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
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
