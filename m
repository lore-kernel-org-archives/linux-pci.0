Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Trent Piepho <tpiepho@impinj.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: imx7d: Add node for PCIe PHY
Date: Wed, 1 Aug 2018 17:33:32 +0000
Message-ID: <1533144812.2283.227.camel@impinj.com>
References: <20180718194424.8844-1-tpiepho@impinj.com>
 <20180718194424.8844-2-tpiepho@impinj.com>
 <1533119951.20186.5.camel@pengutronix.de>
In-Reply-To: <1533119951.20186.5.camel@pengutronix.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-08-01 at 12:39 +0200, Lucas Stach wrote:
> 
> > +This is the PHY associated with the IMX7d PCIe controller.  It's
> > used by the
> > +PCI-e controller via the fsl,pcie-phy phandle.
> > +
> > +Required properties:
> > +- compatible:
> > +	- "fsl,imx-pcie-phy"
> 
> This is too generic. Please change it to "fsl,imx7-pcie-phy".

Can anyone from NXP tell us if an external PCIe PHY block is present in
other IMX designs?  I suspect that this is generic, but no design other
than imx7d has had any reason to use this PHY register space yet.

If this is specific to this SoC, then maybe it shoudl be fsl,imx7d-
pcie-phy, since the iMX7s has no pcie.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
