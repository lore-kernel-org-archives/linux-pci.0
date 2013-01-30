Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:50409 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281Ab3A3EVI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 23:21:08 -0500
Date: Tue, 29 Jan 2013 21:21:03 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130130042103.GB5734@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301292015.21478.arnd@arndb.de>
 <20130129213308.7e845064@skate>
 <201301292254.01069.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301292254.01069.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 10:54:00PM +0000, Arnd Bergmann wrote:

> I'm actually fine with either of the two suggestions you mentioned above,
> whichever is easier to implement and/or more closely matches what the
> hardware actually implements is better IMHO.
> 
> The part that I did not like about having emulated PCI-to-PCI bridges
> is that it seems to just work around a (percieved or real) limitation
> in the Linux kernel by adding a piece of infrastructure, rather than
> lifting that limitation by making the kernel deal with what the
> hardware provides. That reminded me of the original mach-vt8500

Well.. in this case there is a standard - PCI-E for what HW vendors
are supposed to do. The kernel core code follows it and works with
compliant hardware.

Marvell HW is not compliant.

So..

Should the kernel core PCI code support this particular non-compliance?
Should the driver work around the non-compliance and present a
compliant interface to the kernel and userspace?

My take is the kernel core PCI code is fine, and I hope
this will be an isolated issue with one family of Marvell IP. So
working around the HW problem in the driver seems best.

If we learn of many more instances like this then, yah, update the
core code and rip out this driver work around...

Jason
