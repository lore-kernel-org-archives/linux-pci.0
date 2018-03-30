Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752869AbeC3VE6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:04:58 -0400
Subject: [PATCH v5 02/14] PCI: Add pcie_get_width_cap() to find max
 supported link width
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
Date: Fri, 30 Mar 2018 16:04:56 -0500
Message-ID: <152244389596.135666.10041465699313744043.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tal Gilboa <talgi@mellanox.com>

Add pcie_get_width_cap() to find the max link width supported by a device.
Change max_link_width_show() to use pcie_get_width_cap().

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
[bhelgaas: return width directly instead of error and *width, don't export
outside drivers/pci]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci-sysfs.c |   10 ++--------
 drivers/pci/pci.c       |   18 ++++++++++++++++++
 drivers/pci/pci.h       |    1 +
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index c2ea05fbbf1d..63d0952684fb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -167,15 +167,9 @@ static DEVICE_ATTR_RO(max_link_speed);
 static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u32 linkcap;
-	int err;
-
-	err = pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &linkcap);
-	if (err)
-		return -EINVAL;
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return sprintf(buf, "%u\n", (linkcap & PCI_EXP_LNKCAP_MLW) >> 4);
+	return sprintf(buf, "%u\n", pcie_get_width_cap(pdev));
 }
 static DEVICE_ATTR_RO(max_link_width);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b29d3436ee9f..43075be79388 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5190,6 +5190,24 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 	return PCI_SPEED_UNKNOWN;
 }
 
+/**
+ * pcie_get_width_cap - query for the PCI device's link width capability
+ * @dev: PCI device to query
+ *
+ * Query the PCI device width capability.  Return the maximum link width
+ * supported by the device.
+ */
+enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
+{
+	u32 lnkcap;
+
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (lnkcap)
+		return (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
+
+	return PCIE_LNK_WIDTH_UNKNOWN;
+}
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1186d8be6055..66738f1050c0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -262,6 +262,7 @@ void pci_disable_bridge_window(struct pci_dev *dev);
 	 "Unknown speed")
 
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
+enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
 
 /* Single Root I/O Virtualization */
 struct pci_sriov {
