Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:39965 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532Ab3A1WXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Jan 2013 17:23:48 -0500
Date: Mon, 28 Jan 2013 15:23:48 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Message-ID: <20130128222348.GA21628@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de>
 <5106F5CB.8050304@wwwdotorg.org>
 <20130128220904.GA21446@obsidianresearch.com>
 <20130128231829.6b205c3c@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130128231829.6b205c3c@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 11:18:29PM +0100, Thomas Petazzoni wrote:

> > That would simplify the question of PCI IDs - for Marvell's case and
> > the sw root port bridge we can just copy the IDs from the bogus config
> > space of the HW.
> 
> Not sure what you mean in this last paragraph. In this second version,
> I really rely on the emulated PCI-to-PCI bridges for the resource

I'm refering to your earlier question about what PCI IDs to use for
the SW emulated devices. If there is no need for the host bridge then
you only need 1 PCI ID (for the root port bridge) and you can probably
fairly safely re-use the one in the Marvell config space of the HW.

> allocation. I give the Linux PCI core a global range of addresses for
> memory regions and a global range of addresses for I/O regions, and
> then I let Linux do the allocation of ranges on a per bridge basis,
> depending on the devices detected downstream. And at the end, I use
> those allocated ranges to set up the address decoding windows.

Yes, that all seems OK to me.

Jason
