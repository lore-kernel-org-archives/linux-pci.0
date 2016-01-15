Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41442 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbcAOSTp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 13:19:45 -0500
Date: Fri, 15 Jan 2016 12:19:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160115181938.GA5296@localhost>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Tue, Jan 12, 2016 at 01:18:05PM -0700, Keith Busch wrote:
> Nothing changed; just contained in a single series, as requested.
> 
> Keith Busch (4):
>   x86/IRQ: Export IRQ domain function for module use
>   x86/PCI: Allow PCI domain specific dma ops
>   PCI/AER: Use 32 bit int type domains
>   x86/PCI: Initial commit for new VMD device driver
> 
> Liu Jiang (1):
>   msi: Relax msi_domain_alloc() to support parentless MSI irqdomains
> 
>  MAINTAINERS                       |   6 +
>  arch/x86/Kconfig                  |  13 +
>  arch/x86/include/asm/device.h     |  10 +
>  arch/x86/include/asm/hw_irq.h     |   5 +
>  arch/x86/pci/Makefile             |   2 +
>  arch/x86/pci/common.c             |  38 +++
>  arch/x86/pci/vmd.c                | 699 ++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aer/aer_inject.c |  16 +-
>  kernel/irq/irqdomain.c            |   1 +
>  kernel/irq/msi.c                  |   8 +-
>  10 files changed, 787 insertions(+), 11 deletions(-)
>  create mode 100644 arch/x86/pci/vmd.c

I applied these to pci/host-vmd with the changes below.  Most of them
are cosmetic (rewrapping changelogs, fixing whitespace, etc.), but
there are a few I'd like you to take a close look at:

  - Added VMD_CFGBAR and similar #defines
  - Added vmd_cfg_addr() to factor out the addr computation and
    validation
  - Resource setup in vmd_enable_domain().  I suggested a temporary to
    make the lines shorter.  I had the vmd->dev->resource[n] in mind,
    but you added a temporary for vmd->resources[n].  Either way is
    fine, but I liked the look of the v7 init, so I reverted to that,
    with a temporary for vmd->dev->resource[n].
  - Flags setup in vmd_enable_domain().  This was pretty confusing,
    and I *think* what I did is equivalent, but you should verify.

I also have a more substantive question about the flags setup.  I
think you should not clear IORESOURCE_MEM_64.  The intent of
IORESOURCE_MEM_64 is to describe the *capability* of a BAR, not its
contents.  But I assume you cleared it for a reason.  vmd->resources[n]
are not BARs, so the PCI core won't assign resources to them like it
does for BAR, so we shouldn't care about IORESOURCE_MEM_64 for that
reason.  Is there some other reason IORESOURCE_MEM_64 makes a
difference there?

I'm still hoping to get this in during the merge window.

If you want to test this, I recommend using my git branch
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-vmd
instead of applying the patch below on top of your v8.  If you want
to make changes, post an incremental patch based on that branch.

Bjorn


@@ -1,114 +1,123 @@
-commit 7b1cd49008b8
+commit a0fea74a2b8f
 Author: Keith Busch <keith.busch@intel.com>
 Date:   Tue Jan 12 13:18:10 2016 -0700
 
-    x86/PCI: Initial commit for new VMD device driver
+    x86/PCI: Add driver for Intel Volume Management Device (VMD)
     
-    The Intel Volume Management Device (VMD) is an integrated endpoint on the
-    platform's PCIe root complex that acts as a host bridge to a secondary
-    PCIe domain. BIOS can reassign one or more root ports to appear within
-    a VMD domain instead of the primary domain. The immediate benefit is
-    that additional PCI-e domains allow more than 256 buses in a system by
-    letting bus number be reused across different domains.
-    
-    VMD domains do not define ACPI _SEG, so to avoid domain clashing with
-    host bridges defining this segment, VMD domains start at 0x10000 which
-    is greater than the highest possible 16-bit ACPI defined _SEG.
+    The Intel Volume Management Device (VMD) is a Root Complex Integrated
+    Endpoint that acts as a host bridge to a secondary PCIe domain.  BIOS can
+    reassign one or more Root Ports to appear within a VMD domain instead of
+    the primary domain.  The immediate benefit is that additional PCIe domains
+    allow more than 256 buses in a system by letting bus numbers be reused
+    across different domains.
+    
+    VMD domains do not define ACPI _SEG, so to avoid domain clashing with host
+    bridges defining this segment, VMD domains start at 0x10000, which is
+    greater than the highest possible 16-bit ACPI defined _SEG.
     
     This driver enumerates and enables the domain using the root bus
