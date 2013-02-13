Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:48889 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231Ab3BMTMI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Feb 2013 14:12:08 -0500
Date: Wed, 13 Feb 2013 12:12:04 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Message-ID: <20130213191204.GA15710@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302122305.28467.arnd@arndb.de>
 <20130213003224.GA32535@obsidianresearch.com>
 <201302131853.14617.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201302131853.14617.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 13, 2013 at 06:53:14PM +0000, Arnd Bergmann wrote:

> > The standard answer is to leave appropriate gaps. My *guess* on this
> > matter is that on x86 the gaps are left, as appropriate, by the boot
> > firmware. Eg an ExpressCard slot will always have a window assigned to
> > its bridge and Linux would typically not reassign it (or similar).
> > 
> > PCI core support for firmware-less embedded will someday need to do
> > something similar, eg via a special DT attribute on hot plug capable
> > ports.
> 
> I saw that the PCI core reserves 2MB memory space and 256 bytes of
> I/O space per hotplug capable bridge by default, and you can
> override

Haven't looked at how it determines what is hot plug
capable.. Technically every PCI-E port is hot plug capable, it really
depends on the specific board if a port can actually be hot plugged or
not - so maybe that is what gets set in DT?

> these at boot time if you need more. I wonder if this means that
> we end up using two of the precious address space windows for each
> unused root port to already map these at boot time, and it certainly
> works for most adapters, but this does not seem better than assigning
> static windows of the same size at boot time for each port.

If the PCI core programs the decoder on the bridge, then it will
consume a window - however if there is nothing behind the bridge then
leaving the brdige window disabled, but reserving the memory region is
a sensible thing to do.

I'm not sure what the state of the PCI core is today on this point,
but it could be altered..

Also the host driver can check the link status before consuming a
window, no link = no window.

Thomas, what were your test results on your 10 slot system? Did all 10
P2P bridges appear in lspci? Was there any address space reservation
for hot plug?

> > Just to circle back on this whole thread - Thomas's solution is pretty
> > good, it covers pretty much all the use cases. I think it is a good
> > place to start, and as the firmware-less 'drivers/pci/host' concept
> > develops the right support will eventually come, as everyone is now
> > aware of the need to control the host bridge aperture from the core
> > PCI code.
> 
> I agree the solution is not all that bad, I just want to be convinced
> that it actually has advantages over the simpler approaches.

Unfortunatelly my Marvell systems do not have oversubscribed mbus
windows, so I can't really comment on this :( However I do use the
hotplug capability in the current driver, so at least for me, it is
important to not loose that when trying to solve the oversubcription.

Jason
