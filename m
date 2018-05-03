Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751575AbeECOzK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 10:55:10 -0400
Date: Thu, 3 May 2018 10:55:09 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
cc: Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] nvme/pci: Use async_schedule for initial reset work
In-Reply-To: <20180502152953.GH5938@localhost.localdomain>
Message-ID: <alpine.LRH.2.02.1805021717430.2705@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180427211708.5604-1-keith.busch@intel.com> <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com> <20180430194533.GC5938@localhost.localdomain> <alpine.LRH.2.02.1805011928470.17838@file01.intranet.prod.int.rdu2.redhat.com>
 <20180502152953.GH5938@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wed, 2 May 2018, Keith Busch wrote:

> On Tue, May 01, 2018 at 07:33:10PM -0400, Mikulas Patocka wrote:
> > On Mon, 30 Apr 2018, Keith Busch wrote:
> > 
> > > On Sat, Apr 28, 2018 at 05:11:18PM +0800, Ming Lei wrote:
> > > > Looks fine,
> > > > 
> > > > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > > 
> > > Thanks, Ming.
> > > 
> > > Mikulas, would you be able to test this and confirm it works for you?
> > > This appears successful in my testing, but want to hear from the source
> > > if possible.
> > > 
> > > Thanks,
> > > Keith
> > 
> > The patch is not correct - scan_work is still called from a workqueue and 
> > if it's too slow, the nvme device is not found when mounting root.
> > 
> > You can add msleep(10000) at the beginning of nvme_scan_work to test for 
> > the race condition on your system.
> > 
> > Here I submit the corrected patch - I added 
> > flush_work(&dev->ctrl.scan_work) to nvme_async_probe
> 
> Roger that. Will incorporate your adjustment and add your
> Tested-by. Thanks for the confirmation.

I think there is still one more bug:

If nvme_probe is called, it schedules the asynchronous work using 
async_schedule - now suppose that the pci system calls the "remove", 
"shutdown" or "suspend" method - this method will race with 
nvme_async_probe running in the async domain - that will cause 
misbehavior.

Or - does the PCI subsystem flush the async queues before calling these 
methods? I'm not sure, but it doesn't seem so.

I think, you need to save the cookie returned by async_schedule and wait 
for this cookie with async_synchronize_cookie in the other methods.

Mikulas


This patch schedules the initial controller reset in an async_domain so
that it can be synchronized from wait_for_device_probe(). This way the
kernel waits for the first nvme controller initialization to complete
for all devices before proceeding with the boot sequence, which may have
nvme dependencies.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/nvme/host/pci.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

Index: linux-4.16.6/drivers/nvme/host/pci.c
===================================================================
--- linux-4.16.6.orig/drivers/nvme/host/pci.c	2018-05-03 16:43:01.000000000 +0200
+++ linux-4.16.6/drivers/nvme/host/pci.c	2018-05-03 16:46:35.000000000 +0200
@@ -13,6 +13,7 @@
  */
 
 #include <linux/aer.h>
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
@@ -111,6 +112,8 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+
+	async_cookie_t probe_cookie;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2471,6 +2474,13 @@ static unsigned long check_vendor_combin
 	return 0;
 }
 
+static void nvme_async_probe(void *data, async_cookie_t cookie)
+{
+	struct nvme_dev *dev = data;
+	nvme_reset_ctrl_sync(&dev->ctrl);
+	flush_work(&dev->ctrl.scan_work);
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2515,7 +2525,7 @@ static int nvme_probe(struct pci_dev *pd
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	nvme_reset_ctrl(&dev->ctrl);
+	dev->probe_cookie = async_schedule(nvme_async_probe, dev);
 
 	return 0;
 
@@ -2546,6 +2556,9 @@ static void nvme_reset_done(struct pci_d
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	async_synchronize_cookie(dev->probe_cookie);
+
 	nvme_dev_disable(dev, true);
 }
 
@@ -2558,6 +2571,8 @@ static void nvme_remove(struct pci_dev *
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	async_synchronize_cookie(dev->probe_cookie);
+
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
 	cancel_work_sync(&dev->ctrl.reset_work);
@@ -2605,6 +2620,8 @@ static int nvme_suspend(struct device *d
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	async_synchronize_cookie(dev->probe_cookie);
+
 	nvme_dev_disable(ndev, true);
 	return 0;
 }
@@ -2614,6 +2631,8 @@ static int nvme_resume(struct device *de
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	async_synchronize_cookie(dev->probe_cookie);
+
 	nvme_reset_ctrl(&ndev->ctrl);
 	return 0;
 }