-    configuration interface provided by the PCI subsystem. The driver
-    provides configuration space accessor functions (pci_ops), bus and
-    memory resources, an MSI irq domain with irq_chip implementation, and
-    dma operations necessary to use devices in through the VMD endpoint's
-    interface.
+    configuration interface provided by the PCI subsystem.  The driver provides
+    configuration space accessor functions (pci_ops), bus and memory resources,
+    an MSI IRQ domain with irq_chip implementation, and DMA operations
+    necessary to use devices through the VMD endpoint's interface.
     
     VMD routes I/O as follows:
     
        1) Configuration Space: BAR 0 ("CFGBAR") of VMD provides the base
        address and size for configuration space register access to VMD-owned
-       root ports. It works similarly to MMCONFIG for extended configuration
-       space. Bus numbering is independent and does not conflict with the
+       root ports.  It works similarly to MMCONFIG for extended configuration
+       space.  Bus numbering is independent and does not conflict with the
        primary domain.
     
-       2) MMIO Space: BARs 2 and 4 ("MEMBAR1" and "MEMBAR2") of VMD provide
-       the base address, size, and type for MMIO register access. These
-       addresses are not translated by VMD hardware; they are simply
-       reservations to be distributed to root ports' memory base/limit
-       registers and subdivided among devices downstream.
-    
-       3) DMA: To interact appropriately with IOMMU, the source ID DMA read
-       and write requests are translated to the bus-device-function of the
-       VMD endpoint. Otherwise, DMA operates normally without VMD-specific
-       address translation.
-    
-       4) Interrupts: Part of VMD's BAR 4 is reserved for VMD's MSI-X Table
-       and PBA. MSIs from VMD domain devices and ports are remapped to appear
-       if they were issued using one of VMD's MSI-X table entries. Each MSI
-       and MSI-X addresses of VMD-owned devices and ports have a special
-       format where the address refers to specific entries in VMD's MSI-X
-       table. As with DMA, the interrupt source id is translated to VMD's
+       2) MMIO Space: BARs 2 and 4 ("MEMBAR1" and "MEMBAR2") of VMD provide the
+       base address, size, and type for MMIO register access.  These addresses
+       are not translated by VMD hardware; they are simply reservations to be
+       distributed to root ports' memory base/limit registers and subdivided
+       among devices downstream.
+    
+       3) DMA: To interact appropriately with an IOMMU, the source ID DMA read
+       and write requests are translated to the bus-device-function of the VMD
+       endpoint.  Otherwise, DMA operates normally without VMD-specific address
+       translation.
+    
+       4) Interrupts: Part of VMD's BAR 4 is reserved for VMD's MSI-X Table and
+       PBA.  MSIs from VMD domain devices and ports are remapped to appear as
+       if they were issued using one of VMD's MSI-X table entries.  Each MSI
+       and MSI-X address of VMD-owned devices and ports has a special format
+       where the address refers to specific entries in the VMD's MSI-X table.
+       As with DMA, the interrupt source ID is translated to VMD's
        bus-device-function.
     
        The driver provides its own MSI and MSI-X configuration functions
