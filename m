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
Subject: [PATCH v11 07/10] iommu/vt-d: enable kdump support in iommu module
Date: Mon, 11 May 2015 17:52:51 +0800
Message-Id: <1431337974-545-8-git-send-email-zhen-hual@hp.com>
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Modify the operation of the following functions when called during crash dump:
    iommu_context_addr
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
 drivers/iommu/intel-iommu.c | 95 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 83 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 28c3c64..91545bf 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -397,6 +397,7 @@ static int copy_root_entry_table(struct intel_iommu *iommu);
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
 
 static void iommu_check_pre_te_status(struct intel_iommu *iommu);
+static u8 g_translation_pre_enabled;
 
 /*
  * This domain is a statically identity mapping domain.
@@ -794,6 +795,9 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 		phy_addr = virt_to_phys((void *)context);
 		*entry = phy_addr | 1;
 		__iommu_flush_cache(iommu, entry, sizeof(*entry));
+
+		if (iommu->pre_enabled_trans)
+			__iommu_update_old_root_entry(iommu, bus);
 	}
 	return &context[devfn];
 }
@@ -887,13 +891,15 @@ static void clear_context_table(struct intel_iommu *iommu, u8 bus, u8 devfn)
 
 static void free_context_table(struct intel_iommu *iommu)
 {
+	struct root_entry *root = NULL;
 	int i;
 	unsigned long flags;
 	struct context_entry *context;
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	if (!iommu->root_entry) {
-		goto out;
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		return;
 	}
 	for (i = 0; i < ROOT_ENTRY_NR; i++) {
 		context = iommu_context_addr(iommu, i, 0, 0);
@@ -908,10 +914,23 @@ static void free_context_table(struct intel_iommu *iommu)
 			free_pgtable_page(context);
 
 	}
+
+	if (iommu->pre_enabled_trans) {
+		iommu->root_entry_old_phys = 0;
+		root = iommu->root_entry_old_virt;
+		iommu->root_entry_old_virt = NULL;
+	}
+
 	free_pgtable_page(iommu->root_entry);
 	iommu->root_entry = NULL;
-out:
+
 	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	/* We put this out of spin_unlock is because iounmap() may
+	 * cause error if surrounded by spin_lock and unlock;
+	 */
+	if (iommu->pre_enabled_trans)
+		iounmap(root);
 }
 
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
@@ -2333,6 +2352,7 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	unsigned long flags;
 	u8 bus, devfn;
 	int did = -1;   /* Default to "no domain_id supplied" */
+	struct context_entry *ce = NULL;
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2366,6 +2386,20 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
+
+	if (iommu->pre_enabled_trans) {
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
+
 	domain->id = iommu_attach_domain_with_id(domain, iommu, did);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
@@ -2897,6 +2931,7 @@ static int __init init_dmars(void)
 		goto free_g_iommus;
 	}
 
+	g_translation_pre_enabled = 0; /* To know whether to skip RMRR */
 	for_each_active_iommu(iommu, drhd) {
 		g_iommus[iommu->seq_id] = iommu;
 
@@ -2904,14 +2939,30 @@ static int __init init_dmars(void)
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
+		iommu_check_pre_te_status(iommu);
+		if (iommu->pre_enabled_trans) {
+			pr_info("IOMMU Copying translate tables from panicked kernel\n");
+			ret = intel_iommu_load_translation_tables(iommu);
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
+			/*
+			 * TBD:
+			 * we could share the same root & context tables
+			 * among all IOMMU's. Need to Split it later.
+			 */
+			ret = iommu_alloc_root_entry(iommu);
+			if (ret)
+				goto free_iommu;
+		}
+
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
 	}
@@ -2929,6 +2980,14 @@ static int __init init_dmars(void)
 	check_tylersburg_isoch();
 
 	/*
+	 * In the second kernel: Skip setting-up new domains for
+	 * si, rmrr, and the isa bus on the expectation that these
+	 * translations were copied from the old kernel.
+	 */
+	if (g_translation_pre_enabled)
+		goto skip_new_domains_for_si_rmrr_isa;
+
+	/*
 	 * If pass through is not set or not enabled, setup context entries for
 	 * identity mappings for rmrr, gfx, and isa and may fall back to static
 	 * identity mapping if iommu_identity_mapping is set.
@@ -2968,6 +3027,8 @@ static int __init init_dmars(void)
 
 	iommu_prepare_isa();
 
+skip_new_domains_for_si_rmrr_isa:;
+
 	/*
 	 * for each drhd
 	 *   enable fault log
@@ -2996,7 +3057,13 @@ static int __init init_dmars(void)
 
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
-		iommu_enable_translation(iommu);
+
+		if (iommu->pre_enabled_trans) {
+			if (!(iommu->gcmd & DMA_GCMD_TE))
+				iommu_enable_translation(iommu);
+		} else
+			iommu_enable_translation(iommu);
+
 		iommu_disable_protect_mem_regions(iommu);
 	}
 
@@ -4282,11 +4349,14 @@ int __init intel_iommu_init(void)
 	}
 
 	/*
-	 * Disable translation if already enabled prior to OS handover.
+	 * We do not need to disable translation if already enabled prior
+	 * to OS handover. Because we will try to copy old tables;
 	 */
+	/*
 	for_each_active_iommu(iommu, drhd)
 		if (iommu->gcmd & DMA_GCMD_TE)
 			iommu_disable_translation(iommu);
+	*/
 
 	if (dmar_dev_scope_init() < 0) {
 		if (force_on)
@@ -5106,5 +5176,6 @@ static void iommu_check_pre_te_status(struct intel_iommu *iommu)
 	if (sts & DMA_GSTS_TES) {
 		pr_info("Translation is enabled prior to OS.\n");
 		iommu->pre_enabled_trans = 1;
+		g_translation_pre_enabled = 1;
 	}
 }
-- 
2.0.0-rc0

