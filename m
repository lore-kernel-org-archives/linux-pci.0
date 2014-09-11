Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dub004-omc4s28.hotmail.com ([157.55.2.103]:59211 "EHLO
	DUB004-OMC4S28.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752642AbaIKATP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 20:19:15 -0400
Message-ID: <DUB130-DS11BD5E00A5726DD8D15192DBCC0@phx.gbl>
From: "Robert" <RJSmith92@live.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
References: <DUB130-DS10845119A34A53DA8A6430DBC50@phx.gbl> <CAErSpo4GRh2LzeoDu-84h1+YfkYuCz4yLE2xGV8V4GG8ajsrcw@mail.gmail.com> <DUB130-DS63ED85165793FD03D1CB1DBC50@phx.gbl> <CAErSpo4_S_9OLrODQO8u0VZU-7sv2XbhcAUd7CxjaV37zcY_Sg@mail.gmail.com>
In-Reply-To: <CAErSpo4_S_9OLrODQO8u0VZU-7sv2XbhcAUd7CxjaV37zcY_Sg@mail.gmail.com>
Subject: Re: PCIe root bridge and memory ranges.
Date: Thu, 11 Sep 2014 01:18:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks again Bjorn,

> I don't know much about DMI, but as far as I know, it is not visible
> in the ACPI platform description.  If the range at 0xA0000 can be used
> for a PCI device, then it needs to be in the _CRS of the host bridge.

As far as I know the DMI is transparent from an OS point of view, when the 
datasheet says something is sent to DMI, they're basically saying it is sent 
to the 'Southbridge'. I actually got the range wrong, The PAM range is from 
0xC0000 - 0xFFFFFF. From what I can gather these ranges are positively 
decoded either to DRAM or to the DMI. My guess is that these ranges don't go 
through the host bridge (which I believe to use subtractive decoding) but 
they are in the _CRS for the host bridge to let the OS know it can be used 
for a PCI device (even though technically it isn't going through the host 
bridge)

> Sounds possible.  It seems like BIOSes often don't really do anything
> with the bus address space above 4GB even when the hardware supports
> it.  And of course, Linux has no idea what the hardware actually
> supports, since we only look at the ACPI PNP0A03/08 descriptions.

Thanks.

> A host bridge definitely *can* use subtractive decoding.  But at least
> on ACPI systems, that level of detail is really invisible to Linux.
> We only know about the abstract host bridge described by ACPI, which
> tells us about the positively decoded regions claimed by the bridge.

> There actually is a _DEC bit in the ACPI Extended Address Space
> Descriptor (ACPI r5.0, sec 6.4.3.5.4), that means "the bridge
> subtractively decodes this address."  But Linux doesn't look at this
> bit, and I assume it means that ACPI would have explicitly describe
> all the address space that could be subtractively decoded anyway.

Thanks. I agree, when I look at the _CRS for the host bridge it reads form 
TOLUD to get the bottom of the MMIO space, but then the top of this space is 
hardcoded in rather than read from a register. I suppose if it wasn't using 
subtractive decoding you wouldn't need to do this and could read from the 
registers in the host bridge directly to see what it decodes.

>> ..and finally, regarding PCI, an ancient HP article says "The PCI 2.2
>> specification (pages 202-204) dictates that root PCI bus must be 
>> allocated
>> one block of MMIO addresses. This block of addresses is subdivided into 
>> the
>> regions needed for each device on that PCI bus. And each of those device
>> MMIO regions must be aligned on addresses that are multiples of the size 
>> of
>> the region". The part that says the root PCI bus must be allocated one 
>> block
>> of addresses, is this true? I have looked at the PCI 2.2 spec pages 202 -
>> 204 and it says nothing about this and am I right in thinking the root
>> bridges are chipset specific, so it wouldn't' be in the PCI 2.2 spec 
>> anyway?
>> would it be possible for a root bridge to have 2 blocks of addresses go
>> through it (not that you ever would) and then have 2 _CRS entries for 
>> that
>> root bridge?

> Hmm.  I don't have a copy of the PCI 2.2 spec, but I don't think this
> is true.  As far as I know, there is no restriction on the number of
> regions that a PCI host bridge can claim.  The discovery and
> programming of these regions is device-specific, of course, so this is
> all outside the scope of the PCI specs.

> We did a lot of work a few years ago to support an arbitrary number of
> apertures, e.g.,
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2fe2abf896c1

Thanks. Yes I think the HP article just meant that on page 202 -204 of the 
PCI 2.2 spec that each device takes a some of the resources assigned to the 
root bridge, and as you say the root bridge is device specific and not in 
the Spec. I've had a look at the link you sent me, it's a bit too 
complicated for me :( but in basic terms, does it allow for a root bridge to 
have 2 or more memory address windows e.g. 0xC0000000 - 0xCFFFFFFF and 
0xD0000000 - 0xFFFFFFFF?

1 last question :) Regarding PCIe, I understand that it is a packet based 
protocol but where are the packets created? Online a lot of resources say 
the Root Complex generates a PCIe transaction on behalf of the processor, 
but isn't the Root Complex made up of multiple devices (host bridge/s and 
memory controller etc.) Do you know which specific device generates the PCIe 
packet, is it the root bridge?

As always, thanks for taking the time to answer my questions.

Kind Regards,
Robert

-----Original Message----- 
From: Bjorn Helgaas
Sent: Tuesday, September 09, 2014 4:50 PM
To: Robert
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe root bridge and memory ranges.

