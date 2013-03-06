Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52580 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756138Ab3CFJuP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 04:50:15 -0500
Date: Wed, 6 Mar 2013 10:50:09 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130306105009.1ed18a87@skate>
In-Reply-To: <201302131037.02464.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201302130929.21326.arnd@arndb.de>
	<20130213104051.07bcffe0@skate>
	<201302131037.02464.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Wed, 13 Feb 2013 10:37:02 +0000, Arnd Bergmann wrote:

> Yes, of course. And the ranges property tells you how to turn the
> first address space into the second address space. So the above
> property defines that the PCI bus I/O space range from 0 to 0x10000
> gets converted into the host MMIO range 0xc0000000 to 0xc0010000 on
> the host, and the PCI bus memory space range from 0 to 0x08000000
> gets converted to the host MMIO range 0xc1000000 to 0xc9000000.
> 
> The output of your of_pci_process_ranges() function is the host MMIO
> range, not the range in the bus address space, so it has to be
> IORESOURCE_MEM.

I am sorry, but I don't get how this can work. My code currently relies
on the DT encoding one I/O resource and one MEM resource to find which
is one to use.

Right now, in the ranges property of my DT, I have:

          0x81000000 0 0          0xc0000000 0 0x00010000   /* downstream I/O */
          0x82000000 0 0          0xc1000000 0 0x08000000>; /* non-prefetchable memory */

And the code parsing this does:

        /* Get the I/O and memory ranges from DT */
        while ((range = of_pci_process_ranges(np, &res, range)) != NULL) {
                if (resource_type(&res) == IORESOURCE_IO) {
                        memcpy(&pcie->io, &res, sizeof(res));
                        memcpy(&pcie->realio, &res, sizeof(res));
                        pcie->io.name = "I/O";
                        pcie->realio.start &= 0xFFFFF;
                        pcie->realio.end   &= 0xFFFFF;
                }
                if (resource_type(&res) == IORESOURCE_MEM) {
                        memcpy(&pcie->mem, &res, sizeof(res));
                        pcie->mem.name = "MEM";
                }
        }

As you can see, it relies on one of the two ranges being for I/O
(address starts with 0x81), and another range being for MEM (address
starts with 0x82).

If I make both ranges start with 0x82, how can my code differentiate
between the range used for I/O and the range used for MEM?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
