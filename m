Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53152 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab3A3QSk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 11:18:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Date: Wed, 30 Jan 2013 16:17:38 +0000
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201301300955.49473.arnd@arndb.de> <20130130124721.0ad0294e@skate>
In-Reply-To: <20130130124721.0ad0294e@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301301617.38883.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 30 January 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Wed, 30 Jan 2013 09:55:49 +0000, Arnd Bergmann wrote:
> 
> > I don't remember the kernel ever caring about whether hardware complies
> > to a standard or not. The kernel's job is to make hardware work, based
> > on the actual implementation of that hardware. In a lot of cases that
> > means taking the standard document as a reference, and adding quirks
> > for the devices that are different.
> > 
> > In the end, it comes down to the impact on the code complexity, and
> > the run-time overhead for whatever hardware is most common when adding
> > those quirks.
> 
> This is not only about standards, it is also about re-using the PCI
> resource allocation code.
> 
> In my RFCv1, sent December, 7th, I wasn't using any emulated PCI-to-PCI
> bridge. So it *can* perfectly work without it.

Ok, Isee.

> However, one major drawback of my RFCv1 version is that since I didn't
> know how much I/O space and memory space was needed for each PCIe
> device, I had to oversize the address decoding windows. And also, I had
> to have a special allocator (certainly simple, but still) to find an
> available physical address to set up each address decoding window.

Well, for the I/O space, there is no oversizing because either way you
end up with exactly 64KB per root port, right?

> Emulating a PCI-to-PCI bridge very nicely allows to re-use the PCI core
> resource allocation code. I think it's really the main reason for
> emulated those PCI-to-PCI bridges, rather than willing to comply to
> some standards.
> 
> So what I'm going to do now is rework my patch series by removing the
> emulated host bridge (which is normally mandatory by PCIe standard, but
> Linux doesn't need it, so we don't care), but I'll keep the emulated
> PCI-to-PCI bridges in order to benefit for the PCI core resource
> allocation mechanisms.
> 
> Is this ok for you?

Using the Linux allocator for memory resources does sound useful,
so if that requires using the emulated PCI-to-PCI bridges, I guess
it's the best compromise.

> I'd like to settle on the strategy to follow, because we're really
> going a funny road here: on December 7th, I submit a series that
> doesn't use any PCI-to-PCI bridge, and I'm told that I should emulate
> some. I spent a long time working on an implementation that uses
> emumlated PCI-to-PCI bridges, which I submitted on Monday, now to be
> told that I should work really hard not to use PCI-to-PCI bridges. I
> hope you can feel my little embarrassment here...

I'm sorry about this situation. Unfortunatly the way that such decisions
are made is not always straightforward, and what seems like a good idea
at one point turns out to be a mistake or more complex than anticipated
later. With the description of the first patch set, I did not think
it would be necessary to fake a bridge device and their config space.

What I had guessed you could do was to call pci_scan_root_bus on
each of the ports, and then set up the memory space window for
the bus including all of its child devices.

	Arnd
