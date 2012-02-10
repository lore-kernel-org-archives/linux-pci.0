Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com> <CAE9FiQWE-VGoh=8hyhWPMrTe7X1dqTyBCgAM=ozWMyZXEvwGTg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Feb 2012 20:34:30 -0800
Message-ID: <CAErSpo7pxGA02uTDNoFpxU_6_B4CgvJM10zpFRjjhXHK5L3mtg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] add PCI bus-to-resource offset support in core
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 9, 2012 at 8:03 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> There's a lot of PCI-related code under arch/, but much of it is not actually
>> architecture-specific.  This series removes some of that code by moving most
>> of the bus-to-resource conversions into the core.
>>
>> We currently read PCI bus addresses from BARs in the core (pci_setup_device()).
>> Then every arch is responsible for converting those bus addresses to CPU
>> resources, usually in pcibios_fixup_bus().
>>
>> We already have a way for architectures to tell the core what the windows
>> through a host bridge are:
>>
>>    LIST_HEAD(resources);
>>    pci_add_resource(&resources, io_space);
>>    pci_add_resource(&resources, mem_space);
>>    pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>
>> This series extends that so the arch can also tell the core about address
>> translation performed by the host bridge:
>>
>>    LIST_HEAD(resources);
>>    pci_add_resource_offset(&resources, io_space, io_offset);
>>    pci_add_resource_offset(&resources, mem_space, mem_offset);
>>    pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>
>> Given that offset (the difference between bus address and CPU address for
>> each aperture), the core can do the bus-to-resource conversion immediately
>> when it reads the BARs.
>>
>> This removes an opportunity for bugs (some PCI fixups currently see bus
>> addresses in struct pci_dev resources when they're expecting CPU addresses),
>> but the main reason to do this is to make our PCI resource handling simpler
>> and more uniform.
>>
>> These patches are also available in this git repo:
>>    git://github.com/bjorn-helgaas/linux.git pci-offset-v2-d15af52258dd
>>
>> Or you can browse them here:
>>    https://github.com/bjorn-helgaas/linux/compare/master...pci-offset-v2-d15af52258dd
>>
>> I'd like to get these into linux-next soon to be ready for the 3.4 merge
>> window, so please let me know if you see any issues.
>>
>> Changes since v1:
>>  - mips: remove Cobalt legacy IDE fixup
>>  - show bus address range, not offset, e.g., this:
>>        pci_bus 0000:00: root bus resource [mem 0xf0000000000-0xf007edfffff] (bus address [0x80000000-0xfedfffff])
>>    instead of this:
>>        pci_bus 0000:00: root bus resource [mem 0xf0000000000-0xf007edfffff] (bus offset 0xeff80000000)
>>
>
> still think make pci_sysdata to generic and add one offset field to
> that would be more simple.

Maybe I'm misunderstanding you, because this doesn't make sense to me at all.

*One* offset field is insufficient.  A host bridge can have an
arbitrary number of apertures, and each aperture can have a different
offset.  So we must have a list or other variable-size structure.

pci_scan_bus() takes a "void *sysdata".  Every arch defines its own
structure (struct pci_sysdata for x86, struct pci_controller for most
others) to supply here.  Are you suggesting that we make a common
structure like this:

    struct pci_sysdata {
        struct list_head windows;
        void *sysdata;  /* arch-specific stuff */
    };

That's possible, but I don't see the advantage over what I've done.
It doesn't seem simpler, because all the arch code that looks at
bus->sysdata would have to change to use
bus->generic_sysdata->sysdata.

If you can show an example of what you mean, maybe it will help me understand.

Bjorn
