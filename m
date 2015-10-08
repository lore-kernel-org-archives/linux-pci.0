Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27363 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbbJHVj6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 17:39:58 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
Date: Thu,  8 Oct 2015 14:38:22 -0700
Message-Id: <1444340359-8011-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We register regions for legacy and iommu and all have open code.

Unify them to pci_register_region() and call it accordingly.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/sparc/kernel/pci_common.c | 83 +++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 28e976a..c4b6989 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -328,41 +328,49 @@ void pci_get_pbm_props(struct pci_pbm_info *pbm)
 	}
 }
 
-static void pci_register_legacy_regions(struct resource *io_res,
-					struct resource *mem_res)
+static void pci_register_region(struct pci_pbm_info *pbm, const char *name,
+				resource_size_t rstart, resource_size_t size)
 {
-	struct resource *p;
+	struct resource *res, *conflict;
+	struct resource *mem_res = &pbm->mem_space;
+	resource_size_t offset = pbm->mem_offset;
+	resource_size_t mem_rstart, mem_rend;
+	resource_size_t rend = rstart + size - 1UL;
 
-	/* VGA Video RAM. */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	if (!mem_res->flags)
 		return;
 
-	p->name = "Video RAM area";
-	p->start = mem_res->start + 0xa0000UL;
-	p->end = p->start + 0x1ffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
+	mem_rstart = mem_res->start - offset;
+	mem_rend = mem_res->end - offset;
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	/* contain checking */
+	if (!(mem_rstart <= rstart && mem_rend >= rend))
 		return;
 
-	p->name = "System ROM";
-	p->start = mem_res->start + 0xf0000UL;
-	p->end = p->start + 0xffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
 		return;
 
-	p->name = "Video ROM";
-	p->start = mem_res->start + 0xc0000UL;
-	p->end = p->start + 0x7fffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
+	res->name = name;
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	res->start = rstart + offset;
+	res->end = rend + offset;
+	conflict = request_resource_conflict(mem_res, res);
+	if (conflict) {
+		printk(KERN_DEBUG "PCI: %s can't claim %s %pR: address conflict with %s %pR\n",
+			pbm->name, res->name, res, conflict->name, conflict);
+		kfree(res);
+	}
+}
+
+static void pci_register_legacy_regions(struct pci_pbm_info *pbm)
+{
+	/* VGA Video RAM. */
+	pci_register_region(pbm, "Video RAM area", 0xa0000UL, 0x20000UL);
+
+	pci_register_region(pbm, "System ROM",     0xf0000UL, 0x10000UL);
+
+	pci_register_region(pbm, "Video ROM",      0xc0000UL,  0x8000UL);
 }
 
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)
@@ -370,24 +378,8 @@ static void pci_register_iommu_region(struct pci_pbm_info *pbm)
 	const u32 *vdma = of_get_property(pbm->op->dev.of_node, "virtual-dma",
 					  NULL);
 
-	if (vdma) {
-		struct resource *rp = kzalloc(sizeof(*rp), GFP_KERNEL);
-
-		if (!rp) {
-			pr_info("%s: Cannot allocate IOMMU resource.\n",
-				pbm->name);
-			return;
-		}
-		rp->name = "IOMMU";
-		rp->start = pbm->mem_space.start + (unsigned long) vdma[0];
-		rp->end = rp->start + (unsigned long) vdma[1] - 1UL;
-		rp->flags = IORESOURCE_BUSY;
-		if (request_resource(&pbm->mem_space, rp)) {
-			pr_info("%s: Unable to request IOMMU resource.\n",
-				pbm->name);
-			kfree(rp);
-		}
-	}
+	if (vdma)
+		pci_register_region(pbm, "IOMMU", vdma[0], vdma[1]);
 }
 
 void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
@@ -506,8 +498,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	if (pbm->mem64_space.flags)
 		request_resource(&iomem_resource, &pbm->mem64_space);
 
-	pci_register_legacy_regions(&pbm->io_space,
-				    &pbm->mem_space);
+	pci_register_legacy_regions(pbm);
 	pci_register_iommu_region(pbm);
 }
 
-- 
1.8.4.5

