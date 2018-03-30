Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbeC3VGY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:06:24 -0400
Subject: [PATCH v5 13/14] ixgbe: Report PCIe link properties with
 pcie_print_link_status()
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
Date: Fri, 30 Mar 2018 16:06:21 -0500
Message-ID: <152244398122.135666.12981274179207169419.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use pcie_print_link_status() to report PCIe link speed and possible
limitations instead of implementing this in the driver itself.

Note that pcie_get_minimum_link() can return misleading information because
it finds the slowest link and the narrowest link without considering the
total bandwidth of the link.  If the path contains a 16 GT/s x1 link and a
2.5 GT/s x16 link, pcie_get_minimum_link() returns 2.5 GT/s x1, which
corresponds to 250 MB/s of bandwidth, not the actual available bandwidth of
about 2000 MB/s for a 16 GT/s x1 link.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   47 +------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0da5aa2c8aba..38bb9c17d333 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -270,9 +270,6 @@ static void ixgbe_check_minimum_link(struct ixgbe_adapter *adapter,
 				     int expected_gts)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	int max_gts = 0;
-	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
-	enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;
 	struct pci_dev *pdev;
 
 	/* Some devices are not connected over PCIe and thus do not negotiate
@@ -288,49 +285,7 @@ static void ixgbe_check_minimum_link(struct ixgbe_adapter *adapter,
 	else
 		pdev = adapter->pdev;
 
-	if (pcie_get_minimum_link(pdev, &speed, &width) ||
-	    speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN) {
-		e_dev_warn("Unable to determine PCI Express bandwidth.\n");
-		return;
-	}
-
-	switch (speed) {
-	case PCIE_SPEED_2_5GT:
-		/* 8b/10b encoding reduces max throughput by 20% */
-		max_gts = 2 * width;
-		break;
-	case PCIE_SPEED_5_0GT:
-		/* 8b/10b encoding reduces max throughput by 20% */
-		max_gts = 4 * width;
-		break;
-	case PCIE_SPEED_8_0GT:
-		/* 128b/130b encoding reduces throughput by less than 2% */
-		max_gts = 8 * width;
-		break;
-	default:
-		e_dev_warn("Unable to determine PCI Express bandwidth.\n");
-		return;
-	}
-
-	e_dev_info("PCI Express bandwidth of %dGT/s available\n",
-		   max_gts);
-	e_dev_info("(Speed:%s, Width: x%d, Encoding Loss:%s)\n",
-		   (speed == PCIE_SPEED_8_0GT ? "8.0GT/s" :
-		    speed == PCIE_SPEED_5_0GT ? "5.0GT/s" :
-		    speed == PCIE_SPEED_2_5GT ? "2.5GT/s" :
-		    "Unknown"),
-		   width,
-		   (speed == PCIE_SPEED_2_5GT ? "20%" :
-		    speed == PCIE_SPEED_5_0GT ? "20%" :
-		    speed == PCIE_SPEED_8_0GT ? "<2%" :
-		    "Unknown"));
-
-	if (max_gts < expected_gts) {
-		e_dev_warn("This is not sufficient for optimal performance of this card.\n");
-		e_dev_warn("For optimal performance, at least %dGT/s of bandwidth is required.\n",
-			expected_gts);
-		e_dev_warn("A slot with more lanes and/or higher speed is suggested.\n");
-	}
+	pcie_print_link_status(pdev);
 }
 
 static void ixgbe_service_event_schedule(struct ixgbe_adapter *adapter)
