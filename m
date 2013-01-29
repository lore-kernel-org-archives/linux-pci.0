Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62137 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3A2UQV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 15:16:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Date: Tue, 29 Jan 2013 20:15:21 +0000
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
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201301291645.08040.arnd@arndb.de> <20130129180936.3737e550@skate>
In-Reply-To: <20130129180936.3737e550@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301292015.21478.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 January 2013, Thomas Petazzoni wrote:
> Yes, it is about the emulated PCI-to-PCI bridges. Each
> emulated PCI-to-PCI bridge corresponds to one hardware PCIe interface,
> and I need the I/O base address assigned to each PCIe interface to be
> aligned on a 64 KB boundary. I am not sure to understand why you think
> this is a problem.
> 
> Also, what do you mean exactly by making them appear as individual
> domains?

I mean you could make each root port look like a separate host
bridge that is not related to the others, and not have any
emulated PCI-to-PCI bridges at all.

> Remember that the very reason to use emulated PCI-to-PCI bridges is
> that we want to assign a global range of addresses of I/O regions and a
> global range of addresses of memory regions, and let the Linux PCI core
> allocate from those two ranges to the different devices connected
> downstream of the PCI-to-PCI bridges. This gives us for free the rather
> complex allocation of addresses we need to set up our address decoding
> windows.
> 
> If we have have separate domains for each of our hardware PCIe
> interface, can we still benefit from this allocation of resources from
> a globally defined range of I/O addresses and memory addresses?

My interpretation of what you told me in the previous mail is that
each root port has 

* A separate configuration space
* A separate 64KB I/O window that is not shared with the other ports,
  or potentially multiple 64KB windows, which we would not want to use
* A configurable range of the memory space that does not overlap
  with the other ports

Is the above a correct description?

If so, I think it would be most sensible to not try to put all ports
into the same domain, but give each port the full view of its own
256 buses, and 64KB I/O space. The memory space can still be directly
mapped, if you only set up the physical address window for that after
the bus scan is complete.

	Arnd
