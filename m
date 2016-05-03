Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	<1460074573-7481-5-git-send-email-yinghai@kernel.org>
	<20160422204920.GA17215@localhost>
	<CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
	<20160428135607.GA12470@localhost>
	<CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
Date: Tue, 3 May 2016 15:52:16 -0700
Message-ID: <CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 12:19 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Apr 28, 2016 at 6:56 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> 1) The sysfs path uses offsets between 0 and BAR size.  This path
>> should work identically on all arches.  "User" addresses are not
>> involved, so it doesn't make sense that this path calls
>> pci_resource_to_user() from pci_mmap_resource().
>>
>> 2) The procfs path uses offsets of resource values (CPU physical
>> addresses) on most architectures.  If some arches use something else,
>> e.g., "user" addresses, the grunge of dealing with them should be in
>> this path, i.e., in proc_bus_pci_mmap().  This implies that
>> pci_mmap_page_range() should deal with CPU physical addresses, not bus
>> addresses, and proc_bus_pci_mmap() should perform any necessary
>> translation.

Please check if following is what you want.

BenH and DavidM,
Are you ok to let /proc/bus/pci/devices to expose resource value instead of
BAR value?
powerpc already expose MMIO as resource value, but still keep IO as BAR value?

Or can we just dump /proc/bus/pci support from now?

Thanks

Yinghai


Subject: [RFC PATCH] PCI: Expose resource value in /proc/bus/pci/devices

Some arch where cpu address (resource value) is not same as pci bus address
(BAR value in pci BAR registers), include sparc, powerpc, microblaze.

Orignally in /proc/bus/pci/devices is exposing device BAR value aka is
user value. later in 396a1a5832 ("[POWERPC] Fix mmap of PCI resource with
hack for X"), in will change to use resource start instead.

Also in 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
to check exposed value with resource start/end in proc mmap path.
|        start = vma->vm_pgoff;
|        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
|        pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
|                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
|        if (start >= pci_start && start < pci_start + size &&
|                        start + nr <= pci_start + size)
That would break sparc that exposed value is still BAR value.

According to Bjorn, we could just pass resource addr instead of BAR.

In the patch:
1. remove those non uniformed pci_resource_to_user.
2. in proc path: proc_bus_pci_mmap==>pci_mmap_fits/pci_mmap_page_range
   all use resource start instead.
3. in sysfs path: pci_mmap_resource will just offset with resource start.
4. all pci_mmap_page_range will all have vma->vm_pgoff with in resource range
   instead of BAR value.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/microblaze/include/asm/pci.h |    5 ---
 arch/microblaze/pci/pci-common.c  |   53 ++------------------------------------
 arch/mips/include/asm/pci.h       |   12 --------
 arch/powerpc/include/asm/pci.h    |    5 ---
 arch/powerpc/kernel/pci-common.c  |   53 ++------------------------------------
 arch/sparc/include/asm/pci_64.h   |    5 ---
 arch/sparc/kernel/pci.c           |   43 ++++++------------------------
 arch/xtensa/kernel/pci.c          |   11 ++-----
 drivers/pci/pci-sysfs.c           |   13 ++-------
 drivers/pci/proc.c                |   16 ++++-------
 include/linux/pci.h               |   15 ----------
 kernel/trace/trace_mmiotrace.c    |   21 +++++----------
 12 files changed, 37 insertions(+), 215 deletions(-)

Index: linux-2.6/arch/microblaze/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/microblaze/include/asm/pci.h
+++ linux-2.6/arch/microblaze/include/asm/pci.h
@@ -81,11 +81,6 @@ extern pgprot_t    pci_phys_mem_access_prot
                      unsigned long size,
                      pgprot_t prot);

-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
-                 const struct resource *rsrc,
-                 resource_size_t *start, resource_size_t *end);
-
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);

