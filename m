Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750823AbeECUAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 16:00:39 -0400
Subject: [PATCH v6 4/5] ixgbe: Report PCIe link properties with
 pcie_print_link_status()
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ariel Elior <ariel.elior@cavium.com>
Cc: linux-pci@vger.kernel.org, everest-linux-l2@cavium.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kubakici@wp.pl>
Date: Thu, 03 May 2018 15:00:36 -0500
Message-ID: <152537763602.62474.15659483976051204438.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the driver used pcie_get_minimum_link() to warn when the NIC
is in a slot that can't supply as much bandwidth as the NIC could use.

pcie_get_minimum_link() can be misleading because it finds the slowest link
and the narrowest link (which may be different links) without considering
the total bandwidth of each link.  For a path with a 16 GT/s x1 link and a
2.5 GT/s x16 link, it returns 2.5 GT/s x1, which corresponds to 250 MB/s of
bandwidth, not the true available bandwidth of about 1969 MB/s for a
16 GT/s x1 link.

Use pcie_print_link_status() to report PCIe link speed and possible
limitations instead of implementing this in the driver itself.  This finds
the slowest link in the path to the device by computing the total bandwidth
of each link and compares that with the capabilities of the device.

The dmesg change is:

  - PCI Express bandwidth of %dGT/s available
  - (Speed:%s, Width: x%d, Encoding Loss:%s)
  + %u.%03u Gb/s available PCIe bandwidth (%s x%d link)

or, if the device is capable of better performance than is available in the
current slot:

  - This is not sufficient for optimal performance of this card.
  - For optimal performance, at least %dGT/s of bandwidth is required.
  - A slot with more lanes and/or higher speed is suggested.
  + %u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)

Note that the driver previously used dev_warn() to suggest using a
different slot, but pcie_print_link_status() uses dev_info() because if the
platform has no faster slot available, the user can't do anything about the
warning and may not want to be bothered with it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   47 +------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba99f7b8..8990285f6e12 100644
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
