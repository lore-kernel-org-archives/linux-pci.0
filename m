Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 21 Jun 2016 17:27:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/6] NVMe: Use pci_(request|release)_mem_regions
Message-ID: <20160621222718.GE7603@localhost>
References: <cover.1465200424.git.jthumshirn@suse.de>
 <5c9932602e6d43ef8ad77856c686765f9e63aa9c.1465200424.git.jthumshirn@suse.de>
 <20160617112716.74e4hgy5bhkkgmi6@c203.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160617112716.74e4hgy5bhkkgmi6@c203.arch.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 17, 2016 at 01:27:16PM +0200, Johannes Thumshirn wrote:
> On Tue, Jun 07, 2016 at 09:44:02AM +0200, Johannes Thumshirn wrote:
> > Now that we do have pci_request_mem_regions() and pci_release_mem_regions() at
> > hand, use it in the NVMe driver.
> > 
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: linux-nvme@lists.infradead.org
> 
> Bjorn, 
> 
> Jens merged a band aid here which conflicts with the patch. Shall I send you
> this patch re-based or the entire series?

I see the conflict with the patch below.  I don't know how Jens
manages his tree, but the conflict should be pretty trivial to
resolve, so I won't worry about it too much.


commit edb50a5403d2
Author: Johannes Thumshirn <jthumshirn@suse.de>
Date:   Tue May 10 15:14:28 2016 +0200

    NVMe: Only release requested regions
    
    The NVMe driver only requests the PCIe device's memory regions but releases
    all possible regions (including eventual I/O regions). This leads to a stale
    warning entry in dmesg about freeing non existent resources.
    
    Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
    Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 78dca31..befac5b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1679,9 +1679,14 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
+       struct pci_dev *pdev = to_pci_dev(dev->dev);
+       int bars;
+
        if (dev->bar)
                iounmap(dev->bar);
-       pci_release_regions(to_pci_dev(dev->dev));
+
+       bars = pci_select_bars(pdev, IORESOURCE_MEM);
+       pci_release_selected_regions(pdev, bars);
 }
 
 static void nvme_pci_disable(struct nvme_dev *dev)
@@ -1924,7 +1929,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 
        return 0;
   release:
-       pci_release_regions(pdev);
+       pci_release_selected_regions(pdev, bars);
        return -ENODEV;
 }
 
