Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57940 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab3A2P61 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 10:58:27 -0500
Date: Tue, 29 Jan 2013 15:58:20 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Message-ID: <20130129155820.GB23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com> <20130129161211.7bb8cada@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130129161211.7bb8cada@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 04:12:11PM +0100, Thomas Petazzoni wrote:
> On Mon, 28 Jan 2013 19:56:14 +0100, Thomas Petazzoni wrote:
> > The PCI specifications says that an I/O region must be aligned on a 4
> > KB boundary, and a memory region aligned on a 1 MB boundary.

BTW, this, as a general statement, is wrong - though it really depends
what you mean by "region".

Remember that BARs can be set where-ever provided that they satisify
their _individual_ alignment requirements.  So, an IO bar which
occupies 16 bytes must be set to a 16-byte boundary.

Now, there's an additional complication there which occurs if you have
ISA devices sharing the PCI IO space: ISA devices used to only decode
10 bits of IO space, which means that their registers repeat throughout
the IO space.

Therefore, it is generally accepted that within any 1K block, only the
first 256 locations are only usable.

Moreover, some PCI cards have taken advantage of this, particularly VGA
cards.  For example, S3 VGA cards put different registers on 1K
multiples of the standard PC VGA IO addresses...

Also, another reason why I suspect your statement is wrong if I were
to interpret "region" as "BAR" is that consider a bunch of PCI peripherals
behind a PCI bridge.  The total number of IO BARs on the peripherals
is 16.

If you allocate each of those IO BARs to be 4K aligned, then you
consume all 64K of IO space behind one bridge, which leaves no space
for any other IO peripherals elsewhere in the bus structure.

Last reason I think that intepretation is wrong is, on this PC, I see:

        Region 4: I/O ports at 1800 [size=8]
        Region 0: I/O ports at 1830 [size=8]
        Region 2: I/O ports at 1840 [size=32]
        Region 4: I/O ports at 1860 [size=32]
        Region 4: I/O ports at 1880 [size=32]
        Region 4: I/O ports at 18a0 [size=32]
        Region 4: I/O ports at 18c0 [size=32]
        Region 4: I/O ports at 18e0 [size=32]
        Region 4: I/O ports at 1c00 [size=32]
        Region 0: I/O ports at 1c48 [size=8]
        Region 1: I/O ports at 183c [size=4]
        Region 2: I/O ports at 1c40 [size=8]
        Region 3: I/O ports at 1838 [size=4]
        Region 4: I/O ports at 1c20 [size=32]
        Region 4: I/O ports at 1c60 [size=32]

which doesn't follow - and I can pull out other examples on other
x86 platforms where IO BARs aren't aligned to 4K...
