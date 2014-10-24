Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46407 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbaJXMpn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Oct 2014 08:45:43 -0400
Message-ID: <1414154737.6267.8.camel@pengutronix.de>
Subject: Re: [PATCH V2] PCI: imx6: Wait the clocks to stabilize after ref_en
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Richard Zhu <richard.zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Tim Harvey <tharvey@gateworks.com>, m-karicheri2@ti.com,
	Richard Zhu <r65037@freescale.com>,
	Eric Nelson <eric.nelson@boundarydevices.com>
Date: Fri, 24 Oct 2014 14:45:37 +0200
In-Reply-To: <CAOMZO5CE=gDUTHQW7h1nDv_H+1iakPAatZ8Pzr=dqHxFZChTeA@mail.gmail.com>
References: <1414118200-2018-1-git-send-email-richard.zhu@freescale.com>
	 <1414118200-2018-2-git-send-email-richard.zhu@freescale.com>
	 <CAOMZO5CE=gDUTHQW7h1nDv_H+1iakPAatZ8Pzr=dqHxFZChTeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 24.10.2014, 09:57 -0200 schrieb Fabio Estevam:
> Hi Richard,
> 
> On Fri, Oct 24, 2014 at 12:36 AM, Richard Zhu <richard.zhu@freescale.com> wrote:
> > From: Richard Zhu <r65037@freescale.com>
> >
> > For boards without a reset GPIO we skip the delay between enabling the
> > pcie_ref_clk and touching the RC registers for configuration.
> > This hangs the system if there isn't a proper delay to ensure the clocks
> > are settled in the DW PCIe core.
> >
> > Also iMX6Q always needs an additional 10us delay to make sure the reset
> > is propagated through the core, as we don't have an explicitly
> > controlled reset input on this SoC.
> >
> > Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
> > Tested-by: Tim Harvey <tharvey@gateworks.com>
> > Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Please always add Bjorn on Cc.
> 
> > ---
> >  drivers/pci/host/pci-imx6.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index 233fe8a..eac96fb 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -275,15 +275,22 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
> >                 goto err_pcie;
> >         }
> >
> > -       /* allow the clocks to stabilize */
> > -       usleep_range(200, 500);
> > -
> >         /* power up core phy and enable ref clock */
> >         regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> >                         IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> > +       /*
> > +        * the async reset input need ref clock to sync internally,
> > +        * when the ref clock comes after reset, internal synced
> > +        * reset time is too short , cannot meet the requirement.
> > +        * add one ~10us delay here.
> > +        */
> > +       udelay(10);
> 
> The patch that myself and Tim has given a Tested-by tag did not
> contain this udelay:
> http://www.spinics.net/lists/linux-pci/msg34748.html
> 
> In your original patch it only moved the the usleep range and that's
> the version that Tim has run intensive boot tests over temperature, so
> I would prefer that you re-send a patch like the original one.

Given that the moving of the usleep didn't cause any ill effects I'm
pretty confident that the additional 10us will not break thing.

As this short sleep is certainly needed on some platforms it will get
added eventually anyways, so I'm fine with having it in this patch.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

