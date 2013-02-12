Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56947 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758579Ab3BLQAr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:00:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Date: Tue, 12 Feb 2013 16:00:08 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <CAErSpo7hwG89LTO+4+eqT_Gb+yUn1XKHYJ8CnnZcf_FPo-Kpyw@mail.gmail.com> <20130208091420.703a39b4@skate>
In-Reply-To: <20130208091420.703a39b4@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302121600.08434.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 08 February 2013, Thomas Petazzoni wrote:
> Dear Bjorn Helgaas,
> 
> On Thu, 7 Feb 2013 21:21:57 -0700, Bjorn Helgaas wrote:
> 
> > Huh.  That hardware looks less and less like a P2P bridge all the time
> > :(  You can't configure it via standard PCI config accesses, and the
> > aperture alignment and size constraints sound completely non-standard.

Right.

> > I could imagine changing pcibios_window_alignment() to take the
> > resource, so it could deal with the alignment question (though I
> > haven't looked in detail and there might be some implementation issue
> > with that).
> > 
> > With regard to the size issue (3MB window using 4MB of address space),
> > I can't think of a reasonable way to teach the PCI core about both
> > sizes.  But is there any reason to program the bridge for a 3MB window
> > instead of a 4MB window, given that there's nothing else we can do
> > with the extra 1MB anyway?  Is a 3MB window even possible?  I would
> > think something that must be aligned on its size would be restricted
> > to power-of-2 sizes anyway, just like PCI BARs are.  Maybe you can
> > just always round up window sizes to a power of 2?
> 
> The window sizes are power of two sizes. I didn't realize that it was
> also the case for PCI BARs. Then there is no problem with the size I
> guess, and only a problem of alignment. Having the possibility to
> get the resource and return a fixed up start address would solve the
> problem I'd say.

I thought that only device BARs in PCI had natural alignment, while
bridges don't.

I tried understanding the actual problem we have with the current
procedure, which on today's kirkwood is rought implemented in ARM's
pci_common_init() as follows:

for_each_root_bus() {
	pci_scan_root_bus();
}
for_each_root_bus {
	pci_bus_size_bridges();
	pci_bus_assign_resources();
	pci_enable_bridges();
	pci_bus_add_devices();
}

This is using hardcoded windows today, which are set up before calling
pci_scan_root_bus(). With your change, there is only one root bus,
and you intercept the pci_bus_assign_resources() stage in order to
set up the hardware specific window configuration for each PCIe
port of that root bus.

My feeling is that an easier solution would be to keep separate
root buses for each port, which then behaves completely PCIe
compliant, but add a hook in the procedure above to set up the
address translation windows between the pci_bus_size_bridges()
and the pci_bus_assign_resources() calls.

	Arnd
