Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbeC3VGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 17:06:07 -0400
Subject: [PATCH v5 11/14] cxgb4: Report PCIe link properties with
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
Date: Fri, 30 Mar 2018 16:06:03 -0500
Message-ID: <152244396327.135666.7664182741063970438.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |   75 -----------------------
 1 file changed, 1 insertion(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 56bc626ef006..2d6864c8199e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -4762,79 +4762,6 @@ static int init_rss(struct adapter *adap)
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
@@ -5466,7 +5393,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* check for PCI Express bandwidth capabiltites */
-	cxgb4_check_pcie_caps(adapter);
+	pcie_print_link_status(pdev);
 
 	err = init_rss(adapter);
 	if (err)
