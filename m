Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51775 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936370Ab3DHVxq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2013 17:53:46 -0400
Date: Mon, 8 Apr 2013 23:53:41 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm" <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCHv7 08/17] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130408235341.7012b791@skate>
In-Reply-To: <201304082334.13186.arnd@arndb.de>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo7fGPe3wFha36kNMxeRP4gBpBWgfw85aTLey-DSz2ZYew@mail.gmail.com>
	<20130408225741.74fc383c@skate>
	<201304082334.13186.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Mon, 8 Apr 2013 23:34:12 +0200, Arnd Bergmann wrote:

> > No, I'm assuming PCIBIOS_MIN_IO is always 0. So presumarly, this should
> > be something like:
> > 
> >         pcie->realio.end = min(PCIBIOS_MIN_IO +
> >                                 resource_size(&pcie->io),
> >                                 IO_SPACE_LIMIT);
> > 
> 
> Normally PCIBIOS_MIN_IO is 0x1000, since the first 4096 ports are reserved
> for ISA and PCMCIA compatible drivers and should not be assigned to
> PCI devices. So the first port should get ports 0x1000 to 0xffff, later
> ones can used the entire 65536 ports e.g. 0x10000 to 0x1ffff.

Then I guess it should work with the code I'm proposing here, no?

Note: this pcie->realio region is global: it will be shared by all PCIe
interfaces.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
