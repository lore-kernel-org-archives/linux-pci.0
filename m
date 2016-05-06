Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39168 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758224AbcEFS0E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 May 2016 14:26:04 -0400
Date: Fri, 6 May 2016 13:26:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Miller <davem@davemloft.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
Message-ID: <20160506182600.GA22909@localhost>
References: <CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
 <CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
 <1462322260.30470.76.camel@kernel.crashing.org>
 <20160504012531.GB17170@localhost>
 <CAE9FiQU=e2bf=+KDrOETf_T-KPLQsSDiG5GqVFqgtvSWXwUz4w@mail.gmail.com>
 <CAE9FiQV19OUsSL34GzDXYtVG=Xs724CpwHNfu3HCmYMUqbmrqQ@mail.gmail.com>
 <20160504151722.GA22051@localhost>
 <CAE9FiQXEBkVak0No9dfOidzCrR+UVu44WyBEK8SqTUSiJKeJbg@mail.gmail.com>
 <CAE9FiQUEMq4aj2iAq=P0xu4=1MGuOWgOubpkn=2h+YLXgwJKRQ@mail.gmail.com>
 <CAE9FiQWJ0VH-PNsz96qW8_u14x6bJ6cd66+Zg=j3L4zXWvhq0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWJ0VH-PNsz96qW8_u14x6bJ6cd66+Zg=j3L4zXWvhq0Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 05, 2016 at 08:53:14AM -0700, Yinghai Lu wrote:
> On Wed, May 4, 2016 at 5:25 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Wed, May 4, 2016 at 11:46 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> On Wed, May 4, 2016 at 8:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> My goal is to make pci_mmap_resource() and proc_bus_pci_mmap() look
> >>> very similar, e.g.,
> >>>
> >>>   /* locate resource */
> >>>   pci_user_to_resource()                # only in proc_bus_pci_mmap()
> >>>   if (!pci_mmap_fits()) {
> >>>     WARN(...);
> >>>     return -EINVAL;
> >>>   }
> >>>   pci_mmap_page_range();
> >
> 
> v3, that have more change to pass *res to make powerpc prot setting simple.

This looks corrupted.  On v4.6-rc2:

  $ stg import -M m/yh3 
  Checking for changes in the working directory ... done
  Importing patch "re-patch-v11-04-60-sparc-pci" ... fatal: corrupt patch at line 266
  stg import: Diff does not apply cleanly

> ...
> Subject: [RFC PATCH v3 2/2] PCI: Let pci_mmap_page_range() take resource addr
> 
> In 8c05cd08a7 ("PCI: fix offset check for sysfs mmapped files"), try
> to check exposed value with resource start/end in proc mmap path.
> |        start = vma->vm_pgoff;
> |        size = ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> |        pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
> |                        pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
> |        if (start >= pci_start && start < pci_start + size &&
> |                        start + nr <= pci_start + size)
> 
> That would break sparc that exposed value is still BAR value.
> 
> In the patch:
> 1. in proc path: proc_bus_pci_mmap, try convert back to resource
>    before calling pci_mmap_page_range
> 2. in sysfs path: pci_mmap_resource will just offset with resource start.
> 3. all pci_mmap_page_range will all have vma->vm_pgoff with in resource
>    range instead of BAR value.
> 4. remove __pci_mmap_make_offset, as the checking is done
>    in pci_mmap_fits().

This looks like it could possibly be split into several patches.  I
think it's too big to apply as-is.

I'm not sure what bug this is fixing or what improvement it's making.
