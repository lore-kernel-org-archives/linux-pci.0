Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:33272 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbbBEGfs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Feb 2015 01:35:48 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 5 Feb 2015 16:35:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3257D2BB0047
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2015 17:35:44 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t156ZZbq40108196
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2015 17:35:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t156ZArv012643
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2015 17:35:10 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 1/3] fix on Store individual VF BAR size in struct pci_sriov
Date: Thu,  5 Feb 2015 14:34:23 +0800
Message-Id: <1423118065-6250-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1423118065-6250-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150204234442.GC20072@google.com>
 <1423118065-6250-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

__pci_read_base() will return 1 when it is a 64-bit BAR, which makes the
resource index not correct. So i could not be the index in this case.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 721987b..b348b72 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -444,10 +444,12 @@ found:
 			rc = -EIO;
 			goto failed;
 		}
-		iov->barsz[i] = resource_size(res);
+		iov->barsz[res - dev->resource - PCI_IOV_RESOURCES] =
+			resource_size(res);
 		res->end = res->start + resource_size(res) * total - 1;
 		dev_info(&dev->dev, "VF BAR%d: %pR (contains BAR%d for %d VFs)\n",
-			 i, res, i, total);
+			 (int)(res - dev->resource - PCI_IOV_RESOURCES), res,
+			 (int)(res - dev->resource - PCI_IOV_RESOURCES), total);
 		nres++;
 	}
 
-- 
1.7.9.5

