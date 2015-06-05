Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59218 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423043AbbFEOLT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Jun 2015 10:11:19 -0400
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
Subject: [PATCH 09/17] iommu/vt-d: Clean up log messages in intel-iommu.c
Date: Fri,  5 Jun 2015 16:10:55 +0200
Message-Id: <1433513463-19128-10-git-send-email-joro@8bytes.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Give them a common prefix and fix some message spellings.
Also make the meaning of some messages more clear.

Tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/dmar.c                | 26 ++++++++++-----------
 drivers/iommu/intel-iommu.c         | 46 ++++++++++++++++++-------------------
 drivers/iommu/intel_irq_remapping.c | 22 ++++++++++--------
 3 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9847613..a2f50c5 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -26,7 +26,7 @@
  * These routines are used by both DMA-remapping and Interrupt-remapping
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt /* has to precede printk.h */
+#define pr_fmt(fmt) "DMAR: " fmt /* has to precede printk.h */
 
 #include <linux/pci.h>
 #include <linux/dmar.h>
@@ -555,7 +555,7 @@ static int dmar_walk_remapping_entries(struct acpi_dmar_header *start,
 			break;
 		} else if (next > end) {
 			/* Avoid passing table end */
-			pr_warn(FW_BUG "record passes table end\n");
+			pr_warn(FW_BUG "Record passes table end\n");
 			ret = -EINVAL;
 			break;
 		}
@@ -623,7 +623,7 @@ parse_dmar_table(void)
 		return -ENODEV;
 
 	if (dmar->width < PAGE_SHIFT - 1) {
-		pr_warn("Invalid DMAR haw\n");
+		pr_warn("Invalid DMAR host address width\n");
 		return -EINVAL;
 	}
 
@@ -802,7 +802,7 @@ int __init dmar_table_init(void)
 		ret = parse_dmar_table();
 		if (ret < 0) {
 			if (ret != -ENODEV)
-				pr_info("parse DMAR table failure.\n");
+				pr_info("DMAR table parse failure.\n");
 		} else  if (list_empty(&dmar_drhd_units)) {
 			pr_info("No DMAR devices found\n");
 			ret = -ENODEV;
@@ -847,7 +847,7 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 	else
 		addr = early_ioremap(drhd->address, VTD_PAGE_SIZE);
 	if (!addr) {
-		pr_warn("IOMMU: can't validate: %llx\n", drhd->address);
+		pr_warn("Can't validate DRHD address: %llx\n", drhd->address);
 		return -EINVAL;
 	}
 
@@ -921,14 +921,14 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 	iommu->reg_size = VTD_PAGE_SIZE;
 
 	if (!request_mem_region(iommu->reg_phys, iommu->reg_size, iommu->name)) {
-		pr_err("IOMMU: can't reserve memory\n");
+		pr_err("Can't reserve MMIO register region\n");
 		err = -EBUSY;
 		goto out;
 	}
 
 	iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
 	if (!iommu->reg) {
-		pr_err("IOMMU: can't map the region\n");
+		pr_err("Can't map MMIO registers\n");
 		err = -ENOMEM;
 		goto release;
 	}
@@ -952,13 +952,13 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 		iommu->reg_size = map_size;
 		if (!request_mem_region(iommu->reg_phys, iommu->reg_size,
 					iommu->name)) {
-			pr_err("IOMMU: can't reserve memory\n");
+			pr_err("Can't reserve MMIO register region\n");
 			err = -EBUSY;
 			goto out;
 		}
 		iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
 		if (!iommu->reg) {
-			pr_err("IOMMU: can't map the region\n");
+			pr_err("Can't map MMIO registers\n");
 			err = -ENOMEM;
 			goto release;
 		}
@@ -1014,14 +1014,14 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		return -ENOMEM;
 
 	if (dmar_alloc_seq_id(iommu) < 0) {
-		pr_err("IOMMU: failed to allocate seq_id\n");
+		pr_err("Failed to allocate seq_id\n");
 		err = -ENOSPC;
 		goto error;
 	}
 
 	err = map_iommu(iommu, drhd->reg_base_addr);
 	if (err) {
-		pr_err("IOMMU: failed to map %s\n", iommu->name);
+		pr_err("Failed to map %s\n", iommu->name);
 		goto error_free_seq_id;
 	}
 
@@ -1644,7 +1644,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 
 	irq = dmar_alloc_hwirq();
 	if (irq <= 0) {
-		pr_err("IOMMU: no free vectors\n");
+		pr_err("No free irq vectors\n");
 		return -EINVAL;
 	}
 
@@ -1661,7 +1661,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 
 	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
 	if (ret)
-		pr_err("IOMMU: can't request irq\n");
+		pr_err("Can't request irq\n");
 	return ret;
 }
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 82239e3..49065a9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -17,6 +17,8 @@
  *          Fenghua Yu <fenghua.yu@intel.com>
  */
 
