Return-Path: <SRS0=ftyf=2N=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=ftyf=2N=free.fr=slash.tmp@kernel.org>
Subject: Re: Using the generic host PCIe driver
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 David Daney <david.daney@cavium.com>, Marc Zyngier <marc.zyngier@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Will Deacon <will.deacon@arm.com>, Thierry Reding <treding@nvidia.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
 <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
 <20170227183534.GA12481@bhelgaas-glaptop.roam.corp.google.com>
 <347d4200-e089-60df-5f60-58d16efc7c4e@free.fr>
 <20170301161801.GB13171@bhelgaas-glaptop.roam.corp.google.com>
 <98ee3041-6a94-91af-b4bf-208aa02624ed@free.fr>
 <20170301215726.GA32286@bhelgaas-glaptop.roam.corp.google.com>
 <258cd6f3-ef17-6705-ff48-ae06f26778c2@free.fr>
 <20170303154628.GA21522@bhelgaas-glaptop.roam.corp.google.com>
 <8e1a0b5d-8dfb-4be1-a049-b16892a6c0d0@free.fr>
 <20170303200407.GB30375@bhelgaas-glaptop.roam.corp.google.com>
 <5c899946-4220-a63e-fe98-6a103200c2ad@free.fr>
 <CAKv+Gu-QxUYZcg4DPwuhhfqKCp4eJEWXCh43ZyvDe12=exEhWw@mail.gmail.com>
 <8daa1f79-8fda-bef9-e216-3c15f53c4f32@free.fr>
 <CAKv+Gu_fLKvruKy2Aoa95ThPAJ2XDJVUCjeuAWaRwpifsn_A_w@mail.gmail.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <c6d21078-b2f0-8dd3-adf7-13fc6456c1aa@free.fr>