-       specific to how MSI messages are used within the VMD domain,
-       and provides an irq_chip for independent IRQ allocation to relay
-       interrupts from VMD's interrupt handler to the appropriate device
-       driver's handler.
-    
-       5) Errors: PCIe error message are intercepted by the root ports
-       normally (e.g. AER), except with VMD, system errors (i.e. firmware
-       first) are disabled by default. AER and hotplug interrupts are
-       translated in the same way as endpoint interrupts.
+       specific to how MSI messages are used within the VMD domain, and
+       provides an irq_chip for independent IRQ allocation to relay interrupts
+       from VMD's interrupt handler to the appropriate device driver's handler.
+    
+       5) Errors: PCIe error message are intercepted by the root ports normally
+       (e.g., AER), except with VMD, system errors (i.e., firmware first) are
+       disabled by default.  AER and hotplug interrupts are translated in the
+       same way as endpoint interrupts.
     
-       6) VMD does not support INTx interrupts or IO ports. Devices or drivers
+       6) VMD does not support INTx interrupts or IO ports.  Devices or drivers
        requiring these features should either not be placed below VMD-owned
        root ports, or VMD should be disabled by BIOS for such endpoints.
     
+    [bhelgaas: add VMD BAR #defines, factor out vmd_cfg_addr(), whitespace]
     Signed-off-by: Keith Busch <keith.busch@intel.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 05e97692e217
+commit 60707d6ebbbe
 Author: Keith Busch <keith.busch@intel.com>
 Date:   Tue Jan 12 13:18:09 2016 -0700
 
-    PCI/AER: Use 32 bit int type domains
+    PCI/AER: Use 32 bit PCI domain numbers
     
-    New pci device provides additional pci domains that start above what 16
-    bits can address.
+    The Intel Volume Management Device (VMD) supports 32-bit domain numbers.
+    To accommodate this, use u32 instead of u16 to store domain numbers.
     
+    [bhelgaas: changelog]
     Signed-off-by: Keith Busch <keith.busch@intel.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 323121f05c8d
+commit cbab4ba90c61
 Author: Keith Busch <keith.busch@intel.com>
 Date:   Tue Jan 12 13:18:08 2016 -0700
 
-    x86/PCI: Allow PCI domain specific dma ops
+    x86/PCI: Allow DMA ops specific to a PCI domain
     
-    New x86 pci h/w will require dma operations specific to that domain. This
-    patch allows those domains to register their operations, and sets devices
-    as they are discovered in that domain to use them.
+    The Intel Volume Management Device (VMD) is a PCIe endpoint that acts as a
+    host bridge to another PCI domain.  When devices below the VMD perform DMA,
+    the VMD replaces their DMA source IDs with its own source ID.  Therefore,
+    those devices require special DMA ops.
     
+    Add interfaces to allow the VMD driver to set up dma_ops for the devices
+    below it.
+    
+    [bhelgaas: remove "extern", add "static", changelog]
     Signed-off-by: Keith Busch <keith.busch@intel.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit b54bc8bc78d0
+commit db6a7b7a3887
 Author: Keith Busch <keith.busch@intel.com>
 Date:   Tue Jan 12 13:18:07 2016 -0700
 
-    x86/IRQ: Export IRQ domain function for module use
+    irqdomain: Export irq_domain_set_info() for module use
+    
+    Export irq_domain_set_info() for module use.  It will be used by the Volume
+    Management Device driver.
     
+    [bhelgaas: changelog]
     Signed-off-by: Keith Busch <keith.busch@intel.com>
     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
 
-commit 7c8c9dc397f2
+commit 23e42d853208
 Author: Liu Jiang <jiang.liu@linux.intel.com>
 Date:   Tue Jan 12 13:18:06 2016 -0700
 
-    msi: Relax msi_domain_alloc() to support parentless MSI irqdomains
+    genirq/MSI: Relax msi_domain_alloc() to support parentless MSI irqdomains
     
-    Previously msi_domain_alloc() assumes MSI irqdomains always have parent
-    irqdomains, but that's not true for the new Intel VMD devices. So relax
+    Previously msi_domain_alloc() assumed MSI irqdomains always had parent
+    irqdomains, but that's not true for the new Intel VMD devices.  Relax
     msi_domain_alloc() to support parentless MSI irqdomains.
     
     Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>


diff --git a/MAINTAINERS b/MAINTAINERS
index 76369d4..ce47e08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8216,7 +8216,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
 F:	drivers/pci/host/pci-host-generic.c
 
-PCI DRIVER FOR VMD
+PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
 M:	Keith Busch <keith.busch@intel.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9a5ab69..3e6aca8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2670,13 +2670,13 @@ config VMD
 	tristate "Volume Management Device Driver"
 	default N
 	---help---
-	  Adds support for the Intel Volume Manage Device (VMD). VMD is a
+	  Adds support for the Intel Volume Management Device (VMD). VMD is a
 	  secondary PCI host bridge that allows PCI Express root ports,
 	  and devices attached to them, to be removed from the default
 	  PCI domain and placed within the VMD domain. This provides
-	  additional bus resources than are otherwise possible with a
+	  more bus resources than are otherwise possible with a
 	  single domain. If you know your system provides one of these and
-	  have devices attached to it, say Y; if you are not sure, say N.
+	  has devices attached to it, say Y; if you are not sure, say N.
 
 source "net/Kconfig"
 
diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
index 3b23897..684ed6c 100644
--- a/arch/x86/include/asm/device.h
+++ b/arch/x86/include/asm/device.h
@@ -16,8 +16,8 @@ struct dma_domain {
 	struct dma_map_ops *dma_ops;
 	int domain_nr;
 };
-extern void add_dma_domain(struct dma_domain *domain);
-extern void del_dma_domain(struct dma_domain *domain);
+void add_dma_domain(struct dma_domain *domain);
+void del_dma_domain(struct dma_domain *domain);
 #endif
 
 struct pdev_archdata {
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 106fd13..2879efc 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -642,8 +642,8 @@ unsigned int pcibios_assign_all_busses(void)
 }
 
 #if defined(CONFIG_X86_DEV_DMA_OPS) && defined(CONFIG_PCI_DOMAINS)
-LIST_HEAD(dma_domain_list);
-DEFINE_SPINLOCK(dma_domain_list_lock);
+static LIST_HEAD(dma_domain_list);
+static DEFINE_SPINLOCK(dma_domain_list_lock);
 
 void add_dma_domain(struct dma_domain *domain)
 {
diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 56ef447..d57e480 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -27,20 +27,24 @@
 #include <asm/msi.h>
 #include <asm/msidef.h>
 
+#define VMD_CFGBAR	0
+#define VMD_MEMBAR1	2
+#define VMD_MEMBAR2	4
+
 /*
- * Lock for manipulating vmd irq lists.
+ * Lock for manipulating VMD IRQ lists.
  */
 static DEFINE_RAW_SPINLOCK(list_lock);
 
 /**
- * struct vmd_irq - private data to map driver irq to the VMD shared vector
+ * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
  * @node:	list item for parent traversal.
- * @rcu:	rcu callback item for freeing.
+ * @rcu:	RCU callback item for freeing.
  * @irq:	back pointer to parent.
- * @virq:	the virtual irq value provided to the requesting driver.
+ * @virq:	the virtual IRQ value provided to the requesting driver.
  *
- * Every MSI/MSI-x irq requested for a device in a VMD domain will be mapped to
- * a VMD irq using this structure.
+ * Every MSI/MSI-X IRQ requested for a device in a VMD domain will be mapped to
+ * a VMD IRQ using this structure.
  */
 struct vmd_irq {
 	struct list_head	node;
@@ -50,11 +54,11 @@ struct vmd_irq {
 };
 
 /**
- * struct vmd_irq_list - list of driver requested irq's mapping to a vmd vector
+ * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
  * @irq_list:	the list of irq's the VMD one demuxes to.
- * @vmd_vector:	the h/w irq assigned to the VMD device.
- * @index:	index into the VMD MSI-x table; used for message routing.
- * @count:	number of child irqs assigned to this vector; used to track
+ * @vmd_vector:	the h/w IRQ assigned to the VMD.
+ * @index:	index into the VMD MSI-X table; used for message routing.
+ * @count:	number of child IRQs assigned to this vector; used to track
  *		sharing.
  */
 struct vmd_irq_list {
@@ -92,11 +96,11 @@ static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
 }
 
 /*
- * Drivers managing a device in a VMD domain allocate their own irqs as before,
+ * Drivers managing a device in a VMD domain allocate their own IRQs as before,
  * but the MSI entry for the hardware it's driving will be programmed with a
- * destination id for the VMD MSI-x table. The VMD device muxes interrupts in
- * its domain into one of its own, and the VMD driver de-muxes these for the
- * handlers sharing that VMD irq. The vmd irq_domain provides the operations
+ * destination ID for the VMD MSI-X table.  The VMD muxes interrupts in its
+ * domain into one of its own, and the VMD driver de-muxes these for the
+ * handlers sharing that VMD IRQ.  The vmd irq_domain provides the operations
  * and irq_chip to set this up.
  */
 static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
@@ -110,7 +114,7 @@ static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 }
 
 /*
- * We rely on MSI_FLAG_USE_DEF_CHIP_OPS to set the irq mask/unmask ops.
+ * We rely on MSI_FLAG_USE_DEF_CHIP_OPS to set the IRQ mask/unmask ops.
  */
 static void vmd_irq_enable(struct irq_data *data)
 {
@@ -139,7 +143,7 @@ static void vmd_irq_disable(struct irq_data *data)
  * other devices sharing the same vector.
  */
 static int vmd_irq_set_affinity(struct irq_data *data,
-			const struct cpumask *dest, bool force)
+				const struct cpumask *dest, bool force)
 {
 	return -EINVAL;
 }
@@ -159,7 +163,7 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
 }
 
 /*
- * XXX: We can be even smarter selecting the best irq once we solve the
+ * XXX: We can be even smarter selecting the best IRQ once we solve the
  * affinity problem.
  */
 static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd)
