Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57263 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3A2WyL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 17:54:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Date: Tue, 29 Jan 2013 22:54:00 +0000
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
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <201301292015.21478.arnd@arndb.de> <20130129213308.7e845064@skate>
In-Reply-To: <20130129213308.7e845064@skate>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201301292254.01069.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 January 2013, Thomas Petazzoni wrote:
> Does this still allows me to give the Linux PCI one global range of
> addresses for I/O space, and one global range of addresses for memory
> space, and the the Linux PCI core assign ranges, within those global
> ranges, to each host bridge?
> 
> This is absolutely essential for me, as I then read those allocated
> ranges to configure the address decoding windows.
> 
> Basically, I have currently two suggestions:
> 
>  * From Jason Gunthorpe, to not use any host bridge, and instead use
>    only PCI-to-PCI bridges, one per PCIe interface.
> 
>  * From you, to not use any PCI-to-PCI bridge, and use only host
>    bridges, one per PCIe interface.
> 
> Would it be possible to get some consensus on this? In the review of
> RFCv1, I was already told to use one global host bridge, and then one
> PCI-to-PCI bridge per PCIe interface, and now we're talking about doing
> something different. I'd like to avoid having to try gazillions of
> different possible implementations :-)

I'm actually fine with either of the two suggestions you mentioned above,
whichever is easier to implement and/or more closely matches what the
hardware actually implements is better IMHO.

The part that I did not like about having emulated PCI-to-PCI bridges
is that it seems to just work around a (percieved or real) limitation
in the Linux kernel by adding a piece of infrastructure, rather than
lifting that limitation by making the kernel deal with what the
hardware provides. That reminded me of the original mach-vt8500
PCI implementation that faked a complete PCI host bridge and a
bunch of PCI devices on it, in order to use the via-velocity
ethernet controller, instead of adding a simple 'platform_driver'
struct to that driver.

	Arnd
