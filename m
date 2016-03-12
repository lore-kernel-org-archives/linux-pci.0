Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33154 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbcCLIWI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Mar 2016 03:22:08 -0500
MIME-Version: 1.0
In-Reply-To: <20160310182440.GC14873@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
	<1456366370-28995-3-git-send-email-yinghai@kernel.org>
	<20160310182440.GC14873@localhost>
Date: Sat, 12 Mar 2016 00:22:06 -0800
Message-ID: <CAE9FiQX=ecBEuABmkfGwN3p3H5YU-XbXDguKKbArj6weQbbAPA@mail.gmail.com>
Subject: Re: [PATCH v10 02/59] sparc/PCI: Use correct bus address to resource offset
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Matthew Wilcox <willy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 10, 2016 at 10:24 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
>
> Just double-checking that your ioport space really contains 256M ports.
> It's fine if it does; it's just a little unusual.

Then according to davem, OF said so.
...
>> @@ -733,30 +733,28 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>>  static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struct *vma,
>>                                     enum pci_mmap_state mmap_state)
>>  {
>> -     struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
>> -     unsigned long space_size, user_offset, user_size;
>> -
>> -     if (mmap_state == pci_mmap_io) {
>> -             space_size = resource_size(&pbm->io_space);
>> -     } else {
>> -             space_size = resource_size(&pbm->mem_space);
>> -     }
>> +     unsigned long user_offset, user_size;
>> +     struct resource res, *root_bus_res;
>> +     struct pci_bus_region region;
>>
>>       /* Make sure the request is in range. */
>>       user_offset = vma->vm_pgoff << PAGE_SHIFT;
>>       user_size = vma->vm_end - vma->vm_start;
>>
>> -     if (user_offset >= space_size ||
>> -         (user_offset + user_size) > space_size)
>> +     region.start = user_offset;
>> +     region.end = user_offset + user_size - 1;
>> +     memset(&res, 0, sizeof(res));
>> +     if (mmap_state == pci_mmap_io)
>> +             res.flags = IORESOURCE_IO;
>> +     else
>> +             res.flags = IORESOURCE_MEM;
>> +
>> +     pcibios_bus_to_resource(pdev->bus, &res, &region);
>> +     root_bus_res = pci_find_root_bus_resource(pdev->bus, &res);
>> +     if (!root_bus_res)
>>               return -EINVAL;
>>
>> -     if (mmap_state == pci_mmap_io) {
>> -             vma->vm_pgoff = (pbm->io_space.start +
>> -                              user_offset) >> PAGE_SHIFT;
>> -     } else {
>> -             vma->vm_pgoff = (pbm->mem_space.start +
>> -                              user_offset) >> PAGE_SHIFT;
>> -     }
>> +     vma->vm_pgoff = res.start >> PAGE_SHIFT;
>>
>>       return 0;
>
> This needs to explain what's unique about sparc that means it needs
> pci_find_root_bus_resource() when no other arch does.

I just follow the old code to get pbm->io_offset, mem_offset, mem64_offset.
at the same use that to check boundary with that checking.


>
> This is used in the pci_mmap_resource() path.  I don't understand how
> that path works on sparc.  I tried to work through the simple case of
> a user mapping the first 4096 bytes of a BAR.  Assume the BAR is 4096
> bytes in size:
>
>   # User does something like this:
>   #   mmap(NULL, 4096, ..., "/sys/.../resourceN", 0);
>
>   pci_mmap_resource
>
>     # At entry, "vma->vm_pgoff" is the offset into the BAR (in pages).
>     # In this case, the user wants the first page of the BAR, so
>     # vma->vm_pgoff == 0.
>
>     # "res" is the the pdev->resource[n], which contains the CPU
>     # physical address of the BAR.
>
>     pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)
>       start = vma->vm_pgoff           # == 0
>       size = 4096
>       pci_start = 0                   # offset into BAR (PCI_MMAP_SYSFS case)
>
>       # we return 1 because [0x0000-0x0fff] is a valid area in this
>       # BAR
>
>     pci_resource_to_user(pdev, i, res, &start, &end);
>
>     # On most platforms: pci_resource_to_user() copies res->start to
>     # *start, so "start" is the CPU physical address of the
>     # BAR.
>
>     # On sparc: pci_resource_to_user() calls pcibios_resource_to_bus()
>     # (see below), so "start" is the PCI bus address of the BAR.
>
>     vma->vm_pgoff += start >> PAGE_SHIFT;
>
>     # On most platforms: "vma->vm_pgoff" is now the CPU physical page
>     # number of the part of the BAR we're mapping.
>
>     # On sparc: "vma->vm_pgoff" is the PCI bus page number of the part
>     # of the BAR we're mapping.  This seems wrong: doesn't the VM
>     # system assume vm_pgoff is a CPU physical page number?
>
>     if (... && iomem_is_exclusive(start))
>
>     # On most platforms, "start" is a CPU physical address, and
>     # iomem_is_exclusive() looks it up in the iomem_resource tree,
>     # which contains resources of CPU physical addresses.
>
>     # On sparc, "start" is a PCI bus address.  How can this work in
>     # iomem_is_exclusive()?  I assume the resources in iomem_resource
>     # still contain CPU physical addresses, not PCI bus addresses,
>     # don't they?

Good findings, that would break the sparc for a while.
(we should use res->start instead)

it is from

commit e8de1481fd7126ee9e93d6889da6f00c05e1e019
Author: Arjan van de Ven <arjan@linux.intel.com>
Date:   Wed Oct 22 19:55:31 2008 -0700

    resource: allow MMIO exclusivity for device drivers

    Device drivers that use pci_request_regions() (and similar APIs) have a
    reasonable expectation that they are the only ones accessing their device.
    As part of the e1000e hunt, we were afraid that some userland (X or some
    bootsplash stuff) was mapping the MMIO region that the driver thought it
    had exclusively via /dev/mem or via various sysfs resource mappings.

    This patch adds the option for device drivers to cause their reserved
    regions to the "banned from /dev/mem use" list, so now both kernel memory
    and device-exclusive MMIO regions are banned.
    NOTE: This is only active when CONFIG_STRICT_DEVMEM is set.

    In addition to the config option, a kernel parameter iomem=relaxed is
    provided for the cases where developers want to diagnose, in the field,
    drivers issues from userspace.

    Reviewed-by: Matthew Wilcox <willy@linux.intel.com>
    Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
    Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 388440e..d5cdccf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -620,6 +620,9 @@ pci_mmap_resource(struct kobject *kobj, struct
bin_attribute *attr,
        vma->vm_pgoff += start >> PAGE_SHIFT;
        mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;

+       if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(start))
+               return -EINVAL;
+
        return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
 }
