Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:38358 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758699AbaGXGW6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 02:22:58 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 24 Jul 2014 16:22:51 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 65A2B2CE8056
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6O6Mdrf11993562
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:39 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6O6MsnD031402
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:55 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 14/17] powerpc/powernv: Shift VF resource with an offset
Date: Thu, 24 Jul 2014 14:22:24 +0800
Message-Id: <1406182947-11302-15-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On powrnv platform, resource position in M64 implies the PE# the resource
belongs to. In some particular case, adjustment of a resource is necessary to
locate it to a correct position in M64.

This patch introduce a function to shift the 'real' VF BAR address according to
an offset.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3aeb87b..18e2917 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/crash_dump.h>
+#include <linux/pci_regs.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/string.h>
@@ -730,6 +731,36 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 	return 10;
 }
 
+#ifdef CONFIG_PCI_IOV
+static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
+{
+	struct pci_dn *pdn = pci_get_pdn(dev);
+	int i;
+	struct resource *res;
+	resource_size_t size;
+
+	if (!dev->is_physfn)
+		return;
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = dev->resource + PCI_IOV_RESOURCES + i;
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!pnv_pci_is_mem_pref_64(res->flags))
+			continue;
+
+		dev_info(&dev->dev, "PowerNV: Shifting VF BAR %pR to\n", res);
+		size = pnv_pci_sriov_resource_size(dev, PCI_IOV_RESOURCES + i);
+		res->start += size*offset;
+
+		dev_info(&dev->dev, "                         %pR\n", res);
+		pci_update_resource(dev, PCI_IOV_RESOURCES + i);
+	}
+	pdn->vfs -= offset;
+}
+#endif /* CONFIG_PCI_IOV */
+
 #if 0
 static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
-- 
1.7.9.5

