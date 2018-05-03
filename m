Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v6 2/5] bnxt_en: Report PCIe link properties with
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
Date: Thu, 03 May 2018 15:00:22 -0500
Message-ID: <152537762239.62474.691804492516629751.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
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

  - PCIe: Speed %s Width x%d
  + %u.%03u Gb/s available PCIe bandwidth (%s x%d link)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f83769d8047b..34fddb48fecc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8621,22 +8621,6 @@ static int bnxt_init_mac_addr(struct bnxt *bp)
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
@@ -8851,8 +8835,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev_info(dev, "%s found at mem %lx, node addr %pM\n",
 		    board_info[ent->driver_data].name,
 		    (long)pci_resource_start(pdev, 0), dev->dev_addr);
-
-	bnxt_parse_log_pcie_link(bp);
+	pcie_print_link_status(pdev);
 
 	return 0;
 
