Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752568AbeC3VEv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:04:51 -0400
Subject: [PATCH v5 01/14] PCI: Add pcie_get_speed_cap() to find max
 supported link speed
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Date: Fri, 30 Mar 2018 16:04:48 -0500
Message-ID: <152244388865.135666.13225254795423314446.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tal Gilboa <talgi@mellanox.com>

Add pcie_get_speed_cap() to find the max link speed supported by a device.
Change max_link_speed_show() to use pcie_get_speed_cap().

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
[bhelgaas: return speed directly instead of error and *speed, don't export
outside drivers/pci]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci-sysfs.c |   28 ++--------------------------
 drivers/pci/pci.c       |   44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h       |   10 ++++++++++
 3 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7dc5be545d18..c2ea05fbbf1d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -158,33 +158,9 @@ static DEVICE_ATTR_RO(resource);
 static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u32 linkcap;
-	int err;
-	const char *speed;
-
-	err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
-	if (err)
-		return -EINVAL;
-
-	switch (linkcap & PCI_EXP_LNKCAP_SLS) {
-	case PCI_EXP_LNKCAP_SLS_16_0GB:
-		speed = "16 GT/s";
-		break;
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
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%s\n", speed);
+	return sprintf(buf, "%s\n", PCIE_SPEED2STR(pcie_get_speed_cap(pdev)));
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..b29d3436ee9f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5146,6 +5146,50 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 }
 EXPORT_SYMBOL(pcie_get_minimum_link);
 
+/**
+ * pcie_get_speed_cap - query for the PCI device's link speed capability
+ * @dev: PCI device to query
+ *
+ * Query the PCI device speed capability.  Return the maximum link speed
+ * supported by the device.
+ */
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
+{
+	u32 lnkcap2, lnkcap;
+
+	/*
+	 * PCIe r4.0 sec 7.5.3.18 recommends using the Supported Link
+	 * Speeds Vector in Link Capabilities 2 when supported, falling
+	 * back to Max Link Speed in Link Capabilities otherwise.
+	 */
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2);
+	if (lnkcap2) { /* PCIe r3.0-compliant */
+		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_16_0GB)
+			return PCIE_SPEED_16_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
+			return PCIE_SPEED_8_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
+			return PCIE_SPEED_5_0GT;
+		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
+			return PCIE_SPEED_2_5GT;
+		return PCI_SPEED_UNKNOWN;
+	}
+
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (lnkcap) {
+		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
+			return PCIE_SPEED_16_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
+			return PCIE_SPEED_8_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
+			return PCIE_SPEED_5_0GT;
+		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
+			return PCIE_SPEED_2_5GT;
+	}
+
+	return PCI_SPEED_UNKNOWN;
+}
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd81911b127..1186d8be6055 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -253,6 +253,16 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 
+/* PCIe link information */
+#define PCIE_SPEED2STR(speed) \
+	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
+	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
+	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
+	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
+	 "Unknown speed")
+
+enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
+
 /* Single Root I/O Virtualization */
 struct pci_sriov {
 	int		pos;		/* Capability position */
