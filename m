Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:52470 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758713AbaGXGWz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 02:22:55 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 24 Jul 2014 11:52:52 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 398DD125805B
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:52:43 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6O6OdBq36110408
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:54:39 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6O6Ml44010785
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 11:52:48 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 09/17] powerpc/powernv: mark IOV BAR with IORESOURCE_ARCH
Date: Thu, 24 Jul 2014 14:22:19 +0800
Message-Id: <1406182947-11302-10-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On powernv platform, the IOV BAR size will be adjusted to meet the alignment
requirement from hardware. This leads to the VF resource size need to be
retrieved from hardware directly.

This patch adds this flag for IOV BAR on powernv platform.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b97aa79..cc7c9a6 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/msi.h>
 #include <linux/iommu.h>
+#include <uapi/linux/pci_regs.h>
 
 #include <asm/sections.h>
 #include <asm/io.h>
@@ -876,3 +877,20 @@ static int __init tce_iommu_bus_notifier_init(void)
 }
 
 subsys_initcall_sync(tce_iommu_bus_notifier_init);
+
+static void pnv_sriov_final_fixup(struct pci_dev *dev)
+{
+	struct resource *res;
+	int i;
+
+	if (!dev->is_physfn)
+		return;
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = dev->resource + PCI_IOV_RESOURCES + i;
+		if (!res->flags)
+			continue;
+		res->flags |= IORESOURCE_ARCH;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_sriov_final_fixup);
-- 
1.7.9.5

