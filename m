Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33180 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752822AbeC3HPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 03:15:00 -0400
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Keller Jacob E <jacob.e.keller@intel.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V4 5/8] PCI: Print PCI device link status in kernel log
Date: Fri, 30 Mar 2018 10:14:43 +0300
Message-Id: <1522394086-3555-6-git-send-email-talgi@mellanox.com>
In-Reply-To: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
References: <1522394086-3555-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pcie_print_link_status() function for querying and verifying
a PCI device link status. The PCI speed and width are reported
in kernel log. If there's a bandwidth limitation caused by a device
in the PCIe chain, a relevant entry would be added to kernel log.

This provides a unified method for all PCI devices to
report status and issues, instead of each device reporting in a
different way, using different code.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci.c   | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fb79ff6..bd8aa64 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5265,6 +5265,35 @@ int pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 EXPORT_SYMBOL(pcie_bandwidth_capable);
 
 /**
+ * pcie_print_link_status - Reports the PCI device's link speed and width.
+ * @dev: PCI device to query
+ *
+ * This function checks whether the PCI device current speed and width are equal
+ * to the maximum PCI device capabilities.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	enum pcie_link_width width, width_cap;
+	struct pci_dev *limiting_dev = NULL;
+	enum pci_bus_speed speed, speed_cap;
+	int bw, bw_cap;
+
+	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
+	pcie_bandwidth_available(dev, &speed, &width, &bw, &limiting_dev);
+
+	if (bw >= bw_cap)
+		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
+			 bw, PCIE_SPEED2STR(speed), width);
+	else
+		pci_info(dev, "%d Mb/s available bandwidth (capable of %d Mb/s, %s x%d link)\n",
+			 bw, bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
+	if (limiting_dev && strcmp(pci_name(limiting_dev), pci_name(dev)))
+		pci_info(dev, "Bandwidth limited by device at %s\n",
+			 pci_name(limiting_dev));
+}
+EXPORT_SYMBOL(pcie_print_link_status);
+
+/**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
  * @flags: resource type mask to be selected
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 585cea1..1a672c9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1105,6 +1105,7 @@ int pcie_bandwidth_available(struct pci_dev *dev, enum pci_bus_speed *speed,
 int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
 int pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 			   enum pcie_link_width *width);
+void pcie_print_link_status(struct pci_dev *dev);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.8.3.1
