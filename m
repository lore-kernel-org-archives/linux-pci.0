Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0127.outbound.protection.outlook.com ([207.46.100.127]:37027
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750775AbaJOI2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 04:28:55 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <festevam@gmail.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>,
	Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: imx6q-pcie doc: Update the clocks descriptions to
 use defines
Date: Wed, 15 Oct 2014 08:28:51 +0000
Message-ID: <79d95f1ce195473b983c45519adf3e82@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1412434548-11219-1-git-send-email-festevam@gmail.com>
 <20141015001746.GC15225@google.com>
In-Reply-To: <20141015001746.GC15225@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, October 15, 2014 8:18 AM
> To: Fabio Estevam
> Cc: l.stach@pengutronix.de; Zhu Richard-R65037; linux-pci@vger.kernel.org;
> Estevam Fabio-R49496; Zhu Richard-R65037; Rob Herring; Arnd Bergmann; linux-
> arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] PCI: imx6q-pcie doc: Update the clocks descriptions to
> use defines
> 
> [+cc Rob, Arnd, linux-arm-kernel]
> 
> On Sat, Oct 04, 2014 at 11:55:48AM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Let's make the imx6q-pcie example to actually match the usage on
> > imx6qdl.dtsi by providing the clock names via defines rather than hardcoded
> numbers.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Is this an arm-soc thing?
> 
> If you want me to take it, I'll wait for an ack from the likes of
> Richard/Lucas/Rob/Arnd since I can't review this myself.
> 
Hi Bjorn:
yes, this should be an arm-soc stuff.

Hi Fabio:
The prefix of this patch should be ARM: xxxx, and reviewed/merged by shawn.

Best Regards
Richard Zhu
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index 6fbba53..0b28b52 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -35,6 +35,8 @@ Example:
> >  		                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> >  		                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> >  		                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> > -		clocks = <&clks 144>, <&clks 206>, <&clks 189>;
> > +		clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
> > +			 <&clks IMX6QDL_CLK_LVDS1_GATE>,
> > +			 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> >  		clock-names = "pcie", "pcie_bus", "pcie_phy";
> >  	};
> > --
> > 1.9.1
> >
