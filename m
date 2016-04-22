Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34454 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbcDVUt1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 22 Apr 2016 16:49:27 -0400
Date: Fri, 22 Apr 2016 15:49:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
Message-ID: <20160422204920.GA17215@localhost>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
 <1460074573-7481-5-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460074573-7481-5-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ben, Michael]

On Thu, Apr 07, 2016 at 05:15:17PM -0700, Yinghai Lu wrote:
> After we added 64bit mmio parsing, we got some "no compatible bridge window"
> warning on anther new model that support 64bit resource.
> 
> It turns out that we can not use mem_space.start as 64bit mem space
> offset, aka there is mem_space.start != offset.
> 
> Use child_phys_addr to calculate exact offset and record offset in
> pbm.
> 
> After patch we get correct offset.
> 
> /pci@305: PCI IO [io  0x2007e00000000-0x2007e0fffffff] offset 2007e00000000
> /pci@305: PCI MEM [mem 0x2000000100000-0x200007effffff] offset 2000000000000
> /pci@305: PCI MEM64 [mem 0x2000100000000-0x2000dffffffff] offset 2000000000000
> ...
> pci_sun4v f02ae7f8: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x2007e00000000-0x2007e0fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x2000000100000-0x200007effffff] (bus address [0x00100000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x2000100000000-0x2000dffffffff] (bus address [0x100000000-0xdffffffff])
> ...

> @@ -733,30 +733,32 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struct *vma,
>  				      enum pci_mmap_state mmap_state)
>  {
> -	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
> -	unsigned long space_size, user_offset, user_size;
> -
> -	if (mmap_state == pci_mmap_io) {
> -		space_size = resource_size(&pbm->io_space);
> -	} else {
> -		space_size = resource_size(&pbm->mem_space);
> -	}
> +	unsigned long user_offset, user_size;
> +	struct resource res, *root_bus_res;
> +	struct pci_bus_region region;
> +	struct pci_bus *bus;
>  
>  	/* Make sure the request is in range. */
>  	user_offset = vma->vm_pgoff << PAGE_SHIFT;
>  	user_size = vma->vm_end - vma->vm_start;
>  
> -	if (user_offset >= space_size ||
> -	    (user_offset + user_size) > space_size)
> +	region.start = user_offset;
> +	region.end = user_offset + user_size - 1;
> +	memset(&res, 0, sizeof(res));
> +	if (mmap_state == pci_mmap_io)
> +		res.flags = IORESOURCE_IO;
> +	else
> +		res.flags = IORESOURCE_MEM;
> +
> +	pcibios_bus_to_resource(pdev->bus, &res, &region);
> +	bus = pdev->bus;
> +	while (bus->parent)
> +		bus = bus->parent;
> +	root_bus_res = pci_find_bus_resource(bus, &res);
> +	if (!root_bus_res)
>  		return -EINVAL;
>  
> -	if (mmap_state == pci_mmap_io) {
> -		vma->vm_pgoff = (pbm->io_space.start +
> -				 user_offset) >> PAGE_SHIFT;
> -	} else {
> -		vma->vm_pgoff = (pbm->mem_space.start +
> -				 user_offset) >> PAGE_SHIFT;
> -	}
> +	vma->vm_pgoff = res.start >> PAGE_SHIFT;
>  
>  	return 0;
>  }

I'm kind of confused here.  There are two ways to mmap PCI BARs:

  /proc/bus/pci/00/02.0 (proc_bus_pci_mmap()):
    all BARs in one file; MEM/IO determined by ioctl()
    mmap offset is a CPU physical address in the PCI resource

  /sys/devices/pci0000:00/0000:00:02.0/resource0 (pci_mmap_resource()):
    one file per BAR; MEM/IO determined by BAR type
    mmap offset is between 0 and BAR size

Both proc_bus_pci_mmap() and pci_mmap_resource() validate the
requested area with pci_mmap_fits() before calling pci_mmap_page_range().

In the proc_bus_pci_mmap() path, the offset in vma->vm_pgoff must be
within the pdev->resource[], so the user must be supplying a CPU
physical address (not an address obtained from pci_resource_to_user()).
That vma->vm_pgoff is passed unchanged to pci_mmap_page_range().

In the pci_mmap_resource() path, vma->vm_pgoff must be between 0 and
the BAR size.  Then we add in the pci_resource_to_user() information
before passing it to pci_mmap_page_range().  The comment in
pci_mmap_resource() says pci_mmap_page_range() expects a "user
visible" address, but I don't really believe that based on how
proc_bus_pci_mmap() works.

Do both proc_bus_pci_mmap() and pci_mmap_resource() work on sparc?
It looks like they call pci_mmap_page_range() with different
assumptions, so I don't see how they can both work.

In any case, pci_mmap_page_range() on sparc converts that
vma->vm_pgoff back to a CPU physical address, so there's an awful lot
of work going on in the pci_mmap_resource() path to convert the mmap
offset to a "user" address and then convert it back again.

There's also quite a bit of validation done in the arch code (in
__pci_mmap_make_offset() and __pci_mmap_make_offset_bus()) that looks
partly redundant with pci_mmap_fits() and not necessarily
arch-specific.

As far as I can see, pci_mmap_resource() doesn't need to have any
connection at all with pci_resource_to_user().  All it needs is the
pdev->resource[] (which has the CPU physical address of the BAR) and
vma->vm_pgoff (the offset into the BAR).

I don't think pci_mmap_resource() should call pci_resource_to_user(),
and I think pci_mmap_page_range() should expect a normal VMA that
contains a valid CPU PFN in vm_pgoff (or a valid CPU I/O port number,
in the case of an I/O port mmap).

The original pci_resource_to_user() was added for powerpc by
2311b1f2bbd3 ("[PATCH] PCI: fix-pci-mmap-on-ppc-and-ppc64.patch"),
but I couldn't find the linux-pci discussion it mentions.

> @@ -977,16 +979,12 @@ void pci_resource_to_user(const struct pci_dev *pdev, int bar,
>  			  const struct resource *rp, resource_size_t *start,
>  			  resource_size_t *end)
>  {
> -	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
> -	unsigned long offset;
> +	struct pci_bus_region region;
>  
> -	if (rp->flags & IORESOURCE_IO)
> -		offset = pbm->io_space.start;
> -	else
> -		offset = pbm->mem_space.start;
> +	pcibios_resource_to_bus(pdev->bus, &region, (struct resource *)rp);
>  
> -	*start = rp->start - offset;
> -	*end = rp->end - offset;
> +	*start = region.start;
> +	*end = region.end;
>  }
