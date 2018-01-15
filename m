Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59338 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965524AbeAOPgJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jan 2018 10:36:09 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V1 3/7] PCI: Calculate BW limitation for PCI devices
Date: Mon, 15 Jan 2018 17:35:37 +0200
Message-Id: <1516030541-6626-4-git-send-email-talgi@mellanox.com>
In-Reply-To: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
References: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie_get_link_limits() function, which is based on
pcie_get_minimum_link(), iterates over the PCI chain
and calculates maximum BW in addition to minimum speed and
width. The BW calculation at each level is speed * width, so
even if, for instance, a level has lower width, than the device max
capabilities, it still might not cause a BW limitation if it has a
higher speed. pcie_get_minimum_link() is kept for compatibility.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci.c   | 31 ++++++++++++++++++++++++++++---
 include/linux/pci.h |  8 ++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cf0401d..f0c60dc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5012,16 +5012,37 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
  * @speed: storage for minimum speed
  * @width: storage for minimum width
  *
- * This function will walk up the PCI device chain and determine the minimum
- * link width and speed of the device.
+ * This function use pcie_get_link_limits() for determining the minimum
+ * link width and speed of the device. Legacy code is kept for compatibility.
  */
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width)
 {
+	int bw;
+
+	return pcie_get_link_limits(dev, speed, width, &bw);
+}
+EXPORT_SYMBOL(pcie_get_minimum_link);
+
+/**
+ * pcie_get_link_limits - determine minimum link settings of a PCI
+			  device and its BW limitation
+ * @dev: PCI device to query
+ * @speed: storage for minimum speed
+ * @width: storage for minimum width
+ * @bw: storage for BW limitation
+ *
+ * This function walks up the PCI device chain and determines the link
+ * limitations - minimum width, minimum speed and max possible BW of the device.
+ */
+int pcie_get_link_limits(struct pci_dev *dev, enum pci_bus_speed *speed,
+			 enum pcie_link_width *width, int *bw)
+{
 	int ret;
 
 	*speed = PCI_SPEED_UNKNOWN;
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
+	*bw = 0;
 
 	while (dev) {
 		u16 lnksta;
@@ -5042,12 +5063,16 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 		if (next_width < *width)
 			*width = next_width;
 
+		/* Check if current level in the chain limits the total BW */
+		if (!(*bw) || *bw > (next_width) * PCIE_SPEED2MBS(next_speed))
+			*bw = (next_width) * PCIE_SPEED2MBS(next_speed);
+
 		dev = dev->bus->self;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL(pcie_get_minimum_link);
+EXPORT_SYMBOL(pcie_get_link_limits);
 
 /**
  * pcie_get_speed_cap - queries for the PCI device's link speed capability
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27dc070..88e23eb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -265,6 +265,12 @@ enum pci_bus_speed {
 	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
 	 "Unknown speed")
 
+#define PCIE_SPEED2MBS(speed) \
+	((speed) == PCIE_SPEED_8_0GT ? 8000 : \
+	 (speed) == PCIE_SPEED_5_0GT ? 5000 : \
+	 (speed) == PCIE_SPEED_2_5GT ? 2500 : \
+	 0)
+
 struct pci_cap_saved_data {
 	u16		cap_nr;
 	bool		cap_extended;
@@ -1088,6 +1094,8 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
 int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed);
 int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
+int pcie_get_link_limits(struct pci_dev *dev, enum pci_bus_speed *speed,
+			 enum pcie_link_width *width, int *bw);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.8.3.1
