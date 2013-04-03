Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26377 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757209Ab3DCK6U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 06:58:20 -0400
Date: Wed, 3 Apr 2013 06:57:57 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFC PATCHv1 2/5] bus: mvebu: fix mistake in PCIe window
 target attribute for Kirkwood
Message-ID: <20130403105757.GV13280@titan.lakedaemon.net>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364407504-13524-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130403125247.5914a862@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130403125247.5914a862@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Wed, Apr 03, 2013 at 12:52:47PM +0200, Thomas Petazzoni wrote:
> Jason (Cooper),
> 
> Do you mind taking this patch in your mvebu/drivers branch, next to the
> patch adding the mvebu-mbus driver? Or do you want a new mvebu-mbus
> driver patch that contains this fix and would replace the one you have
> already merged in mvebu/drivers?

Thanks for pointing this out.  I'll put it in mvebu/drivers as you
suggested.  I'll need to rebase mvebu/soc on it.  But I haven't done the
PR yet, so not a big deal.

thx,

Jason.


> On Wed, 27 Mar 2013 19:05:01 +0100, Thomas Petazzoni wrote:
> > The target and attributes for the PCIe address decoding windows were
> > not correct on Kirkwood for the second PCIe interface.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> > Note: this patch should be merged with the existing mvebu-mbus driver.
> > ---
> >  drivers/bus/mvebu-mbus.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
> > index 586d03e..4de2c6b 100644
> > --- a/drivers/bus/mvebu-mbus.c
> > +++ b/drivers/bus/mvebu-mbus.c
> > @@ -626,7 +626,7 @@ static const struct mvebu_mbus_soc_data armada_xp_mbus_data = {
> >  
> >  static const struct mvebu_mbus_mapping kirkwood_map[] = {
> >  	MAPDEF("pcie0.0", 4, 0xe0, MAPDEF_PCIMASK),
> > -	MAPDEF("pcie1.0", 8, 0xe0, MAPDEF_PCIMASK),
> > +	MAPDEF("pcie1.0", 4, 0xd0, MAPDEF_PCIMASK),
> >  	MAPDEF("sram",    3, 0x01, MAPDEF_NOMASK),
> >  	MAPDEF("nand",    1, 0x2f, MAPDEF_NOMASK),
> >  	{},