Index: linux-2.6/arch/microblaze/pci/pci-common.c
===================================================================
--- linux-2.6.orig/arch/microblaze/pci/pci-common.c
+++ linux-2.6/arch/microblaze/pci/pci-common.c
@@ -169,23 +169,16 @@ static struct resource *__pci_mmap_make_
                            enum pci_mmap_state mmap_state)
 {
     struct pci_controller *hose = pci_bus_to_host(dev->bus);
-    unsigned long io_offset = 0;
     int i, res_bit;

     if (!hose)
         return NULL;        /* should never happen */

     /* If memory, add on the PCI bridge address offset */
-    if (mmap_state == pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-        *offset += hose->pci_mem_offset;
-#endif
+    if (mmap_state == pci_mmap_mem)
         res_bit = IORESOURCE_MEM;
-    } else {
-        io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-        *offset += io_offset;
+    else
         res_bit = IORESOURCE_IO;
-    }

     /*
      * Check that the offset requested corresponds to one of the
@@ -209,7 +202,8 @@ static struct resource *__pci_mmap_make_

         /* found it! construct the final physical address */
         if (mmap_state == pci_mmap_io)
-            *offset += hose->io_base_phys - io_offset;
+            *offset += hose->io_base_phys -
+                 ((unsigned long)hose->io_base_virt - _IO_BASE);
         return rp;
     }

@@ -467,45 +461,6 @@ int pci_mmap_legacy_page_range(struct pc
                    vma->vm_page_prot);
 }

-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-              const struct resource *rsrc,
-              resource_size_t *start, resource_size_t *end)
-{
-    struct pci_controller *hose = pci_bus_to_host(dev->bus);
-    resource_size_t offset = 0;
-
-    if (hose == NULL)
-        return;
-
-    if (rsrc->flags & IORESOURCE_IO)
-        offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-    /* We pass a fully fixed up address to userland for MMIO instead of
-     * a BAR value because X is lame and expects to be able to use that
-     * to pass to /dev/mem !
-     *
-     * That means that we'll have potentially 64 bits values where some
-     * userland apps only expect 32 (like X itself since it thinks only
-     * Sparc has 64 bits MMIO) but if we don't do that, we break it on
-     * 32 bits CHRPs :-(
-     *
-     * Hopefully, the sysfs insterface is immune to that gunk. Once X
-     * has been fixed (and the fix spread enough), we can re-enable the
-     * 2 lines below and pass down a BAR value to userland. In that case
-     * we'll also have to re-enable the matching code in
-     * __pci_mmap_make_offset().
-     *
-     * BenH.
-     */
-#if 0
-    else if (rsrc->flags & IORESOURCE_MEM)
-        offset = hose->pci_mem_offset;
-#endif
-
-    *start = rsrc->start - offset;
-    *end = rsrc->end - offset;
-}
-
 /**
  * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
  * @hose: newly allocated pci_controller to be setup
Index: linux-2.6/arch/mips/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/mips/include/asm/pci.h
+++ linux-2.6/arch/mips/include/asm/pci.h
@@ -80,18 +80,6 @@ extern void pcibios_set_master(struct pc
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
     enum pci_mmap_state mmap_state, int write_combine);

-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-
-static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
-        const struct resource *rsrc, resource_size_t *start,
-        resource_size_t *end)
-{
-    phys_addr_t size = resource_size(rsrc);
-
-    *start = fixup_bigphys_addr(rsrc->start, size);
-    *end = rsrc->start + size;
-}
-
 /*
  * Dynamic DMA mapping stuff.
  * MIPS has everything mapped statically.
Index: linux-2.6/arch/powerpc/include/asm/pci.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/pci.h
+++ linux-2.6/arch/powerpc/include/asm/pci.h
@@ -135,11 +135,6 @@ extern pgprot_t    pci_phys_mem_access_prot
                      unsigned long size,
                      pgprot_t prot);

-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-extern void pci_resource_to_user(const struct pci_dev *dev, int bar,
-                 const struct resource *rsrc,
-                 resource_size_t *start, resource_size_t *end);
-
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
Index: linux-2.6/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci-common.c
+++ linux-2.6/arch/powerpc/kernel/pci-common.c
@@ -308,23 +308,16 @@ static struct resource *__pci_mmap_make_
                            enum pci_mmap_state mmap_state)
 {
     struct pci_controller *hose = pci_bus_to_host(dev->bus);
-    unsigned long io_offset = 0;
     int i, res_bit;

     if (hose == NULL)
         return NULL;        /* should never happen */

     /* If memory, add on the PCI bridge address offset */
