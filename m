Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47794 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbHUJxp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 05:53:45 -0400
From: Ethan Zhao <ethan.zhao@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ethan Zhao <ethan.zhao@oracle.com>
Subject: [PATCH] iov: initialize NumVFs register to 0 at the end of sriov_init()
Date: Fri, 21 Aug 2015 18:51:25 +0900
Message-Id: <1440150685-6690-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After commit 4449f079722c ("PCI: Calculate maximum number of buses
required for VFs"),the initial value of NumVFs register was set to
non-zero after sriov_init() and no VFs was enabled in device driver.
this changed the behaviour of kernel exported by lspci and sysfs etc.
so this patch initialize the NumVFs register to zero after the
calculation of max_VF_buses was done.

Tested on stable 4.1 and passed building on stable 4.2-rc7

Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
Tested-by: Sriharsha Yadagudde <sriharsha.devdas@oracle.com>
---
 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..6969084 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -476,6 +476,7 @@ found:
 	dev->is_physfn = 1;
 	iov->max_VF_buses = virtfn_max_buses(dev);
 
+	pci_iov_set_numvfs(dev, 0);
 	return 0;
 
 failed:
-- 
1.8.3.1

