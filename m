Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
To: <dwmw2@infradead.org>, <indou.takao@jp.fujitsu.com>,
	<bhe@redhat.com>, <joro@8bytes.org>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>
Cc: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
	<alex.williamson@redhat.com>, <ddutile@redhat.com>,
	<ishii.hironobu@jp.fujitsu.com>, <bhelgaas@google.com>,
	<doug.hatch@hp.com>, <jerry.hoemann@hp.com>, <tom.vaden@hp.com>,
	<li.zhang6@hp.com>, <lisa.mitchell@hp.com>,
	<billsumnerlinux@gmail.com>, <zhen-hual@hp.com>, <rwright@hp.com>
Subject: [PATCH v9 07/10] iommu/vt-d: enable kdump support in iommu module
Date: Thu, 19 Mar 2015 13:36:25 +0800
Message-Id: <1426743388-26908-8-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Modify the operation of the following functions when called during crash dump:
    device_to_context_entry
    free_context_table
    get_domain_for_dev
    init_dmars
    intel_iommu_init

Bill Sumner:
    Original version.

Zhenhua:
    The name of new calling functions.
    Do not disable and re-enable TE in kdump kernel.
    Use the did and gaw from old context entry;

Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/intel-iommu.c | 118 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 103 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 44f3369..312f06b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -841,6 +841,11 @@ static struct context_entry * device_to_context_entry(struct intel_iommu *iommu,
 		set_root_value(root, phy_addr);
 		set_root_present(root);
 		__iommu_flush_cache(iommu, root, sizeof(*root));
+
+#ifdef CONFIG_CRASH_DUMP
+		if (is_kdump_kernel())
+			__iommu_update_old_root_entry(iommu, bus);
+#endif
 	}
 	spin_unlock_irqrestore(&iommu->lock, flags);
 	return &context[devfn];
@@ -892,7 +897,8 @@ static void free_context_table(struct intel_iommu *iommu)
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	if (!iommu->root_entry) {
-		goto out;
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		return;
 	}
 	for (i = 0; i < ROOT_ENTRY_NR; i++) {
 		root = &iommu->root_entry[i];
@@ -900,10 +906,23 @@ static void free_context_table(struct intel_iommu *iommu)
 		if (context)
 			free_pgtable_page(context);
 	}
+
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel()) {
+		iommu->root_entry_old_phys = 0;
+		root = iommu->root_entry_old_virt;
+		iommu->root_entry_old_virt = NULL;
+	}
+#endif
 	free_pgtable_page(iommu->root_entry);
 	iommu->root_entry = NULL;
-out:
+
 	spin_unlock_irqrestore(&iommu->lock, flags);
+
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel())
+		iounmap(root);
+#endif
 }
 
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
@@ -2322,6 +2341,9 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	unsigned long flags;
 	u8 bus, devfn;
 	int did = -1;   /* Default to "no domain_id supplied" */
+#ifdef CONFIG_CRASH_DUMP
+	struct context_entry *ce = NULL;
+#endif /* CONFIG_CRASH_DUMP */
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2355,6 +2377,22 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
+
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel()) {
+		/*
+		 * if this device had a did in the old kernel
+		 * use its values instead of generating new ones
+		 */
+		ce = device_to_existing_context_entry(iommu, bus, devfn);
+
+		if (ce) {
+			did = context_domain_id(ce);
+			gaw = agaw_to_width(context_address_width(ce));
+		}
+	}
+#endif /* CONFIG_CRASH_DUMP */
+
 	domain->id = iommu_attach_domain_with_id(domain, iommu, did);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
@@ -2889,14 +2927,33 @@ static int __init init_dmars(void)
 		if (ret)
 			goto free_iommu;
 
-		/*
-		 * TBD:
-		 * we could share the same root & context tables
-		 * among all IOMMU's. Need to Split it later.
-		 */
-		ret = iommu_alloc_root_entry(iommu);
-		if (ret)
-			goto free_iommu;
+#ifdef CONFIG_CRASH_DUMP
+		if (is_kdump_kernel()) {
+			pr_info("IOMMU Copying translate tables from panicked kernel\n");
+			ret = intel_iommu_load_translation_tables(drhd);
+			if (ret) {
+				pr_err("IOMMU: Copy translate tables failed\n");
+
+				/* Best to stop trying */
+				goto free_iommu;
+			}
+			pr_info("IOMMU: root_cache:0x%12.12llx phys:0x%12.12llx\n",
+				(u64)iommu->root_entry,
+				(u64)iommu->root_entry_old_phys);
+		} else {
+#endif /* CONFIG_CRASH_DUMP */
+			/*
+			 * TBD:
+			 * we could share the same root & context tables
+			 * among all IOMMU's. Need to Split it later.
+			 */
+			ret = iommu_alloc_root_entry(iommu);
+			if (ret)
+				goto free_iommu;
+#ifdef CONFIG_CRASH_DUMP
+		}
+#endif
+
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
 	}
@@ -2913,6 +2970,16 @@ static int __init init_dmars(void)
 
 	check_tylersburg_isoch();
 
+#ifdef CONFIG_CRASH_DUMP
+	/*
+	 * In the crashdump kernel: Skip setting-up new domains for
+	 * si, rmrr, and the isa bus on the expectation that these
+	 * translations were copied from the old kernel.
+	 */
+	if (is_kdump_kernel())
+		goto skip_new_domains_for_si_rmrr_isa;
+#endif /* CONFIG_CRASH_DUMP */
+
 	/*
 	 * If pass through is not set or not enabled, setup context entries for
 	 * identity mappings for rmrr, gfx, and isa and may fall back to static
@@ -2953,6 +3020,10 @@ static int __init init_dmars(void)
 
 	iommu_prepare_isa();
 
+#ifdef CONFIG_CRASH_DUMP
+skip_new_domains_for_si_rmrr_isa:;
+#endif /* CONFIG_CRASH_DUMP */
+
 	/*
 	 * for each drhd
 	 *   enable fault log
@@ -2981,7 +3052,15 @@ static int __init init_dmars(void)
 
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
-		iommu_enable_translation(iommu);
+
+#ifdef CONFIG_CRASH_DUMP
+		if (is_kdump_kernel()) {
+			if (!(iommu->gcmd & DMA_GCMD_TE))
+				iommu_enable_translation(iommu);
+		} else
+#endif
+			iommu_enable_translation(iommu);
+
 		iommu_disable_protect_mem_regions(iommu);
 	}
 
@@ -4266,12 +4345,21 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
 
+#ifdef CONFIG_CRASH_DUMP
 	/*
-	 * Disable translation if already enabled prior to OS handover.
+	 * If (This is the crash kernel)
+	 *    Skip disabling the iommu hardware translations
 	 */
-	for_each_active_iommu(iommu, drhd)
-		if (iommu->gcmd & DMA_GCMD_TE)
-			iommu_disable_translation(iommu);
+	if (is_kdump_kernel()) {
+		pr_info("IOMMU Skip disabling iommu hardware translations\n");
+	} else
+#endif /* CONFIG_CRASH_DUMP */
+		/*
+		 * Disable translation if already enabled prior to OS handover.
+		 */
+		for_each_active_iommu(iommu, drhd)
+			if (iommu->gcmd & DMA_GCMD_TE)
+				iommu_disable_translation(iommu);
 
 	if (dmar_dev_scope_init() < 0) {
 		if (force_on)
-- 
2.0.0-rc0