@@ -176,8 +180,7 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd)
 	return &vmd->irqs[best];
 }
 
-static int vmd_msi_init(struct irq_domain *domain,
-			struct msi_domain_info *info,
+static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 			unsigned int virq, irq_hw_number_t hwirq,
 			msi_alloc_info_t *arg)
 {
@@ -191,14 +194,13 @@ static int vmd_msi_init(struct irq_domain *domain,
 	vmdirq->irq = vmd_next_irq(vmd);
 	vmdirq->virq = virq;
 
-	irq_domain_set_info(domain, virq, vmdirq->irq->vmd_vector,
-			info->chip, vmdirq, handle_simple_irq, vmd, NULL);
+	irq_domain_set_info(domain, virq, vmdirq->irq->vmd_vector, info->chip,
+			    vmdirq, handle_simple_irq, vmd, NULL);
 	return 0;
 }
 
 static void vmd_msi_free(struct irq_domain *domain,
-			struct msi_domain_info *info,
-			unsigned int virq)
+			struct msi_domain_info *info, unsigned int virq)
 {
 	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
 
@@ -210,15 +212,15 @@ static void vmd_msi_free(struct irq_domain *domain,
 	kfree_rcu(vmdirq, rcu);
 }
 
-static int vmd_msi_prepare(struct irq_domain *domain,
-			struct device *dev, int nvec,
-			msi_alloc_info_t *arg)
+static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
+			   int nvec, msi_alloc_info_t *arg)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
 
 	if (nvec > vmd->msix_count)
 		return vmd->msix_count;