-    if (mmap_state == pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-        *offset += hose->pci_mem_offset;
-#endif
+    if (mmap_state == pci_mmap_mem)
         res_bit = IORESOURCE_MEM;
-    } else {
-        io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-        *offset += io_offset;
+    else
         res_bit = IORESOURCE_IO;
-    }

     /*
      * Check that the offset requested corresponds to one of the
@@ -348,7 +341,8 @@ static struct resource *__pci_mmap_make_

         /* found it! construct the final physical address */
         if (mmap_state == pci_mmap_io)
-            *offset += hose->io_base_phys - io_offset;
+            *offset += hose->io_base_phys -
+                 ((unsigned long)hose->io_base_virt - _IO_BASE);
         return rp;
     }

@@ -606,45 +600,6 @@ int pci_mmap_legacy_page_range(struct pc
                    vma->vm_page_prot);
 }

-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-              const struct resource *rsrc,
-              resource_size_t *start, resource_size_t *end)
-{
-    struct pci_controller *hose = pci_bus_to_host(dev->bus);
-    resource_size_t offset = 0;
-
-    if (hose == NULL)
-        return;
-
-    if (rsrc->flags & IORESOURCE_IO)
-        offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-    /* We pass a fully fixed up address to userland for MMIO instead of
-     * a BAR value because X is lame and expects to be able to use that
-     * to pass to /dev/mem !
-     *
-     * That means that we'll have potentially 64 bits values where some
-     * userland apps only expect 32 (like X itself since it thinks only
-     * Sparc has 64 bits MMIO) but if we don't do that, we break it on
-     * 32 bits CHRPs :-(
-     *
-     * Hopefully, the sysfs insterface is immune to that gunk. Once X
-     * has been fixed (and the fix spread enough), we can re-enable the
-     * 2 lines below and pass down a BAR value to userland. In that case
-     * we'll also have to re-enable the matching code in
-     * __pci_mmap_make_offset().
-     *
-     * BenH.
-     */
-#if 0
-    else if (rsrc->flags & IORESOURCE_MEM)
-        offset = hose->pci_mem_offset;
-#endif
-
-    *start = rsrc->start - offset;
-    *end = rsrc->end - offset;
-}
-
 /**
  * pci_process_bridge_OF_ranges - Parse PCI bridge resources from device tree
  * @hose: newly allocated pci_controller to be setup
Index: linux-2.6/arch/sparc/include/asm/pci_64.h
===================================================================
--- linux-2.6.orig/arch/sparc/include/asm/pci_64.h
+++ linux-2.6/arch/sparc/include/asm/pci_64.h
@@ -53,11 +53,6 @@ static inline int pci_get_legacy_ide_irq
 {
     return PCI_IRQ_NONE;
 }
-
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-void pci_resource_to_user(const struct pci_dev *dev, int bar,
-              const struct resource *rsrc,
-              resource_size_t *start, resource_size_t *end);
 #endif /* __KERNEL__ */

 #endif /* __SPARC64_PCI_H */
