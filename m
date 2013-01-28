Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:59361 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab3A1WSf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:18:35 -0500
Date: Mon, 28 Jan 2013 23:18:29 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
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
Message-ID: <20130128231829.6b205c3c@skate>
In-Reply-To: <20130128220904.GA21446@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<201301282018.17714.arnd@arndb.de>
	<5106F5CB.8050304@wwwdotorg.org>
	<20130128220904.GA21446@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Mon, 28 Jan 2013 15:09:04 -0700, Jason Gunthorpe wrote:

> If Linux will discover properly (I strongly suspect it does) without
> the host bridge, then I would say to ditch this...
> 
> The PCI-E standard requires a host bridge device, but if Linux doesn't
> require it then there is no reason to emulate one.
> 
> That would simplify the question of PCI IDs - for Marvell's case and
> the sw root port bridge we can just copy the IDs from the bogus config
> space of the HW.

Not sure what you mean in this last paragraph. In this second version,
I really rely on the emulated PCI-to-PCI bridges for the resource
allocation. I give the Linux PCI core a global range of addresses for
memory regions and a global range of addresses for I/O regions, and
then I let Linux do the allocation of ranges on a per bridge basis,
depending on the devices detected downstream. And at the end, I use
those allocated ranges to set up the address decoding windows.

This all comes from your suggestions during the review of the first
revision of this patch set.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
