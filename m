Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35684 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3A2QVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 11:21:12 -0500
Date: Tue, 29 Jan 2013 17:20:55 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130129172055.0ca5f341@skate>
In-Reply-To: <20130129155820.GB23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129161211.7bb8cada@skate>
	<20130129155820.GB23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

On Tue, 29 Jan 2013 15:58:20 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 29, 2013 at 04:12:11PM +0100, Thomas Petazzoni wrote:
> > On Mon, 28 Jan 2013 19:56:14 +0100, Thomas Petazzoni wrote:
> > > The PCI specifications says that an I/O region must be aligned on a 4
> > > KB boundary, and a memory region aligned on a 1 MB boundary.
> 
> BTW, this, as a general statement, is wrong - though it really depends
> what you mean by "region".

Yes, sorry, my statement does not correctly reflect the reality. My
knowledge of the PCI terminology is still quite fuzzy (as you found
out). What I am referring to is that the PCI standard requires the I/O
base register of a PCI-to-PCI bridge to contain a 4 KB aligned address.

>From the PCI-to-PCI Bridge Architecture Specification, Revision 1.1,
section 3.2.5.6. I/O Base Register and I/O Limit Register:

"""
   If a bridge implements an I/O address range, the upper 4 bits of
   both the I/O Base and I/O Limit registers are writable and
   correspond to address bits AD[15::12]. For the purpose of address
   decoding, the bridge assumes that the lower 12 address bits,
   AD[11::00], of the I/O base address (not implemented in the I/O Base
   register) are zero. Similarly, the bridge assumes that the lower 12
   address bits, AD[11::00], of the I/O limit address (not implemented
   in the I/O Limit register) are FFFh. Thus, the bottom of the defined
   I/O address range will be aligned to a 4 KB boundary and the top of
   the defined I/O address range will be one less than a 4 KB boundary.
"""

And the Linux PCI resource allocation code complies with this, so that
if I have two PCI-to-PCI bridges (each having downstream a device with
an I/O BAR), then the first PCI-to-PCI bridge gets its I/O base address
register set to ADDR + 0x0, and the second bridge gets its I/O base
address set to ADDR + 0x1000. And this doesn't play well with the
requirements of Marvell address decoding windows for PCIe I/O regions,
which must be 64 KB aligned.

So I guess I should simply rewrite the commit log to make it clear that
I'm referring to the I/O base address register of PCI-to-PCI bridges.

Would this be more correct? In that case, maybe in fact I really need a
hook so that this alignment requirement on only applied on the
resources allocated to bridges, and not on their downstream devices?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
