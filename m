Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v6 3/5] cxgb4: Report PCIe link properties with
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
Date: Thu, 03 May 2018 15:00:29 -0500
Message-ID: <152537762921.62474.3606947168382589745.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

  - PCIe link speed is %s, device supports %s
  - PCIe link width is x%d, device supports x%d
  + %u.%03u Gb/s available PCIe bandwidth (%s x%d link)

or, if the device is capable of better performance than is available in the
current slot:

  - A slot with more lanes and/or higher speed is suggested for optimal performance.
  + %u.%03u Gb/s available PCIe bandwidth, limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d link)

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |   75 -----------------------
 1 file changed, 1 insertion(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 24d2865b8806..7328f24ba1dd 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5042,79 +5042,6 @@ static int init_rss(struct adapter *adap)
 	return 0;
 }
 
-static int cxgb4_get_pcie_dev_link_caps(struct adapter *adap,
-					enum pci_bus_speed *speed,
-					enum pcie_link_width *width)
-{
-	u32 lnkcap1, lnkcap2;
-	int err1, err2;
-
-#define  PCIE_MLW_CAP_SHIFT 4   /* start of MLW mask in link capabilities */
-
-	*speed = PCI_SPEED_UNKNOWN;
-	*width = PCIE_LNK_WIDTH_UNKNOWN;
-
-	err1 = pcie_capability_read_dword(adap->pdev, PCI_EXP_LNKCAP,
-					  &lnkcap1);
-	err2 = pcie_capability_read_dword(adap->pdev, PCI_EXP_LNKCAP2,
-					  &lnkcap2);
-	if (!err2 && lnkcap2) { /* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
-			*speed = PCIE_SPEED_8_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
-			*speed = PCIE_SPEED_5_0GT;
-		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
-			*speed = PCIE_SPEED_2_5GT;
-	}
-	if (!err1) {
-		*width = (lnkcap1 & PCI_EXP_LNKCAP_MLW) >> PCIE_MLW_CAP_SHIFT;
-		if (!lnkcap2) { /* pre-r3.0 */
-			if (lnkcap1 & PCI_EXP_LNKCAP_SLS_5_0GB)
-				*speed = PCIE_SPEED_5_0GT;
-			else if (lnkcap1 & PCI_EXP_LNKCAP_SLS_2_5GB)
-				*speed = PCIE_SPEED_2_5GT;
-		}
-	}
-
-	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
-		return err1 ? err1 : err2 ? err2 : -EINVAL;
-	return 0;
-}
-
-static void cxgb4_check_pcie_caps(struct adapter *adap)
-{
-	enum pcie_link_width width, width_cap;
-	enum pci_bus_speed speed, speed_cap;
-
-#define PCIE_SPEED_STR(speed) \
-	(speed == PCIE_SPEED_8_0GT ? "8.0GT/s" : \
-	 speed == PCIE_SPEED_5_0GT ? "5.0GT/s" : \
-	 speed == PCIE_SPEED_2_5GT ? "2.5GT/s" : \
-	 "Unknown")
-
-	if (cxgb4_get_pcie_dev_link_caps(adap, &speed_cap, &width_cap)) {
-		dev_warn(adap->pdev_dev,
-			 "Unable to determine PCIe device BW capabilities\n");
-		return;
-	}
-
-	if (pcie_get_minimum_link(adap->pdev, &speed, &width) ||
-	    speed == PCI_SPEED_UNKNOWN || width == PCIE_LNK_WIDTH_UNKNOWN) {
-		dev_warn(adap->pdev_dev,
-			 "Unable to determine PCI Express bandwidth.\n");
-		return;
-	}
-
-	dev_info(adap->pdev_dev, "PCIe link speed is %s, device supports %s\n",
-		 PCIE_SPEED_STR(speed), PCIE_SPEED_STR(speed_cap));
-	dev_info(adap->pdev_dev, "PCIe link width is x%d, device supports x%d\n",
-		 width, width_cap);
-	if (speed < speed_cap || width < width_cap)
-		dev_info(adap->pdev_dev,
-			 "A slot with more lanes and/or higher speed is "
-			 "suggested for optimal performance.\n");
-}
-
 /* Dump basic information about the adapter */
 static void print_adapter_info(struct adapter *adapter)
 {
@@ -5750,7 +5677,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* check for PCI Express bandwidth capabiltites */
-	cxgb4_check_pcie_caps(adapter);
+	pcie_print_link_status(pdev);
 
 	err = init_rss(adapter);
 	if (err)
