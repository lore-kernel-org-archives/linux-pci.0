Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Mar 2016 05:26:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 02/59] sparc/PCI: Use correct bus address to resource
 offset
Message-ID: <20160312112634.GB27552@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
 <1456366370-28995-3-git-send-email-yinghai@kernel.org>
 <20160310182440.GC14873@localhost>
 <CAE9FiQX=ecBEuABmkfGwN3p3H5YU-XbXDguKKbArj6weQbbAPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQX=ecBEuABmkfGwN3p3H5YU-XbXDguKKbArj6weQbbAPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 12, 2016 at 12:22:06AM -0800, Yinghai Lu wrote:
> On Thu, Mar 10, 2016 at 10:24 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
> >> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
> >
> > Just double-checking that your ioport space really contains 256M ports.
> > It's fine if it does; it's just a little unusual.
> 
> Then according to davem, OF said so.
> ...
> >> @@ -733,30 +733,28 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
> >>  static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struct *vma,
> >>                                     enum pci_mmap_state mmap_state)
> >>  {
> >> -     struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
> >> -     unsigned long space_size, user_offset, user_size;
> >> -
> >> -     if (mmap_state == pci_mmap_io) {
> >> -             space_size = resource_size(&pbm->io_space);
> >> -     } else {
> >> -             space_size = resource_size(&pbm->mem_space);
> >> -     }
> >> +     unsigned long user_offset, user_size;
> >> +     struct resource res, *root_bus_res;
> >> +     struct pci_bus_region region;
> >>
> >>       /* Make sure the request is in range. */
> >>       user_offset = vma->vm_pgoff << PAGE_SHIFT;
> >>       user_size = vma->vm_end - vma->vm_start;
> >>
> >> -     if (user_offset >= space_size ||
> >> -         (user_offset + user_size) > space_size)
> >> +     region.start = user_offset;
> >> +     region.end = user_offset + user_size - 1;
> >> +     memset(&res, 0, sizeof(res));
> >> +     if (mmap_state == pci_mmap_io)
> >> +             res.flags = IORESOURCE_IO;
> >> +     else
> >> +             res.flags = IORESOURCE_MEM;
> >> +
> >> +     pcibios_bus_to_resource(pdev->bus, &res, &region);
> >> +     root_bus_res = pci_find_root_bus_resource(pdev->bus, &res);
> >> +     if (!root_bus_res)
> >>               return -EINVAL;
> >>
> >> -     if (mmap_state == pci_mmap_io) {
> >> -             vma->vm_pgoff = (pbm->io_space.start +
> >> -                              user_offset) >> PAGE_SHIFT;
> >> -     } else {
> >> -             vma->vm_pgoff = (pbm->mem_space.start +
> >> -                              user_offset) >> PAGE_SHIFT;
> >> -     }
> >> +     vma->vm_pgoff = res.start >> PAGE_SHIFT;
> >>
> >>       return 0;
> >
> > This needs to explain what's unique about sparc that means it needs
> > pci_find_root_bus_resource() when no other arch does.
> 
> I just follow the old code to get pbm->io_offset, mem_offset, mem64_offset.
> at the same use that to check boundary with that checking.

That's not enough of a reason to add a new interface.  I don't think
there is anything unique about sparc, so if the existing interfaces
work for all the other arches, they ought to work for sparc too.

> > This is used in the pci_mmap_resource() path.  I don't understand how
> > that path works on sparc.  I tried to work through the simple case of
> > a user mapping the first 4096 bytes of a BAR.  Assume the BAR is 4096
> > bytes in size:
> >
> >   # User does something like this:
> >   #   mmap(NULL, 4096, ..., "/sys/.../resourceN", 0);
> >
> >   pci_mmap_resource
> >
> >     # At entry, "vma->vm_pgoff" is the offset into the BAR (in pages).
> >     # In this case, the user wants the first page of the BAR, so
> >     # vma->vm_pgoff == 0.
> >
> >     # "res" is the the pdev->resource[n], which contains the CPU
> >     # physical address of the BAR.
> >
> >     pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)
> >       start = vma->vm_pgoff           # == 0
> >       size = 4096
> >       pci_start = 0                   # offset into BAR (PCI_MMAP_SYSFS case)
> >
> >       # we return 1 because [0x0000-0x0fff] is a valid area in this
> >       # BAR
> >
> >     pci_resource_to_user(pdev, i, res, &start, &end);
> >
> >     # On most platforms: pci_resource_to_user() copies res->start to
> >     # *start, so "start" is the CPU physical address of the
> >     # BAR.
> >
> >     # On sparc: pci_resource_to_user() calls pcibios_resource_to_bus()
> >     # (see below), so "start" is the PCI bus address of the BAR.
> >
> >     vma->vm_pgoff += start >> PAGE_SHIFT;
> >
> >     # On most platforms: "vma->vm_pgoff" is now the CPU physical page
> >     # number of the part of the BAR we're mapping.
> >
> >     # On sparc: "vma->vm_pgoff" is the PCI bus page number of the part
> >     # of the BAR we're mapping.  This seems wrong: doesn't the VM
> >     # system assume vm_pgoff is a CPU physical page number?
> >
> >     if (... && iomem_is_exclusive(start))
> >
> >     # On most platforms, "start" is a CPU physical address, and
> >     # iomem_is_exclusive() looks it up in the iomem_resource tree,
> >     # which contains resources of CPU physical addresses.
> >
> >     # On sparc, "start" is a PCI bus address.  How can this work in
> >     # iomem_is_exclusive()?  I assume the resources in iomem_resource
> >     # still contain CPU physical addresses, not PCI bus addresses,
> >     # don't they?
> 
> Good findings, that would break the sparc for a while.
> (we should use res->start instead)