+
 	memset(arg, 0, sizeof(*arg));
 	return 0;
 }
@@ -245,8 +247,8 @@ static struct msi_domain_info vmd_msi_domain_info = {
 
 #ifdef CONFIG_X86_DEV_DMA_OPS
 /*
- * VMD replaces the requester id with its own. DMA mappings for devices in a
- * VMD domain need to be mapped for the VMD device, not the device requiring
+ * VMD replaces the requester ID with its own.  DMA mappings for devices in a
+ * VMD domain need to be mapped for the VMD, not the device requiring
  * the mapping.
  */
 static struct device *to_vmd_dev(struct device *dev)
@@ -263,76 +265,73 @@ static struct dma_map_ops *vmd_dma_ops(struct device *dev)
 }
 
 static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
-				gfp_t flag, struct dma_attrs *attrs)
+		       gfp_t flag, struct dma_attrs *attrs)
 {
 	return vmd_dma_ops(dev)->alloc(to_vmd_dev(dev), size, addr, flag,
-								attrs);
+				       attrs);
 }
 
 static void vmd_free(struct device *dev, size_t size, void *vaddr,
-				dma_addr_t addr, struct dma_attrs *attrs)
+		     dma_addr_t addr, struct dma_attrs *attrs)
 {
 	return vmd_dma_ops(dev)->free(to_vmd_dev(dev), size, vaddr, addr,
-								attrs);
+				      attrs);
 }
 
 static int vmd_mmap(struct device *dev, struct vm_area_struct *vma,
-				void *cpu_addr, dma_addr_t addr,
-				size_t size, struct dma_attrs *attrs)
+		    void *cpu_addr, dma_addr_t addr, size_t size,
+		    struct dma_attrs *attrs)
 {
 	return vmd_dma_ops(dev)->mmap(to_vmd_dev(dev), vma, cpu_addr, addr,
-								size, attrs);
+				      size, attrs);
 }
 
 static int vmd_get_sgtable(struct device *dev, struct sg_table *sgt,
-				void *cpu_addr, dma_addr_t addr,
-				size_t size, struct dma_attrs *attrs)
+			   void *cpu_addr, dma_addr_t addr, size_t size,
+			   struct dma_attrs *attrs)
 {
 	return vmd_dma_ops(dev)->get_sgtable(to_vmd_dev(dev), sgt, cpu_addr,
-							addr, size, attrs);
+					     addr, size, attrs);
 }
 
 static dma_addr_t vmd_map_page(struct device *dev, struct page *page,
-				unsigned long offset, size_t size,
-				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+			       unsigned long offset, size_t size,
+			       enum dma_data_direction dir,
+			       struct dma_attrs *attrs)
 {
 	return vmd_dma_ops(dev)->map_page(to_vmd_dev(dev), page, offset, size,
-								dir, attrs);
+					  dir, attrs);
 }
 
 static void vmd_unmap_page(struct device *dev, dma_addr_t addr, size_t size,
-				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+			   enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	vmd_dma_ops(dev)->unmap_page(to_vmd_dev(dev), addr, size, dir, attrs);
 }
 
 static int vmd_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+		      enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	return vmd_dma_ops(dev)->map_sg(to_vmd_dev(dev), sg, nents, dir, attrs);
 }
 
 static void vmd_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-				enum dma_data_direction dir,
