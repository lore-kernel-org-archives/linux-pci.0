Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:39938 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbaKMSae convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 13:30:34 -0500
Received: by mail-qc0-f177.google.com with SMTP id l6so11610793qcy.36
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 10:30:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4c98ff3154924990b1d3d20bd51eae8b@DM2PR03MB592.namprd03.prod.outlook.com>
References: <863202fec7e0428682edf682c27beb2b@DM2PR03MB592.namprd03.prod.outlook.com>
 <CAErSpo5pbY8oooXT4XD0qqOY8rW74iTi5RbJBO9rUHwRPL54qQ@mail.gmail.com> <4c98ff3154924990b1d3d20bd51eae8b@DM2PR03MB592.namprd03.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Nov 2014 11:30:13 -0700
Message-ID: <CAErSpo5C5Qq_Dux1bcsSyEWSXG9UD1KsbuQ6L=Lr8VFJBvhgFA@mail.gmail.com>
Subject: Re: Sorting out terminology
To: Jake Oshins <jakeo@microsoft.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 13, 2014 at 11:04 AM, Jake Oshins <jakeo@microsoft.com> wrote:
>>> I can see how to create a root PCI bus, and I can see how to do that in
>>> response to events coming in through paravirtual channels.  What's not clear
>>> to me is whether there is a way to tear down a root PCI bus after it has been
>>> created.  The most natural implementation for me would be to create a root
>>> PCI bus whenever a PCI device is offered to the guest VM, tearing down that
>>> root bus when the device is removed from the VM.  Would I be better off
>>> creating one "fake" root PCI bus that lives forever and placing functions
>>> beneath that?  (This seems more complicated to me, unless there's no way
>>> to tear down a root.)
>>
>> I'd start by looking at acpi_pci_root_remove().  Theoretically that
>> removes a PCI host bridge.  I say "theoretically" because this is new
>> code and I haven't seen any bug reports related to it.  Maybe that
>> means it works perfectly, or maybe it means nobody is really using it
>> :)  Yinghai Lu has done most of the work in this area.
>
> Thanks for this advice.  That function was very informative.  I didn't really explain myself properly, though, and so I need to follow up here.  The root PCI bus that I would like to expose is not driven by ACPI.  The only role that ACPI takes in this VM (at least relevant to this discussion) is to create a Module Device (_CID of "ACPI0004") which has a _CRS that exposes all the address space available for all types of I/O devices, both paravirtual and PCI pass-through.  The paravirtual frame buffer, for instance, allocates from this range, and that isn't exposed in any way that looks like a PCI bus.

Makes sense.  I didn't think acpi_pci_root_remove() would be a
fully-formed solution for you; I
just pointed you there because it does things similar to what you want to do.

> When we do SR-IOV for Windows guests, we just create a root PCI bus and place a function underneath the root bus.  No root complex or anything other than the function itself is exposed in the guest.  The paravirtualization is purely a protocol, in contrast to the strategies used with libvirt, Xenbus and others.  There is no ACPI node for the root PCI buses.  There is no emulator for the host bridge, etc.
>
> I'm curious whether this strategy can work for Linux guests.  It seems like my paravirtual PCI front-end could just call the same functions that are invoked in acpi_pci_root_remove().  The only impediment seems to be that pci_stop_root_bus() and pci_remove_root_bus() are not marked with EXPORT_SYMBOL_GPL ().
>
> Would it be acceptable to mark these with EXPORT_SYMBOL_GPL()?  Is this not done simply because nobody has needed it before?  Or is there some other reason?

They're not exported simply because we haven't had any need to export
them.  I think they could be exported if necessary.

>> You said "root port's bridge windows," and I think we can change PCIe
>> Root Port bridge windows in the same way we can change any other
>> PCI-to-PCI bridge's windows.  This is another area that works in
>> theory but is not well-exercised, and here we *do* have bug reports,
>> so I know it doesn't work perfectly.  Yinghai Lu is also the expert in
>> this sort of resource allocation.
>>
>> But it sounds like you might be talking about changing the host
>> bridge's windows, i.e., using _SRS on the host bridge ACPI device, and
>> Linux doesn't have any support for that.
>>
>> Since you mentioned terminology, here's how I use it:
>>
>>   host bridge = a PNP0A03 or PNP0A08 device
>>   root bus = the PCI/PCIe bus immediately below a host bridge (bus
>> number is the _MIN of the bus number range in the host bridge _CRS)
>>   root port = a PCIe Root Port, which we handle as a regular
>> PCI-to-PCI bridge (plus the PCIe services)
>>
>> Bjorn
>
> Similarly, I'm not talking about invoking _SRS on a host bridge.  (I know where the pitfalls are there, and why doing it is a bad idea.  I happen to have implemented that code in Windows.)  I'm talking about changing the resources assigned to a purely paravirtual root PCI bus.  I assume that the protocol for changing the size of PCI-to-PCI bridge windows could be used for this, too.  Do you have a pointer on where to read the code to understand this process?

The existing resource reassignment code is mostly in
drivers/pci/setup-bus.c.  It's possible that if you change the
resources assigned to the paravirtual root bus, it will do the right
thing.  It's not exactly a case we have today, but it *is* similar to
the case of a device below a P2P bridge where we changed the window
size.

Bjorn