We haven't even gotten to the part that your patch changes.  If my
analysis is correct, this call to iomem_is_exclusive() is already
broken on sparc.  I think we need the following patches:

commit 4688b92991e43ab3b286d11e8f388b1b39d10b1b
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat Mar 12 04:27:39 2016 -0600

    PCI: Fix iomem_is_exclusive() checking in pci_mmap_resource()
    
    iomem_is_exclusive() requires a CPU physical address, but on some arches we
    supplied a PCI bus address instead.
    
    On most arches, pci_resource_to_user(res) returns "res->start", which is a
    CPU physical address.  But on microblaze, mips, powerpc, and sparc, it
    returns the PCI bus address corresponding to "res->start".
    
    The result is that pci_mmap_resource() may fail when it shouldn't (if the
    bus address happens to match an existing resource), or it may succeed when
    it should fail (if the resource is exclusive but the bus address doesn't
    match it).
    
    Call iomem_is_exclusive() with "res->start", which is always a CPU physical
    address, not the result of pci_resource_to_user().
    
    Fixes: e8de1481fd71 ("resource: allow MMIO exclusivity for device drivers")
    Suggested-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Arjan van de Ven <arjan@linux.intel.com>

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 95d9e7b..1559d67 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1004,6 +1004,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
+	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+		return -EINVAL;
+
 	if (!pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)) {
 		WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
 			current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
@@ -1020,10 +1023,6 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
 	pci_resource_to_user(pdev, i, res, &start, &end);
 	vma->vm_pgoff += start >> PAGE_SHIFT;
 	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
-
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(start))
-		return -EINVAL;
-
 	return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
 }
 
commit fd88769b8c4d840278137f9ca3968da5aa09c97f
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat Mar 12 05:10:11 2016 -0600

    alpha/PCI: Only check iomem_is_exclusive() for IORESOURCE_MEM, not IORESOURCE_IO
    
    The alpha pci_mmap_resource() is used for both IORESOURCE_MEM and
    IORESOURCE_IO resources, but iomem_is_exclusive() is only applicable for
    IORESOURCE_MEM.
    
    Call iomem_is_exclusive() only for IORESOURCE_MEM resources, and do it
    earlier to match the generic version of pci_mmap_resource().
    
    Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 99e8d47..92c0d46 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -77,10 +77,10 @@ static int pci_mmap_resource(struct kobject *kobj,
 	if (i >= PCI_ROM_RESOURCE)
 		return -ENODEV;
 
-	if (!__pci_mmap_fits(pdev, i, vma, sparse))
+	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-	if (iomem_is_exclusive(res->start))
+	if (!__pci_mmap_fits(pdev, i, vma, sparse))
 		return -EINVAL;
 
 	pcibios_resource_to_bus(pdev->bus, &bar, res);
