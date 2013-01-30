Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:39371 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab3A3JfH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 04:35:07 -0500
Date: Wed, 30 Jan 2013 10:35:01 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
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
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130130103501.1873d39c@skate>
In-Reply-To: <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com>
	<20130129055508.GA3339@obsidianresearch.com>
	<CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
	<20130129184157.GA29274@obsidianresearch.com>
	<CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
	<20130129191853.GB29274@obsidianresearch.com>
	<CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
	<CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Tue, 29 Jan 2013 15:27:43 -0700, Bjorn Helgaas wrote:

> I'm not sure the existing emulation in these patches is sufficient.
> For example, pci_sw_pci_bridge_write() updates bridge->membase when we
> write to the window register, but I don't see anything that updates
> the actual hardware decoder.  That might be done in
> mvebu_pcie_window_config_port() via armada_370_xp_alloc_pcie_window(),
> but that looks like it's only done once.

That's correct. I currently let the Linux PCI core enumerate the
real PCIe devices, allocate the resources, and set the appropriate
values in the emulated PCI-to-PCI bridge registers. Once this is all
done, the Marvell PCIe driver looks at each PCI-to-PCI bridge, reads
the membase and iobase registers, and creates address decoding windows
so that the physical addresses assigned by the Linux PCI core actually
resolve to the right PCIe interface. This is done once for all.

> If the PCI core updates a root port window later, I don't see where the hardware
> decoder will be updated.

It will not be updated.

> Maybe you're counting on the window assignments to be static?  The PCI
> core doesn't guarantee anything like that, though in the absence of
> hotplug I don't know any reason why it would change things.

Right. Is supporting hotplug a show-stopper to get this included? I
think it could be added later, if it happens to be needed, no?

I could of course do it, but the patch series is already quite large
and complicated, so if we could merge a simple, but working, version
first, and then improve on top of it when needed, it would be nice.

> I also forgot about the bus number munging in mvebu_pcie_rd_conf().
> The PCI core can update the bridge secondary/subordinate registers.
> It looks like you don't support writing to them, and the read path
> (pci_sw_pci_bridge_read()) looks like it doesn't do any translation
> between the hardware and Linux bus numbers.  I don't understand the
> system well enough to know if this is an issue.

Right. Could you explain a little bit for what reasons the PCI core
could update the secondary/subordinate registers, and to what values it
sets them?

For now, I statically assign the secondary bus register value to be
X+1, where X is the number of the PCIe interface, since X=0 is reserved
for the root bus (which has the host bridge and the PCI-to-PCI
bridges).

Also, could you detail what kind of translation I should be doing when
reading the hardware and Linux bus numbers?

I apologize for asking so many, probably silly, questions, but I am
still learning all those internal PCI mechanisms.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
