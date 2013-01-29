Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36072 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab3A2RJn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 12:09:43 -0500
Date: Tue, 29 Jan 2013 18:09:36 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
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
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130129180936.3737e550@skate>
In-Reply-To: <201301291645.08040.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129155820.GB23505@n2100.arm.linux.org.uk>
	<20130129172055.0ca5f341@skate>
	<201301291645.08040.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 29 Jan 2013 16:45:07 +0000, Arnd Bergmann wrote:
> On Tuesday 29 January 2013, Thomas Petazzoni wrote:
> > And the Linux PCI resource allocation code complies with this, so
> > that if I have two PCI-to-PCI bridges (each having downstream a
> > device with an I/O BAR), then the first PCI-to-PCI bridge gets its
> > I/O base address register set to ADDR + 0x0, and the second bridge
> > gets its I/O base address set to ADDR + 0x1000. And this doesn't
> > play well with the requirements of Marvell address decoding windows
> > for PCIe I/O regions, which must be 64 KB aligned.
> 
> But we normally only assign a 64 KB I/O window to each PCI host
> bridge. Requiring PCI bridges to be space 64 KB apart would mean that
> we cannot actually support bridges at all.
> 
> Is this just about your "virtual" bridges? If each one has its
> own 64 KB I/O range and its own configuration space, that sounds
> a lot like you should make them appear as individual domains instead.

Yes, it is about the emulated PCI-to-PCI bridges. Each
emulated PCI-to-PCI bridge corresponds to one hardware PCIe interface,
and I need the I/O base address assigned to each PCIe interface to be
aligned on a 64 KB boundary. I am not sure to understand why you think
this is a problem.

Also, what do you mean exactly by making them appear as individual
domains?

Remember that the very reason to use emulated PCI-to-PCI bridges is
that we want to assign a global range of addresses of I/O regions and a
global range of addresses of memory regions, and let the Linux PCI core
allocate from those two ranges to the different devices connected
downstream of the PCI-to-PCI bridges. This gives us for free the rather
complex allocation of addresses we need to set up our address decoding
windows.

If we have have separate domains for each of our hardware PCIe
interface, can we still benefit from this allocation of resources from
a globally defined range of I/O addresses and memory addresses?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
