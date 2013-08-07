Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60323 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab3HGPvw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 11:51:52 -0400
Date: Wed, 7 Aug 2013 11:51:24 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
Message-ID: <20130807155124.GC19280@titan.lakedaemon.net>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806200256.GB19280@titan.lakedaemon.net>
 <520157B2.8080205@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <520157B2.8080205@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 02:08:18PM -0600, Stephen Warren wrote:
> On 08/06/2013 02:02 PM, Jason Cooper wrote:
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
> When do you intend to send the pull-request? I need a stable branch
> before I can even apply Thierry's changes, and I'd prefer to get those
> changes applied and in linux-next well before I send my pull requests to
> arm-soc. At the very latest, I need enough time to apply Thierry's
> patches on top of your final version of that branch, get it briefly
> tested, and then send a pull-request to arm-soc before -rc6 is out, so
> if your pull request goes in just before -rc6, that's going to be a problem.

I'll tag the head of mvebu/msi_common once it makes it through -next
successfully (I saw a linux-next email go by, but I haven't gotten that
far down my inbox yet)

Hopefully today or tomorrow, depending on where the -next problem is.
I'll send the PR along side that.  Once I tag it, you should be able to
base off of it before it gets into arm-soc, since the commit-id won't
change.

thx,

Jason.
