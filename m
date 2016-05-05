Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAE9FiQXEBkVak0No9dfOidzCrR+UVu44WyBEK8SqTUSiJKeJbg@mail.gmail.com>
References: <1460074573-7481-5-git-send-email-yinghai@kernel.org>
	<20160422204920.GA17215@localhost>
	<CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
	<20160428135607.GA12470@localhost>
	<CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
	<CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
	<1462322260.30470.76.camel@kernel.crashing.org>
	<20160504012531.GB17170@localhost>
	<CAE9FiQU=e2bf=+KDrOETf_T-KPLQsSDiG5GqVFqgtvSWXwUz4w@mail.gmail.com>
	<CAE9FiQV19OUsSL34GzDXYtVG=Xs724CpwHNfu3HCmYMUqbmrqQ@mail.gmail.com>
	<20160504151722.GA22051@localhost>
	<CAE9FiQXEBkVak0No9dfOidzCrR+UVu44WyBEK8SqTUSiJKeJbg@mail.gmail.com>
Date: Wed, 4 May 2016 17:25:16 -0700
Message-ID: <CAE9FiQUEMq4aj2iAq=P0xu4=1MGuOWgOubpkn=2h+YLXgwJKRQ@mail.gmail.com>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 4, 2016 at 11:46 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, May 4, 2016 at 8:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> My goal is to make pci_mmap_resource() and proc_bus_pci_mmap() look
>> very similar, e.g.,
>>
>>   /* locate resource */
>>   pci_user_to_resource()                # only in proc_bus_pci_mmap()
>>   if (!pci_mmap_fits()) {
>>     WARN(...);
>>     return -EINVAL;
>>   }
>>   pci_mmap_page_range();

Please check v2.

Subject: [RFC PATCH v2] PCI: Let pci_mmap_page_range() take resource addr

In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
to check exposed value with resource start/end in proc mmap path.
|        start = vma->vm_pgoff;
|        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
|        pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
|                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
|        if (start >= pci_start && start < pci_start + size &&
|                        start + nr <= pci_start + size)

That would break sparc that exposed value is still BAR value.

In the patch:
1. in proc path: proc_bus_pci_mmap, try convert back to resource
   before calling pci_mmap_page_range
2. in sysfs path: pci_mmap_resource will just offset with resource start.
3. all pci_mmap_page_range will all have vma->vm_pgoff with in resource
   range instead of BAR value.
4. remove __pci_mmap_make_offset, as the checking is done
   in pci_mmap_fits().

-v2: add pci_user_to_resource and remove __pci_mmap_make_offset

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/microblaze/pci/pci-common.c |   94 ++++++++-----------------------
 arch/powerpc/kernel/pci-common.c |   95 ++++++++-----------------------
 arch/sparc/kernel/pci.c          |  117 ---------------------------------------
 arch/xtensa/kernel/pci.c         |   73 ++----------------------
 drivers/pci/pci-sysfs.c          |   23 ++++---
 drivers/pci/pci.h                |    2
 drivers/pci/proc.c               |   59 ++++++++++++++++---
 7 files changed, 124 insertions(+), 339 deletions(-)

