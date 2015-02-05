Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:34411 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbbBEGgM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Feb 2015 01:36:12 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 5 Feb 2015 16:36:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id D69E52CE804E
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2015 17:36:07 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t156ZwDi35324070
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2015 17:36:06 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t156ZWsE013522
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2015 17:35:32 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 2/3] fix Reserve additional space for IOV BAR, with m64_per_iov supported
Date: Thu,  5 Feb 2015 14:34:24 +0800
Message-Id: <1423118065-6250-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1423118065-6250-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150204234442.GC20072@google.com>
 <1423118065-6250-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When IOV BAR is bigger than 64MB, we just reserve a power_2 value.

I guess this change is lost during the rebase.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 70a0d24..1776b36 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2372,10 +2372,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
 		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
-		res->end = res->start + size * phb->ioda.total_pe - 1;
+		res->end = res->start + size * mul - 1;
 		dev_dbg(&pdev->dev, "                       %pR\n", res);
 		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
-				i, res, phb->ioda.total_pe);
+				i, res, mul);
 	}
 	pdn->max_vfs = mul;
 }
-- 
1.7.9.5

