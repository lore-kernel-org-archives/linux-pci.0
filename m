Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:59320 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965520AbeAOPgI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jan 2018 10:36:08 -0500
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V1 2/7] PCI: Add a query function for PCI device's width cap
Date: Mon, 15 Jan 2018 17:35:36 +0200
Message-Id: <1516030541-6626-3-git-send-email-talgi@mellanox.com>
In-Reply-To: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
References: <1516030541-6626-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie_get_width_cap() implements the logic for querying a PCI device's
maximum width capability. Change max_link_width_show() function to
use pcie_get_width_cap().

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci-sysfs.c |  6 +++---
 drivers/pci/pci.c       | 23 +++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 14fce9d..16213d3 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -177,14 +177,14 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u32 linkcap;
+	enum pcie_link_width width;
 	int err;
 
-	err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
+	err = pcie_get_width_cap(pci_dev, &width);
 	if (err)
 		return -EINVAL;
 
-	return sprintf(buf, "%u\n", (linkcap & PCI_EXP_LNKCAP_MLW) >> 4);
+	return sprintf(buf, "%u\n", width);
 }
 static DEVICE_ATTR_RO(max_link_width);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 05fb356..cf0401d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5092,6 +5092,29 @@ int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed)
 EXPORT_SYMBOL(pcie_get_speed_cap);
 
 /**
+ * pcie_get_width_cap - queries for the PCI device's link width capability.
+ * @dev: PCI device to query
+ * @width: storage for link width
+ *
+ * This function queries the PCI device width capability.
+ */
+int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width)
+{
+	u32 lnkcap;
+	int err;
+
+	*width = PCIE_LNK_WIDTH_UNKNOWN;
+
+	err = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (!err && lnkcap)
+		/* Shift start of width mask by 4 to get actual speed cap */
+		*width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+
+	return err;
+}
+EXPORT_SYMBOL(pcie_get_width_cap);
+
+/**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
  * @flags: resource type mask to be selected
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ff9d46..27dc070 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1087,6 +1087,7 @@ static inline int pci_is_managed(struct pci_dev *pdev)
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
 int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed);
+int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.8.3.1
