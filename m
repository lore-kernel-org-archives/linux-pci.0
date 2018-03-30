Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbeC3VGb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:06:31 -0400
Subject: [PATCH v5 14/14] PCI: Remove unused pcie_get_minimum_link()
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
Date: Fri, 30 Mar 2018 16:06:29 -0500
Message-ID: <152244398928.135666.9455627241901450661.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

In some cases pcie_get_minimum_link() returned misleading information
because it found the slowest link and the narrowest link without
considering the total bandwidth of the link.  For example, if the path
contained a 16 GT/s x1 link and a 2.5 GT/s x16 link,
pcie_get_minimum_link() returned 2.5 GT/s x1, which corresponds to 250 MB/s
of bandwidth, not the actual available bandwidth of about 2000 MB/s for a
16 GT/s x1 link.

Callers should use pcie_print_link_status() instead, or
pcie_bandwidth_available() if they need more detailed information.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c   |   43 -------------------------------------------
 include/linux/pci.h |    2 --
 2 files changed, 45 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cec7aed09f6b..b6951c44ae6c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5103,49 +5103,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-/**
- * pcie_get_minimum_link - determine minimum link settings of a PCI device
- * @dev: PCI device to query
- * @speed: storage for minimum speed
- * @width: storage for minimum width
- *
- * This function will walk up the PCI device chain and determine the minimum
- * link width and speed of the device.
- */
-int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
-			  enum pcie_link_width *width)
-{
-	int ret;
-
-	*speed = PCI_SPEED_UNKNOWN;
-	*width = PCIE_LNK_WIDTH_UNKNOWN;
-
-	while (dev) {
-		u16 lnksta;
-		enum pci_bus_speed next_speed;
-		enum pcie_link_width next_width;
-
-		ret = pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
-		if (ret)
-			return ret;
-
-		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
-		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
-			PCI_EXP_LNKSTA_NLW_SHIFT;
-
-		if (next_speed < *speed)
-			*speed = next_speed;
-
-		if (next_width < *width)
-			*width = next_width;
-
-		dev = dev->bus->self;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(pcie_get_minimum_link);
-
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 38f7957121ef..5ccee29fe1b1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1081,8 +1081,6 @@ int pcie_get_readrq(struct pci_dev *dev);
 int pcie_set_readrq(struct pci_dev *dev, int rq);
 int pcie_get_mps(struct pci_dev *dev);
 int pcie_set_mps(struct pci_dev *dev, int mps);
-int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
-			  enum pcie_link_width *width);
 u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
