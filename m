Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:63621 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518Ab3A3Swg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 13:52:36 -0500
Received: by mail-vc0-f179.google.com with SMTP id gb23so1227965vcb.10
        for <linux-pci@vger.kernel.org>; Wed, 30 Jan 2013 10:52:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130130103501.1873d39c@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com>
 <20130129055508.GA3339@obsidianresearch.com> <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
 <20130129184157.GA29274@obsidianresearch.com> <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
 <20130129191853.GB29274@obsidianresearch.com> <CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
 <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com> <20130130103501.1873d39c@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Jan 2013 11:52:15 -0700
Message-ID: <CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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

On Wed, Jan 30, 2013 at 2:35 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Tue, 29 Jan 2013 15:27:43 -0700, Bjorn Helgaas wrote:
>
>> I'm not sure the existing emulation in these patches is sufficient.
>> For example, pci_sw_pci_bridge_write() updates bridge->membase when we
>> write to the window register, but I don't see anything that updates
>> the actual hardware decoder.  That might be done in
>> mvebu_pcie_window_config_port() via armada_370_xp_alloc_pcie_window(),
>> but that looks like it's only done once.
>
> That's correct. I currently let the Linux PCI core enumerate the
> real PCIe devices, allocate the resources, and set the appropriate
> values in the emulated PCI-to-PCI bridge registers. Once this is all
> done, the Marvell PCIe driver looks at each PCI-to-PCI bridge, reads
> the membase and iobase registers, and creates address decoding windows
> so that the physical addresses assigned by the Linux PCI core actually
> resolve to the right PCIe interface. This is done once for all.
>
>> If the PCI core updates a root port window later, I don't see where the hardware
>> decoder will be updated.
>
> It will not be updated.
>
>> Maybe you're counting on the window assignments to be static?  The PCI
>> core doesn't guarantee anything like that, though in the absence of
>> hotplug I don't know any reason why it would change things.
>
> Right. Is supporting hotplug a show-stopper to get this included? I
> think it could be added later, if it happens to be needed, no?
>
> I could of course do it, but the patch series is already quite large
> and complicated, so if we could merge a simple, but working, version
> first, and then improve on top of it when needed, it would be nice.

I'm most concerned about the stuff in drivers/pci.  I hesitate to
merge drivers/pci/sw-pci-pci-bridge.c as-is because it's a model
that's not connected to hardware and only works in a completely static
situation, and the rest of the PCI core can't really deal with that.

But I don't think supporting hotplug should be a show-stopper at this
point, either.  It sounds like we might be heading towards hooking
this up more directly to the Marvell hardware, which will make it more
arch-dependent.  Something like that could either go in arch/arm, or
in some not-quite-so-generic spot under drivers/pci.

>> I also forgot about the bus number munging in mvebu_pcie_rd_conf().
>> The PCI core can update the bridge secondary/subordinate registers.
>> It looks like you don't support writing to them, and the read path
>> (pci_sw_pci_bridge_read()) looks like it doesn't do any translation
>> between the hardware and Linux bus numbers.  I don't understand the
>> system well enough to know if this is an issue.
>
> Right. Could you explain a little bit for what reasons the PCI core
> could update the secondary/subordinate registers, and to what values it
> sets them?

The secondary/subordinate registers effectively define a bus number
aperture that tells the bridge which transactions to claim and forward
downstream.  When enumerating devices, we may update the subordinate
bus number to widen the aperture so we can enumerate an arbitrary tree
behind the bridge.  When we're finished, we'll probably narrow it by
updating the subordinate again, so the unused bus number space can be
used for other bridges.  I don't know the exact details of the
algorithm, and they're likely to change anyway, but pci_scan_bridge()
is where most of it happens.

It looks like your current system doesn't support trees below the
bridges, but hopefully we can make it so the generic enumeration
algorithms still work.

> For now, I statically assign the secondary bus register value to be
> X+1, where X is the number of the PCIe interface, since X=0 is reserved
> for the root bus (which has the host bridge and the PCI-to-PCI
> bridges).

That makes sense but limits you to a single bus (and really, a single
device since this is PCIe) below the bridge.

> Also, could you detail what kind of translation I should be doing when
> reading the hardware and Linux bus numbers?

I'm hoping that the register Jason mentioned is enough to avoid the
need for translation.  If it's not, we can explore this a bit more.

Bjorn
