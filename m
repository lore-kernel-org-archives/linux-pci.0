Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:33702 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbCTDJr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 23:09:47 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 20 Mar 2015 13:09:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0078F2BB0052
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:09:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2K39aR333685566
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:09:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2K39AqG003513
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 14:09:11 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V14 04/21] PCI: Print PF SR-IOV resource that contains all VF(n) BAR space
Date: Fri, 20 Mar 2015 11:06:20 +0800
Message-Id: <1426820797-6267-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

