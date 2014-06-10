Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:35768 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933917AbaFJB5Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jun 2014 21:57:25 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Jun 2014 11:57:22 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 65F6B3578048
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 11:57:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5A1fGTv21102680
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 11:41:16 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5A1vJCI000766
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 11:57:19 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [RFC PATCH V3 16/17] ppc/pci: Expanding IOV BAR, with m64_per_iov supported
Date: Tue, 10 Jun 2014 09:56:38 +0800
Message-Id: <1402365399-5121-17-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

M64 aperture size is limited on PHB3. When the IOV BAR is too big, this will
exceed the limitation and failed to be assigned.

This patch introduce a different expanding based on the IOV BAR size:

IOV BAR size is smaller than 64M, expand to total_pe.
IOV BAR size is bigger than 64M, roundup power2.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    2 ++
 arch/powerpc/platforms/powernv/pci-ioda.c |   28 ++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 72f0af5..36b88e4 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -171,6 +171,8 @@ struct pci_dn {
 #ifdef CONFIG_PCI_IOV
 	u16     vfs;
 	int     offset;
+#define M64_PER_IOV 4
+	int     m64_per_iov;
 	int     m64_wins[PCI_SRIOV_NUM_BARS];
 #endif /* CONFIG_PCI_IOV */
 #endif
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fb2c2c6..98fc163 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1756,6 +1756,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	int i;
 	resource_size_t size;
 	struct pci_dn *pdn;
+	int mul, total_vfs;
 
 	if (!pdev->is_physfn || pdev->is_added)
 		return;
@@ -1775,6 +1776,10 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	pdn = pci_get_pdn(pdev);
 	pdn->vfs = 0;
 
+	total_vfs = pci_sriov_get_totalvfs(pdev);
+	pdn->m64_per_iov = 1;
+	mul = phb->ioda.total_pe;
+
 	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
 		res = &pdev->resource[i];
 		if (!res->flags || res->parent)
@@ -1783,13 +1788,32 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 		if (!is_mem_pref_64_type(res->flags))
 			continue;
 
+		size = pci_sriov_resource_size(pdev, i);
+
+		/* bigger than 64M */
+		if (size > (1 << 26)) {
+			dev_info(&pdev->dev, "PowerNV: VF BAR[%d] size "
+					"is bigger than 64M, roundup power2\n", i);
+			pdn->m64_per_iov = M64_PER_IOV;
+			mul = __roundup_pow_of_two(total_vfs);
+			break;
+		}
+	}
+
+	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+		res = &pdev->resource[i];
+		if (!res->flags || res->parent)
+			continue;
+		if (!is_mem_pref_64_type(res->flags))
+			continue;
+
 		dev_info(&pdev->dev, "PowerNV: Fixing VF BAR[%d] %pR to\n",
 				i, res);
 		size = pci_sriov_resource_size(pdev, i);
-		res->end = res->start + size * phb->ioda.total_pe - 1;
+		res->end = res->start + size * mul - 1;
 		dev_info(&pdev->dev, "                       %pR\n", res);
 	}
-	pdn->vfs = phb->ioda.total_pe;
+	pdn->vfs = mul;
 }
 
 static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
-- 
1.7.9.5

