Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14793 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab3HGPzj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 11:55:39 -0400
Date: Wed, 7 Aug 2013 11:55:18 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
Message-ID: <20130807155518.GD19280@titan.lakedaemon.net>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806200256.GB19280@titan.lakedaemon.net>
 <20130807065954.GA22906@manwe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130807065954.GA22906@manwe>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 07, 2013 at 08:59:56AM +0200, Thierry Reding wrote:
> On Tue, Aug 06, 2013 at 04:02:56PM -0400, Jason Cooper wrote:
> > Thomas,
> > 
> > In order to get some testing in -next, I've *tentatively* applied this
> > series in the following way:
> > 
> > +---+ mvebu/msi_common (1,2,3,10)
> >     |
> >     +---+---+ mvebu/msi_irq (4-9)
> >             |
> >             +---+---+ mvebu/msi_mvebu (11-13)
> > 
> > I had to make one change to patch #9, I protected the last two blocks
> > with #ifdef CONFIG_PCI_MSI to prevent a build failure at that point.
> > 
> > mvebu/msi_common should be appropriate for Thierry to base off, however,
> > I make no guarantees about the stability of the branch until I send a
> > PR for it.  Code-wise, it should be fine, but the commit-ids may change
> > due to adding Tested-by's, etc.
> 
> I noticed that patch 10 has my Reviewed-by, even though my comments
> weren't addressed. They were about stylistic issues but I'd still like
> to see them fixed now rather than having to fix them up later. Also I
> think I gave my Tested-by on those patches somewhere already and I think
> it's unlikely that anybody else will test them, so with the consistency
> style fixes applied I don't see any reason why that branch can't be
> stabilized right away.

Ahh, thanks.  I did miss your tested-by.  We did get one other from
Daniel Price (which sounded like a pretty cool setup, btw), so I'll add
yours before I tag it.

wrt your Reviewed-by, that came with the patch and may be from a
previous revision.  At any rate, I saw your comments about the
whitespace/alignment, and I'll fixup v7 as I pull it in.

thx,

Jason.
