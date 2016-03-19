Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36764 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbcCSGBi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Mar 2016 02:01:38 -0400
MIME-Version: 1.0
In-Reply-To: <20160312112634.GB27552@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
	<1456366370-28995-3-git-send-email-yinghai@kernel.org>
	<20160310182440.GC14873@localhost>
	<CAE9FiQX=ecBEuABmkfGwN3p3H5YU-XbXDguKKbArj6weQbbAPA@mail.gmail.com>
	<20160312112634.GB27552@localhost>
Date: Fri, 18 Mar 2016 23:01:37 -0700
Message-ID: <CAE9FiQUvDdiNxrjkiEVJfQw3yxi1qAj1yJW35AYpVEyY6ZcdRg@mail.gmail.com>
Subject: Re: [PATCH v10 02/59] sparc/PCI: Use correct bus address to resource offset
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 12, 2016 at 3:26 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Mar 12, 2016 at 12:22:06AM -0800, Yinghai Lu wrote:

>> Good findings, that would break the sparc for a while.
>> (we should use res->start instead)
>
> We haven't even gotten to the part that your patch changes.  If my
> analysis is correct, this call to iomem_is_exclusive() is already
> broken on sparc.  I think we need the following patches:

Good for me. For your two patches

Acked-by: Yinghai Lu <yinghai@kernel.org>

>
> commit 4688b92991e43ab3b286d11e8f388b1b39d10b1b
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Sat Mar 12 04:27:39 2016 -0600
>
>     PCI: Fix iomem_is_exclusive() checking in pci_mmap_resource()
>
>     iomem_is_exclusive() requires a CPU physical address, but on some arches we
>     supplied a PCI bus address instead.
>
>     On most arches, pci_resource_to_user(res) returns "res->start", which is a
>     CPU physical address.  But on microblaze, mips, powerpc, and sparc, it
>     returns the PCI bus address corresponding to "res->start".
>
>     The result is that pci_mmap_resource() may fail when it shouldn't (if the
>     bus address happens to match an existing resource), or it may succeed when
>     it should fail (if the resource is exclusive but the bus address doesn't
>     match it).
>
>     Call iomem_is_exclusive() with "res->start", which is always a CPU physical
>     address, not the result of pci_resource_to_user().
>
>     Fixes: e8de1481fd71 ("resource: allow MMIO exclusivity for device drivers")
>     Suggested-by: Yinghai Lu <yinghai@kernel.org>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: Arjan van de Ven <arjan@linux.intel.com>
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 95d9e7b..1559d67 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1004,6 +1004,9 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
>         if (i >= PCI_ROM_RESOURCE)
>                 return -ENODEV;
>
> +       if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
> +               return -EINVAL;
> +
>         if (!pci_mmap_fits(pdev, i, vma, PCI_MMAP_SYSFS)) {
>                 WARN(1, "process \"%s\" tried to map 0x%08lx bytes at page 0x%08lx on %s BAR %d (start 0x%16Lx, size 0x%16Lx)\n",
>                         current->comm, vma->vm_end-vma->vm_start, vma->vm_pgoff,
> @@ -1020,10 +1023,6 @@ static int pci_mmap_resource(struct kobject *kobj, struct bin_attribute *attr,
>         pci_resource_to_user(pdev, i, res, &start, &end);
>         vma->vm_pgoff += start >> PAGE_SHIFT;
>         mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
> -
> -       if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(start))
> -               return -EINVAL;
> -
>         return pci_mmap_page_range(pdev, vma, mmap_type, write_combine);
>  }
>
> commit fd88769b8c4d840278137f9ca3968da5aa09c97f
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Sat Mar 12 05:10:11 2016 -0600
>
>     alpha/PCI: Only check iomem_is_exclusive() for IORESOURCE_MEM, not IORESOURCE_IO
>
>     The alpha pci_mmap_resource() is used for both IORESOURCE_MEM and
>     IORESOURCE_IO resources, but iomem_is_exclusive() is only applicable for
>     IORESOURCE_MEM.
>
>     Call iomem_is_exclusive() only for IORESOURCE_MEM resources, and do it
>     earlier to match the generic version of pci_mmap_resource().
>
>     Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index 99e8d47..92c0d46 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -77,10 +77,10 @@ static int pci_mmap_resource(struct kobject *kobj,
>         if (i >= PCI_ROM_RESOURCE)
>                 return -ENODEV;
>
> -       if (!__pci_mmap_fits(pdev, i, vma, sparse))
> +       if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
>                 return -EINVAL;
>
> -       if (iomem_is_exclusive(res->start))
> +       if (!__pci_mmap_fits(pdev, i, vma, sparse))
>                 return -EINVAL;
>
>         pcibios_resource_to_bus(pdev->bus, &bar, res);
