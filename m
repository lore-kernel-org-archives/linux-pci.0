Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:49797 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaKBPl5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Nov 2014 10:41:57 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 3 Nov 2014 01:41:56 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8AFFF2CE8040
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2014 02:41:53 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sA2Fho9L31654000
	for <linux-pci@vger.kernel.org>; Mon, 3 Nov 2014 02:43:50 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sA2FfqR0028121
	for <linux-pci@vger.kernel.org>; Mon, 3 Nov 2014 02:41:53 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 06/18] powerpc/pci: Don't unset pci resources for VFs
Date: Sun,  2 Nov 2014 23:41:22 +0800
Message-Id: <1414942894-17034-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
resources will be cleaned out during device header fixup time and then get
reassigned by PCI core. However, the VF resources won't be reassigned and
thus, we shouldn't clean them out.

This patch adds a condition. If the pci_dev is a VF, skip the resource
unset process.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index e5dad9a..399d813 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -789,6 +789,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 		       pci_name(dev));
 		return;
 	}
+
+	if (dev->is_virtfn)
+		return;
+
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		struct resource *res = dev->resource + i;
 		struct pci_bus_region reg;
-- 
1.7.9.5

