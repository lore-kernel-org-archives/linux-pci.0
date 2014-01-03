Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53166 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaACMWk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2014 07:22:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: Issue with the emulated PCI bridge implementation
Date: Fri, 3 Jan 2014 13:22:31 +0100
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, linux-pci@vger.kernel.org,
	"Gregory Cl??ment" <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <20131226160534.36cc4203@skate> <20131226165241.2c50b244@skate> <20140103002656.GA12098@obsidianresearch.com>
In-Reply-To: <20140103002656.GA12098@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201401031322.31433.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 03 January 2014, Jason Gunthorpe wrote:
> On Thu, Dec 26, 2013 at 04:52:41PM +0100, Thomas Petazzoni wrote:
> 
> > Here is an implementation of this idea, tested to work with an e1000e
> > card, with the driver modified to do a few read/write to the I/O
> > region. What do you think about it?
> 
> This seems reasonable, the only down side is that a stray read to an
> unused portion of the Linux IO mapping will lock the machine instead
> of getting a page fault - however I don't see that as a blocker.
> 

I've scratched my head a bit over this patch, and I couldn't find anything
wrong with it in the end, as long as we don't have any other device
in the system that also wants its share of the I/O space (e.g. a
PCMCIA port on the SRAM interface), but then we'd probably need other
changes as well.

However the part that made me wonder is that an e1000e with a PCI bridge
actually /should/not/ need to allocate an I/O space window with a precious
mbus resource, since AFAIK this adapter does not have an I/O space BARs.

Thomas, can you send the 'lspci -v' output of the system with this card
to confirm that the I/O space is actually needed? If not, we should probably
review the core PCI code to see why the bridge code tries to add this window.

	Arnd
