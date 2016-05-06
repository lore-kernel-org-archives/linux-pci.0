Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1462485774.20290.34.camel@kernel.crashing.org>
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
	<CAE9FiQUEMq4aj2iAq=P0xu4=1MGuOWgOubpkn=2h+YLXgwJKRQ@mail.gmail.com>
	<CAE9FiQWJ0VH-PNsz96qW8_u14x6bJ6cd66+Zg=j3L4zXWvhq0Q@mail.gmail.com>
	<1462485774.20290.34.camel@kernel.crashing.org>
Date: Thu, 5 May 2016 17:56:25 -0700
Message-ID: <CAE9FiQUC3i=MkLnFi563T7rDVFiLXxk764WUQjktnPMJqXa93g@mail.gmail.com>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, David Miller <davem@davemloft.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 5, 2016 at 3:02 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2016-05-05 at 08:53 -0700, Yinghai Lu wrote:
>> For powerpc io port, we still need extra offset from resource address
>> to final address.
>>
>>      resource_size_t offset =
>>          ((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
>>
>> +    if (mmap_state == pci_mmap_io) {
>> +        struct pci_controller *hose = pci_bus_to_host(dev->bus);
>> +
>> +        /* hose should never be NULL */
>> +        offset += hose->io_base_phys -
>> +              ((unsigned long)hose->io_base_virt - _IO_BASE);
>> +    }
>>
>>      vma->vm_pgoff = offset >> PAGE_SHIFT;
>>
>> but sparc does not need that trick.
>
> I'm not sure how sparc handles IO space but on powerpc, the IO resource
> is not a physical address, it's a virtual address (coming from
> ioremap).

That is interesting. Any reason for that ?

why just cpu_addr in resource directly ?

Thanks

Yinghai