-				struct dma_attrs *attrs)
+			 enum dma_data_direction dir, struct dma_attrs *attrs)
 {
 	vmd_dma_ops(dev)->unmap_sg(to_vmd_dev(dev), sg, nents, dir, attrs);
 }
 
 static void vmd_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-				size_t size, enum dma_data_direction dir)
+				    size_t size, enum dma_data_direction dir)
 {
 	vmd_dma_ops(dev)->sync_single_for_cpu(to_vmd_dev(dev), addr, size, dir);
 }
 
 static void vmd_sync_single_for_device(struct device *dev, dma_addr_t addr,
-				size_t size, enum dma_data_direction dir)
+				       size_t size, enum dma_data_direction dir)
 {
 	vmd_dma_ops(dev)->sync_single_for_device(to_vmd_dev(dev), addr, size,
-									dir);
+						 dir);
 }
 
 static void vmd_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
@@ -342,7 +341,7 @@ static void vmd_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 }
 
 static void vmd_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction dir)
+				   int nents, enum dma_data_direction dir)
 {
 	vmd_dma_ops(dev)->sync_sg_for_device(to_vmd_dev(dev), sg, nents, dir);
 }
@@ -414,20 +413,32 @@ static void vmd_teardown_dma_ops(struct vmd_dev *vmd) {}
 static void vmd_setup_dma_ops(struct vmd_dev *vmd) {}
 #endif
 
