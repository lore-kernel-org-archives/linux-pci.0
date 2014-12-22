Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46236 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbaLVFzM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 00:55:12 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 22 Dec 2014 15:55:11 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id B2A8A2CE8050
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:55:09 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBM5t74c36831330
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:55:07 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBM5t83a021104
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 16:55:09 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V10 14/17] powerpc/powernv: Shift VF resource with an offset
Date: Mon, 22 Dec 2014 13:54:34 +0800
Message-Id: <1419227677-12312-15-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On PowrNV platform, resource position in M64 implies the PE# the resource
belongs to. In some particular case, adjustment of a resource is necessary to
locate it to a correct position in M64.

This patch introduces a function to shift the 'real' PF IOV BAR address
according to an offset.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 512dc48..f5aa1ef 100644
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
@@ -749,6 +750,36 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
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
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+		res = &dev->resource[i];
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!pnv_pci_is_mem_pref_64(res->flags))
+			continue;
+
+		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
+		size = pci_iov_resource_size(dev, i);
+		res->start += size*offset;
+
+		dev_info(&dev->dev, "                 %pR\n", res);
+		pci_update_resource(dev, i);
+	}
+	pdn->max_vfs -= offset;
+}
+#endif /* CONFIG_PCI_IOV */
+
 #if 0
 static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
-- 
1.7.9.5

