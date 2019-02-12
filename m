Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC86C282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 08:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0632080A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 08:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfBLIzG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:55:06 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38379 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfBLIzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 03:55:06 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gtTqC-0004fM-KI; Tue, 12 Feb 2019 09:54:56 +0100
Message-ID: <1549961694.2546.18.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: limit DBI register length
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Agner <stefan@agner.ch>
Cc:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, tpiepho@impinj.com,
        leonard.crestez@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Feb 2019 09:54:54 +0100
In-Reply-To: <20190211213900.GA247873@google.com>
References: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
         <119211b4f2e9ada55b86041d009656e49c2b5281.1549446867.git.stefan@agner.ch>
         <20190211213900.GA247873@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Am Montag, den 11.02.2019, 15:39 -0600 schrieb Bjorn Helgaas:
> On Wed, Feb 06, 2019 at 10:57:32AM +0100, Stefan Agner wrote:
> > Define the length of the DBI registers. This makes sure that
> > the kernel does not access registers beyond that point, avoiding
> > the following abort on a i.MX 6Quad:
> >   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
> >   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
> >   ...
> >   [  100.056423] PC is at dw_pcie_read+0x50/0x84
> >   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
> >   ...
> 
> I assume this problem happens when using the pci_read_config() path or
> something similar?
> 
> Could this be solved using pci_dev.cfg_size instead of building a new
> dwc-specific mechanism?  There are some quirks that set dev->cfg_size
> to keep from reading past certain points in config space, e.g.,
> quirk_citrine(), quirk_nfp6000().
> 
> I'm not necessarily opposed to doing it in dwc, but maybe there's some
> advantage in reducing the number of ways of doing the same thing.

This actually started out as a quirk changing the cfg size. But the
valid config space size seems to be different between root ports that
share the same (broken) device ID (Synopsys abcd), so I doubt that this
would be easier and/or any cleaner to implement as a quirk.

Regards,
Lucas

> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > Changes in v3:
> > - Rebase on pci/dwc
> > Changes in v4:
> > - Rebase on pci/dwc
> > Changes in v5:
> > - Rebased ontop of pci/dwc
> > - Use DBI length of 0x200
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index c1d434ba3642..1ef7be1232f3 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -55,6 +55,7 @@ enum imx6_pcie_variants {
> >  struct imx6_pcie_drvdata {
> > > >  	enum imx6_pcie_variants variant;
> > > >  	u32 flags;
> > > > +	int dbi_length;
> >  };
> >  
> >  struct imx6_pcie {
> > @@ -1087,6 +1088,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > >  		break;
> > > >  	}
> >  
> > > > +	pci->dbi_length = imx6_pcie->drvdata->dbi_length;
> > +
> > > >  	/* Grab turnoff reset */
> > > >  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > > >  	if (IS_ERR(imx6_pcie->turnoff_reset)) {
> > @@ -1170,6 +1173,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > > >  		.variant = IMX6Q,
> > > >  		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
> > > >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> > > > +		.dbi_length = 0x200,
> > > >  	},
> > > >  	[IMX6SX] = {
> > > >  		.variant = IMX6SX,
> > -- 
> > 2.20.1
> > 
