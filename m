Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33160 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752536AbeC3HPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 03:15:00 -0400
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Keller Jacob E <jacob.e.keller@intel.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V4 1/8] PCI: Add a query function for PCI device's speed cap
Date: Fri, 30 Mar 2018 10:14:39 +0300
Message-Id: <1522394086-3555-2-git-send-email-talgi@mellanox.com>
In-Reply-To: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
References: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie_get_speed_cap() implements the logic for querying a PCI device's
maximum speed capability. Change max_link_speed_show() function to
use pcie_get_speed_cap().

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci-sysfs.c | 22 +++++-----------------
 drivers/pci/pci.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  7 +++++++
 3 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index eb6bee8..69624d3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -159,29 +159,17 @@ static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u32 linkcap;
+	enum pci_bus_speed speed;
+	const char *speed_str;
 	int err;
-	const char *speed;
 
-	err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
+	err = pcie_get_speed_cap(pci_dev, &speed);
 	if (err)
 		return -EINVAL;
 
-	switch (linkcap & PCI_EXP_LNKCAP_SLS) {
-	case PCI_EXP_LNKCAP_SLS_8_0GB:
-		speed = "8 GT/s";
-		break;
-	case PCI_EXP_LNKCAP_SLS_5_0GB:
-		speed = "5 GT/s";
-		break;
-	case PCI_EXP_LNKCAP_SLS_2_5GB:
-		speed = "2.5 GT/s";
-		break;
-	default:
-		speed = "Unknown speed";
-	}
+	speed_str = PCIE_SPEED2STR(speed);
 
-	return sprintf(buf, "%s\n", speed);
+	return sprintf(buf, "%s\n", speed_str);
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd1..6fbf170 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5147,6 +5147,48 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 EXPORT_SYMBOL(pcie_get_minimum_link);
 
 /**
+ * pcie_get_speed_cap - queries for the PCI device's link speed capability
+ * @dev: PCI device to query
+ * @speed: storage for link speed
+ *
+ * This function queries the PCI device speed capability.
+ */
+int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed)
+{
+	u32 lnkcap;
+	int err1, err2;
+
+	*speed = PCI_SPEED_UNKNOWN;
+
+	err1 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
+					  &lnkcap);
+	if (!err1 && lnkcap) {
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
+			*speed = PCIE_SPEED_8_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
+			*speed = PCIE_SPEED_5_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
+			*speed = PCIE_SPEED_2_5GT;
+		return 0;
+	}
+
+	err2 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2,
+					  &lnkcap);
+	if (!err2 && lnkcap) { /* PCIe r3.0-compliant */
+		if (lnkcap & PCI_EXP_LNKCAP2_SLS_8_0GB)
+			*speed = PCIE_SPEED_8_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP2_SLS_5_0GB)
+			*speed = PCIE_SPEED_5_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP2_SLS_2_5GB)
+			*speed = PCIE_SPEED_2_5GT;
+		return 0;
+	}
+
+	return err1 ? err1 : err2;
+}
+EXPORT_SYMBOL(pcie_get_speed_cap);
+
+/**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
  * @flags: resource type mask to be selected
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1be..fcc6eb3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -259,6 +259,12 @@ enum pci_bus_speed {
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
+#define PCIE_SPEED2STR(speed) \
+	((speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
+	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
+	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
+	 "Unknown speed")
+
 struct pci_cap_saved_data {
 	u16		cap_nr;
 	bool		cap_extended;
@@ -1082,6 +1088,7 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
+int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.8.3.1
