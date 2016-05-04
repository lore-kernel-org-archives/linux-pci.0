Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20160504151722.GA22051@localhost>
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
Date: Wed, 4 May 2016 11:46:48 -0700
Message-ID: <CAE9FiQXEBkVak0No9dfOidzCrR+UVu44WyBEK8SqTUSiJKeJbg@mail.gmail.com>
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

On Wed, May 4, 2016 at 8:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> What mess do you mean?  The fact that you could only use
> pcibios_bus_to_resource() for MEM, and something else for IO?  Even
> if we could only use pcibios_bus_to_resource() for MEM, that sounds
> like an improvement, not a mess.

I means that we need create another 5 pci_user_to_resource
arch/microblaze/pci/pci-common.c:void pci_resource_to_user(const
struct pci_dev *dev, int bar,
arch/mips/include/asm/pci.h:static inline void
pci_resource_to_user(const struct pci_dev *dev, int bar,
arch/powerpc/kernel/pci-common.c:void pci_resource_to_user(const
struct pci_dev *dev, int bar,
arch/sparc/kernel/pci.c:void pci_resource_to_user(const struct pci_dev
*pdev, int bar,
include/linux/pci.h:static inline void pci_resource_to_user(const
struct pci_dev *dev, int bar,

>
> Most of __pci_mmap_make_offset() is pointless.

we can clean up them later.

>
> We might need something there for I/O regions, but for MEM, the
> vma->vm_pgoff coming into pci_mmap_page_range() should be exactly what
> we need and we shouldn't touch it.  I think __pci_mmap_make_offset()
> actually does leave it alone for MEM, but you have to read the code
> carefully to figure that out.
>
> All the validation stuff ("Check that the offset requested corresponds
> to one of the resources...") should be removed or moved to
> pci_mmap_fits().

ok, will give it try.

>> @@ -231,13 +231,26 @@ static int proc_bus_pci_mmap(struct file
>>  {
>>      struct pci_dev *dev = PDE_DATA(file_inode(file));
>>      struct pci_filp_private *fpriv = file->private_data;
>> +    resource_size_t start, end, offset;
>> +    struct resource *res;
>>      int i, ret;
>>
>>      if (!capable(CAP_SYS_RAWIO))
>>          return -EPERM;
>>
>> +    offset = vma->vm_pgoff << PAGE_SHIFT;
>> +
>>      /* Make sure the caller is mapping a real resource for this device */
>>      for (i = 0; i < PCI_ROM_RESOURCE; i++) {
>> +        res = &dev->resource[i];
>> +        if (!res->flags)
>> +            continue;
>> +
>> +        pci_resource_to_user(dev, i, res, &start, &end);
>> +        if (!(offset >= start && offset <= end))
>> +            continue;
>> +
>> +        vma->vm_pgoff = (res->start + (offset - start)) >> PAGE_SHIFT;
>>          if (pci_mmap_fits(dev, i, vma,  PCI_MMAP_PROCFS))
>
> This is sort of OK, but I think we can do better.  I don't see any
> problem with introducing pci_user_to_resource() as the inverse of
> pci_resource_to_user().  I think it will make this code read much
> better.
>
> The default pci_user_to_resource() would do nothing, just like the
> default pci_resource_to_user().
>
> For sparc, I think pci_user_to_resource() can use
> pcibios_bus_to_resource(), and pci_resource_to_user() can be rewritten
> to use pcibios_resource_to_bus().  That makes it much more obvious
> what's happening.
>
> It looks like microblaze and powerpc should use
> pcibios_resource_to_bus() for I/O resources and the default "user
> address == resource address" for MMIO (?)
>
> My goal is to make pci_mmap_resource() and proc_bus_pci_mmap() look
> very similar, e.g.,
>
>   /* locate resource */
>   pci_user_to_resource()                # only in proc_bus_pci_mmap()
>   if (!pci_mmap_fits()) {
>     WARN(...);
>     return -EINVAL;
>   }
>   pci_mmap_page_range();
>
> Obviously there are several steps in getting here.  Reworking
> pci_resource_to_user() to use pcibios_resource_to_bus() when possible
> would be a good start.

I would like to avoid adding pci_user_to_resource, and put extra calling
pci_resource_to_user  pci_mmap_fits instead.

Thanks

Yinghai
