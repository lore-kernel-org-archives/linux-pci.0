Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19227 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab3ETSDe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2013 14:03:34 -0400
Date: Mon, 20 May 2013 14:02:54 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Grant Likely <grant.likely@secretlab.ca>,
	Mike Turquette <mturquette@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv10 5/9] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
Message-ID: <20130520180254.GD31290@titan.lakedaemon.net>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1368719725-21265-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130519204703.GP11137@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130519204703.GP11137@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 19, 2013 at 04:47:03PM -0400, Jason Cooper wrote:
> On Thu, May 16, 2013 at 05:55:20PM +0200, Thomas Petazzoni wrote:
> > The Armada 370 has two gatable clocks for each PCIe interface, and we
> > want both of them to be enabled. We therefore make one of the two
> > clocks a child of the other, as we did for the sataX and sataXlnk
> > clocks on Armada XP.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > ---
> >  drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Patches 5 - 8 applied to mvebu/pcie, with a dep on Sebastian's clock
> rework and mvebu/of_pci.  Thanks for the head's up on the clk conflict.
> My resolution should match yours.  Please let me know if it doesn't.

As stated in the clk thread, I'm going to re-order this so pcie doesn't
depend on the clk series.

thx,

Jason.
