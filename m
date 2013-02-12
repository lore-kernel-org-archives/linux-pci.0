Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:47026 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933729Ab3BLTBX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 14:01:23 -0500
Date: Tue, 12 Feb 2013 20:01:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH 06/32] arm: pci: add a align_resource hook
Message-ID: <20130212200118.531cda2e@skate>
In-Reply-To: <201302121803.12660.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1360686546-24277-7-git-send-email-thomas.petazzoni@free-electrons.com>
	<201302121803.12660.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 12 Feb 2013 18:03:12 +0000, Arnd Bergmann wrote:
> On Tuesday 12 February 2013, Thomas Petazzoni wrote:
> > The PCI specifications says that an I/O region must be aligned on a
> > 4 KB boundary, and a memory region aligned on a 1 MB boundary.
> > 
> > However, the Marvell PCIe interfaces rely on address decoding
> > windows (which allow to associate a range of physical addresses
> > with a given device), and those have special requirements compared
> > to the standard PCI-to-PCI bridge specifications.
> 
> I'm not convince that we should add this complexity yet, until
> everyone agrees on the basic approach taken.

Regardless of whether we choose to have the emulated PCI-to-PCI bridges
or not, we still need this align_resource() hook.

In the solution you propose, where each PCIe interface is represented
as a separate PCIe domain, we still need the kernel to dynamically
assign ranges of address to each memory BAR and I/O BAR of each PCIe
device. And those range of address must comply with the address
decoding windows requirements, otherwise, we don't be able to create
those address decoding windows, and the devices will be unaccessible.

Of course, if you have an alternate solution to do a _dynamic_
assignment of address ranges to the different PCIe devices, I'm
entirely open to suggestions.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
