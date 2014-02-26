Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37225 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbaBZQ5i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 11:57:38 -0500
Message-ID: <1393433825.4692.2.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6: adjust the interrupt list in
 order to support MSI
From: Lucas Stach <l.stach@pengutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Richard Zhu <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Wed, 26 Feb 2014 17:57:05 +0100
In-Reply-To: <20140226163402.GF29659@e106331-lin.cambridge.arm.com>
References: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
	 <20140226163402.GF29659@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 26.02.2014, 16:34 +0000 schrieb Mark Rutland:
> On Wed, Feb 26, 2014 at 10:27:17AM +0000, Lucas Stach wrote:
> > From: Juergen Beisert <jbe@pengutronix.de>
> > 
> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index fb28b2ecb1db..aeccbb114fc5 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -126,7 +126,8 @@
> >  				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
> >  				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
> >  			num-lanes = <1>;
> > -			interrupts = <0 123 0x04>;
> > +			/*               inta          intb         intc         intd/msi */
> > +			interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;
> 
> This seems to be a "fsl,imx6q-pcie", "snps,dw-pcie" device.
> 
> In Documentation/devicetree/bindings/pci/designware-pcie.txt I only see 3
> interrupts listed.
> 
> The fourth interrupt must be documented.
> 
> Do the first three correspond to those in the documentation?
> 
Urgh, seems Samsung and FSL do all the glue a lot different. The IRQs
seem to be different and the same holds true for the clocks.

I think we should split the Documentation here to avoid further
confusion. Will send a patch.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