Index: linux-2.6/arch/microblaze/pci/pci-common.c
===================================================================
--- linux-2.6.orig/arch/microblaze/pci/pci-common.c
+++ linux-2.6/arch/microblaze/pci/pci-common.c
@@ -153,63 +153,25 @@ void pcibios_set_master(struct pci_dev *
  *  -- paulus.
  */

-/*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-                           resource_size_t *offset,
-                           enum pci_mmap_state mmap_state)
+static struct resource *pci_find_resource(struct pci_dev *dev,
+                resource_size_t offset, int flags)
 {
-    struct pci_controller *hose = pci_bus_to_host(dev->bus);
-    unsigned long io_offset = 0;
-    int i, res_bit;
-
-    if (!hose)
-        return NULL;        /* should never happen */
-
-    /* If memory, add on the PCI bridge address offset */
-    if (mmap_state == pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-        *offset += hose->pci_mem_offset;
-#endif
-        res_bit = IORESOURCE_MEM;
-    } else {
-        io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-        *offset += io_offset;
-        res_bit = IORESOURCE_IO;
-    }
+    int i;

-    /*
-     * Check that the offset requested corresponds to one of the
-     * resources of the device.
-     */
     for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
         struct resource *rp = &dev->resource[i];
-        int flags = rp->flags;

-        /* treat ROM as memory (should be already) */
-        if (i == PCI_ROM_RESOURCE)
-            flags |= IORESOURCE_MEM;
+        if (!(rp->flags & flags))
+            continue;

-        /* Active and same type? */
-        if ((flags & res_bit) == 0)
+        if (pci_resource_len(dev, i) == 0)
             continue;

         /* In the range of this resource? */
-        if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
+        if (offset < (rp->start & PAGE_MASK) ||
+            offset > rp->end)
             continue;

-        /* found it! construct the final physical address */
-        if (mmap_state == pci_mmap_io)
-            *offset += hose->io_base_phys - io_offset;
         return rp;
     }

