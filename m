Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59232 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423047AbbFEOLW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:22 -0400
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Cc: zhen-hual@hp.com, bhe@redhat.com, dwmw2@infradead.org,
	vgoyal@redhat.com, dyoung@redhat.com, alex.williamson@redhat.com,
	ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com,
	indou.takao@jp.fujitsu.com, bhelgaas@google.com, doug.hatch@hp.com,
	jerry.hoemann@hp.com, tom.vaden@hp.com, li.zhang6@hp.com,
	lisa.mitchell@hp.com, billsumnerlinux@gmail.com, rwright@hp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, joro@8bytes.org, jroedel@suse.de
Subject: [PATCH 15/17] iommu/vt-d: Mark irt entries from old kernel as allocated
Date: Fri,  5 Jun 2015 16:11:01 +0200
Message-Id: <1433513463-19128-16-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

After we copied over all irq remapping entries from the old
kernel we need to mark the present entries as allocated in
our table too. Otherwise we might overwrite entries from the
previous kernel and cause DMAR faults.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel_irq_remapping.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index fd6c25b..f7b02ca 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1300,6 +1300,7 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 {
 	struct irte *old_ir_table;
 	phys_addr_t irt_phys;
+	unsigned int i;
 	size_t size;
 	u64 irta;
 
@@ -1325,6 +1326,15 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 	iommu->ir_table->base_old_phys = irt_phys;
 	iommu->ir_table->base_old_virt = old_ir_table;
 
+	/*
+	 * Now check the table for used entries and mark those as
+	 * allocated in the bitmap
+	 */
+	for (i = 0; i < INTR_REMAP_TABLE_ENTRIES; i++) {
+		if (iommu->ir_table->base[i].present)
+			bitmap_set(iommu->ir_table->bitmap, i, 1);
+	}
+
 	return 0;
 }
 
-- 
1.9.1