Date: Sat, 4 Mar 2017 14:07:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_fLKvruKy2Aoa95ThPAJ2XDJVUCjeuAWaRwpifsn_A_w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 04/03/2017 12:45, Ard Biesheuvel wrote:
> On 4 March 2017 at 10:56, Mason <slash.tmp@free.fr> wrote:
>> On 04/03/2017 10:35, Ard Biesheuvel wrote:
>>> On 3 March 2017 at 23:23, Mason <slash.tmp@free.fr> wrote:
>>>> On 03/03/2017 21:04, Bjorn Helgaas wrote:
>>>>> On Fri, Mar 03, 2017 at 06:18:02PM +0100, Mason wrote:
>>>>>> On 03/03/2017 16:46, Bjorn Helgaas wrote:
>>>>>>> On Fri, Mar 03, 2017 at 01:44:54PM +0100, Mason wrote:
>>>>>>>
>>>>>>>> For now, I have "hidden" the root's BAR0 from the system with:
>>>>>>>>
>>>>>>>>    if (bus->number == 0 && where == PCI_BASE_ADDRESS_0) {
>>>>>>>>            *val = 0;
>>>>>>>>            return PCIBIOS_SUCCESSFUL;
>>>>>>>>    }
>>>>>>>
>>>>>>> I'm scratching my head about this a little.  Here's what your dmesg
>>>>>>> log contained originally:
>>>>>>>
>>>>>>>   pci 0000:00:00.0: [1105:8758] type 01 class 0x048000
>>>>>>>   pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00ffffff 64bit]
>>>>>>>   pci 0000:00:00.0: BAR 0: no space for [mem size 0x01000000 64bit]
>>>>>>>   pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit]
>>>>>>>   pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>>>   pcieport 0000:00:00.0: enabling device (0140 -> 0142)
>>>>>>>
>>>>>>> This device is a bridge (a Root Port, per your lspci output).  With a
>>>>>>> BAR, which is legal but unusual.  We couldn't assign space for the
>>>>>>> BAR, which means we can't use whatever vendor-specific functionality
>>>>>>> it provides.
>>>>>>
>>>>>> I had several chats with the HW designer. I'll try to explain, only as
>>>>>> far as I could understand ;-)
>>>>>>
>>>>>> We used to make devices, before implementing a root. Since at least
>>>>>> one BAR is required (?) for a device, it was decided to have one BAR
>>>>>> for the root, for symmetry.
>>>>>
>>>>> I'm not aware of a spec requirement for any BARs.  It's conceivable
>>>>> that one could build a device that only uses config space.  And of
>>>>> course, most bridges have windows but no BARs.  But that doesn't
>>>>> matter; the hardware is what it is and we have to deal with it.
>>>>
>>>> I appreciate the compassion. RMK considered the DMA HW too screwy
>>>> to bother supporting ;-)
>>>>
>>>>>> In fact, I thought I could ignore that BAR, but it is apparently NOT
>>>>>> the case, as MSIs are supposed to be sent *within* the BAR of the root.
>>>>>
>>>>> I don't know much about this piece of the MSI puzzle, but maybe Marc
>>>>> can enlighten us.  If this Root Port is the target of MSIs and the
>>>>> Root Port turns them into some sort of interrupt on the CPU side, I
>>>>> can see how this might make sense.
>>>>>
>>>>> I think it's unusual for the PCI core to assign the MSI target using a
>>>>> BAR, though.  I think this means you'll have to implement your
>>>>> arch_setup_msi_irq() or .irq_compose_msi_msg() method such that it
>>>>> looks up that BAR value, since you won't know it at build-time.
>>>>
>>>> I'll hack the Altera driver to fit my purpose.
>>>>
>>>>>> The weird twist is that the BAR advertizes a 64-bit memory zone,
>>>>>> but we will, in fact, map MMIO registers behind it. So all the
>>>>>> RAM Linux assigns to the area is wasted, IIUC.
>>>>>
>>>>> I'm not sure what this means.  You have this:
>>>>>
>>>>>> OF: PCI:   MEM 0x90000000..0x9fffffff -> 0x90000000
>>>>
>>>> This means I've put 256 MB of system RAM aside for PCIe devices.
>>>> This memory is no longer available for Linux "stuff".
>>>>
>>>
>>> No it doesn't. It is a physical memory *range* that is assigned to the
>>> PCI host bridge. Any memory accesses by the CPU to that window will be
>>> forwarded to the PCI bus by the host bridge. From the kernel driver's
>>> POV, this range is a given, but your host bridge h/w may involve some
>>> configuration to make the host bridge 'listen' to this range. This is
>>> h/w specific, and as Bjorn pointed out, usually configured by the
>>> firmware so that the kernel driver does not require any knowledge of
>>> those internals.
>>>
>>>>>> pci_bus 0000:00: root bus resource [mem 0x90000000-0x9fffffff]
>>>>
>>>> I suppose this is the PCI bus address. As we've discussed,
>>>> I used the identity to map bus <-> CPU addresses.
>>>>
>>>
>>> Yes, that is fine
>>>
>>>>> This [mem 0x90000000-0x9fffffff] host bridge window means there can't
>>>>> be RAM in that region.  CPU accesses to 0x90000000-0x9fffffff have to
>>>>> be claimed by the host bridge and forwarded to PCI.
>>>>>
>>>>> Linux doesn't "assign system RAM" anywhere; we just learn somehow
>>>>> where that RAM is.  Linux *does* assign BARs of PCI devices, and they
>>>>> have to be inside the host bridge windows(s).
>>>>
>>>> I'm confused, I thought I had understood that part...
>>>> I thought the binding required me to specify (in the "ranges"
>>>> property) a non-prefetchable zone of system RAM, and this
>>>> memory is then "handed out" by Linux to different devices.
>>>> Or do I just need to specify some address range that's not
>>>> necessarily backed with actual RAM?
>>>>
>>>
>>> Yes. Each PCI device advertises its need of memory windows via its
>>> BARs, but the actual placement of those windows inside the host
>>> bridge's memory range is configured dynamically, usually by the
>>> firmware (on PCs) but on ARM/arm64 systems, this is done from scratch
>>> by the kernel. The *purpose* of those memory windows is device
>>> specific, but whatever is behind it lives on the PCI device. So this
>>> is *not* system RAM.
>>
>> Hello Ard,
>>
>> It appears I have misunderstood something fundamental.
>>
>> The binding for generic PCI support
>> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pci/host-generic-pci.txt
>> requires two address-type specs
>> (please correct me if I'm wrong)
>> 1) in the "reg" prop, the address of the configuration space (CPU physical)
>> 2) in the "ranges" prop, at least a non-prefetchable area
>> http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
>>
>> In my 32-bit system, there are 2GB of RAM at [0x8000_0000,0x10000_0000[
>> There are MMIO registers at [0, 16MB[ and also other stuff higher
>> Suppose there is nothing mapped at [0x7000_0000, 0x8000_0000[
>>
>> Can I provide that range to the PCI subsystem?
> 
> Well, it obviously needs to be a range that is not otherwise occupied.
> But it is SoC specific where the forwarded MEM region(s) are, and
> whether they are configurable or not.

My problem is that I don't understand bus addresses vs physical addresses.
(where and when they are used, and how.) Devices themselves put bus
addresses in messages in the PCIe protocol, I assume? When does it matter
what physical address maps to a bus address? When and where does this
mapping take place? (In the RC HW, in the RC driver, elsewhere?)

I suppose some devices do actually need access to *real* *actual* memory
for stuff like DMA. I suppose they must use system memory for that.
Does the generic PCI(e) framework setup this memory?

> IOW, you can ask *us* all you
> want about these details, but only the H/W designer can answer this
> for you.

My biggest problem is that, in order to get useful answers, one must
ask specific questions. And my understanding of PCI is still too
limited to ask good questions.

My current understanding is that I must find a large area in the memory
map where there is NOTHING (no RAM, no registers). Then I can specify
this area in the "ranges" prop of my DT node, to be used as a
non-prefetchable memory address range.

> The DT node that describes the host bridge should simply describe
> which MMIO regions are used by the device. This is no different from
> any other MMO peripheral.

In my limited experience, the DT node for PCI is, by far, the most
complex node I've had to write.

> As for the bus ranges: this also depends on the h/w, as far as i know,
> and has a direct relation with the size of the PCI configuration space
> (1 MB per bus for ECAM iirc?) On 32-bit systems, supporting that many
> buses may be costly in terms of 32-bit addressable space, given that
> the PCIe config space is typically below 4 GB. But it all depends on
> the h/w implementation.

That I know. The HW designer has confirmed reserving 256 MB of address
space for the configuration space. In hind-sight, this was probably a
waste of address space. Supporting 4 buses seems amply sufficient.
Am I wrong?

I suppose wasting 256 MB of address space is not an issue on 64-bit
systems, though.

Regards.