+#define pr_fmt(fmt)	"DMAR: " fmt
+
 #include <linux/init.h>
 #include <linux/bitmap.h>
 #include <linux/debugfs.h>
@@ -1214,8 +1216,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 
 	root = (struct root_entry *)alloc_pgtable_page(iommu->node);
 	if (!root) {
-		pr_err("IOMMU: allocating root entry for %s failed\n",
-			iommu->name);
+		pr_err("allocating root entry for %s failed\n", iommu->name);
 		return -ENOMEM;
 	}
 
@@ -1352,9 +1353,9 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 
 	/* check IOTLB invalidation granularity */
 	if (DMA_TLB_IAIG(val) == 0)
-		printk(KERN_ERR"IOMMU: flush IOTLB failed\n");
+		pr_err("flush IOTLB failed\n");
 	if (DMA_TLB_IAIG(val) != DMA_TLB_IIRG(type))
-		pr_debug("IOMMU: tlb flush request %Lx, actual %Lx\n",
+		pr_debug("tlb flush request %Lx, actual %Lx\n",
 			(unsigned long long)DMA_TLB_IIRG(type),
 			(unsigned long long)DMA_TLB_IAIG(val));
 }
@@ -1525,7 +1526,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	unsigned long nlongs;
 
 	ndomains = cap_ndoms(iommu->cap);
