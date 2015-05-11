Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35894 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbbEKCoy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 May 2015 22:44:54 -0400
Received: by pdea3 with SMTP id a3so136488852pde.3
        for <linux-pci@vger.kernel.org>; Sun, 10 May 2015 19:44:53 -0700 (PDT)
Date: Mon, 11 May 2015 08:14:48 +0530
From: Tina Ruchandani <ruchandani.tina@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org
Subject: [PATCH] xen/pcifront: Remove usage of struct timeval
Message-ID: <20150511024448.GA2836@tinar>
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
---
 drivers/pci/xen-pcifront.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 7cfd2db..43d1d6c 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -20,6 +20,7 @@
 #include <linux/workqueue.h>
 #include <linux/bitops.h>
 #include <linux/time.h>
+#include <linux/ktime.h>
 #include <xen/platform_pci.h>
 
 #include <asm/xen/swiotlb-xen.h>
@@ -115,7 +116,7 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 	evtchn_port_t port = pdev->evtchn;
 	unsigned irq = pdev->irq;
 	s64 ns, ns_timeout;
-	struct timeval tv;
+	ktime_t tv;
 
 	spin_lock_irqsave(&pdev->sh_info_lock, irq_flags);
 
@@ -132,8 +133,8 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 	 * (in the latter case we end up continually re-executing poll() with a
 	 * timeout in the past). 1s difference gives plenty of slack for error.
 	 */
-	do_gettimeofday(&tv);
-	ns_timeout = timeval_to_ns(&tv) + 2 * (s64)NSEC_PER_SEC;
+	tv = ktime_get_real();
+	ns_timeout = ktime_to_ns(tv) + 2 * (s64)NSEC_PER_SEC;
 
 	xen_clear_irq_pending(irq);
 
@@ -141,8 +142,8 @@ static int do_pci_op(struct pcifront_device *pdev, struct xen_pci_op *op)
 			(unsigned long *)&pdev->sh_info->flags)) {
 		xen_poll_irq_timeout(irq, jiffies + 3*HZ);
 		xen_clear_irq_pending(irq);
-		do_gettimeofday(&tv);
-		ns = timeval_to_ns(&tv);
+		tv = ktime_get_real();
+		ns = ktime_to_ns(tv);
 		if (ns > ns_timeout) {
 			dev_err(&pdev->xdev->dev,
 				"pciback not responding!!!\n");
-- 
2.2.0.rc0.207.ga3a616c

