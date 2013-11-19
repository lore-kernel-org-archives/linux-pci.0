Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:55665
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858Ab3KSFYG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 00:24:06 -0500
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <agraf@suse.de>, <scottwood@freescale.com>,
	<stuart.yoder@freescale.com>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Bharat Bhushan <Bharat.Bhushan@freescale.com>,
	Bharat Bhushan <bharat.bhushan@freescale.com>
Subject: [PATCH 6/9 v2] powerpc: pci: Extend msi iova page setup to arch specific
Date: Tue, 19 Nov 2013 10:47:10 +0530
Message-ID: <1384838233-24847-7-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch extend the interface to arch specific code for setting
msi iova address for a msi page. Machine specific code is not yet
implemented.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v2
 - new patch

 arch/powerpc/include/asm/machdep.h |    2 ++
 arch/powerpc/kernel/msi.c          |   10 ++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 8d1b787..e87b806 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -132,6 +132,8 @@ struct machdep_calls {
 	/* Returns the requested region's address and size */
 	int		(*msi_get_region)(int region_num,
 					  struct msi_region *region);
+	int		(*msi_set_iova)(struct pci_dev *pdev, int region_num,
+					dma_addr_t iova, bool set);
 #endif
 
 	void		(*restart)(char *cmd);
diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 1a67787..e2bd555 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,6 +13,16 @@
 
 #include <asm/machdep.h>
 
+int arch_msi_set_iova(struct pci_dev *pdev, int region_num,
+		      dma_addr_t iova, bool set)
+{
+	if (ppc_md.msi_set_iova) {
+		pr_debug("msi: Using platform get_region_count routine.\n");
+		return ppc_md.msi_set_iova(pdev, region_num, iova, set);
+	}
+	return 0;
+}
+
 int arch_msi_get_region_count(void)
 {
 	if (ppc_md.msi_get_region_count) {
-- 
1.7.0.4


