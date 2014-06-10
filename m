Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:35472 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933389AbaFJB5A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jun 2014 21:57:00 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Jun 2014 07:26:58 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0B0A4E004B
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5A1vlLP60555296
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5A1utXb008952
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:26:56 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [RFC PATCH V3 03/17] ppc/pci: don't unset pci resources for VFs
Date: Tue, 10 Jun 2014 09:56:25 +0800
Message-Id: <1402365399-5121-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When the PCI_REASSIGN_ALL_RSRC is set, each resource for a pci_dev will be
unset. which means the pci core will reassign those resources.

While this behavior will clean up the resources information for VFs, whose
value is calculated in virtfn_add.

This patch adds a condition. If the pci_dev is a VF, skip the resource
unset process.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d9476c1..c449a26 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -824,6 +824,12 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
 		       pci_name(dev));
 		return;
 	}
+
+#ifdef CONFIG_PCI_IOV
+	if (dev->is_virtfn)
+		return;
+#endif
+
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		struct resource *res = dev->resource + i;
 		struct pci_bus_region reg;
-- 
1.7.9.5

