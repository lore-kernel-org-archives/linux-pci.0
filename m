Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVqKZGacZYqXETVVaqzobiw01OyCmASUfxwZ075rdX7XA@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
 <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
 <CAErSpo7pxGA02uTDNoFpxU_6_B4CgvJM10zpFRjjhXHK5L3mtg@mail.gmail.com>
 <CAE9FiQVx7=cSVkApbh_8dnoBqdrRYDOVtMqdC=mDCwq0fuVZpA@mail.gmail.com>
 <CAErSpo6zHhpz+N6y3ybDVp-oabVWAYeTt9pPJS3nz+nD2C8xkg@mail.gmail.com> <CAE9FiQVqKZGacZYqXETVVaqzobiw01OyCmASUfxwZ075rdX7XA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 10 Feb 2012 09:24:15 -0800
Message-ID: <CAErSpo6MWS0=3gin7P6HQ7CNZwxD9cPfB6QNr1GDF7DVMhx2tw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2012 at 9:20 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Feb 10, 2012 at 8:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> ...
>>>
>>> I mean, we can unify sysdata usuage, make them all most the same.
>>>
>>> and for some sysdata, already acting like host_bridge struct with
>>> domain, numa_node, and resources.
>>>
>>>> If you can show an example of what you mean, maybe it will help me understand.
>>>
>>> just looked the sys_data of different arch,
>>>
>>> looks like pci_sys_data for arm already include the io offset
>>>
>>> arch/arm/include/asm/mach/pci.h::
>>>
>>> struct pci_sys_data {
>>> #ifdef CONFIG_PCI_DOMAINS
>>>        int             domain;
>>> #endif
>>>        struct list_head node;
>>>        int             busnr;          /* primary bus number
>>>         */
>>>        u64             mem_offset;     /* bus->cpu memory mapping
>>> offset       */
>>>        unsigned long   io_offset;      /* bus->cpu IO mapping offset
>>>         */
>>>        struct pci_bus  *bus;           /* PCI bus
>>>         */
>>>        struct list_head resources;     /* root bus resources (apertures)
>>
>> Let me try again.  Maybe your idea is that we should create something
>> like "struct pcibios_sysdata" and require every arch to define a
>> struct with that name.  Every arch's struct would contain some members
>> such as "domain," "mem_offset," "io_offset," and "resources."  These
>> would have standard names & types across all arches and would be
>> referenced by the PCI core.  In addition, the struct could include
>> arch-specific data such as "acpi_handle," "iommu," etc.
>>
>> That way, the core could implement things like pci_domain_nr() and
>> pci_bus_to_resource() by using the data in struct pcibios_sysdata.
>> The current "void *sysdata" parameters to pci_scan_bus() and friends
>> would become "struct pcibios_sysdata *sysdata".
>>
>> I like the idea of unifying the sysdata struct name and changing from
>> a "void *" to something like "struct pcibios_sysdata *".  That might
>> be worth doing.
>
> what i am mean:
> 1. make every arch to use same name for the struct, but could have
> different contents.
>   struct pci_sys_data.
> 2. unify member field name, by changing name
>    pci_first_busno ==> first_busno
>    pci_last_busno ==> last_busno
>    or adding
>    first_busno
>    last_busno
> 3. changing more filed like domain, node
>    and io_offset, mem_offset
> ...

That's exactly what I said above, isn't it?  (In the paragraph
starting "Let me try again.")

As I said, the reason I don't like that approach is that I don't want
a dozen copies of first_busno, last_busno, domain, node, io_offset,
mem_offset, etc.  That information is not architecture-specific, so we
shouldn't keep it in an architecture-specific struct.

Bjorn
