Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59350 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965476AbeAOPgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jan 2018 10:36:10 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V1 4/7] PCI: Print PCI device link status in kernel log
Date: Mon, 15 Jan 2018 17:35:38 +0200
Message-Id: <1516030541-6626-5-git-send-email-talgi@mellanox.com>
In-Reply-To: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
References: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pcie_print_link_status() function for querying and verifying
a PCI device link status. The PCI speed and width are reported
in kernel log. In case the PCI device BW is limited somewhere in
the PCI chain a warning would be reported in kernel log.

This provides a unified method for all PCI devices to
report status and issues, instead of each device reporting in a
different way, using different code.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci.c   | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 68 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f0c60dc..35873cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5140,6 +5140,73 @@ int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width)
 EXPORT_SYMBOL(pcie_get_width_cap);
 
 /**
+ * pcie_print_link_status - Reports the PCI device's link speed and width.
+ * @dev: PCI device to query
+ *
+ * This function checks whether the PCI device current speed and width are equal
+ * to the maximum PCI device capabilities and that available BW equals to BW capability.
+ * It issues a warning in cases there's a BW limitation in the PCI chain.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	enum pcie_link_width width, width_cap;
+	enum pci_bus_speed speed, speed_cap;
+	int bw, bw_cap;
+	int err;
+
+	err = pcie_get_speed_cap(dev, &speed_cap);
+	if (err) {
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device speed capability (err = %d)\n",
+			 err);
+		return;
+	}
+
+	err = pcie_get_width_cap(dev, &width_cap);
+	if (err) {
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device width capability (err = %d)\n",
+			 err);
+		return;
+	}
+
+	err = pcie_get_link_limits(dev, &speed, &width, &bw);
+	if (err) {
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device chain minimum BW (err = %d)\n",
+			 err);
+		return;
+	}
+
+	if (speed == PCI_SPEED_UNKNOWN)
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device chain minimum speed\n");
+
+	if (width == PCIE_LNK_WIDTH_UNKNOWN)
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine PCIe device chain minimum width\n");
+
+	bw_cap = width_cap * PCIE_SPEED2MBS(speed_cap);
+	if (!bw_cap)
+		dev_warn(&dev->dev,
+			 "Warning: unable to determine max PCIe chain BW\n");
+
+	if (bw_cap && bw < bw_cap) {
+		dev_warn(&dev->dev,
+			 "Warning: PCIe BW (%dGb/s) is lower than device's capability (%dGb/s)\n",
+			 bw / 1000, bw_cap / 1000);
+		dev_info(&dev->dev,
+			 "If device status is at max capabilities, might be due to a narrow part down the chain\n");
+	}
+
+	dev_info(&dev->dev, "PCIe link speed is %s, device supports %s\n",
+		 PCIE_SPEED2STR(speed), PCIE_SPEED2STR(speed_cap));
+	dev_info(&dev->dev, "PCIe link width is x%d, device supports x%d\n",
+		 width, width_cap);
+}
+EXPORT_SYMBOL(pcie_print_link_status);
+
+/**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
  * @flags: resource type mask to be selected
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 88e23eb..321cf22 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1096,6 +1096,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
 int pcie_get_link_limits(struct pci_dev *dev, enum pci_bus_speed *speed,
 			 enum pcie_link_width *width, int *bw);
+void pcie_print_link_status(struct pci_dev *dev);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.8.3.1
