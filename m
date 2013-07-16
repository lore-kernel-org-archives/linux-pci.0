Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49311 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932356Ab3GPNQJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2013 09:16:09 -0400
Date: Tue, 16 Jul 2013 09:15:47 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Message-ID: <20130716131547.GC12062@titan.lakedaemon.net>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
 <20130716104347.045a612a@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130716104347.045a612a@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 16, 2013 at 10:43:47AM +0200, Thomas Petazzoni wrote:
> Dear Stephen Warren,
> 
> On Mon, 15 Jul 2013 09:34:19 -0600, Stephen Warren wrote:
> 
> > > This patch set is intended for merging in 3.12, so the respective
> > > maintainers of the different areas are invited to review/ack the
> > > patches, see below for the details. This set of patches applies on top
> > > of 3.11-rc1.
> > 
> > Thomas, who is going to merge this series?
> 
> I don't know. There are quite a few build dependencies in there:
> 
>  * PATCH 7 build depends on PATCH 1 and PATCH 5, and obviously depends
>    on PATCH 6.
> 
>  * PATCH 2 to 5 really are one thing, they depend on each other.
> 
>  * PATCH 10 build depends on PATCH 5 and PATCH 8.
> 
> A quick diagram of the dependencies, best viewed with a fixed-size font
> mailer.
> 
> kernel/irq/irqdomain    drivers/pci        arch/arm/kernel
>      patch 1           patch 2, 3, 4           patch 8
>         ||                  ||                   ||
>         ||                  \/                   \/
>         ||               drivers/of   ==> drivers/pci/host
>         ||                patch 5           patch 10
>         ||                  ||
>         \\__________________//
>                   ||
>                   \/
>             drivers/irqchip
>               patch 6, 7

Well, that got more complicated.  :(  No cookie for you.

> Patches 9 and 11 are DT patches, so they are not mentioned in this
> diagram.
> 
> Normally tegra would require 1, 2, 3, 4, 5 and 8, so ideally, with
> the respective maintainers ACKs, Jason Cooper could take them in a
> specific topic stable branch that would not be rebased, on top of which
> both the Marvell work and Tegra work could be done.

After my recent discussions with tglx, here's my proposal:

- rmk creates a dedicated topic branch with patch 8

- Bjorn creates a dedicated topic branch based on rmk's with 2, 3, 4, 5,
  and 10

- tglx creates a dedicated topic branch based on Bjorn's with 1, 6, 7

- I take 9 and 11.

For Tegra, tglx can tag patch 1 for merging.  Tegra will 'adopt' patch
10, but that shouldn't hurt anything.

thx,

Jason.