+static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
+				  unsigned int devfn, int reg, int len)
+{
+	char __iomem *addr = vmd->cfgbar +
+			     (bus->number << 20) + (devfn << 12) + reg;
+
+	if ((addr - vmd->cfgbar) + len >=
+	    resource_size(&vmd->dev->resource[VMD_CFGBAR]))
+		return NULL;
+
+	return addr;
+}
+
 /*
  * CPU may deadlock if config space is not serialized on some versions of this
  * hardware, so all config space access is done under a spinlock.
  */
 static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
-							int len, u32 *value)
+			int len, u32 *value)
 {
-	int ret = 0;
-	unsigned long flags;
 	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd->cfgbar + (bus->number << 20) +
-						(devfn << 12) + reg;
+	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	unsigned long flags;
+	int ret = 0;
 
-	if ((addr - vmd->cfgbar) + len >= resource_size(&vmd->dev->resource[0]))
+	if (!addr)
 		return -EFAULT;
 
 	spin_lock_irqsave(&vmd->cfg_lock, flags);
@@ -455,15 +466,14 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
  * the config space was written, as expected.
  */
 static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
-							int len, u32 value)
+			 int len, u32 value)
 {
-	int ret = 0;
-	unsigned long flags;
 	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd->cfgbar + (bus->number << 20) +
-						(devfn << 12) + reg;
+	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	unsigned long flags;
+	int ret = 0;
 
-	if ((addr - vmd->cfgbar) + len >= resource_size(&vmd->dev->resource[0]))
+	if (!addr)
 		return -EFAULT;
 
 	spin_lock_irqsave(&vmd->cfg_lock, flags);
@@ -494,7 +504,7 @@ static struct pci_ops vmd_ops = {
 };
 
 /*
- * VMD domains start at 10000h to not clash with domains defining ACPI _SEG.
+ * VMD domains start at 0x1000 to not clash with ACPI _SEG domains.
  */
 static int vmd_find_free_domain(void)
 {
@@ -510,37 +520,50 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
 	struct resource *res;
+	u32 upper_bits;
+	unsigned long flags;
 	LIST_HEAD(resources);
 
-	res = &vmd->resources[0];
-	res->name = "VMD CFGBAR";
-	res->start = 0;
-	res->end = (resource_size(&vmd->dev->resource[0]) >> 20) - 1;
-	res->flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
-
-	res = &vmd->resources[1];
-	res->name = "VMD MEMBAR1";
-	res->start = vmd->dev->resource[2].start;
-	res->end = vmd->dev->resource[2].end;
-	res->flags = (vmd->dev->resource[2].flags & ~IORESOURCE_SIZEALIGN) &
-				(!upper_32_bits(vmd->dev->resource[2].end) ?
-						~IORESOURCE_MEM_64 : ~0);
-
-	res = &vmd->resources[2];
-	res->name = "VMD MEMBAR2";
-	res->start = vmd->dev->resource[4].start + 0x2000;
-	res->end = vmd->dev->resource[4].end;
-	res->flags = (vmd->dev->resource[4].flags & ~IORESOURCE_SIZEALIGN) &
-				(!upper_32_bits(vmd->dev->resource[4].end) ?
-						~IORESOURCE_MEM_64 : ~0);
+	res = &vmd->dev->resource[VMD_CFGBAR];
+	vmd->resources[0] = (struct resource) {
+		.name  = "VMD CFGBAR",
+		.start = res->start,
+		.end   = (resource_size(res) >> 20) - 1,
+		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
+	};
+
+	res = &vmd->dev->resource[VMD_MEMBAR1];
+	upper_bits = upper_32_bits(res->end);
+	flags = res->flags & ~IORESOURCE_SIZEALIGN;
+	if (!upper_bits)
+		flags &= ~IORESOURCE_MEM_64;
+	vmd->resources[1] = (struct resource) {
+		.name  = "VMD MEMBAR1",
+		.start = res->start,
+		.end   = res->end,
+		.flags = flags,
+	};
+
+	res = &vmd->dev->resource[VMD_MEMBAR2];
+	upper_bits = upper_32_bits(res->end);
+	flags = res->flags & ~IORESOURCE_SIZEALIGN;
+	if (!upper_bits)
+		flags &= ~IORESOURCE_MEM_64;
+	vmd->resources[2] = (struct resource) {
+		.name  = "VMD MEMBAR2",
+		.start = res->start + 0x2000,
+		.end   = res->end,
+		.flags = flags,
+	};
 
 	sd->domain = vmd_find_free_domain();
 	if (sd->domain < 0)
 		return sd->domain;
+
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
 	vmd->irq_domain = pci_msi_create_irq_domain(NULL, &vmd_msi_domain_info,
-									NULL);
+						    NULL);
 	if (!vmd->irq_domain)
 		return -ENODEV;
 
@@ -548,7 +571,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	pci_add_resource(&resources, &vmd->resources[1]);
 	pci_add_resource(&resources, &vmd->resources[2]);
 	vmd->bus = pci_create_root_bus(&vmd->dev->dev, 0, &vmd_ops, sd,
-								&resources);
+				       &resources);
 	if (!vmd->bus) {
 		pci_free_resource_list(&resources);
 		irq_domain_remove(vmd->irq_domain);
@@ -560,8 +583,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 	pci_rescan_bus(vmd->bus);
 
 	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
-								"domain"),
-			"Can't create symlink to domain\n");
+			       "domain"), "Can't create symlink to domain\n");
 	return 0;
 }
 
