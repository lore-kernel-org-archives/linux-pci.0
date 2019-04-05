Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1533C10F00
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 08:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2271206C0
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 08:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfDEIjD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:39:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51775 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbfDEIjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Apr 2019 04:39:03 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hCKNH-0005rD-0u; Fri, 05 Apr 2019 10:38:59 +0200
Message-ID: <1554453537.2748.10.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Allow async probe
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Date:   Fri, 05 Apr 2019 10:38:57 +0200
In-Reply-To: <CAOMZO5Cycm23RFM=GBME_gGXT=F_oaT-XB2P1eCz8M9T+-DEjA@mail.gmail.com>
References: <20190404164517.17735-1-l.stach@pengutronix.de>
         <CAOMZO5Cycm23RFM=GBME_gGXT=F_oaT-XB2P1eCz8M9T+-DEjA@mail.gmail.com>
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

Hi Fabio,

Am Donnerstag, den 04.04.2019, 14:32 -0300 schrieb Fabio Estevam:
> Hi Lucas,
> 
> > On Thu, Apr 4, 2019 at 1:46 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Establishing a PCIe link can take a while. Allow async probing so all
> > this happens in the background while other devices are being probed.
> > 
> > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 3d627f94a166..2eb39d5de4f6 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1279,6 +1279,7 @@ static struct platform_driver imx6_pcie_driver = {
> >                 .of_match_table = imx6_pcie_of_match,
> >                 .suppress_bind_attrs = true,
> >                 .pm = &imx6_pcie_pm_ops,
> > +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> 
> This does not seem to be imx6 specific.
> 
> Should this be moved to
> drivers/pci/controller/dwc/pcie-designware-plat.c instead?

This property needs to be set in the SoC specific driver that gets
probed, we don't use pcie-designware-plat.c t all. While it isn't
really i.MX specific, I won't go around and set it for platforms I
can't test, as the async behavior may have some unexpected consequences
on other platforms.

Regards,
Lucas
