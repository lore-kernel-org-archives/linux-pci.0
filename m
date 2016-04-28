Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55943 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbcD1N4V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 09:56:21 -0400
Date: Thu, 28 Apr 2016 08:56:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
Message-ID: <20160428135607.GA12470@localhost>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
 <1460074573-7481-5-git-send-email-yinghai@kernel.org>
 <20160422204920.GA17215@localhost>
 <CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 27, 2016 at 09:55:45PM -0700, Yinghai Lu wrote:
> On Fri, Apr 22, 2016 at 1:49 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [+cc Ben, Michael]
> > I'm kind of confused here.  There are two ways to mmap PCI BARs:
> >
> >   /proc/bus/pci/00/02.0 (proc_bus_pci_mmap()):
> >     all BARs in one file; MEM/IO determined by ioctl()
> >     mmap offset is a CPU physical address in the PCI resource
> >
> >   /sys/devices/pci0000:00/0000:00:02.0/resource0 (pci_mmap_resource()):
> >     one file per BAR; MEM/IO determined by BAR type
> >     mmap offset is between 0 and BAR size
> >
> > Both proc_bus_pci_mmap() and pci_mmap_resource() validate the
> > requested area with pci_mmap_fits() before calling pci_mmap_page_range().
> >
> > In the proc_bus_pci_mmap() path, the offset in vma->vm_pgoff must be
> > within the pdev->resource[], so the user must be supplying a CPU
> > physical address (not an address obtained from pci_resource_to_user()).
> > That vma->vm_pgoff is passed unchanged to pci_mmap_page_range().
> >
> > In the pci_mmap_resource() path, vma->vm_pgoff must be between 0 and
> > the BAR size.  Then we add in the pci_resource_to_user() information
> > before passing it to pci_mmap_page_range().  The comment in
> > pci_mmap_resource() says pci_mmap_page_range() expects a "user
> > visible" address, but I don't really believe that based on how
> > proc_bus_pci_mmap() works.
> >
> > Do both proc_bus_pci_mmap() and pci_mmap_resource() work on sparc?
> > It looks like they call pci_mmap_page_range() with different
> > assumptions, so I don't see how they can both work.
> 
> for sysfs path: in pci_mmap_resource
>         pci_resource_to_user(pdev, i, res, &start, &end);
>         vma->vm_pgoff += start >> PAGE_SHIFT;
>      then call pci_mmap_page_range()
> 
> the fit checking in pci_mmap_fits(),
>         pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
>                         pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
>         if (start >= pci_start && start < pci_start + size &&
>                         start + nr <= pci_start + size)
> 
> so proc fs assume resource_start for vm_pgoff ?
> 
> but current pci_mmap_page_range want to use bus address
> start aka BAR value.
> 
> and we have
> 
>         /* pci_mmap_page_range() expects the same kind of entry as coming
>          * from /proc/bus/pci/ which is a "user visible" value. If this is
>          * different from the resource itself, arch will do necessary fixup.
>          */
> 
> so we need to fix pci_mmap_fits(), please check if it is ok, will
> submit it as separated one.

1) The sysfs path uses offsets between 0 and BAR size.  This path
should work identically on all arches.  "User" addresses are not
involved, so it doesn't make sense that this path calls
pci_resource_to_user() from pci_mmap_resource().

2) The procfs path uses offsets of resource values (CPU physical
addresses) on most architectures.  If some arches use something else,
e.g., "user" addresses, the grunge of dealing with them should be in
this path, i.e., in proc_bus_pci_mmap().  This implies that
pci_mmap_page_range() should deal with CPU physical addresses, not bus
addresses, and proc_bus_pci_mmap() should perform any necessary
translation.

3) If my theory that proc_bus_pci_mmap() and pci_mmap_resource() are
calling pci_mmap_page_range() with different assumptions is correct,
you should be able to write a test program that fails for one method,
and your patch should fix that failure.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index d319a9c..3768c6a 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -969,15 +969,20 @@ void pci_remove_legacy_files(struct pci_bus *b)
>  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vma,
>                   enum pci_mmap_api mmap_api)
>  {
> -       unsigned long nr, start, size, pci_start;
> +       unsigned long nr, start, size;
> +       resource_size_t pci_start = 0, pci_end;
> 
>         if (pci_resource_len(pdev, resno) == 0)
>                 return 0;
>         nr = vma_pages(vma);
>         start = vma->vm_pgoff;
>         size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> -       pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
> -                       pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
> +       if (mmap_api == PCI_MMAP_PROCFS) {
> +               struct resource *res = &pdev->resource[resno];
> +
> +               pci_resource_to_user(pdev, resno, res, &pci_start, &pci_end);
> +               pci_start >>= PAGE_SHIFT;
> +       }

This is the wrong place to deal with this.  IMO, any pci_resource_to_user()
fiddling should be done directly in proc_bus_pci_mmap(), and
pci_mmap_fits() should deal only with resources (CPU physical
addresses).  Then it wouldn't care where it was called from, so we
could get rid of the pci_mmap_api thing completely.

>         if (start >= pci_start && start < pci_start + size &&
>                         start + nr <= pci_start + size)
>                 return 1;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
