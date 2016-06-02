Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/6] NVMe: Use pci_(request|release)_mem_regions
Date: Thu,  2 Jun 2016 09:30:30 +0200
Message-Id: <9cdb60ecb1d5124311a05c6b75d16f48526593f0.1464795082.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464795082.git.jthumshirn@suse.de>
References: <cover.1464795082.git.jthumshirn@suse.de>
In-Reply-To: <cover.1464795082.git.jthumshirn@suse.de>
References: <cover.1464795082.git.jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we do have pci_request_mem_regions() and pci_release_mem_regions() at
hand, use it in the NVMe driver.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
---
 drivers/nvme/host/pci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4fd733f..e7d17ae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1756,7 +1756,7 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 {
 	if (dev->bar)
 		iounmap(dev->bar);
-	pci_release_regions(to_pci_dev(dev->dev));
+	pci_release_mem_regions(to_pci_dev(dev->dev));
 }
 
 static void nvme_pci_disable(struct nvme_dev *dev)
@@ -1979,13 +1979,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 
 static int nvme_dev_map(struct nvme_dev *dev)
 {
-	int bars;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	bars = pci_select_bars(pdev, IORESOURCE_MEM);
-	if (!bars)
-		return -ENODEV;
-	if (pci_request_selected_regions(pdev, bars, "nvme"))
+	if (pci_request_mem_regions(pdev, "nvme"))
 		return -ENODEV;
 
 	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
@@ -1994,7 +1990,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 
        return 0;
   release:
-       pci_release_regions(pdev);
+       pci_release_mem_regions(pdev);
        return -ENODEV;
 }
 
-- 
1.8.5.6
