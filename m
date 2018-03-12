Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:58208 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750988AbeCLMG1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Mar 2018 08:06:27 -0400
From: Tal Gilboa <talgi@mellanox.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>
Subject: [PATCH next V3 3/5] PCI: Print PCI device link status in kernel log
Date: Mon, 12 Mar 2018 14:06:08 +0200
Message-Id: <1520856370-15404-4-git-send-email-talgi@mellanox.com>
In-Reply-To: <1520856370-15404-1-git-send-email-talgi@mellanox.com>
References: <1520856370-15404-1-git-send-email-talgi@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pcie_print_link_status() function for querying and verifying
a PCI device link status. The PCI speed and width are reported
in kernel log.
This provides a unified method for all PCI devices to
report status and issues, instead of each device reporting in a
different way, using different code.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
---
 drivers/pci/pci.c   | 25 +++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 48b9fd6..ac876c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5229,6 +5229,31 @@ int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width)
 EXPORT_SYMBOL(pcie_get_width_cap);
 
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
+	enum pci_bus_speed speed, speed_cap;
+
+	pcie_get_speed_cap(dev, &speed_cap);
+	pcie_get_width_cap(dev, &width_cap);
+	pcie_get_minimum_link(dev, &speed, &width);
+
+	if (speed == speed_cap && width == width_cap)
+		pci_info(dev, "%s x%d link\n", PCIE_SPEED2STR(speed), width);
+	else
+		pci_info(dev, "%s x%d link (capable of %s x%d)\n",
+			 PCIE_SPEED2STR(speed), width,
+			 PCIE_SPEED2STR(speed_cap), width_cap);
+}
+EXPORT_SYMBOL(pcie_print_link_status);
+
+/**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
  * @flags: resource type mask to be selected
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8242d3d..4a20870 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1085,6 +1085,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
 int pcie_get_speed_cap(struct pci_dev *dev, enum pci_bus_speed *speed);
 int pcie_get_width_cap(struct pci_dev *dev, enum pcie_link_width *width);
+void pcie_print_link_status(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
-- 
1.8.3.1
