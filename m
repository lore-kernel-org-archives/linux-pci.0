Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33363 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab3A2KB0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 05:01:26 -0500
Date: Tue, 29 Jan 2013 11:01:19 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Maen Suleiman <maen@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Message-ID: <20130129110119.07cb9ef3@skate>
In-Reply-To: <20130128225105.GA21935@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<201301282018.17714.arnd@arndb.de>
	<5106F5CB.8050304@wwwdotorg.org>
	<20130128220904.GA21446@obsidianresearch.com>
	<20130128231829.6b205c3c@skate>
	<20130128222348.GA21628@obsidianresearch.com>
	<20130128233048.2ab6a6d2@skate>
	<20130128225105.GA21935@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Mon, 28 Jan 2013 15:51:05 -0700, Jason Gunthorpe wrote:

> > > I'm refering to your earlier question about what PCI IDs to use for
> > > the SW emulated devices. If there is no need for the host bridge then
> > > you only need 1 PCI ID (for the root port bridge) and you can probably
> > > fairly safely re-use the one in the Marvell config space of the HW.
> > 
> > Ah, ok, I see. But isn't a host bridge needed to bind all the
> > PCI-to-PCI bridges under a single bus, in order to get the global
> > resource assignment I was referring to?
> 
> The PCI-E spec requires it, but AFAIK it doesn't actually *do*
> anything on Linux, and Linux doesn't require it.
> 
> I thought Thierry did this experiment and decided it wasn't necessary:

Could you detail what would be visible PCI bus topology if I remove the
emulated PCI host bridge? (And keeping one PCI-to-PCI bridge per PCIe
interface) ?

I'm just trying to understand what it would look like, in terms of
"lspci -t" output, because for now, it's not clear to me how everything
would fit together with the emulated host bridge.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
