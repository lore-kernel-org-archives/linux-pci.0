Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56844 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcFGHoM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Jun 2016 03:44:12 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Frank Haverkamp <haver@linux.vnet.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/6] GenWQE: Use pci_(request|release)_mem_regions
Date: Tue,  7 Jun 2016 09:44:04 +0200
Message-Id: <9dc00591ce163069d2fa72e320997996dc37b3ea.1465200424.git.jthumshirn@suse.de>
In-Reply-To: <cover.1465200424.git.jthumshirn@suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
In-Reply-To: <cover.1465200424.git.jthumshirn@suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
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

