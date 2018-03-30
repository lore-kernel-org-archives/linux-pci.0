Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752774AbeC3VF6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:05:58 -0400
Subject: [PATCH v5 10/14] bnxt_en: Report PCIe link properties with
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
Date: Fri, 30 Mar 2018 16:05:55 -0500
Message-ID: <152244395584.135666.5051262627122405867.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1500243b9886..3be42431e029 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8469,22 +8469,6 @@ static int bnxt_init_mac_addr(struct bnxt *bp)
 	return rc;
 }
 
-static void bnxt_parse_log_pcie_link(struct bnxt *bp)
-{
-	enum pcie_link_width width = PCIE_LNK_WIDTH_UNKNOWN;
-	enum pci_bus_speed speed = PCI_SPEED_UNKNOWN;
-
-	if (pcie_get_minimum_link(pci_physfn(bp->pdev), &speed, &width) ||
-	    speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN)
-		netdev_info(bp->dev, "Failed to determine PCIe Link Info\n");
-	else
-		netdev_info(bp->dev, "PCIe: Speed %s Width x%d\n",
-			    speed == PCIE_SPEED_2_5GT ? "2.5GT/s" :
-			    speed == PCIE_SPEED_5_0GT ? "5.0GT/s" :
-			    speed == PCIE_SPEED_8_0GT ? "8.0GT/s" :
-			    "Unknown", width);
-}
-
 static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int version_printed;
@@ -8694,8 +8678,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev_info(dev, "%s found at mem %lx, node addr %pM\n",
 		    board_info[ent->driver_data].name,
 		    (long)pci_resource_start(pdev, 0), dev->dev_addr);
-
-	bnxt_parse_log_pcie_link(bp);
+	pcie_print_link_status(pdev);
 
 	return 0;
 
