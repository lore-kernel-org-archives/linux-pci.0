Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52988 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab3BFSm2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2013 13:42:28 -0500
Date: Wed, 6 Feb 2013 19:42:22 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130206194222.27db0d90@skate>
In-Reply-To: <51129F6B.1050709@wwwdotorg.org>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
	<2776630.gp5gC9tvLk@wuerfel>
	<20130131180249.GA30869@obsidianresearch.com>
	<201301312046.22560.arnd@arndb.de>
	<20130131224459.GA11846@obsidianresearch.com>
	<20130206175128.1b64196d@skate>
	<20130206170903.GA28198@obsidianresearch.com>
	<20130206181852.4eca53e3@skate>
	<20130206175019.GA24248@obsidianresearch.com>
	<51129F6B.1050709@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Stephen Warren,

On Wed, 06 Feb 2013 11:22:35 -0700, Stephen Warren wrote:

> > No.. PCI end devices are required to decode all 32 bits of address,
> > less the bits requires for their allocation. So a device with 64 bytes
> > of IO will match bits 31:6 and then use bits 5:0 for the internal
> > register.
> 
> Didn't Arnd say (earlier this thread) that PCI devices using IO BARs
> were probably fairly legacy and hence might be buggy and might not obey
> that rule? Now, I'd guess it's safe within the first 64k of IO space
> though, so perhaps he was only talking about IO BAR bases >= 64k being
> dubious? That would imply a device might only use bits 15:6 for matching
> the BAR base and 5:0 for the internal register for a 64-byte BAR.

The thing is that the existing PCIe support for earlier Marvell SoC
families already use more than the first 64 KB to map the I/O BARs, and
this hasn't apparently caused any problems. We're talking about PCIe
support, not PCI, so I guess a lot of the very legacy devices are
simply not part of the equation.

Can't we simply agree on having a first implementation that does the
simple thing, like the existing PCIe implementation for earlier Marvell
SoC families, and improve that if it happens to be needed, depending on
user feedback?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
