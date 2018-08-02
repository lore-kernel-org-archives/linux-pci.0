Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Trent Piepho <tpiepho@impinj.com>, "l.stach@pengutronix.de"
 <l.stach@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/2] ARM: dts: imx7d: Add node for PCIe PHY
Date: Thu, 2 Aug 2018 00:43:27 +0000
Message-ID: <AM5PR0402MB28501824F60DB56D923758A38C2C0@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <20180718194424.8844-1-tpiepho@impinj.com>
 <20180718194424.8844-2-tpiepho@impinj.com>
 <1533119951.20186.5.camel@pengutronix.de>
 <1533144812.2283.227.camel@impinj.com>
In-Reply-To: <1533144812.2283.227.camel@impinj.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Trent Piepho [mailto:tpiepho@impinj.com]
> Sent: Thursday, August 2, 2018 1:34 AM
> To: l.stach@pengutronix.de; linux-arm-kernel@lists.infradead.org;
> linux-pci@vger.kernel.org
> Cc: Richard Zhu <hongxing.zhu@nxp.com>; shawnguo@kernel.org;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>
> Subject: Re: [PATCH 1/2] ARM: dts: imx7d: Add node for PCIe PHY
> 
> On Wed, 2018-08-01 at 12:39 +0200, Lucas Stach wrote:
> >
> > > +This is the PHY associated with the IMX7d PCIe controller.  It's
> > > used by the
> > > +PCI-e controller via the fsl,pcie-phy phandle.
> > > +
> > > +Required properties:
> > > +- compatible:
> > > +	- "fsl,imx-pcie-phy"
> >
> > This is too generic. Please change it to "fsl,imx7-pcie-phy".
> 
> Can anyone from NXP tell us if an external PCIe PHY block is present in other
> IMX designs?  I suspect that this is generic, but no design other than imx7d
> has had any reason to use this PHY register space yet.
>
Hi Trent:
There is a different PCIe PHY block in imx7d PCIe refer to the imx6.
So, the standalone memory region is used to map the imx7d PCIe PHY registers.
Instead of the standalone PHY node, how about to include the PHY registers memory region into PCIe node?
For example:
               pcie: pcie@0x33800000 {
                        compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
                        reg = <0x33800000 0x4000>, <0x306d0000 0x10000>, <0x4ff00000 0x80000>;
                        reg-names = "dbi", "phy", "config";

Richard Zhu
Best Regards!

 
> If this is specific to this SoC, then maybe it shoudl be fsl,imx7d- pcie-phy, since
> the iMX7s has no pcie.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
