Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752978AbeC3VFV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:05:21 -0400
Subject: [PATCH v5 05/14] PCI: Add pcie_print_link_status() to log link
 speed and whether it's limited
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
Date: Fri, 30 Mar 2018 16:05:18 -0500
Message-ID: <152244391852.135666.14903825998610307052.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tal Gilboa <talgi@mellanox.com>

Add pcie_print_link_status().  This logs the current settings of the link
(speed, width, and total available bandwidth).

If the device is capable of more bandwidth but is limited by a slower
upstream link, we include information about the link that limits the
device's performance.

The user may be able to move the device to a different slot for better
performance.

This provides a unified method for all PCI devices to report status and
issues, instead of each device reporting in a different way, using
different code.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
[bhelgaas: changelog, reword log messages, print device capabilities when
not limited]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   |   29 +++++++++++++++++++++++++++++
 include/linux/pci.h |    1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e00d56b12747..cec7aed09f6b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5283,6 +5283,35 @@ u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
 	return *width * PCIE_SPEED2MBS_ENC(*speed);
 }
 
+/**
+ * pcie_print_link_status - Report the PCI device's link speed and width
+ * @dev: PCI device to query
+ *
+ * Report the available bandwidth at the device.  If this is less than the
+ * device is capable of, report the device's maximum possible bandwidth and
+ * the upstream link that limits its performance to less than that.
+ */
+void pcie_print_link_status(struct pci_dev *dev)
+{
+	enum pcie_link_width width, width_cap;
+	enum pci_bus_speed speed, speed_cap;
+	struct pci_dev *limiting_dev = NULL;
+	u32 bw_avail, bw_cap;
+
+	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
+	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width);
+
+	if (bw_avail >= bw_cap)
+		pci_info(dev, "%d Mb/s available bandwidth (%s x%d link)\n",
+			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
+	else
+		pci_info(dev, "%d Mb/s available bandwidth, limited by %s x%d link at %s (capable of %d Mb/s with %s x%d link)\n",
+			 bw_avail, PCIE_SPEED2STR(speed), width,
+			 limiting_dev ? pci_name(limiting_dev) : "<unknown>",
+			 bw_cap, PCIE_SPEED2STR(speed_cap), width_cap);
+}
+EXPORT_SYMBOL(pcie_print_link_status);
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f2bf2b7a66c7..38f7957121ef 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1086,6 +1086,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
+void pcie_print_link_status(struct pci_dev *dev);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
