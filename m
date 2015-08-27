Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:45945 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbbH0Nge (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2015 09:36:34 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
	Thu, 27 Aug 2015 14:36:18 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH] iommu/s390: add iommu api for s390 pci devices
Date: Thu, 27 Aug 2015 15:33:03 +0200
Message-Id: <1440682383-27688-1-git-send-email-gerald.schaefer@de.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds an IOMMU API implementation for s390 PCI devices.

Reviewed-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---
 MAINTAINERS                     |   7 +
 arch/s390/Kconfig               |   1 +
 arch/s390/include/asm/pci.h     |   4 +
 arch/s390/include/asm/pci_dma.h |   5 +-
 arch/s390/pci/pci_dma.c         |  37 +++--
 drivers/iommu/Kconfig           |   7 +
 drivers/iommu/Makefile          |   1 +
 drivers/iommu/s390-iommu.c      | 337 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 386 insertions(+), 13 deletions(-)
 create mode 100644 drivers/iommu/s390-iommu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 23da5da..8845410 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8937,6 +8937,13 @@ F:	drivers/s390/net/*iucv*
 F:	include/net/iucv/
 F:	net/iucv/
 
+S390 IOMMU (PCI)
+M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
+L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+F:	drivers/iommu/s390-iommu.c
+
 S3C24XX SD/MMC Driver
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1d57000..74db332 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -582,6 +582,7 @@ menuconfig PCI
 	bool "PCI support"
 	select HAVE_DMA_ATTRS
 	select PCI_MSI
+	select IOMMU_SUPPORT
 	help
 	  Enable PCI support.
 
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 34d9603..c873e68 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -62,6 +62,8 @@ struct zpci_bar_struct {
 	u8		size;		/* order 2 exponent */
 };
 
+struct s390_domain;
+
 /* Private data per function */
 struct zpci_dev {
 	struct pci_dev	*pdev;
@@ -118,6 +120,8 @@ struct zpci_dev {
 
 	struct dentry	*debugfs_dev;
 	struct dentry	*debugfs_perf;
+
+	struct s390_domain *s390_domain; /* s390 IOMMU domain data */
 };
 
 static inline bool zdev_enabled(struct zpci_dev *zdev)
diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index 30b4c17..7a7abf1 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -192,5 +192,8 @@ static inline unsigned long *get_st_pto(unsigned long entry)
 /* Prototypes */
 int zpci_dma_init_device(struct zpci_dev *);
 void zpci_dma_exit_device(struct zpci_dev *);
-
+void dma_free_seg_table(unsigned long);
+unsigned long *dma_alloc_cpu_table(void);
+void dma_cleanup_tables(unsigned long *);
+void dma_update_cpu_trans(unsigned long *, void *, dma_addr_t, int);
 #endif
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 37505b8..37d10f7 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -24,7 +24,7 @@ static int zpci_refresh_global(struct zpci_dev *zdev)
 				  zdev->iommu_pages * PAGE_SIZE);
 }
 
-static unsigned long *dma_alloc_cpu_table(void)
+unsigned long *dma_alloc_cpu_table(void)
 {
 	unsigned long *table, *entry;
 
@@ -114,12 +114,12 @@ static unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr
 	return &pto[px];
 }
 
