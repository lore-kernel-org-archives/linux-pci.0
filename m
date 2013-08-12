Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30249 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909Ab3HLRzO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 13:55:14 -0400
Date: Mon, 12 Aug 2013 13:54:51 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv9 00/10] MSI support for Marvell EBU PCIe driver
Message-ID: <20130812175451.GP25111@titan.lakedaemon.net>
References: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130812163723.GK25111@titan.lakedaemon.net>
 <520916E0.5030404@wwwdotorg.org>
 <20130812174439.GO25111@titan.lakedaemon.net>
 <520920C1.5040904@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <520920C1.5040904@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 12, 2013 at 11:52:01AM -0600, Stephen Warren wrote:
> On 08/12/2013 11:44 AM, Jason Cooper wrote:
> > On Mon, Aug 12, 2013 at 11:09:52AM -0600, Stephen Warren wrote:
> >> On 08/12/2013 10:37 AM, Jason Cooper wrote:
> >>> Thomas,
> >>>
> >>> Whole series applied as follows:
> >>>
> >>> +---+ mvebu/msi_pci (1-4,7)
> >>>     |
> >>>     +---+---+ mvebu/msi_irq (5,6)
> >>>             |
> >>>             +---+---+ mvebu/msi_mvebu (8-10)
> >>>
> >>> mvebu/msi_pci built successfully with Randy's config for x86_64.
> >>>
> >>> Thierry, I've tagged mvebu/msi_pci.  Unless it all falls apart in -next,
> >>> those commit-id's won't change from what will be in arm-soc.
> >>
> >> So, the branch still isn't stable, hence I shouldn't use it as a
> >> baseline to apply Thierry's PCIe patches?
> > 
> > It's as stable as I can make it.  I've tested it for all known build
> > regressions (discovered in -next), and I see no reason to change it.
> > Anything needing fixed after today, I'll append the fix to it's HEAD if
> > appropriate.
> 
> OK, if you will only append fixes rather than rebase the branch, then
> it's fine; what you said above implied that the commit IDs still might
> change.

Well, that's being generous. ;-)  What I said was muddy as hell.  Thanks
for making me clear that up.

> So, I'll try pulling this in with Thierry's patches today.

Great!

thx,

Jason.
