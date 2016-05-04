Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <CAE9FiQU=e2bf=+KDrOETf_T-KPLQsSDiG5GqVFqgtvSWXwUz4w@mail.gmail.com>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	<1460074573-7481-5-git-send-email-yinghai@kernel.org>
	<20160422204920.GA17215@localhost>
	<CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
	<20160428135607.GA12470@localhost>
	<CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
	<CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
	<1462322260.30470.76.camel@kernel.crashing.org>
	<20160504012531.GB17170@localhost>
	<CAE9FiQU=e2bf=+KDrOETf_T-KPLQsSDiG5GqVFqgtvSWXwUz4w@mail.gmail.com>
Date: Tue, 3 May 2016 22:52:33 -0700
Message-ID: <CAE9FiQV19OUsSL34GzDXYtVG=Xs724CpwHNfu3HCmYMUqbmrqQ@mail.gmail.com>
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

On Tue, May 3, 2016 at 10:08 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, May 3, 2016 at 6:25 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> I did not propose changing any user-visible ABI.  To recap what I did
>> propose:
>
> I want to avoid introduce one strange pci_user_to_resource.
>
>>
>>   - The sysfs path uses offsets between 0 and BAR size on all arches.
>>     It uses pci_resource_to_user() today, but I think it should not.
>>
>>   - The procfs path uses offsets of resource values (CPU physical
>>     addresses) on most architectures, but uses something else, e.g.,
>>     BAR values, on others.  pci_resource_to_user() does this
>>     translation.  The procfs path does not use pci_resource_to_user()
>>     today, but I think it should.
>
> current powerpc pci_resource_to_user is strange:
> it will return resource start for io mem.
> but will return BAR (?) start for io port.
>
> sparc pci_resource_to_user does return BAR value for iomem.
>
>>
>>   - This implies that pci_mmap_page_range() should deal with resource
>>     values (CPU physical addresses), and proc_bus_pci_mmap() should do
>>     any necessary arch-specific translation from BAR values to
>>     resource values.
>
> so will need one different version pci_user_to_resource.
> and can not use pcibios_bus_to_resource directly, and will be another mess.

looks like we can avoid that pci_user_to_resource() via trying out.

Please check it:


Subject: [RFC PATCH] PCI: Let pci_mmap_page_range() take resource addr

Some arch where cpu address (resource value) is not same as pci bus address
(BAR value in pci BAR registers), include sparc, powerpc, microblaze.

In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
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
1. in proc path: proc_bus_pci_mmap, try convert back to resource
   before calling pci_mmap_page_range
2. in sysfs path: pci_mmap_resource will just offset with resource start.
3. all pci_mmap_page_range will all have vma->vm_pgoff with in resource range
   instead of BAR value.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 arch/microblaze/pci/pci-common.c |   14 ++++----------
 arch/powerpc/kernel/pci-common.c |   14 ++++----------
 arch/sparc/kernel/pci.c          |   27 +++++++++------------------
 arch/xtensa/kernel/pci.c         |   11 ++++-------
 drivers/pci/pci-sysfs.c          |    8 +-------
 drivers/pci/proc.c               |   13 +++++++++++++
 6 files changed, 35 insertions(+), 52 deletions(-)

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
@@ -999,7 +999,6 @@ static int pci_mmap_resource(struct kobj
     struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
     struct resource *res = attr->private;
     enum pci_mmap_state mmap_type;
-    resource_size_t start, end;
     int i;

     for (i = 0; i < PCI_ROM_RESOURCE; i++)
@@ -1020,12 +1019,7 @@ static int pci_mmap_resource(struct kobj
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
@@ -231,13 +231,26 @@ static int proc_bus_pci_mmap(struct file
 {
     struct pci_dev *dev = PDE_DATA(file_inode(file));
     struct pci_filp_private *fpriv = file->private_data;
+    resource_size_t start, end, offset;
+    struct resource *res;
     int i, ret;

     if (!capable(CAP_SYS_RAWIO))
         return -EPERM;

+    offset = vma->vm_pgoff << PAGE_SHIFT;
+
     /* Make sure the caller is mapping a real resource for this device */
     for (i = 0; i < PCI_ROM_RESOURCE; i++) {
+        res = &dev->resource[i];
+        if (!res->flags)
+            continue;
+
+        pci_resource_to_user(dev, i, res, &start, &end);
+        if (!(offset >= start && offset <= end))
+            continue;
+
+        vma->vm_pgoff = (res->start + (offset - start)) >> PAGE_SHIFT;
         if (pci_mmap_fits(dev, i, vma,  PCI_MMAP_PROCFS))
             break;
     }