-	pr_debug("IOMMU%d: Number of Domains supported <%ld>\n",
+	pr_debug("Number of Domains supported iommu[%d] <%ld>\n",
 		 iommu->seq_id, ndomains);
 	nlongs = BITS_TO_LONGS(ndomains);
 
@@ -1536,14 +1537,14 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 */
 	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
 	if (!iommu->domain_ids) {
-		pr_err("IOMMU%d: allocating domain id array failed\n",
+		pr_err("Allocating domain id array for iommu[%d] failed\n",
 		       iommu->seq_id);
 		return -ENOMEM;
 	}
 	iommu->domains = kcalloc(ndomains, sizeof(struct dmar_domain *),
 			GFP_KERNEL);
 	if (!iommu->domains) {
-		pr_err("IOMMU%d: allocating domain array failed\n",
+		pr_err("Allocating domain array for iommu[%d] failed\n",
 		       iommu->seq_id);
 		kfree(iommu->domain_ids);
 		iommu->domain_ids = NULL;
@@ -1649,7 +1650,7 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 	num = __iommu_attach_domain(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (num < 0)
-		pr_err("IOMMU: no free domain ids\n");
+		pr_err("No free domain ids\n");
 
 	return num;
 }
@@ -1814,7 +1815,7 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 	sagaw = cap_sagaw(iommu->cap);
 	if (!test_bit(agaw, &sagaw)) {
 		/* hardware doesn't support it, choose a bigger one */
-		pr_debug("IOMMU: hardware doesn't support agaw %d\n", agaw);
+		pr_debug("Hardware doesn't support agaw %d\n", agaw);
 		agaw = find_next_bit(&sagaw, 5, agaw);
 		if (agaw >= 5)
 			return -ENODEV;
@@ -1890,7 +1891,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct device_domain_info *info = NULL;
 
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
-		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		 bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
 	BUG_ON(!domain->pgd);
 	BUG_ON(translation != CONTEXT_TT_PASS_THROUGH &&
@@ -1915,7 +1916,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			id = iommu_attach_vm_domain(domain, iommu);
 			if (id < 0) {
 				spin_unlock_irqrestore(&iommu->lock, flags);
-				pr_err("IOMMU: no free domain ids\n");
+				pr_err("No free domain ids\n");
 				return -EFAULT;
 			}
 		}
@@ -2564,7 +2565,7 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 	}
 
-	pr_debug("IOMMU: identity mapping domain is domain %d\n",
+	pr_debug("Identity mapping domain is domain %d\n",
 		 si_domain->id);
 
 	if (hw)
@@ -2764,7 +2765,7 @@ static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw
 				  hw ? CONTEXT_TT_PASS_THROUGH :
 				       CONTEXT_TT_MULTI_LEVEL);
 	if (!ret)
-		pr_info("IOMMU: %s identity mapping for device %s\n",
+		pr_info("%s identity mapping for device %s\n",
 			hw ? "hardware" : "software", dev_name(dev));
 	else if (ret == -ENODEV)
 		/* device not associated with an iommu */
@@ -2842,12 +2843,11 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 		 */
 		iommu->flush.flush_context = __iommu_flush_context;
 		iommu->flush.flush_iotlb = __iommu_flush_iotlb;
-		pr_info("IOMMU: %s using Register based invalidation\n",
-			iommu->name);
+		pr_info("%s using Register based invalidation\n", iommu->name);
 	} else {
 		iommu->flush.flush_context = qi_flush_context;
 		iommu->flush.flush_iotlb = qi_flush_iotlb;
-		pr_info("IOMMU: %s using Queued invalidation\n", iommu->name);
+		pr_info("%s using Queued invalidation\n", iommu->name);
 	}
 }
 
@@ -3982,20 +3982,18 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		return 0;
 
 	if (hw_pass_through && !ecap_pass_through(iommu->ecap)) {
-		pr_warn("IOMMU: %s doesn't support hardware pass through.\n",
+		pr_warn("%s doesn't support hardware pass through.\n",
 			iommu->name);
 		return -ENXIO;
 	}
 	if (!ecap_sc_support(iommu->ecap) &&
 	    domain_update_iommu_snooping(iommu)) {
-		pr_warn("IOMMU: %s doesn't support snooping.\n",
-			iommu->name);
+		pr_warn("%s doesn't support snooping.\n", iommu->name);
 		return -ENXIO;
 	}
 	sp = domain_update_iommu_superpage(iommu) - 1;
 	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
-		pr_warn("IOMMU: %s doesn't support large page.\n",
-			iommu->name);
+		pr_warn("%s doesn't support large page.\n", iommu->name);
 		return -ENXIO;
 	}
 
@@ -4225,7 +4223,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 		start = mhp->start_pfn << PAGE_SHIFT;
 		end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
 		if (iommu_domain_identity_map(si_domain, start, end)) {
-			pr_warn("dmar: failed to build identity map for [%llx-%llx]\n",
+			pr_warn("Failed to build identity map for [%llx-%llx]\n",
 				start, end);
 			return NOTIFY_BAD;
 		}
@@ -4243,7 +4241,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 
 			iova = find_iova(&si_domain->iovad, start_vpfn);
 			if (iova == NULL) {
-				pr_debug("dmar: failed get IOVA for PFN %lx\n",
+				pr_debug("Failed get IOVA for PFN %lx\n",
 					 start_vpfn);
 				break;
 			}
@@ -4251,7 +4249,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			iova = split_and_remove_iova(&si_domain->iovad, iova,
 						     start_vpfn, last_vpfn);
 			if (iova == NULL) {
-				pr_warn("dmar: failed to split IOVA PFN [%lx-%lx]\n",
+				pr_warn("Failed to split IOVA PFN [%lx-%lx]\n",
 					start_vpfn, last_vpfn);
 				return NOTIFY_BAD;
 			}
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index c3f0686..34667d5 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1,3 +1,6 @@
+
+#define pr_fmt(fmt)	"DMAR-IR: " fmt
+
 #include <linux/interrupt.h>
 #include <linux/dmar.h>
 #include <linux/spinlock.h>
@@ -105,8 +108,7 @@ static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 	}
 
 	if (mask > ecap_max_handle_mask(iommu->ecap)) {
-		printk(KERN_ERR
-		       "Requested mask %x exceeds the max invalidation handle"
+		pr_err("Requested mask %x exceeds the max invalidation handle"
 		       " mask value %Lx\n", mask,
 		       ecap_max_handle_mask(iommu->ecap));
 		return -1;
@@ -116,7 +118,7 @@ static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 	index = bitmap_find_free_region(table->bitmap,
 					INTR_REMAP_TABLE_ENTRIES, mask);
 	if (index < 0) {
-		pr_warn("IR%d: can't allocate an IRTE\n", iommu->seq_id);
+		pr_warn("Can't allocate an IRTE for IR[%d]\n", iommu->seq_id);
 	} else {
 		cfg->remapped = 1;
 		irq_iommu->iommu = iommu;
@@ -345,7 +347,7 @@ static int set_ioapic_sid(struct irte *irte, int apic)
 	up_read(&dmar_global_lock);
 
 	if (sid == 0) {
-		pr_warning("Failed to set source-id of IOAPIC (%d)\n", apic);
+		pr_warn("Failed to set source-id of IOAPIC (%d)\n", apic);
 		return -1;
 	}
 
@@ -372,7 +374,7 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 	up_read(&dmar_global_lock);
 
 	if (sid == 0) {
-		pr_warning("Failed to set source-id of HPET block (%d)\n", id);
+		pr_warn("Failed to set source-id of HPET block (%d)\n", id);
 		return -1;
 	}
 
@@ -502,15 +504,15 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 				 INTR_REMAP_PAGE_ORDER);
 
 	if (!pages) {
-		pr_err("IR%d: failed to allocate pages of order %d\n",
-		       iommu->seq_id, INTR_REMAP_PAGE_ORDER);
+		pr_err("Failed to allocate pages of order %d for IR[%d]\n",
+		       INTR_REMAP_PAGE_ORDER, iommu->seq_id);
 		goto out_free_table;
 	}
 
 	bitmap = kcalloc(BITS_TO_LONGS(INTR_REMAP_TABLE_ENTRIES),
 			 sizeof(long), GFP_ATOMIC);
 	if (bitmap == NULL) {
-		pr_err("IR%d: failed to allocate bitmap\n", iommu->seq_id);
+		pr_err("Failed to allocate bitmap for IR[%d]\n", iommu->seq_id);
 		goto out_free_pages;
 	}
 
@@ -592,7 +594,7 @@ static void __init intel_cleanup_irq_remapping(void)
 	}
 
 	if (x2apic_supported())
-		pr_warn("Failed to enable irq remapping.  You are vulnerable to irq-injection attacks.\n");
+		pr_warn("Failed to enable irq remapping. You are vulnerable to irq-injection attacks.\n");
 }
 
 static int __init intel_prepare_irq_remapping(void)
@@ -1385,7 +1387,7 @@ static void iommu_check_pre_ir_status(struct intel_iommu *iommu)
 
 	sts = readl(iommu->reg + DMAR_GSTS_REG);
 	if (sts & DMA_GSTS_IRES) {
-		pr_info("IR is enabled prior to OS.\n");
+		pr_info("IRQ remapping is enabled prior to OS.\n");
 		iommu->pre_enabled_ir = 1;
 	}
 }
-- 
1.9.1

