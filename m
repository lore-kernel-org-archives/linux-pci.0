Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:57495 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758907Ab3BGROX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 12:14:23 -0500
Date: Thu, 7 Feb 2013 18:14:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Andrew Murray <andrew.murray@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130207181418.3753b007@skate>
In-Reply-To: <20130207165347.GA31995@arm.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129132204.GA23886@arm.com>
	<20130207153750.0fef1192@skate>
	<20130207155117.GA19666@arm.com>
	<20130207171904.70270598@skate>
	<20130207174040.3a345770@skate>
	<20130207165347.GA31995@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Andrew Murray,

On Thu, 7 Feb 2013 16:53:47 +0000, Andrew Murray wrote:

> > So in fact the problem is indeed that the subnodes pcie0,0 and pcie1,0
> > are seen as corresponding to the PCI-to-PCI bridges.
> 
> I would suggest changing the interrupt-mask to match any bus number. (Don't
> forget that the secondary bus number of each of your emulated bridges will
> vary depending on how many devices are detected underneath each root port,
> assuming you don't try and partition bus numbers or use domains between ports).

I don't think this would work. Currently, the interrupt-map associates
the interrupts with the PCI-to-PCI bridges, i.e devices 00:01, 00:02,
00:03, 00:04, 00:05, etc.

The real PCIe devices themselves are at 01:00, 02:00, 03:00, 04:00,
05:00. Each of them sit on a different bus, at devfn = 0.

So if I ignore the bus number, how could the PCI code find what is the
matching interrupt?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