Index: linux-2.6/arch/sparc/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/pci.c
+++ linux-2.6/arch/sparc/kernel/pci.c
@@ -743,30 +743,21 @@ static int __pci_mmap_make_offset_bus(st
                       enum pci_mmap_state mmap_state)
 {
     struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-    unsigned long space_size, user_offset, user_size;
+    unsigned long start, end;
+    struct resource *res;

-    if (mmap_state == pci_mmap_io) {
-        space_size = resource_size(&pbm->io_space);
-    } else {
-        space_size = resource_size(&pbm->mem_space);
-    }
+    if (mmap_state == pci_mmap_io)
+        res = &pbm->io_space;
+    else
+        res = &pbm->mem_space;

     /* Make sure the request is in range. */
-    user_offset = vma->vm_pgoff << PAGE_SHIFT;
-    user_size = vma->vm_end - vma->vm_start;
+    start = vma->vm_pgoff << PAGE_SHIFT;
+    end = vma->vm_end - vma->vm_start + start - 1;

-    if (user_offset >= space_size ||
-        (user_offset + user_size) > space_size)
+    if (!((res->start <= start) && (res->end >= end)))
         return -EINVAL;

-    if (mmap_state == pci_mmap_io) {
-        vma->vm_pgoff = (pbm->io_space.start +
-                 user_offset) >> PAGE_SHIFT;
-    } else {
-        vma->vm_pgoff = (pbm->mem_space.start +
-                 user_offset) >> PAGE_SHIFT;
-    }
-
     return 0;
 }

@@ -982,22 +973,6 @@ int pci64_dma_supported(struct pci_dev *
     return (device_mask & dma_addr_mask) == dma_addr_mask;
 }

