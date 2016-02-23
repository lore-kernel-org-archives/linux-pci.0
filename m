Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48187 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755500AbcBWArp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Feb 2016 19:47:45 -0500
Subject: [PATCH v4 11/11] PCI: Sleep rather than busy-wait for VPD access
 completion
To: Hannes Reinecke <hare@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 22 Feb 2016 18:47:42 -0600
Message-ID: <20160223004742.10635.55287.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use usleep_range() instead of udelay() while waiting for a VPD access to
complete.  This is not a performance path, so no need to hog the CPU.

Rationale for usleep_range() parameters:

  We clear PCI_VPD_ADDR_F for a read (or set it for a write), then wait for
  the device to change it.  For a device that updates PCI_VPD_ADDR between
  our config write and subsequent config read, we won't sleep at all and
  can get the device's maximum rate.

  Sleeping a minimum of 10 usec per 4-byte access limits throughput to
  about 400Kbytes/second.  VPD is small (32K bytes at most), and most
  devices use only a fraction of that.

  We back off exponentially up to 1024 usec per iteration.  If we reach
  1024, we've already waited up to 1008 usec (16 + 32 + ...  + 512), so if
  we miss an update and wait an extra 1024 usec, we can still get about 1/2
  of the device's maximum rate.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index cae5462..68cad94 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -342,14 +342,15 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 static int pci_vpd_wait(struct pci_dev *dev)
 {
 	struct pci_vpd *vpd = dev->vpd;
-	unsigned long timeout = jiffies + HZ/20 + 2;
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+	unsigned long max_sleep = 16;
 	u16 status;
 	int ret;
 
 	if (!vpd->busy)
 		return 0;
 
-	for (;;) {
+	while (time_before(jiffies, timeout)) {
 		ret = pci_user_read_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						&status);
 		if (ret < 0)
@@ -360,15 +361,16 @@ static int pci_vpd_wait(struct pci_dev *dev)
 			return 0;
 		}
 
-		if (time_after(jiffies, timeout)) {
-			dev_printk(KERN_DEBUG, &dev->dev, "vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update\n");
-			return -ETIMEDOUT;
-		}
 		if (fatal_signal_pending(current))
 			return -EINTR;
-		if (!cond_resched())
-			udelay(10);
+
+		usleep_range(10, max_sleep);
+		if (max_sleep < 1024)
+			max_sleep *= 2;
 	}
+
+	dev_warn(&dev->dev, "VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update\n");
+	return -ETIMEDOUT;
 }
 
 static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,

