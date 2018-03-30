Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33169 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752712AbeC3HPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 03:15:00 -0400
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Keller Jacob E <jacob.e.keller@intel.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V4 3/8] PCI: Add device link bandwidth capabilities calculation
Date: Fri, 30 Mar 2018 10:14:41 +0300
Message-Id: <1522394086-3555-4-git-send-email-talgi@mellanox.com>
In-Reply-To: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
References: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Added a function for calculating a PCI device's total link bandwidth
capabilities. This function queries for the device link speed and
width, multiplies them and applies encoding overhead for the different
PCIe generations.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci.c   | 22 ++++++++++++++++++++++
 include/linux/pci.h | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 90a6cf2..553d8f3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5212,6 +5212,28 @@ int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width)
 EXPORT_SYMBOL(pcie_get_width_cap);
 
 /**
+ * pcie_bandwidth_capable - Calculates a PCI device's link bandwidth capability
+ * @dev: PCI device
+ * @speed: storage for link speed
+ * @width: storage for link width
+ *
+ * This function caculates a PCI device's link bandwidth by querying for its
+ * link speed and width, multiplying them, and applying encoding overhead.
+ */
+int pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
+			   enum pcie_link_width *width)
+{
+	pcie_get_speed_cap(dev, speed);
+	pcie_get_width_cap(dev, width);
+
+	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
+		return 0;
+
+	return (*width) * PCIE_SPEED2MBS_ENC(*speed);
+}
+EXPORT_SYMBOL(pcie_bandwidth_capable);
+
+/**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
  * @flags: resource type mask to be selected
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1e3d05f..9f57c45 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -265,6 +265,16 @@ enum pci_bus_speed {
 	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
 	 "Unknown speed")
 
+/**
+ * PCIe speed to Mb/s with encoding overhead:
+ * 20% for gen2, ~1.5% for gen3
+ */
+#define PCIE_SPEED2MBS_ENC(speed) \
+	((speed) == PCIE_SPEED_8_0GT ? 7877 : \
+	 (speed) == PCIE_SPEED_5_0GT ? 4000 : \
+	 (speed) == PCIE_SPEED_2_5GT ? 2000 : \
+	 0)
+
 struct pci_cap_saved_data {
 	u16		cap_nr;
 	bool		cap_extended;
@@ -1090,6 +1100,8 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
 int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed);
 int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
+int pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
+			   enum pcie_link_width *width);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.8.3.1
