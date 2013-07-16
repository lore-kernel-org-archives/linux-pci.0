Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35842 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab3GPNjR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2013 09:39:17 -0400
Date: Tue, 16 Jul 2013 15:39:11 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130716153911.423cc408@skate>
In-Reply-To: <20130716131547.GC12062@titan.lakedaemon.net>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<51E4167B.4000208@wwwdotorg.org>
	<20130716104347.045a612a@skate>
	<20130716131547.GC12062@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Tue, 16 Jul 2013 09:15:47 -0400, Jason Cooper wrote:

> > A quick diagram of the dependencies, best viewed with a fixed-size font
> > mailer.
> > 
> > kernel/irq/irqdomain    drivers/pci        arch/arm/kernel
> >      patch 1           patch 2, 3, 4           patch 8
> >         ||                  ||                   ||
> >         ||                  \/                   \/
> >         ||               drivers/of   ==> drivers/pci/host
> >         ||                patch 5           patch 10
> >         ||                  ||
> >         \\__________________//
> >                   ||
> >                   \/
> >             drivers/irqchip
> >               patch 6, 7
> 
> Well, that got more complicated.  :(  No cookie for you.

Yeah, sorry about this. I'm not sure how to handle that differently.

> > Patches 9 and 11 are DT patches, so they are not mentioned in this
> > diagram.
> > 
> > Normally tegra would require 1, 2, 3, 4, 5 and 8, so ideally, with
> > the respective maintainers ACKs, Jason Cooper could take them in a
> > specific topic stable branch that would not be rebased, on top of which
> > both the Marvell work and Tegra work could be done.
> 
> After my recent discussions with tglx, here's my proposal:
> 
> - rmk creates a dedicated topic branch with patch 8
> 
> - Bjorn creates a dedicated topic branch based on rmk's with 2, 3, 4, 5,
>   and 10
> 
> - tglx creates a dedicated topic branch based on Bjorn's with 1, 6, 7

I am wondering if this merge strategy isn't too complicated to work
nicely. Would it be easier if one person took all of those patches in a
stable topic branch, with the ACKs from the proper maintainers?

But anyway, as long as things get merged, I don't really mind what
merge strategy is used, so I'll trust on what will be the best option
on this.

Thanks a lot for taking care of this!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
