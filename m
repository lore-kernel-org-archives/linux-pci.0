Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:55397 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758699AbaGXGWu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 02:22:50 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 24 Jul 2014 11:52:47 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3B5B1E004B
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:54:26 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6O6OZpA25624576
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:54:35 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6O6MgcG031628
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:52:44 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 05/17] powerpc/pci: Don't unset pci resources for VFs
Date: Thu, 24 Jul 2014 14:22:15 +0800
Message-Id: <1406182947-11302-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
index b49c72f..ee70f57 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -794,6 +794,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
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

