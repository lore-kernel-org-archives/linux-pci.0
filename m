Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:37946 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbaKLXJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Nov 2014 18:09:55 -0500
Received: by mail-qa0-f49.google.com with SMTP id i13so9123792qae.8
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2014 15:09:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <863202fec7e0428682edf682c27beb2b@DM2PR03MB592.namprd03.prod.outlook.com>
References: <863202fec7e0428682edf682c27beb2b@DM2PR03MB592.namprd03.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 12 Nov 2014 16:09:33 -0700
Message-ID: <CAErSpo5pbY8oooXT4XD0qqOY8rW74iTi5RbJBO9rUHwRPL54qQ@mail.gmail.com>
Subject: Re: Sorting out terminology
To: Jake Oshins <jakeo@microsoft.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Nov 11, 2014 at 6:04 PM, Jake Oshins <jakeo@microsoft.com> wrote:
> First, let me introduce myself.  I'm Jake Oshins, and I've been working on Hyper-V and other things at Microsoft for a while.  I'm currently trying to create a front-end driver for Linux running on top of Hyper-V that will enable PCI pass-through, to enable SR-IOV networking, and perhaps some other things over time.  This is similar in form to the "Xen front" PCI implementation, but the specifics are different.
>
> Second, let me say that I'd appreciate any response to my query, and I'm perfectly happy to search the archives associated with this list, or others.  But it's clear to me that I don't yet have the terminology that would allow me to narrow my searches.  So if you all could point me in the right direction, if only by telling me "search for posts that contain these words, and probably these people," I would be grateful.
>
> With that out of the way, I'm currently struggling with two topics.  First, I can see how to create a root PCI bus, and I can see how to do that in response to events coming in through paravirtual channels.  What's not clear to me is whether there is a way to tear down a root PCI bus after it has been created.  The most natural implementation for me would be to create a root PCI bus whenever a PCI device is offered to the guest VM, tearing down that root bus when the device is removed from the VM.  Would I be better off creating one "fake" root PCI bus that lives forever and placing functions beneath that?  (This seems more complicated to me, unless there's no way to tear down a root.)

I'd start by looking at acpi_pci_root_remove().  Theoretically that
removes a PCI host bridge.  I say "theoretically" because this is new
code and I haven't seen any bug reports related to it.  Maybe that
means it works perfectly, or maybe it means nobody is really using it
:)  Yinghai Lu has done most of the work in this area.

> Also on the topic of adding root buses, I can see that when creating a root bus, I should supply a resource list.  My question is two-part.  First, can I set this up so that the root PCI buses themselves don't contain any resources at all, with the children's allocations coming from the (ACPI-based) parent?

No, I don't think you can do this.  The current code, which is not as
generic as we'd like, only looks at _CRS on the host bridge itself (on
x86, this happens in probe_pci_root_info()).

> Or do I have to partition the address space so that each root bus contains its own regions?  Second, assuming that I have to partition the address space, allocating discretely to each root PCI bus, is there some protocol for changing the size of the allocation on the fly, and if so, where should I look to find that?  This is analogous to the physical world, where a root port's bridge windows might need to be changed to accommodate a device with a really large requirement.

You said "root port's bridge windows," and I think we can change PCIe
Root Port bridge windows in the same way we can change any other
PCI-to-PCI bridge's windows.  This is another area that works in
theory but is not well-exercised, and here we *do* have bug reports,
so I know it doesn't work perfectly.  Yinghai Lu is also the expert in
this sort of resource allocation.

But it sounds like you might be talking about changing the host
bridge's windows, i.e., using _SRS on the host bridge ACPI device, and
Linux doesn't have any support for that.

Since you mentioned terminology, here's how I use it:

  host bridge = a PNP0A03 or PNP0A08 device
  root bus = the PCI/PCIe bus immediately below a host bridge (bus
number is the _MIN of the bus number range in the host bridge _CRS)
  root port = a PCIe Root Port, which we handle as a regular
PCI-to-PCI bridge (plus the PCIe services)

Bjorn
