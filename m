Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:40193 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166Ab3A1TvJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Jan 2013 14:51:09 -0500
Date: Mon, 28 Jan 2013 12:51:11 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 18/27] arm: plat-orion: add more flexible PCI
 configuration space read/write functions
Message-ID: <20130128195111.GC17722@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-19-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359399397-29729-19-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 07:56:27PM +0100, Thomas Petazzoni wrote:

> However, with the usage of the emulated PCI host bridge and emulated
> PCI-to-PCI bridges, this is not the case: bus number 0 is the emulated
> bus on which the emulated PCI-to-PCI bridges sit, so from the Linux
> point of view, the real busses start at bus 1, but from a hardware
> point of view, they start at bus 0.

Hum.. This is a bit funny sounding, can you confirm..

The bus number programmed into all the end points must match the Linux
number. Ie the PCI-E Link Description register of end point devices
must report the same bus number as Linux. PCI-E devices learn their
bus number by capturing the bus number from type 0 configuration
transactions.

For the most part config transactions issued to the PCI-E controllers
should be type 0 transactions with a bus number that matches what
Linux is setting.

The only time I think you'd ever see bus number 0 is when accessing
the config space of the Marvell PCI-E controller end port. But, I also
think you can avoid doing these transactions by just accessing the MMIO
versions of those registers..

Jason
