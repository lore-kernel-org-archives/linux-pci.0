Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:46107 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab3A2Rrc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 12:47:32 -0500
Received: by mail-vc0-f180.google.com with SMTP id fo13so449649vcb.11
        for <linux-pci@vger.kernel.org>; Tue, 29 Jan 2013 09:47:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130129055508.GA3339@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com> <20130129055508.GA3339@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Jan 2013 10:47:09 -0700
Message-ID: <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 10:55 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Jan 28, 2013 at 08:29:24PM -0700, Bjorn Helgaas wrote:
>> On Mon, Jan 28, 2013 at 11:56 AM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>> > This driver implements the support for the PCIe interfaces on the
>> > Marvell Armada 370/XP ARM SoCs. In the future, it might be extended to
>> > cover earlier families of Marvell SoCs, such as Dove, Orion and
>> > Kirkwood.
>> >
>> > The driver implements the hw_pci operations needed by the core ARM PCI
>> > code to setup PCI devices and get their corresponding IRQs, and the
>> > pci_ops operations that are used by the PCI core to read/write the
>> > configuration space of PCI devices.
>> >
>> > Since the PCIe interfaces of Marvell SoCs are completely separate and
>> > not linked together in a bus, this driver sets up an emulated PCI host
>> > bridge, with one PCI-to-PCI bridge as child for each hardware PCIe
>> > interface.
>>
>> There's no Linux requirement that multiple PCIe interfaces appear to
>> be in the same hierarchy.  You can just use pci_scan_root_bus()
>> separately on each interface.  Each interface can be in its own domain
>> if necessary.
>
> What you suggest is basically what the Marvell driver did originally,
> the probelm is that Linux requires a pre-assigned aperture for each
> PCI domain/root bus, and these new chips have so many PCI-E ports that
> they can exhaust the physical address space, and also a limited
> internal HW resource for setting address routing.
>
> Thus they require resource allocation that is sensitive to the devices
> present downstream.
>
> By far the simplest solution is to merge all the physical links into a
> single domain and rely on existing PCI resource allocation code to
> drive allocation of scarce physical address space and demand allocate
> the HW routing resource (specifically there are enough resources to
> accomidate MMIO only devices on every bus, but not enough to
> accomidate MMIO and IO on every bus).
>
>> > +/*
>> > + * For a given PCIe interface (represented by a mvebu_pcie_port
>> > + * structure), we read the PCI configuration space of the
>> > + * corresponding PCI-to-PCI bridge in order to find out which range of
>> > + * I/O addresses and memory addresses have been assigned to this PCIe
>> > + * interface. Using these informations, we set up the appropriate
>> > + * address decoding windows so that the physical address are actually
>> > + * resolved to the right PCIe interface.
>> > + */
>>
>> Are you inferring the host bridge apertures by using the resources
>> assigned to devices under the bridge, i.e., taking the union of all
>
> The flow is different, a portion of physical address space is set
> aside for use by PCI-E (via DT) and that portion is specified in the
> struct resource's ultimately attached to the PCI domain for the bus
> scan. You could call that the 'host bridge aperture' though it doesn't
> reflect any HW configuration at all. The values come from the device
> tree.

I think I would understand this better if we had a concrete example to
talk about, say a dmesg log and corresponding lspci -v output.

As I understand it, the DT is a description of the hardware, so in
that sense, the DT can't set aside physical address space.  It can
describe what the hardware does with the address space, and I assume
that's what you mean.  Maybe the hardware isn't configurable, e.g., it
is hard-wired to route certain address ranges to PCIe?

> During the bus scan the Linux core code splits up that contiguous
> space and assigns to the PCI-PCI bridges and devices under that domain.
>
> Each physical PCI-E link on the chip is seen by Linux through the SW
> emulated PCI-PCI bridge attached to bus 0. When Linux configures the
> bridge windows it triggers this code here to copy that window
> information from the PCI config space into non-standard internal HW
> registers.
>
> The purpose of the SW PCI-PCI bridge and this code here is to give
> the Linux PCI core control over the window (MMIO,IO,busnr) assigned
> to the PCI-E link.
>
> This arrangement with PCI-PCI bridges controlling address routing is
> part of the PCI-E standard, in this instance Marvell did not implement
> the required config space in HW so the driver is working around that
> deficiency.
>
> Other drivers, like tegra have a similar design, but their hardware
> does implement PCI-PCI bridge configuration space and does drive
> address decoding through the HW PCI-PCI window registers.
>
> Having PCI-E links be bridges, not domains/root_bus's is in-line with
> the standard and works better with the Linux PCI resource allocator.
>
> Jason
