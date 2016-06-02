Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Frank Haverkamp <haver@linux.vnet.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 4/6] GenWQE: Use pci_(request|release)_mem_regions
Date: Thu,  2 Jun 2016 09:30:32 +0200
Message-Id: <a703571b4e3588fa9ba195ca8a40bc22250cdd60.1464795082.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464795082.git.jthumshirn@suse.de>
References: <cover.1464795082.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464795082.git.jthumshirn@suse.de>
References: <cover.1464795082.git.jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we do have pci_request_mem_regions() and pci_release_mem_regions() at
hand, use it in the genwqe driver.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/genwqe/card_base.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 4cf8f82..cb398be 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -182,7 +182,7 @@ static void genwqe_dev_free(struct genwqe_dev *cd)
  */
 static int genwqe_bus_reset(struct genwqe_dev *cd)
 {
-	int bars, rc = 0;
+	int rc = 0;
 	struct pci_dev *pci_dev = cd->pci_dev;
 	void __iomem *mmio;
 
@@ -193,8 +193,7 @@ static int genwqe_bus_reset(struct genwqe_dev *cd)
 	cd->mmio = NULL;
 	pci_iounmap(pci_dev, mmio);
 
-	bars = pci_select_bars(pci_dev, IORESOURCE_MEM);
-	pci_release_selected_regions(pci_dev, bars);
+	pci_release_mem_regions(pci_dev);
 
 	/*
 	 * Firmware/BIOS might change memory mapping during bus reset.
@@ -218,7 +217,7 @@ static int genwqe_bus_reset(struct genwqe_dev *cd)
 			    GENWQE_INJECT_GFIR_FATAL |
 			    GENWQE_INJECT_GFIR_INFO);
 
-	rc = pci_request_selected_regions(pci_dev, bars, genwqe_driver_name);
+	rc = pci_request_mem_regions(pci_dev, genwqe_driver_name);
 	if (rc) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: request bars failed (%d)\n", __func__, rc);
@@ -1071,7 +1070,6 @@ static int genwqe_pci_setup(struct genwqe_dev *cd)
 	int err, bars;
 	struct pci_dev *pci_dev = cd->pci_dev;
 
-	bars = pci_select_bars(pci_dev, IORESOURCE_MEM);
 	err = pci_enable_device_mem(pci_dev);
 	if (err) {
 		dev_err(&pci_dev->dev,
@@ -1080,7 +1078,7 @@ static int genwqe_pci_setup(struct genwqe_dev *cd)
 	}
 
 	/* Reserve PCI I/O and memory resources */
-	err = pci_request_selected_regions(pci_dev, bars, genwqe_driver_name);
+	err = pci_request_mem_regions(pci_dev, genwqe_driver_name);
 	if (err) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: request bars failed (%d)\n", __func__, err);
@@ -1160,8 +1158,7 @@ static void genwqe_pci_remove(struct genwqe_dev *cd)
 	if (cd->mmio)
 		pci_iounmap(pci_dev, cd->mmio);
 
-	bars = pci_select_bars(pci_dev, IORESOURCE_MEM);
-	pci_release_selected_regions(pci_dev, bars);
+	pci_release_mem_regions(pci_dev);
 	pci_disable_device(pci_dev);
 }
 
-- 
1.8.5.6
