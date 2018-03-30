Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33171 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752714AbeC3HPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 03:15:00 -0400
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Keller Jacob E <jacob.e.keller@intel.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V4 4/8] PCI: Calculate available bandwidth for PCI devices
Date: Fri, 30 Mar 2018 10:14:42 +0300
Message-Id: <1522394086-3555-5-git-send-email-talgi@mellanox.com>
In-Reply-To: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
References: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie_bandwidth_available() function, which is based on
pcie_get_minimum_link(), iterates over the PCI chain and calculates
available bandwidth in addition to minimum speed and width. The
bandwidth calculation at each level is encoding * speed * width, so
even if, for instance, a level has lower width than the device max
capabilities, it still might not cause a bandwidth limitation if it
has a higher speed.
The function also returns the device causing the limitation.
pcie_get_minimum_link() is kept for compatibility.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci.c   | 45 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/pci.h |  3 +++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 553d8f3..fb79ff6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5109,25 +5109,48 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
  * @speed: storage for minimum speed
  * @width: storage for minimum width
  *
- * This function will walk up the PCI device chain and determine the minimum
- * link width and speed of the device.
+ * This function use pcie_bandwidth_available() for determining the minimum
+ * link width and speed of the device. Legacy code is kept for compatibility.
  */
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width)
 {
-	int ret;
+	int bw;
+
+	return pcie_bandwidth_available(dev, speed, width, &bw, NULL);
+}
+EXPORT_SYMBOL(pcie_get_minimum_link);
+
+/**
+ * pcie_bandwidth_available - determine minimum link settings of a PCIe
+			      device and its bandwidth limitation
+ * @dev: PCI device to query
+ * @speed: storage for minimum speed
+ * @width: storage for minimum width
+ * @bw: storage for link bandwidth
+ * @limiting_dev: storage for device causing the bandwidth limitation
+ *
+ * This function walks up the PCI device chain and determines the minimum width,
+ * minimum speed and available bandwidth of the device.
+ */
+int pcie_bandwidth_available(struct pci_dev *dev, enum pci_bus_speed *speed,
+			     enum pcie_link_width *width, int *bw,
+			     struct pci_dev **limiting_dev)
+{
+	int err;
 
 	*speed = PCI_SPEED_UNKNOWN;
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
+	*bw = 0;
 
 	while (dev) {
 		u16 lnksta;
 		enum pci_bus_speed next_speed;
 		enum pcie_link_width next_width;
 
-		ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
-		if (ret)
-			return ret;
+		err = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (err)
+			return err;
 
 		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
 		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
@@ -5139,12 +5162,20 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 		if (next_width < *width)
 			*width = next_width;
 
+		/* Check if current device limits the total bandwidth */
+		if (!(*bw) ||
+		    (*bw > next_width * PCIE_SPEED2MBS_ENC(next_speed))) {
+			if (limiting_dev)
+				*limiting_dev = dev;
+			*bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
+		}
+
 		dev = dev->bus->self;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL(pcie_get_minimum_link);
+EXPORT_SYMBOL(pcie_bandwidth_available);
 
 /**
  * pcie_get_speed_cap - queries for the PCI device's link speed capability
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9f57c45..585cea1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1098,6 +1098,9 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
+int pcie_bandwidth_available(struct pci_dev *dev, enum pci_bus_speed *speed,
+			     enum pcie_link_width *width, int *bw,
+			     struct pci_dev **limiting_dev);
 int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed);
 int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
 int pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
-- 
1.8.3.1
