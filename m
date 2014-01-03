Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57944 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbaACTEJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 14:04:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, linux-pci@vger.kernel.org,
	Gregory Cl??ment <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Issue with the emulated PCI bridge implementation
Date: Fri, 03 Jan 2014 20:03:37 +0100
Message-ID: <3770300.2dqxYXsVev@wuerfel>
In-Reply-To: <20140103184424.GC12098@obsidianresearch.com>
References: <20131226160534.36cc4203@skate> <201401031322.31433.arnd@arndb.de> <20140103184424.GC12098@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 03 January 2014 11:44:24 Jason Gunthorpe wrote:
> On Fri, Jan 03, 2014 at 01:22:31PM +0100, Arnd Bergmann wrote:
> 
> > However the part that made me wonder is that an e1000e with a PCI bridge
> > actually /should/not/ need to allocate an I/O space window with a precious
> > mbus resource, since AFAIK this adapter does not have an I/O space BARs.
> 
> IIRC the e1000 still has a legacy IO port BAR.. (guessing it is used
> for PXE boot on x86?)

Ok, that would certainly explain it. I actually found a reference to the
I/O BAR in the e1000 driver now.

> My patch set to allow the DT to turn off IO port allocation is already
> in mainline - drop the IO ranges from the DT and no IO resources are
> consumed at all.

Ah, nice! I haven't followed that, but it sounds like a very good
solution.

> Though, that is an interesting point, a small refinement would be to
> not allocate the pci io map if IO is turned off as well..

Do you mean not call pci_ioremap_io() and pci_add_resource_offset(), or
something else? Either way, it sounds like the correct thing to do.
I wonder if the PCI core has any problems when there is no IO resource,
but it's probably fine.

	Arnd