On Thu, Sep 4, 2014 at 3:41 PM, Robert <RJSmith92@live.com> wrote:
> Bjorn Helgaas wrote:
>> I don't really know anything about PAM registers.  Conceptually, the
>> PNP0A08 _CRS tells the OS that "if the host bridge sees a transaction
>> to an address in _CRS, it will forward it to PCI."  That allows the OS
>> manage BAR assignments for PCI devices.  If we hot-add a PCI device,
>> the OS can assign space for it from anything in _CRS.
>
>
> The PAM registers are used for the legacy DOS memory ranges (0xA0000 -
> 0xFFFFF) and either send reads/writes into DRAM or to the DMI. I was a
> little confused because they show up in the _CRS for the PCI root bridge,
> but reading the Haswell datasheet it never mentions that they go through 
> the
> PCI root bridge, just that they are sent to DMI. I would think that they
> don't go through the root bridge and are there to let an OS know if it 
> needs
> to map a legacy device or something (not sure on that)?

I don't know much about DMI, but as far as I know, it is not visible
in the ACPI platform description.  If the range at 0xA0000 can be used
for a PCI device, then it needs to be in the _CRS of the host bridge.

>> Theoretically, addresses not mentioned in _CRS should not be passed
>> down to PCI.  This is not always true in practice, of course.
>> Sometimes BIOSes leave PCI BARs assigned with addresses outside the
>> _CRS ranges.  As far as the kernel is concerned, that is illegal, and
>> both Windows and Linux will try to move those BARs so they are inside
>> a _CRS range.  But often those devices actually do work even when they
>> are outside the _CRS ranges, so obviously the bridge is forwarding
>> more than what _CRS describes.
>
>
> Thanks, that's what I'm thinking as well. For example the Haswell 
> datasheet
> says that up to the 512GB address mark can be used for MMIO, but the _CRS
> for the root bridge only mentions the '0xC0000000 – 0xFEAFFFFF' range, and
> nothing above the 4GB mark. I'd be interested to see what happens if you
> filled up that space with devices, would the BIOS then create a new _CRS
> entry to tell the OS it can map devices at regions above 4GB?

Sounds possible.  It seems like BIOSes often don't really do anything
with the bus address space above 4GB even when the hardware supports
it.  And of course, Linux has no idea what the hardware actually
supports, since we only look at the ACPI PNP0A03/08 descriptions.

>> That's possible, and I think many older systems used to work that way.
>> But it is not allowed by the ACPI spec, at least partly because you
>> can only have one subtractive decode bridge, and modern systems
>> typically have several PCI host bridges.
>
>
> Looking at the datasheet again, it says for the PCI regions "PCI 
> MemoryAdd.
> Range (subtractively decoded to DMI)". I presume this means that the root
> bridge is using subtractive decoding, as the system only has one root 
> bridge
> would that be possible?,

A host bridge definitely *can* use subtractive decoding.  But at least
on ACPI systems, that level of detail is really invisible to Linux.
We only know about the abstract host bridge described by ACPI, which
tells us about the positively decoded regions claimed by the bridge.

There actually is a _DEC bit in the ACPI Extended Address Space
Descriptor (ACPI r5.0, sec 6.4.3.5.4), that means "the bridge
subtractively decodes this address."  But Linux doesn't look at this
bit, and I assume it means that ACPI would have explicitly describe
all the address space that could be subtractively decoded anyway.

> and if you have a system with multiple root bridges
> then I'd guess that the firmware would need to program each bridge with a
> specific range?

Yes.

> I was looking at the Intel PCI root bridge spec, which can be found at
> (http://www.intel.co.uk/content/dam/doc/reference-guide/efi-pci-host-bridge-allocation-protocol-specification.pdf)
> and it mentions that each root bridge has to request resources from the 
> host
> bridge that will then allocate it resources etc. It's from 2002 so I'm not
> sure if it is used anymore but does anyone know if this is still used, and
> in my system that has one root bridge and looks to be using subtractive
> decoding, I don't think it would be used in my system. With system that 
> have
> 2 or more root bridges, would this protocol still be used?

Sorry, I don't know anything about this.  That spec is talking about
firmware, and really outside the view of the kernel.

> ..and finally, regarding PCI, an ancient HP article says "The PCI 2.2
> specification (pages 202-204) dictates that root PCI bus must be allocated
> one block of MMIO addresses. This block of addresses is subdivided into 
> the
> regions needed for each device on that PCI bus. And each of those device
> MMIO regions must be aligned on addresses that are multiples of the size 
> of
> the region". The part that says the root PCI bus must be allocated one 
> block
> of addresses, is this true? I have looked at the PCI 2.2 spec pages 202 -
> 204 and it says nothing about this and am I right in thinking the root
> bridges are chipset specific, so it wouldn't' be in the PCI 2.2 spec 
> anyway?
> would it be possible for a root bridge to have 2 blocks of addresses go
> through it (not that you ever would) and then have 2 _CRS entries for that
> root bridge?

Hmm.  I don't have a copy of the PCI 2.2 spec, but I don't think this
is true.  As far as I know, there is no restriction on the number of
regions that a PCI host bridge can claim.  The discovery and
programming of these regions is device-specific, of course, so this is
all outside the scope of the PCI specs.

We did a lot of work a few years ago to support an arbitrary number of
apertures, e.g.,
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2fe2abf896c1

Bjorn 