@@ -583,7 +605,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int i, err;
 
-	if (resource_size(&dev->resource[0]) < (1 << 20))
+	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
 	vmd = devm_kzalloc(&dev->dev, sizeof(*vmd), GFP_KERNEL);
@@ -595,7 +617,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (err < 0)
 		return err;
 
-	vmd->cfgbar = pcim_iomap(dev, 0, 0);
+	vmd->cfgbar = pcim_iomap(dev, VMD_CFGBAR, 0);
 	if (!vmd->cfgbar)
 		return -ENOMEM;
 
@@ -609,19 +631,20 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENODEV;
 
 	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
-							GFP_KERNEL);
+				 GFP_KERNEL);
 	if (!vmd->irqs)
 		return -ENOMEM;
 
 	vmd->msix_entries = devm_kcalloc(&dev->dev, vmd->msix_count,
-					sizeof(*vmd->msix_entries), GFP_KERNEL);
+					 sizeof(*vmd->msix_entries),
+					 GFP_KERNEL);
 	if (!vmd->msix_entries)
 		return -ENOMEM;
 	for (i = 0; i < vmd->msix_count; i++)
 		vmd->msix_entries[i].entry = i;
 
 	vmd->msix_count = pci_enable_msix_range(vmd->dev, vmd->msix_entries, 1,
-							vmd->msix_count);
+						vmd->msix_count);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
@@ -631,7 +654,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		vmd->irqs[i].index = i;
 
 		err = devm_request_irq(&dev->dev, vmd->irqs[i].vmd_vector,
-				vmd_irq, 0, "vmd", &vmd->irqs[i]);
+				       vmd_irq, 0, "vmd", &vmd->irqs[i]);
 		if (err)
 			return err;
 	}
@@ -641,8 +664,9 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	err = vmd_enable_domain(vmd);
 	if (err)
 		return err;
-	dev_info(&vmd->dev->dev, "Bound to PCI domain:%x\n",
-					vmd->sysdata.domain);
+
+	dev_info(&vmd->dev->dev, "Bound to PCI domain %04x\n",
+		 vmd->sysdata.domain);
 	return 0;
 }
 
