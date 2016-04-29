Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33833 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcD2HTQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2016 03:19:16 -0400
MIME-Version: 1.0
In-Reply-To: <20160428135607.GA12470@localhost>
References: <1460074573-7481-1-git-send-email-yinghai@kernel.org>
	<1460074573-7481-5-git-send-email-yinghai@kernel.org>
	<20160422204920.GA17215@localhost>
	<CAE9FiQWQ2ke3_P4Qhj+ON7pMiVCx4myhVNVaSYO4vYAL_P4njg@mail.gmail.com>
	<20160428135607.GA12470@localhost>
Date: Fri, 29 Apr 2016 00:19:15 -0700
Message-ID: <CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 6:56 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Apr 27, 2016 at 09:55:45PM -0700, Yinghai Lu wrote:
>> On Fri, Apr 22, 2016 at 1:49 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > [+cc Ben, Michael]
>> > I'm kind of confused here.  There are two ways to mmap PCI BARs:
>> >
>> >   /proc/bus/pci/00/02.0 (proc_bus_pci_mmap()):
>> >     all BARs in one file; MEM/IO determined by ioctl()
>> >     mmap offset is a CPU physical address in the PCI resource
>> >
>> >   /sys/devices/pci0000:00/0000:00:02.0/resource0 (pci_mmap_resource()):
>> >     one file per BAR; MEM/IO determined by BAR type
>> >     mmap offset is between 0 and BAR size
>> >
>> > Both proc_bus_pci_mmap() and pci_mmap_resource() validate the
>> > requested area with pci_mmap_fits() before calling pci_mmap_page_range().
>> >
>> > In the proc_bus_pci_mmap() path, the offset in vma->vm_pgoff must be
>> > within the pdev->resource[], so the user must be supplying a CPU
>> > physical address (not an address obtained from pci_resource_to_user()).
>> > That vma->vm_pgoff is passed unchanged to pci_mmap_page_range().
>> >
>> > In the pci_mmap_resource() path, vma->vm_pgoff must be between 0 and
>> > the BAR size.  Then we add in the pci_resource_to_user() information
>> > before passing it to pci_mmap_page_range().  The comment in
>> > pci_mmap_resource() says pci_mmap_page_range() expects a "user
>> > visible" address, but I don't really believe that based on how
>> > proc_bus_pci_mmap() works.
>> >
>> > Do both proc_bus_pci_mmap() and pci_mmap_resource() work on sparc?
>> > It looks like they call pci_mmap_page_range() with different
>> > assumptions, so I don't see how they can both work.
>>
>> for sysfs path: in pci_mmap_resource
>>         pci_resource_to_user(pdev, i, res, &start, &end);
>>         vma->vm_pgoff += start >> PAGE_SHIFT;
>>      then call pci_mmap_page_range()
>>
>> the fit checking in pci_mmap_fits(),
>>         pci_start = (mmap_api == PCI_MMAP_PROCFS) ?
>>                         pci_resource_start(pdev, resno) >> PAGE_SHIFT : 0;
>>         if (start >= pci_start && start < pci_start + size &&
>>                         start + nr <= pci_start + size)
>>
>> so proc fs assume resource_start for vm_pgoff ?
>>
>> but current pci_mmap_page_range want to use bus address
>> start aka BAR value.
>>
>> and we have
>>
>>         /* pci_mmap_page_range() expects the same kind of entry as coming
>>          * from /proc/bus/pci/ which is a "user visible" value. If this is
>>          * different from the resource itself, arch will do necessary fixup.
>>          */
>>
>> so we need to fix pci_mmap_fits(), please check if it is ok, will
>> submit it as separated one.
>
> 1) The sysfs path uses offsets between 0 and BAR size.  This path
> should work identically on all arches.  "User" addresses are not
> involved, so it doesn't make sense that this path calls
> pci_resource_to_user() from pci_mmap_resource().
>
> 2) The procfs path uses offsets of resource values (CPU physical
> addresses) on most architectures.  If some arches use something else,
> e.g., "user" addresses, the grunge of dealing with them should be in
> this path, i.e., in proc_bus_pci_mmap().  This implies that
> pci_mmap_page_range() should deal with CPU physical addresses, not bus
> addresses, and proc_bus_pci_mmap() should perform any necessary
> translation.
>
> 3) If my theory that proc_bus_pci_mmap() and pci_mmap_resource() are
> calling pci_mmap_page_range() with different assumptions is correct,
> you should be able to write a test program that fails for one method,
> and your patch should fix that failure.
>
...>
> This is the wrong place to deal with this.  IMO, any pci_resource_to_user()
> fiddling should be done directly in proc_bus_pci_mmap(), and
> pci_mmap_fits() should deal only with resources (CPU physical
> addresses).  Then it wouldn't care where it was called from, so we
> could get rid of the pci_mmap_api thing completely.

ok, I got it.

We should offset vma->vm_pgoff back into [0, BAR)

will look at it Monday.

Thanks

Yinghai
