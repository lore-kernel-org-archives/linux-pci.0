Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:54770 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdGFJAl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2017 05:00:41 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: remove unused struct resource *res from pci_resource_io
Date: Thu,  6 Jul 2017 17:00:20 +0800
Message-Id: <1499331620-132371-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is never used and introduces a compile warning:

drivers/pci/pci-sysfs.c: In function 'pci_resource_io':
drivers/pci/pci-sysfs.c:1214:19: warning: variable 'res' set but not
used [-Wunused-but-set-variable]

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/pci-sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2f3780b..0e43705 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1211,11 +1211,8 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
-	struct resource *res;
 	unsigned long port = off;
 
-	res = &pdev->resource[bar];
-
 	port += pci_resource_start(pdev, bar);
 
 	if (port > pci_resource_end(pdev, bar))
-- 
1.9.1
