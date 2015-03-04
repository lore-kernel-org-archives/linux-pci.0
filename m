Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:46972 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbCDFVN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 00:21:13 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 4 Mar 2015 15:21:11 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 959832BB0051
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2015 16:21:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t245L04i32964674
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2015 16:21:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t245KYHl025394
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2015 16:20:35 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V13 02/21] PCI: Print PF SR-IOV resource that contains all VF(n) BAR space
Date: Wed,  4 Mar 2015 13:18:54 +0800
Message-Id: <1425446353-30513-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1425446353-30513-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we size VF BAR0, VF BAR1, etc., from the SR-IOV Capability of a PF, we
learn the alignment requirement and amount of space consumed by a single
VF.  But when VFs are enabled, *each* of the NumVFs consumes that amount of
space, so the total size of the PF resource is "VF BAR size * NumVFs".

Add a printk of the total space consumed by the VFs corresponding to what
we already do for normal non-IOV BARs.

No functional change; new message only.

[bhelgaas: split out into its own patch]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c4c33ea..05f9d97 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -372,6 +372,8 @@ found:
 			goto failed;
 		}
 		res->end = res->start + resource_size(res) * total - 1;
+		dev_info(&dev->dev, "VF(n) BAR%d space: %pR (contains BAR%d for %d VFs)\n",
+			 i, res, i, total);
 		nres++;
 	}
 
-- 
1.7.9.5