-void pci_resource_to_user(const struct pci_dev *pdev, int bar,
-              const struct resource *rp, resource_size_t *start,
-              resource_size_t *end)
-{
-    struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-    unsigned long offset;
-
-    if (rp->flags & IORESOURCE_IO)
-        offset = pbm->io_space.start;
-    else
-        offset = pbm->mem_space.start;
-
-    *start = rp->start - offset;
-    *end = rp->end - offset;
-}
-
 void pcibios_set_master(struct pci_dev *dev)
 {
     /* No special bus mastering setup handling */
Index: linux-2.6/arch/xtensa/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/pci.c
+++ linux-2.6/arch/xtensa/kernel/pci.c
@@ -288,20 +288,16 @@ __pci_mmap_make_offset(struct pci_dev *d
 {
     struct pci_controller *pci_ctrl = (struct pci_controller*) dev->sysdata;
     unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-    unsigned long io_offset = 0;
     int i, res_bit;

     if (pci_ctrl == 0)
         return -EINVAL;        /* should never happen */

     /* If memory, add on the PCI bridge address offset */
-    if (mmap_state == pci_mmap_mem) {
+    if (mmap_state == pci_mmap_mem)
         res_bit = IORESOURCE_MEM;
-    } else {
-        io_offset = (unsigned long)pci_ctrl->io_space.base;
-        offset += io_offset;
+    else
         res_bit = IORESOURCE_IO;
-    }

     /*
      * Check that the offset requested corresponds to one of the
@@ -325,7 +321,8 @@ __pci_mmap_make_offset(struct pci_dev *d

         /* found it! construct the final physical address */
         if (mmap_state == pci_mmap_io)
-            offset += pci_ctrl->io_space.start - io_offset;
+            offset += pci_ctrl->io_space.start -
+                    pci_ctrl->io_space.base;
         vma->vm_pgoff = offset >> PAGE_SHIFT;
         return 0;
     }
Index: linux-2.6/drivers/pci/pci-sysfs.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6/drivers/pci/pci-sysfs.c
@@ -143,10 +143,9 @@ static ssize_t resource_show(struct devi

     for (i = 0; i < max; i++) {
         struct resource *res =  &pci_dev->resource[i];
-        pci_resource_to_user(pci_dev, i, res, &start, &end);
         str += sprintf(str, "0x%016llx 0x%016llx 0x%016llx\n",
-                   (unsigned long long)start,
-                   (unsigned long long)end,
+                   (unsigned long long)res->start,
+                   (unsigned long long)res->end,
                    (unsigned long long)res->flags);
     }
     return (str - buf);
@@ -999,7 +998,6 @@ static int pci_mmap_resource(struct kobj
     struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
     struct resource *res = attr->private;
     enum pci_mmap_state mmap_type;
-    resource_size_t start, end;
     int i;

     for (i = 0; i < PCI_ROM_RESOURCE; i++)
@@ -1020,12 +1018,7 @@ static int pci_mmap_resource(struct kobj
         return -EINVAL;
     }

-    /* pci_mmap_page_range() expects the same kind of entry as coming
-     * from /proc/bus/pci/ which is a "user visible" value. If this is
-     * different from the resource itself, arch will do necessary fixup.
-     */
-    pci_resource_to_user(pdev, i, res, &start, &end);
-    vma->vm_pgoff += start >> PAGE_SHIFT;
+    vma->vm_pgoff += res->start >> PAGE_SHIFT;
     mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
     return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
 }
Index: linux-2.6/drivers/pci/proc.c
===================================================================
--- linux-2.6.orig/drivers/pci/proc.c
+++ linux-2.6/drivers/pci/proc.c
@@ -343,20 +343,16 @@ static int show_device(struct seq_file *
             dev->irq);

     /* only print standard and ROM resources to preserve compatibility */
-    for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-        resource_size_t start, end;
-        pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
+    for (i = 0; i <= PCI_ROM_RESOURCE; i++)
         seq_printf(m, "\t%16llx",
-            (unsigned long long)(start |
+            (unsigned long long)(dev->resource[i].start |
             (dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
-    }
-    for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-        resource_size_t start, end;
-        pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
+
+    for (i = 0; i <= PCI_ROM_RESOURCE; i++)
         seq_printf(m, "\t%16llx",
             dev->resource[i].start < dev->resource[i].end ?
-            (unsigned long long)(end - start) + 1 : 0);
-    }
+              (unsigned long long)resource_size(&dev->resource[i]) : 0);
+
     seq_putc(m, '\t');
     if (drv)
         seq_printf(m, "%s", drv->name);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -1545,21 +1545,6 @@ static inline const char *pci_name(const
     return dev_name(&pdev->dev);
 }

-
-/* Some archs don't want to expose struct resource to userland as-is
- * in sysfs and /proc
- */
-#ifndef HAVE_ARCH_PCI_RESOURCE_TO_USER
-static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
-        const struct resource *rsrc, resource_size_t *start,
-        resource_size_t *end)
-{
-    *start = rsrc->start;
-    *end = rsrc->end;
-}
-#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
-
-
 /*
  *  The world is not perfect and supplies us with broken PCI devices.
  *  For at least a part of these bugs we need a work-around, so both
Index: linux-2.6/kernel/trace/trace_mmiotrace.c
===================================================================
--- linux-2.6.orig/kernel/trace/trace_mmiotrace.c
+++ linux-2.6/kernel/trace/trace_mmiotrace.c
@@ -62,29 +62,22 @@ static void mmio_trace_start(struct trac
 static void mmio_print_pcidev(struct trace_seq *s, const struct pci_dev *dev)
 {
     int i;
-    resource_size_t start, end;
     const struct pci_driver *drv = pci_dev_driver(dev);

     trace_seq_printf(s, "PCIDEV %02x%02x %04x%04x %x",
              dev->bus->number, dev->devfn,
              dev->vendor, dev->device, dev->irq);
-    /*
-     * XXX: is pci_resource_to_user() appropriate, since we are
-     * supposed to interpret the __ioremap() phys_addr argument based on
-     * these printed values?
-     */
-    for (i = 0; i < 7; i++) {
-        pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
+
+    for (i = 0; i < 7; i++)
         trace_seq_printf(s, " %llx",
-            (unsigned long long)(start |
+            (unsigned long long)(dev->resource[i].start |
             (dev->resource[i].flags & PCI_REGION_FLAG_MASK)));
-    }
-    for (i = 0; i < 7; i++) {
-        pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
+
+    for (i = 0; i < 7; i++)
         trace_seq_printf(s, " %llx",
             dev->resource[i].start < dev->resource[i].end ?
-            (unsigned long long)(end - start) + 1 : 0);
-    }
+              (unsigned long long)resource_size(&dev->resource[i]) : 0);
+
     if (drv)
         trace_seq_printf(s, " %s\n", drv->name);
     else
