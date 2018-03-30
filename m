Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v5 09/14] bnx2x: Report PCIe link properties with
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
Date: Fri, 30 Mar 2018 16:05:48 -0500
Message-ID: <152244394874.135666.109326052402414686.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   23 ++++++----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 74fc9af4aadb..c92601f1b0f3 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -13922,8 +13922,6 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 {
 	struct net_device *dev = NULL;
 	struct bnx2x *bp;
-	enum pcie_link_width pcie_width;
-	enum pci_bus_speed pcie_speed;
 	int rc, max_non_def_sbs;
 	int rx_count, tx_count, rss_count, doorbell_size;
 	int max_cos_est;
@@ -14091,21 +14089,12 @@ static int bnx2x_init_one(struct pci_dev *pdev,
 		dev_addr_add(bp->dev, bp->fip_mac, NETDEV_HW_ADDR_T_SAN);
 		rtnl_unlock();
 	}
-	if (pcie_get_minimum_link(bp->pdev, &pcie_speed, &pcie_width) ||
-	    pcie_speed == PCI_SPEED_UNKNOWN ||
-	    pcie_width == PCIE_LNK_WIDTH_UNKNOWN)
-		BNX2X_DEV_INFO("Failed to determine PCI Express Bandwidth\n");
-	else
-		BNX2X_DEV_INFO(
-		       "%s (%c%d) PCI-E x%d %s found at mem %lx, IRQ %d, node addr %pM\n",
-		       board_info[ent->driver_data].name,
-		       (CHIP_REV(bp) >> 12) + 'A', (CHIP_METAL(bp) >> 4),
-		       pcie_width,
-		       pcie_speed == PCIE_SPEED_2_5GT ? "2.5GHz" :
-		       pcie_speed == PCIE_SPEED_5_0GT ? "5.0GHz" :
-		       pcie_speed == PCIE_SPEED_8_0GT ? "8.0GHz" :
-		       "Unknown",
-		       dev->base_addr, bp->pdev->irq, dev->dev_addr);
+	BNX2X_DEV_INFO(
+	       "%s (%c%d) PCI-E found at mem %lx, IRQ %d, node addr %pM\n",
+	       board_info[ent->driver_data].name,
+	       (CHIP_REV(bp) >> 12) + 'A', (CHIP_METAL(bp) >> 4),
+	       dev->base_addr, bp->pdev->irq, dev->dev_addr);
+	pcie_print_link_status(bp->pdev);
 
 	bnx2x_register_phc(bp);
 
