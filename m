Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33824 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbcCIPkB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2016 10:40:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id p65so10846342wmp.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Mar 2016 07:40:00 -0800 (PST)
Message-ID: <1457537997.17531.3.camel@googlemail.com>
Subject: Re: [PATCH v3 0/2] Add PCIe driver support for imx6sx
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Wed, 09 Mar 2016 16:39:57 +0100
In-Reply-To: <1457338819.1904.4.camel@googlemail.com>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
	 <DBXPR04MB27013C807F30DABB9CB667D8CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
	 <1457338819.1904.4.camel@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2016-03-07 at 09:20 +0100, Christoph Fritz wrote:
> On Thu, 2016-03-03 at 01:48 +0000, Richard Zhu wrote:
> > > -----Original Message-----
> > > From: Christoph Fritz [mailto:chf.fritz@googlemail.com]
> > > Sent: Thursday, February 25, 2016 10:48 PM
> > > To: Richard Zhu; Lucas Stach; Shawn Guo; Fabio Estevam; Bjorn Helgaas; Lee
> > > Jones
> > > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Subject: [PATCH v3 0/2] Add PCIe driver support for imx6sx
> > > 
> > > v3:
> > >  * adapt devicetree bindings documentation fsl,imx6q-pcie.txt
> > > v2:
> > >  * leave out regulator handling from driver, will be done later
> > >    in PM subsystem
> > >  * use BIT() macro for MFD
> > > 
> > > Christoph Fritz (2):
> > >   MFD: imx6sx: Add PCIe register definitions for iomuxc gpr
> > >   PCI: imx6: add initial imx6sx support
> > > 
> > >  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   6 +-
> > >  drivers/pci/host/pci-imx6.c                        | 130 ++++++++++++++-------
> > >  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   5 +
> > >  3 files changed, 101 insertions(+), 40 deletions(-)
> > > 
> > > --
> > > 2.1.4
> > 
> > [Zhu hongxing]  Acked-by: Richard Zhu <Richard.Zhu@freescale.com>
> > Richard
> > Best Regards
> 
> @Bjorn: I suppose the PCI patch need to go through your tree. Would you
> pick up this patch?

*ping*
Do you want me to rebase my patch to your pci/host-imx6 branch?

Thanks
 -- Christoph

