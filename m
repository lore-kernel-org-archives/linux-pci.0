Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55428 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753702AbcCIPyA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2016 10:54:00 -0500
Message-ID: <1457538833.3207.27.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] Add PCIe driver support for imx6sx
From: Lucas Stach <l.stach@pengutronix.de>
To: chf.fritz@googlemail.com
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Wed, 09 Mar 2016 16:53:53 +0100
In-Reply-To: <1457537997.17531.3.camel@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
	 <DBXPR04MB27013C807F30DABB9CB667D8CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	 <1457338819.1904.4.camel@googlemail.com>
	 <1457537997.17531.3.camel@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 09.03.2016, 16:39 +0100 schrieb Christoph Fritz:
> On Mon, 2016-03-07 at 09:20 +0100, Christoph Fritz wrote:
> > On Thu, 2016-03-03 at 01:48 +0000, Richard Zhu wrote:
> > > > -----Original Message-----
> > > > From: Christoph Fritz [mailto:chf.fritz@googlemail.com]
> > > > Sent: Thursday, February 25, 2016 10:48 PM
> > > > To: Richard Zhu; Lucas Stach; Shawn Guo; Fabio Estevam; Bjorn Helgaas; Lee
> > > > Jones
> > > > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > > Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
> > > > 
> > > > v3:
> > > >  * adapt devicetree bindings documentation fsl,imx6q-pcie.txt
> > > > v2:
> > > >  * leave out regulator handling from driver, will be done later
> > > >    in PM subsystem
> > > >  * use BIT() macro for MFD
> > > > 
> > > > Christoph Fritz (2):
> > > >   MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
> > > >   PCI: imx6: add initial imx6sx support
> > > > 
> > > >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
> > > >  drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
> > > >  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   5 +
> > > >  3 files changed, 101 insertions(+), 40 deletions(-)
> > > > 
> > > > --
> > > > 2.1.4
> > > 
> > > [Zhu hongxing]  Acked-by: Richard Zhu <Richard.Zhu@freescale.com>
> > > Richard
> > > Best Regards
> > 
> > @Bjorn: I suppose the PCI patch need to go through your tree. Would you
> > pick up this patch?
> 
> *ping*
> Do you want me to rebase my patch to your pci/host-imx6 branch?
> 
I was unsure if we are going to break DT stability at a later point if
we pull this series in without the GPC changes. But after thinking a bit
more about this it should be fine.

So series is:
Acked-by: Lucas Stach <l.stach@pengutronix.de>