-static void dma_update_cpu_trans(struct zpci_dev *zdev, void *page_addr,
-				 dma_addr_t dma_addr, int flags)
+void dma_update_cpu_trans(unsigned long *dma_table, void *page_addr,
+			  dma_addr_t dma_addr, int flags)
 {
 	unsigned long *entry;
 
-	entry = dma_walk_cpu_trans(zdev->dma_table, dma_addr);
+	entry = dma_walk_cpu_trans(dma_table, dma_addr);
 	if (!entry) {
 		WARN_ON_ONCE(1);
 		return;
@@ -156,7 +156,8 @@ static int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
 		goto no_refresh;
 
 	for (i = 0; i < nr_pages; i++) {
-		dma_update_cpu_trans(zdev, page_addr, dma_addr, flags);
+		dma_update_cpu_trans(zdev->dma_table, page_addr, dma_addr,
+				     flags);
 		page_addr += PAGE_SIZE;
 		dma_addr += PAGE_SIZE;
 	}
@@ -181,7 +182,7 @@ no_refresh:
 	return rc;
 }
 
-static void dma_free_seg_table(unsigned long entry)
+void dma_free_seg_table(unsigned long entry)
 {
 	unsigned long *sto = get_rt_sto(entry);
 	int sx;
@@ -193,21 +194,18 @@ static void dma_free_seg_table(unsigned long entry)
 	dma_free_cpu_table(sto);
 }
 
-static void dma_cleanup_tables(struct zpci_dev *zdev)
+void dma_cleanup_tables(unsigned long *table)
 {
-	unsigned long *table;
 	int rtx;
 
-	if (!zdev || !zdev->dma_table)
+	if (!table)
 		return;
 
-	table = zdev->dma_table;
 	for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
 		if (reg_entry_isvalid(table[rtx]))
 			dma_free_seg_table(table[rtx]);
 
 	dma_free_cpu_table(table);
-	zdev->dma_table = NULL;
 }
 
 static unsigned long __dma_alloc_iommu(struct zpci_dev *zdev,
@@ -416,6 +414,13 @@ int zpci_dma_init_device(struct zpci_dev *zdev)
 {
 	int rc;
 
+	/*
+	 * At this point, if the device is part of an IOMMU domain, this would
+	 * be a strong hint towards a bug in the IOMMU API (common) code and/or
+	 * simultaneous access via IOMMU and DMA API. So let's issue a warning.
+	 */
+	WARN_ON(zdev->s390_domain);
+
 	spin_lock_init(&zdev->iommu_bitmap_lock);
 	spin_lock_init(&zdev->dma_table_lock);
 
@@ -450,8 +455,16 @@ out_clean:
 
 void zpci_dma_exit_device(struct zpci_dev *zdev)
 {
+	/*
+	 * At this point, if the device is part of an IOMMU domain, this would
+	 * be a strong hint towards a bug in the IOMMU API (common) code and/or
+	 * simultaneous access via IOMMU and DMA API. So let's issue a warning.
+	 */
+	WARN_ON(zdev->s390_domain);
+
 	zpci_unregister_ioat(zdev, 0);
-	dma_cleanup_tables(zdev);
+	dma_cleanup_tables(zdev->dma_table);
+	zdev->dma_table = NULL;
 	vfree(zdev->iommu_bitmap);
 	zdev->iommu_bitmap = NULL;
 	zdev->next_bit = 0;
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e3b2c2e..0330fb4 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -377,4 +377,11 @@ config ARM_SMMU_V3
 	  Say Y here if your system includes an IOMMU device implementing
 	  the ARM SMMUv3 architecture.
 
+config S390_IOMMU
+	def_bool y if S390 && PCI
+	depends on S390 && PCI
+	select IOMMU_API
+	help
+	  Support for the IOMMU API for s390 PCI devices.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index dc6f511..c0a0649 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
+obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
new file mode 100644
index 0000000..cbe198c
--- /dev/null
+++ b/drivers/iommu/s390-iommu.c
@@ -0,0 +1,337 @@
+/*
+ * IOMMU API for s390 PCI devices
+ *
+ * Copyright IBM Corp. 2015
+ * Author(s): Gerald Schaefer <gerald.schaefer@de.ibm.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/iommu-helper.h>
+#include <linux/pci.h>
+#include <linux/sizes.h>
+#include <asm/pci_dma.h>
+
+/*
+ * Physically contiguous memory regions can be mapped with 4 KiB alignment,
+ * we allow all page sizes that are an order of 4KiB (no special large page
+ * support so far).
+ */
+#define S390_IOMMU_PGSIZES	(~0xFFFUL)
+
+struct s390_domain {
+	struct iommu_domain	domain;
+	struct list_head	devices;
+	unsigned long		*dma_table;
+	spinlock_t		dma_table_lock;
+	spinlock_t		list_lock;
+};
+
+struct s390_domain_device {
+	struct list_head	list;
+	struct zpci_dev		*zdev;
+};
+
+static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct s390_domain, domain);
+}
+
+static bool s390_iommu_capable(enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	case IOMMU_CAP_INTR_REMAP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+struct iommu_domain *s390_domain_alloc(unsigned domain_type)
+{
+	struct s390_domain *s390_domain;
+
+	if (domain_type != IOMMU_DOMAIN_UNMANAGED)
+		return NULL;
+
+	s390_domain = kzalloc(sizeof(*s390_domain), GFP_KERNEL);
+	if (!s390_domain)
+		return NULL;
+
+	s390_domain->dma_table = dma_alloc_cpu_table();
+	if (!s390_domain->dma_table) {
+		kfree(s390_domain);
+		return NULL;
+	}
+
+	spin_lock_init(&s390_domain->dma_table_lock);
+	spin_lock_init(&s390_domain->list_lock);
+	INIT_LIST_HEAD(&s390_domain->devices);
+
+	return &s390_domain->domain;
+}
+
+void s390_domain_free(struct iommu_domain *domain)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+
+	dma_cleanup_tables(s390_domain->dma_table);
+	kfree(s390_domain);
+}
+
+static int s390_iommu_attach_device(struct iommu_domain *domain,
+				    struct device *dev)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+	struct s390_domain_device *domain_device;
+	unsigned long flags;
+	int rc;
+
+	if (!zdev)
+		return -ENODEV;
+
+	domain_device = kzalloc(sizeof(*domain_device), GFP_KERNEL);
+	if (!domain_device)
+		return -ENOMEM;
+
+	if (zdev->dma_table)
+		zpci_dma_exit_device(zdev);
+
+	zdev->dma_table = s390_domain->dma_table;
+	rc = zpci_register_ioat(zdev, 0, zdev->start_dma + PAGE_OFFSET,
+				zdev->start_dma + zdev->iommu_size - 1,
+				(u64) zdev->dma_table);
+	if (rc)
+		goto out_restore;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	/* First device defines the DMA range limits */
+	if (list_empty(&s390_domain->devices)) {
+		domain->geometry.aperture_start = zdev->start_dma;
+		domain->geometry.aperture_end = zdev->end_dma;
+		domain->geometry.force_aperture = true;
+	/* Allow only devices with identical DMA range limits */
+	} else if (domain->geometry.aperture_start != zdev->start_dma ||
+		   domain->geometry.aperture_end != zdev->end_dma) {
+		rc = -EINVAL;
+		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+		goto out_restore;
+	}
+	domain_device->zdev = zdev;
+	zdev->s390_domain = s390_domain;
+	list_add(&domain_device->list, &s390_domain->devices);
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+
+	return 0;
+
+out_restore:
+	zpci_dma_init_device(zdev);
+	kfree(domain_device);
+
+	return rc;
+}
+
+static void s390_iommu_detach_device(struct iommu_domain *domain,
+				     struct device *dev)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+	struct s390_domain_device *domain_device, *tmp;
+	unsigned long flags;
+	int found = 0;
+
+	if (!zdev)
+		return;
+
+	spin_lock_irqsave(&s390_domain->list_lock, flags);
+	list_for_each_entry_safe(domain_device, tmp, &s390_domain->devices,
+				 list) {
+		if (domain_device->zdev == zdev) {
+			list_del(&domain_device->list);
+			kfree(domain_device);
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
+
+	if (found) {
+		zdev->s390_domain = NULL;
+		zpci_unregister_ioat(zdev, 0);
+		zpci_dma_init_device(zdev);
+	}
+}
+
+static int s390_iommu_add_device(struct device *dev)
+{
+	struct iommu_group *group;
+	int rc;
+
+	group = iommu_group_get(dev);
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return PTR_ERR(group);
+	}
+
+	rc = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
+
+	return rc;
+}
+
+static void s390_iommu_remove_device(struct device *dev)
+{
+	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+	struct iommu_domain *domain;
+
+	/*
+	 * This is a workaround for a scenario where the IOMMU API common code
+	 * "forgets" to call the detach_dev callback: After binding a device
+	 * to vfio-pci and completing the VFIO_SET_IOMMU ioctl (which triggers
+	 * the attach_dev), removing the device via
+	 * "echo 1 > /sys/bus/pci/devices/.../remove" won't trigger detach_dev,
+	 * only remove_device will be called via the BUS_NOTIFY_REMOVED_DEVICE
+	 * notifier.
+	 *
+	 * So let's call detach_dev from here if it hasn't been called before.
+	 */
+	if (zdev && zdev->s390_domain) {
+		domain = iommu_get_domain_for_dev(dev);
+		if (domain)
+			s390_iommu_detach_device(domain, dev);
+	}
+
+	iommu_group_remove_device(dev);
+}
+
+static int s390_iommu_update_trans(struct s390_domain *s390_domain,
+				   unsigned long pa, dma_addr_t dma_addr,
+				   size_t size, int flags)
+{
+	struct s390_domain_device *domain_device;
+	u8 *page_addr = (u8 *) (pa & PAGE_MASK);
+	dma_addr_t start_dma_addr = dma_addr;
+	unsigned long irq_flags, nr_pages, i;
+	int rc = 0;
+
+	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
+	    dma_addr + size > s390_domain->domain.geometry.aperture_end)
+		return -EINVAL;
+
+	nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	if (!nr_pages)
+		return 0;
+
+	spin_lock_irqsave(&s390_domain->dma_table_lock, irq_flags);
+	for (i = 0; i < nr_pages; i++) {
+		dma_update_cpu_trans(s390_domain->dma_table, page_addr,
+				     dma_addr, flags);
+		page_addr += PAGE_SIZE;
+		dma_addr += PAGE_SIZE;
+	}
+
+	spin_lock(&s390_domain->list_lock);
+	list_for_each_entry(domain_device, &s390_domain->devices, list) {
+		rc = zpci_refresh_trans((u64) domain_device->zdev->fh << 32,
+					start_dma_addr, nr_pages * PAGE_SIZE);
+		if (rc)
+			break;
+	}
+	spin_unlock(&s390_domain->list_lock);
+	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
+
+	return rc;
+}
+
+static int s390_iommu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	int flags = ZPCI_PTE_VALID, rc = 0;
+
+	if (!(prot & IOMMU_READ))
+		return -EINVAL;
+
+	if (!(prot & IOMMU_WRITE))
+		flags |= ZPCI_TABLE_PROTECTED;
+
+	rc = s390_iommu_update_trans(s390_domain, (unsigned long) paddr, iova,
+				     size, flags);
+
+	return rc;
+}
+
+static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
+					   dma_addr_t iova)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	unsigned long *sto, *pto, *rto, flags;
+	unsigned int rtx, sx, px;
+	phys_addr_t phys = 0;
+
+	if (iova < domain->geometry.aperture_start ||
+	    iova > domain->geometry.aperture_end)
+		return 0;
+
+	rtx = calc_rtx(iova);
+	sx = calc_sx(iova);
+	px = calc_px(iova);
+	rto = s390_domain->dma_table;
+
+	spin_lock_irqsave(&s390_domain->dma_table_lock, flags);
+	if (rto && reg_entry_isvalid(rto[rtx])) {
+		sto = get_rt_sto(rto[rtx]);
+		if (sto && reg_entry_isvalid(sto[sx])) {
+			pto = get_st_pto(sto[sx]);
+			if (pto && pt_entry_isvalid(pto[px]))
+				phys = pto[px] & ZPCI_PTE_ADDR_MASK;
+		}
+	}
+	spin_unlock_irqrestore(&s390_domain->dma_table_lock, flags);
+
+	return phys;
+}
+
+static size_t s390_iommu_unmap(struct iommu_domain *domain,
+			       unsigned long iova, size_t size)
+{
+	struct s390_domain *s390_domain = to_s390_domain(domain);
+	int flags = ZPCI_PTE_INVALID;
+	phys_addr_t paddr;
+	int rc;
+
+	paddr = s390_iommu_iova_to_phys(domain, iova);
+	if (!paddr)
+		return 0;
+
+	rc = s390_iommu_update_trans(s390_domain, (unsigned long) paddr, iova,
+				     size, flags);
+	if (rc)
+		return 0;
+
+	return size;
+}
+
+static struct iommu_ops s390_iommu_ops = {
+	.capable = s390_iommu_capable,
+	.domain_alloc = s390_domain_alloc,
+	.domain_free = s390_domain_free,
+	.attach_dev = s390_iommu_attach_device,
+	.detach_dev = s390_iommu_detach_device,
+	.map = s390_iommu_map,
+	.unmap = s390_iommu_unmap,
+	.iova_to_phys = s390_iommu_iova_to_phys,
+	.add_device = s390_iommu_add_device,
+	.remove_device = s390_iommu_remove_device,
+	.pgsize_bitmap = S390_IOMMU_PGSIZES,
+};
+
+static int __init s390_iommu_init(void)
+{
+	return bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
+}
+subsys_initcall(s390_iommu_init);
-- 
2.3.8

