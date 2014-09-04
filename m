Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dub004-omc4s23.hotmail.com ([157.55.2.98]:51323 "EHLO
	DUB004-OMC4S23.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755428AbaIDVmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 17:42:09 -0400
Message-ID: <DUB130-DS63ED85165793FD03D1CB1DBC50@phx.gbl>
From: "Robert" <RJSmith92@live.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
References: <DUB130-DS10845119A34A53DA8A6430DBC50@phx.gbl> <CAErSpo4GRh2LzeoDu-84h1+YfkYuCz4yLE2xGV8V4GG8ajsrcw@mail.gmail.com>
In-Reply-To: <CAErSpo4GRh2LzeoDu-84h1+YfkYuCz4yLE2xGV8V4GG8ajsrcw@mail.gmail.com>
Subject: Re: PCIe root bridge and memory ranges.
Date: Thu, 4 Sep 2014 22:41:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the reply Bjorn, really appreciate it.

> Right so far.

Thanks.

> I don't really know anything about PAM registers.  Conceptually, the
> PNP0A08 _CRS tells the OS that "if the host bridge sees a transaction
> to an address in _CRS, it will forward it to PCI."  That allows the OS
> manage BAR assignments for PCI devices.  If we hot-add a PCI device,
> the OS can assign space for it from anything in _CRS.

The PAM registers are used for the legacy DOS memory ranges (0xA0000 - 
0xFFFFF) and either send reads/writes into DRAM or to the DMI. I was a 
little confused because they show up in the _CRS for the PCI root bridge, 
but reading the Haswell datasheet it never mentions that they go through the 
PCI root bridge, just that they are sent to DMI. I would think that they 
don't go through the root bridge and are there to let an OS know if it needs 
to map a legacy device or something (not sure on that)?

> Theoretically, addresses not mentioned in _CRS should not be passed
> down to PCI.  This is not always true in practice, of course.
> Sometimes BIOSes leave PCI BARs assigned with addresses outside the
> _CRS ranges.  As far as the kernel is concerned, that is illegal, and
> both Windows and Linux will try to move those BARs so they are inside
> a _CRS range.  But often those devices actually do work even when they
> are outside the _CRS ranges, so obviously the bridge is forwarding
> more than what _CRS describes.

Thanks, that's what I'm thinking as well. For example the Haswell datasheet 
says that up to the 512GB address mark can be used for MMIO, but the _CRS 
for the root bridge only mentions the '0xC0000000 – 0xFEAFFFFF' range, and 
nothing above the 4GB mark. I'd be interested to see what happens if you 
filled up that space with devices, would the BIOS then create a new _CRS 
entry to tell the OS it can map devices at regions above 4GB?

> That's possible, and I think many older systems used to work that way.
> But it is not allowed by the ACPI spec, at least partly because you
> can only have one subtractive decode bridge, and modern systems
> typically have several PCI host bridges.

Looking at the datasheet again, it says for the PCI regions "PCI MemoryAdd. 
Range (subtractively decoded to DMI)". I presume this means that the root 
bridge is using subtractive decoding, as the system only has one root bridge 
would that be possible?, and if you have a system with multiple root bridges 
then I'd guess that the firmware would need to program each bridge with a 
specific range?

> Well, Linux relies completely on the host bridge _CRS.  We don't have
> any native host bridge drivers (except some amd_bus and broadcom_bus
> stuff that is deprecated and only kept for backwards compability), so
> the PNP0A08 device is really all we have to operate the host bridge
> and manage PCI device BARs.

Thanks.

I was looking at the Intel PCI root bridge spec, which can be found at 
(http://www.intel.co.uk/content/dam/doc/reference-guide/efi-pci-host-bridge-allocation-protocol-specification.pdf) 
and it mentions that each root bridge has to request resources from the host 
bridge that will then allocate it resources etc. It's from 2002 so I'm not 
sure if it is used anymore but does anyone know if this is still used, and 
in my system that has one root bridge and looks to be using subtractive 
decoding, I don't think it would be used in my system. With system that have 
2 or more root bridges, would this protocol still be used?

..and finally, regarding PCI, an ancient HP article says "The PCI 2.2 
specification (pages 202-204) dictates that root PCI bus must be allocated 
one block of MMIO addresses. This block of addresses is subdivided into the 
regions needed for each device on that PCI bus. And each of those device 
MMIO regions must be aligned on addresses that are multiples of the size of 
the region". The part that says the root PCI bus must be allocated one block 
of addresses, is this true? I have looked at the PCI 2.2 spec pages 202 - 
204 and it says nothing about this and am I right in thinking the root 
bridges are chipset specific, so it wouldn't' be in the PCI 2.2 spec anyway? 
would it be possible for a root bridge to have 2 blocks of addresses go 
through it (not that you ever would) and then have 2 _CRS entries for that 
root bridge?

Thanks again.

Kind Regards,
Robert

-----Original Message----- 
From: Bjorn Helgaas
Sent: Thursday, September 04, 2014 9:07 PM
To: Robert
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe root bridge and memory ranges.

On Thu, Sep 4, 2014 at 8:57 AM, Robert <RJSmith92@live.com> wrote:
> Hello All,
>
> I am having trouble understanding what memory ranges go through the PCIe
> root bridge on a Haswell CPU (what I have in my system) and similarly on
> other modern CPUs. From what I can gather from sources online (including
> many datasheets) is that the PCIE root complex contains a PCI host bridge,
> which produces 1 PCI root bridge (ACPI\PNP0A08). This root bridge then
> forwards certain memory ranges onto the PCI/PCIe bus.

Right so far.

> First of all if I take something like PAM registers, when something is
> written to this address the PAM register forwards it to DMI (if set to do 
> so
> E.G. 0xD0000), so this transaction never goes through the PCI root bridge?
> What's confusing is if I look at the DSDT ACPI table and look at the
> ACPI\PNP0A08 device, it says that the PAM registers ranges go through it. 
> I
> guess this is just for an OS purpose as it doesn’t need to know what exact
> ranges go through the root bridge? I'm not entirely sure on that and if
> anyone could clarify it would be appreciated.

I don't really know anything about PAM registers.  Conceptually, the
PNP0A08 _CRS tells the OS that "if the host bridge sees a transaction
to an address in _CRS, it will forward it to PCI."  That allows the OS
manage BAR assignments for PCI devices.  If we hot-add a PCI device,
the OS can assign space for it from anything in _CRS.

It sounds like PAM is an arch-specific way to control transaction
routing.  That would probably be outside the purview of ACPI, and if
the OS uses PAM to re-route things mentioned in a PNP0A08 _CRS, that
would be some sort of arch-specific code.

> As well as the PAM register ranges for the root bridge it also has the 
> PCIe
> device memory range, which in my case is 0xC0000000 – 0xFEAFFFFF, now does
> that mean that anything above that range isn't going through the PCI root
> bridge, or is it just like that so an OS doesn't try map a device in that
> region. If I look at the Haswell datasheet it has small regions in that 
> area
> between things like APIC and BIOS that reach the DMI.

Theoretically, addresses not mentioned in _CRS should not be passed
down to PCI.  This is not always true in practice, of course.
Sometimes BIOSes leave PCI BARs assigned with addresses outside the
_CRS ranges.  As far as the kernel is concerned, that is illegal, and
both Windows and Linux will try to move those BARs so they are inside
a _CRS range.  But often those devices actually do work even when they
are outside the _CRS ranges, so obviously the bridge is forwarding
more than what _CRS describes.

> It seems as if the PCI root bridge is using some sort of subtractive
> decoding that picks up whatever isn't sent to DRAM etc. and to make it 
> easy
> for an OS the BIOS gives it a block of address space.

That's possible, and I think many older systems used to work that way.
But it is not allowed by the ACPI spec, at least partly because you
can only have one subtractive decode bridge, and modern systems
typically have several PCI host bridges.

> Finally, I was on a forum related to external GPUs, and some Windows users
> didn’t have enough space to map the device below 4GB. To resolve this they
> manually edited the DSDT table and added another entry above the 4GB
> barrier, now Windows mapped the GPU in the 64bit space. Now I presume
> changing the entry in the DSDT table didn't make any difference to how the
> hardware was set up, it just told the OS that the root bridge will in fact
> pick up this address range and therefore it knew it could map it there.
>
> So am I write in thinking the ranges in the ACPI table are for the OSs
> purpose, and don't actually have to accurately represent what the hardware
> does.

Well, Linux relies completely on the host bridge _CRS.  We don't have
any native host bridge drivers (except some amd_bus and broadcom_bus
stuff that is deprecated and only kept for backwards compability), so
the PNP0A08 device is really all we have to operate the host bridge
and manage PCI device BARs.

> ..and does anyone know what ranges do actually go through a single PCIe 
> root
> bridge on a modern system?
>
> If anyone could help it would be greatly appreciated :)
>
> Kind Regards,
> Robert
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

