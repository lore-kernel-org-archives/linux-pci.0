Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbeC3VGQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:06:16 -0400
Subject: [PATCH v5 12/14] fm10k: Report PCIe link properties with
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
Date: Fri, 30 Mar 2018 16:06:12 -0500
Message-ID: <152244397259.135666.12655029447932912161.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |   87 --------------------------
 1 file changed, 1 insertion(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index a434fecfdfeb..aa05fb534942 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2120,91 +2120,6 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 	return 0;
 }
 
-static void fm10k_slot_warn(struct fm10k_intfc *interface)
-{
-	enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;
-	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
-	struct fm10k_hw *hw = &interface->hw;
-	int max_gts = 0, expected_gts = 0;
-
-	if (pcie_get_minimum_link(interface->pdev, &speed, &width) ||
-	    speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN) {
-		dev_warn(&interface->pdev->dev,
-			 "Unable to determine PCI Express bandwidth.\n");
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
-		/* 128b/130b encoding has less than 2% impact on throughput */
-		max_gts = 8 * width;
-		break;
-	default:
-		dev_warn(&interface->pdev->dev,
-			 "Unable to determine PCI Express bandwidth.\n");
-		return;
-	}
-
-	dev_info(&interface->pdev->dev,
-		 "PCI Express bandwidth of %dGT/s available\n",
-		 max_gts);
-	dev_info(&interface->pdev->dev,
-		 "(Speed:%s, Width: x%d, Encoding Loss:%s, Payload:%s)\n",
-		 (speed == PCIE_SPEED_8_0GT ? "8.0GT/s" :
-		  speed == PCIE_SPEED_5_0GT ? "5.0GT/s" :
-		  speed == PCIE_SPEED_2_5GT ? "2.5GT/s" :
-		  "Unknown"),
-		 hw->bus.width,
-		 (speed == PCIE_SPEED_2_5GT ? "20%" :
-		  speed == PCIE_SPEED_5_0GT ? "20%" :
-		  speed == PCIE_SPEED_8_0GT ? "<2%" :
-		  "Unknown"),
-		 (hw->bus.payload == fm10k_bus_payload_128 ? "128B" :
-		  hw->bus.payload == fm10k_bus_payload_256 ? "256B" :
-		  hw->bus.payload == fm10k_bus_payload_512 ? "512B" :
-		  "Unknown"));
-
-	switch (hw->bus_caps.speed) {
-	case fm10k_bus_speed_2500:
-		/* 8b/10b encoding reduces max throughput by 20% */
-		expected_gts = 2 * hw->bus_caps.width;
-		break;
-	case fm10k_bus_speed_5000:
-		/* 8b/10b encoding reduces max throughput by 20% */
-		expected_gts = 4 * hw->bus_caps.width;
-		break;
-	case fm10k_bus_speed_8000:
-		/* 128b/130b encoding has less than 2% impact on throughput */
-		expected_gts = 8 * hw->bus_caps.width;
-		break;
-	default:
-		dev_warn(&interface->pdev->dev,
-			 "Unable to determine expected PCI Express bandwidth.\n");
-		return;
-	}
-
-	if (max_gts >= expected_gts)
-		return;
-
-	dev_warn(&interface->pdev->dev,
-		 "This device requires %dGT/s of bandwidth for optimal performance.\n",
-		 expected_gts);
-	dev_warn(&interface->pdev->dev,
-		 "A %sslot with x%d lanes is suggested.\n",
-		 (hw->bus_caps.speed == fm10k_bus_speed_2500 ? "2.5GT/s " :
-		  hw->bus_caps.speed == fm10k_bus_speed_5000 ? "5.0GT/s " :
-		  hw->bus_caps.speed == fm10k_bus_speed_8000 ? "8.0GT/s " : ""),
-		 hw->bus_caps.width);
-}
-
 /**
  * fm10k_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -2326,7 +2241,7 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mod_timer(&interface->service_timer, (HZ * 2) + jiffies);
 
 	/* print warning for non-optimal configurations */
-	fm10k_slot_warn(interface);
+	pcie_print_link_status(interface->pdev);
 
 	/* report MAC address for logging */
 	dev_info(&pdev->dev, "%pM\n", netdev->dev_addr);
