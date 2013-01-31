Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:46001 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab3AaOat (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 09:30:49 -0500
Date: Thu, 31 Jan 2013 15:30:41 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130131153041.35fa3b60@skate>
In-Reply-To: <20130130154602.GL23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130130113245.GH23505@n2100.arm.linux.org.uk>
	<20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
	<20130130150856.GJ23505@n2100.arm.linux.org.uk>
	<20130130151934.GK23505@n2100.arm.linux.org.uk>
	<20130130163659.75360dba@skate>
	<20130130154602.GL23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Russell King - ARM Linux,

On Wed, 30 Jan 2013 15:46:02 +0000, Russell King - ARM Linux wrote:

> +resource_size_t pcibios_window_alignment(struct pci_bus *bus,
> +					 unsigned long type)
> +{
> +	struct pci_sys_data *sys = bus->sysdata;
> +
> +	/* Ignore downstream buses */
> +	if (!bus->parent) {
> +		if (type & IORESOURCE_MEM)
> +			return sys->win_align_mem;
> +		if (type & IORESOURCE_IO)
> +			return sys->win_align_io;
> +	}
> +	return 1;
> +}
> +

Unfortunately, this doesn't work as is for me: the if (!bus->parent)
prevents the thing from being effective. Here my lspci output:

# /usr/sbin/lspci 
00:00.0 Host bridge: Marvell Technology Group Ltd. Device 102d
00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:04.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:05.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
00:06.0 PCI bridge: Marvell Technology Group Ltd. Device 1092
03:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)
05:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit Ethernet Controller (Copper) (rev 06)

And the function pcibios_window_alignment() only gets called for bus 1,
2, 3, 4, 5, 6 and never for bus 0. And therefore, the !bus->parent test
is always false. So, if I keep your implementation, I have the following
addresses assigned to my bridges:

pci 0000:00:03.0: PCI bridge to [bus 03]
pci 0000:00:03.0:   bridge window [io  0xc0000000-0xc0000fff]
pci 0000:00:03.0:   bridge window [mem 0xc1000000-0xc10fffff]
pci 0000:00:03.0:   bridge window [mem 0xc1100000-0xc11fffff pref]
pci 0000:00:05.0: PCI bridge to [bus 05]
pci 0000:00:05.0:   bridge window [io  0xc0001000-0xc0001fff]
pci 0000:00:05.0:   bridge window [mem 0xc1200000-0xc12fffff]
pci 0000:00:05.0:   bridge window [mem 0xc1300000-0xc13fffff pref]

Notice how the io window of the second bridge starts 4K after the io
window of the first bridge. Which cannot work on Marvell SoC, due to
the 64KB alignment.

If, however, I remove the !bus->parent test, the I/O addresses
correctly take into account the 64K requirement:

pci 0000:00:03.0: PCI bridge to [bus 03]
pci 0000:00:03.0:   bridge window [io  0xc0000000-0xc000ffff]
pci 0000:00:03.0:   bridge window [mem 0xc1000000-0xc10fffff]
pci 0000:00:03.0:   bridge window [mem 0xc1100000-0xc11fffff pref]
pci 0000:00:05.0: PCI bridge to [bus 05]
pci 0000:00:05.0:   bridge window [io  0xc0010000-0xc001ffff]
pci 0000:00:05.0:   bridge window [mem 0xc1200000-0xc12fffff]
pci 0000:00:05.0:   bridge window [mem 0xc1300000-0xc13fffff pref]

Any idea?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
