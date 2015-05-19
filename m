Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36696 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbbESGIO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 02:08:14 -0400
Received: by pabts4 with SMTP id ts4so9226433pab.3
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2015 23:08:14 -0700 (PDT)
Date: Tue, 19 May 2015 11:38:09 +0530
From: Tina Ruchandani <ruchandani.tina@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org
Subject: [PATCH v2] xen/pcifront: Remove usage of struct timeval
Message-ID: <20150519060809.GA27777@tinar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

struct timeval uses a 32-bit field for representing seconds,
which will overflow in the year 2038 and beyond. This patch replaces
struct timeval with 64-bit ktime_t which is 2038 safe.
The patch is part of a larger effort to remove instances of
32-bit timekeeping variables (timeval, time_t and timespec)
from the kernel.

Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
--
Changes in v2:
- Use monotonic time (ktime_get_ns()) instead of real time
since we only care about elapsed delta here.
- Use macro ktime_get_ns() instead of getting ktime_t and
converting it to ns.
---
 drivers/pci/xen-pcifront.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 7cfd2db..c4796c8 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -20,6 +20,7 @@
 #include <linux/workqueue.h>
 #include <linux/bitops.h>
 #include <linux/time.h>
+#include <linux/ktime.h>
 #include <xen/platform_pci.h>
 
 #include <asm/xen/swiotlb-xen.h>
@@ -115,7 +116,6 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 	evtchn_port_t port = pdev->evtchn;
 	unsigned irq = pdev->irq;
 	s64 ns, ns_timeout;
-	struct timeval tv;
 
 	spin_lock_irqsave(&pdev->sh_info_lock, irq_flags);
 
@@ -132,8 +132,7 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 	 * (in the latter case we end up continually re-executing poll() with a
 	 * timeout in the past). 1s difference gives plenty of slack for error.
 	 */
-	do_gettimeofday(&tv);
-	ns_timeout = timeval_to_ns(&tv) + 2 * (s64)NSEC_PER_SEC;
+	ns_timeout = ktime_get_ns() + 2 * (s64)NSEC_PER_SEC;
 
 	xen_clear_irq_pending(irq);
 
@@ -141,8 +140,7 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 			(unsigned long *)&pdev->sh_info->flags)) {
 		xen_poll_irq_timeout(irq, jiffies + 3*HZ);
 		xen_clear_irq_pending(irq);
-		do_gettimeofday(&tv);
-		ns = timeval_to_ns(&tv);
+		ns = ktime_get_ns();
 		if (ns > ns_timeout) {
 			dev_err(&pdev->xdev->dev,
 				"pciback not responding!!!\n");
-- 
2.2.0.rc0.207.ga3a616c