@@ -236,7 +198,7 @@ static pgprot_t __pci_mmap_set_pgprot(st
     if (mmap_state != pci_mmap_mem)
         write_combine = 0;
     else if (write_combine == 0) {
-        if (rp->flags & IORESOURCE_PREFETCH)
+        if (rp && (rp->flags & IORESOURCE_PREFETCH))
             write_combine = 1;
     }

@@ -256,27 +218,13 @@ pgprot_t pci_phys_mem_access_prot(struct
     struct pci_dev *pdev = NULL;
     struct resource *found = NULL;
     resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
-    int i;

     if (page_is_ram(pfn))
         return prot;

     prot = pgprot_noncached(prot);
     for_each_pci_dev(pdev) {
-        for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-            struct resource *rp = &pdev->resource[i];
-            int flags = rp->flags;
-
-            /* Active and same type? */
-            if ((flags & IORESOURCE_MEM) == 0)
-                continue;
-            /* In the range of this resource? */
-            if (offset < (rp->start & PAGE_MASK) ||
-                offset > rp->end)
-                continue;
-            found = rp;
-            break;
-        }
+        found = pci_find_resource(pdev, offset, IORESOURCE_MEM);
         if (found)
             break;
     }
@@ -305,14 +253,24 @@ pgprot_t pci_phys_mem_access_prot(struct
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
             enum pci_mmap_state mmap_state, int write_combine)
 {
+    struct pci_controller *hose = pci_bus_to_host(dev->bus);
     resource_size_t offset =
         ((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
     struct resource *rp;
-    int ret;
+    int ret, flags;
+
+    if (!hose)
+        return -EINVAL;         /* should never happen */

-    rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
-    if (rp == NULL)
-        return -EINVAL;
+    if (mmap_state == pci_mmap_mem)
+        flags = IORESOURCE_MEM;
+    else
+        flags = IORESOURCE_IO;
+
+    rp = pci_find_resource(dev, offset, flags);
+    if (mmap_state == pci_mmap_io)
+        *offset += hose->io_base_phys -
+             ((unsigned long)hose->io_base_virt - _IO_BASE);

     vma->vm_pgoff = offset >> PAGE_SHIFT;
     vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
@@ -491,9 +449,7 @@ void pci_resource_to_user(const struct p
      *
      * Hopefully, the sysfs insterface is immune to that gunk. Once X
      * has been fixed (and the fix spread enough), we can re-enable the
-     * 2 lines below and pass down a BAR value to userland. In that case
-     * we'll also have to re-enable the matching code in
-     * __pci_mmap_make_offset().
+     * 2 lines below and pass down a BAR value to userland.
      *
      * BenH.
      */
Index: linux-2.6/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci-common.c
+++ linux-2.6/arch/powerpc/kernel/pci-common.c
@@ -292,63 +292,25 @@ static int pci_read_irq_line(struct pci_
  *  -- paulus.
  */

-/*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
-                           resource_size_t *offset,
-                           enum pci_mmap_state mmap_state)
+static struct resource *pci_find_resource(struct pci_dev *dev,
+        resource_size_t offset, int flags)
 {
-    struct pci_controller *hose = pci_bus_to_host(dev->bus);
-    unsigned long io_offset = 0;
-    int i, res_bit;
-
-    if (hose == NULL)
-        return NULL;        /* should never happen */
-
-    /* If memory, add on the PCI bridge address offset */
-    if (mmap_state == pci_mmap_mem) {
-#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
-        *offset += hose->pci_mem_offset;
-#endif
-        res_bit = IORESOURCE_MEM;
-    } else {
-        io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-        *offset += io_offset;
-        res_bit = IORESOURCE_IO;
-    }
+    int i;

-    /*
-     * Check that the offset requested corresponds to one of the
-     * resources of the device.
-     */
     for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
         struct resource *rp = &dev->resource[i];
-        int flags = rp->flags;

-        /* treat ROM as memory (should be already) */
-        if (i == PCI_ROM_RESOURCE)
-            flags |= IORESOURCE_MEM;
+        if (!(rp->flags & flags))
+            continue;

-        /* Active and same type? */
-        if ((flags & res_bit) == 0)
+        if (pci_resource_len(dev, i) == 0)
             continue;

         /* In the range of this resource? */
-        if (*offset < (rp->start & PAGE_MASK) || *offset > rp->end)
+        if (offset < (rp->start & PAGE_MASK) ||
+            offset > rp->end)
             continue;

-        /* found it! construct the final physical address */
-        if (mmap_state == pci_mmap_io)
-            *offset += hose->io_base_phys - io_offset;
         return rp;
     }

@@ -374,7 +336,7 @@ static pgprot_t __pci_mmap_set_pgprot(st
     if (mmap_state != pci_mmap_mem)
         write_combine = 0;
     else if (write_combine == 0) {
-        if (rp->flags & IORESOURCE_PREFETCH)
+        if (rp && (rp->flags & IORESOURCE_PREFETCH))
             write_combine = 1;
     }

@@ -385,6 +347,7 @@ static pgprot_t __pci_mmap_set_pgprot(st
         return pgprot_noncached(protection);
 }

+
 /*
  * This one is used by /dev/mem and fbdev who have no clue about the
  * PCI device, it tries to find the PCI device first and calls the
@@ -398,27 +361,13 @@ pgprot_t pci_phys_mem_access_prot(struct
     struct pci_dev *pdev = NULL;
     struct resource *found = NULL;
     resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
-    int i;

     if (page_is_ram(pfn))
         return prot;

     prot = pgprot_noncached(prot);
     for_each_pci_dev(pdev) {
-        for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-            struct resource *rp = &pdev->resource[i];
-            int flags = rp->flags;
-
-            /* Active and same type? */
-            if ((flags & IORESOURCE_MEM) == 0)
-                continue;
-            /* In the range of this resource? */
-            if (offset < (rp->start & PAGE_MASK) ||
-                offset > rp->end)
-                continue;
-            found = rp;
-            break;
-        }
+        found = pci_find_resource(pdev, offset, IORESOURCE_MEM);
         if (found)
             break;
     }
@@ -448,14 +397,24 @@ pgprot_t pci_phys_mem_access_prot(struct
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
             enum pci_mmap_state mmap_state, int write_combine)
 {
+    struct pci_controller *hose = pci_bus_to_host(dev->bus);
     resource_size_t offset =
         ((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
     struct resource *rp;
-    int ret;
+    int ret, flags;
+
+    if (hose == NULL)
+        return -EINVAL;         /* should never happen */
+
+    if (mmap_state == pci_mmap_mem)
+        flags = IORESOURCE_MEM;
+    else
+        flags = IORESOURCE_IO;
+    rp = pci_find_resource(dev, offset, flags);

-    rp = __pci_mmap_make_offset(dev, &offset, mmap_state);
-    if (rp == NULL)
-        return -EINVAL;
+    if (mmap_state == pci_mmap_io)
+        offset += hose->io_base_phys -
+              ((unsigned long)hose->io_base_virt - _IO_BASE);

     vma->vm_pgoff = offset >> PAGE_SHIFT;
     vma->vm_page_prot = __pci_mmap_set_pgprot(dev, rp,
@@ -630,9 +589,7 @@ void pci_resource_to_user(const struct p
      *
      * Hopefully, the sysfs insterface is immune to that gunk. Once X
      * has been fixed (and the fix spread enough), we can re-enable the
-     * 2 lines below and pass down a BAR value to userland. In that case
-     * we'll also have to re-enable the matching code in
-     * __pci_mmap_make_offset().
+     * 2 lines below and pass down a BAR value to userland.
      *
      * BenH.
      */
Index: linux-2.6/arch/sparc/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/pci.c
+++ linux-2.6/arch/sparc/kernel/pci.c
@@ -732,119 +732,6 @@ int pcibios_enable_device(struct pci_dev

 /* Platform support for /proc/bus/pci/X/Y mmap()s. */

-/* If the user uses a host-bridge as the PCI device, he may use
- * this to perform a raw mmap() of the I/O or MEM space behind
- * that controller.
- *
- * This can be useful for execution of x86 PCI bios initialization code
- * on a PCI card, like the xfree86 int10 stuff does.
- */
-static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct
vm_area_struct *vma,
-                      enum pci_mmap_state mmap_state)
-{
-    struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-    unsigned long space_size, user_offset, user_size;
-
-    if (mmap_state == pci_mmap_io) {
-        space_size = resource_size(&pbm->io_space);
-    } else {
-        space_size = resource_size(&pbm->mem_space);
-    }
-
-    /* Make sure the request is in range. */
-    user_offset = vma->vm_pgoff << PAGE_SHIFT;
-    user_size = vma->vm_end - vma->vm_start;
-
-    if (user_offset >= space_size ||
-        (user_offset + user_size) > space_size)
-        return -EINVAL;
-
-    if (mmap_state == pci_mmap_io) {
-        vma->vm_pgoff = (pbm->io_space.start +
-                 user_offset) >> PAGE_SHIFT;
-    } else {
-        vma->vm_pgoff = (pbm->mem_space.start +
-                 user_offset) >> PAGE_SHIFT;
-    }
-
-    return 0;
-}
-
-/* Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static int __pci_mmap_make_offset(struct pci_dev *pdev,
-                  struct vm_area_struct *vma,
-                  enum pci_mmap_state mmap_state)
-{
-    unsigned long user_paddr, user_size;
-    int i, err;
-
-    /* First compute the physical address in vma->vm_pgoff,
-     * making sure the user offset is within range in the
-     * appropriate PCI space.
-     */
-    err = __pci_mmap_make_offset_bus(pdev, vma, mmap_state);
-    if (err)
-        return err;
-
-    /* If this is a mapping on a host bridge, any address
-     * is OK.
-     */
-    if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_HOST)
-        return err;
-
-    /* Otherwise make sure it's in the range for one of the
-     * device's resources.
-     */
-    user_paddr = vma->vm_pgoff << PAGE_SHIFT;
-    user_size = vma->vm_end - vma->vm_start;
-
-    for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-        struct resource *rp = &pdev->resource[i];
-        resource_size_t aligned_end;
-
-        /* Active? */
-        if (!rp->flags)
-            continue;
-
-        /* Same type? */
-        if (i == PCI_ROM_RESOURCE) {
-            if (mmap_state != pci_mmap_mem)
-                continue;
-        } else {
-            if ((mmap_state == pci_mmap_io &&
-                 (rp->flags & IORESOURCE_IO) == 0) ||
-                (mmap_state == pci_mmap_mem &&
-                 (rp->flags & IORESOURCE_MEM) == 0))
-                continue;
-        }
-
-        /* Align the resource end to the next page address.
-         * PAGE_SIZE intentionally added instead of (PAGE_SIZE - 1),
-         * because actually we need the address of the next byte
-         * after rp->end.
-         */
-        aligned_end = (rp->end + PAGE_SIZE) & PAGE_MASK;
-
-        if ((rp->start <= user_paddr) &&
-            (user_paddr + user_size) <= aligned_end)
-            break;
-    }
-
-    if (i > PCI_ROM_RESOURCE)
-        return -EINVAL;
-
-    return 0;
-}
-
 /* Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
@@ -868,10 +755,6 @@ int pci_mmap_page_range(struct pci_dev *
 {
     int ret;

-    ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-    if (ret < 0)
-        return ret;
-
     __pci_mmap_set_pgprot(dev, vma, mmap_state);

     vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
Index: linux-2.6/arch/xtensa/kernel/pci.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/pci.c
+++ linux-2.6/arch/xtensa/kernel/pci.c
@@ -272,68 +272,6 @@ pci_controller_num(struct pci_dev *dev)
  */

 /*
- * Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static __inline__ int
-__pci_mmap_make_offset(struct pci_dev *dev, struct vm_area_struct *vma,
-               enum pci_mmap_state mmap_state)
-{
-    struct pci_controller *pci_ctrl = (struct pci_controller*) dev->sysdata;
-    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-    unsigned long io_offset = 0;
-    int i, res_bit;
-
-    if (pci_ctrl == 0)
-        return -EINVAL;        /* should never happen */
-
-    /* If memory, add on the PCI bridge address offset */
-    if (mmap_state == pci_mmap_mem) {
-        res_bit = IORESOURCE_MEM;
-    } else {
-        io_offset = (unsigned long)pci_ctrl->io_space.base;
-        offset += io_offset;
-        res_bit = IORESOURCE_IO;
-    }
-
-    /*
-     * Check that the offset requested corresponds to one of the
-     * resources of the device.
-     */
-    for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-        struct resource *rp = &dev->resource[i];
-        int flags = rp->flags;
-
-        /* treat ROM as memory (should be already) */
-        if (i == PCI_ROM_RESOURCE)
-            flags |= IORESOURCE_MEM;
-
-        /* Active and same type? */
-        if ((flags & res_bit) == 0)
-            continue;
-
-        /* In the range of this resource? */
-        if (offset < (rp->start & PAGE_MASK) || offset > rp->end)
-            continue;
-
-        /* found it! construct the final physical address */
-        if (mmap_state == pci_mmap_io)
-            offset += pci_ctrl->io_space.start - io_offset;
-        vma->vm_pgoff = offset >> PAGE_SHIFT;
-        return 0;
-    }
-
-    return -EINVAL;
-}
-
-/*
  * Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
  * device mapping.
  */
@@ -366,11 +304,16 @@ int pci_mmap_page_range(struct pci_dev *
             enum pci_mmap_state mmap_state,
             int write_combine)
 {
+    struct pci_controller *pci_ctrl = (struct pci_controller *)dev->sysdata;
+    unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
     int ret;

-    ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-    if (ret < 0)
-        return ret;
+    if (pci_ctrl == 0)
+        return -EINVAL;        /* should never happen */
+
+    if (mmap_state == pci_mmap_io)
+        offset += pci_ctrl->io_space.start - pci_ctrl->io_space.base;
+    vma->vm_pgoff = offset >> PAGE_SHIFT;

     __pci_mmap_set_pgprot(dev, vma, mmap_state, write_combine);

Index: linux-2.6/drivers/pci/pci-sysfs.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6/drivers/pci/pci-sysfs.c
@@ -967,12 +967,23 @@ void pci_remove_legacy_files(struct pci_
 #ifdef HAVE_PCI_MMAP

 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
+          enum pci_mmap_state mmap_type,
           enum pci_mmap_api mmap_api)
 {
     unsigned long nr, start, size, pci_start;
+    int res_bit;

     if (pci_resource_len(pdev, resno) == 0)
         return 0;
+
+    if (mmap_type == pci_mmap_mem)
+        res_bit = IORESOURCE_MEM;
+    else
+        res_bit = IORESOURCE_IO;
+
+    if (!(pci_resource_flags(pdev, resno) & res_bit))
+        return 0;
+
     nr = vma_pages(vma);
     start = vma->vm_pgoff;
     size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
@@ -999,7 +1010,6 @@ static int pci_mmap_resource(struct kobj
     struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
     struct resource *res = attr->private;
     enum pci_mmap_state mmap_type;
-    resource_size_t start, end;
     int i;

     for (i = 0; i < PCI_ROM_RESOURCE; i++)
@@ -1011,7 +1021,8 @@ static int pci_mmap_resource(struct kobj
     if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
         return -EINVAL;

-    if (!pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)) {
+    mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+    if (!pci_mmap_fits(pdev, i, vma, mmap_type, PCI_MMAP_SYSFS)) {
         WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page
0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
             current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
             pci_name(pdev), i,
@@ -1020,13 +1031,7 @@ static int pci_mmap_resource(struct kobj
         return -EINVAL;
     }

-    /* pci_mmap_page_range() expects the same kind of entry as coming
-     * from /proc/bus/pci/ which is a "user visible" value. If this is
-     * different from the resource itself, arch will do necessary fixup.
-     */
-    pci_resource_to_user(pdev, i, res, &start, &end);
-    vma->vm_pgoff += start >> PAGE_SHIFT;
-    mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+    vma->vm_pgoff += res->start >> PAGE_SHIFT;
     return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
 }

Index: linux-2.6/drivers/pci/proc.c
===================================================================
--- linux-2.6.orig/drivers/pci/proc.c
+++ linux-2.6/drivers/pci/proc.c
@@ -227,26 +227,67 @@ static long proc_bus_pci_ioctl(struct fi
 }

 #ifdef HAVE_PCI_MMAP
+
+static int pci_user_to_resource(struct pci_dev *dev, resource_size_t *offset,
+                resource_size_t size, int flags)
+{
+    int i;
+
+    for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+        resource_size_t start, end;
+        struct resource *res = &dev->resource[i];
+
+        if (!(res->flags & flags))
+            continue;
+
+        if (pci_resource_len(dev, i) == 0)
+            continue;
+
+        pci_resource_to_user(dev, i, res, &start, &end);
+        if (start <= *offset && (*offset + size - 1) <= end) {
+            *offset = res->start + (*offset - start);
+            return i;
+        }
+
+        return i;
+    }
+
+    return -ENODEV;
+}
+
 static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
     struct pci_dev *dev = PDE_DATA(file_inode(file));
     struct pci_filp_private *fpriv = file->private_data;
-    int i, ret;
+    enum pci_mmap_state mmap_type = fpriv->mmap_state;
+    resource_size_t offset, size;
+    int i, ret, flags;

     if (!capable(CAP_SYS_RAWIO))
         return -EPERM;

-    /* Make sure the caller is mapping a real resource for this device */
-    for (i = 0; i < PCI_ROM_RESOURCE; i++) {
-        if (pci_mmap_fits(dev, i, vma,  PCI_MMAP_PROCFS))
-            break;
-    }
-
-    if (i >= PCI_ROM_RESOURCE)
+    offset = vma->vm_pgoff << PAGE_SHIFT;
+    size = vma->vm_end - vma->vm_start;
+    if (mmap_type == pci_mmap_mem)
+        flags = IORESOURCE_MEM;
+    else
+        flags = IORESOURCE_IO;
+    i = pci_user_to_resource(dev, &offset, size, flags);
+    if (i < 0)
         return -ENODEV;

+    vma->vm_pgoff = offset >> PAGE_SHIFT;
+    if (!pci_mmap_fits(dev, i, vma, mmap_type, PCI_MMAP_PROCFS)) {
+        WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page
0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
+            current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
+            pci_name(dev), i,
+            (u64)pci_resource_start(dev, i),
+            (u64)pci_resource_len(dev, i));
+        return -EINVAL;
+    }
+
     ret = pci_mmap_page_range(dev, vma,
-                  fpriv->mmap_state,
+                  mmap_type,
                   fpriv->write_combine);
     if (ret < 0)
         return ret;
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -30,7 +30,7 @@ enum pci_mmap_api {
     PCI_MMAP_PROCFS    /* mmap on /proc/bus/pci/<BDF> */
 };
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
-          enum pci_mmap_api mmap_api);
+          enum pci_mmap_state mmap_type, enum pci_mmap_api mmap_api);
 #endif
 int pci_probe_reset_function(struct pci_dev *dev);
