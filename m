Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, Richard Zhu
 <hongxing.zhu@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Date: Tue, 24 Jul 2018 12:04:15 +0000
Message-ID: <24ba42f6028a90836c73317af1f9e9be2d27ba03.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
 <1532338685.3163.93.camel@pengutronix.de>
 <e8be199b2d5559001a93abb52ba46c283e4454a9.camel@nxp.com>
 <1532426953.32306.5.camel@pengutronix.de>
In-Reply-To: <1532426953.32306.5.camel@pengutronix.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-07-24 at 12:09 +0200, Lucas Stach wrote:
> Am Montag, den 23.07.2018, 12:37 +0000 schrieb Leonard Crestez:
> > On Mon, 2018-07-23 at 11:38 +0200, Lucas Stach wrote:
> > > Am Freitag, den 20.07.2018, 15:47 +0300 schrieb Leonard Crestez:
> > > > On imx7d the pcie-phy power domain is turned off in suspend and this can
> > > > make the system hang after resume when attempting any read from PCI.
> > > > 
> > > > Fix this by adding minimal suspend/resume code from the nxp internal
> > > > tree. This will prepare for powering down on suspend and reset the block
> > > > on resume.
> > > > 
> > > > Code is only for imx7d but a very similar sequence can be used for
> > > > other socs.
> > > > 
> > > > +static void imx6_pcie_ltssm_disable(struct device *dev)
> > > > +{
> > > > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > > > +
> > > > +	switch (imx6_pcie->variant) {
> > > > +	case IMX6Q:
> > > > +	case IMX6SX:
> > > > +	case IMX6QP:
> > > > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > > +				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> > > 
> > > Has this been tested on i.MX6? LTSSM disable requires a more complex
> > > sequence on this SoC to avoid hanging the system. See commit
> > > 3e3e406e3807 "PCI: imx6: Put LTSSM in "Detect" state before disabling
> > > it".
> > 
> > This patch only enables suspend/resume for imx7d with other SOCs to
> > follow later. The ltssm_disable function is just symmetric with
> > ltssm_enable.
> > 
> > The 6Q parts are affected by errata "ERR005723 PCIe: PCIe does not
> > support L2 power down [i.MX 6Dual/6Quad Only]".
> > 
> > This design error seems to have the same root cause as your problem (no
> > dedicated reset control) so this works out quite nicely: the solution
> > is to never power down pci on affected chips.
> 
> I don't quite like code that looks like it is doing the right thing,
> but then doesn't. Can we at least emit a warning that there might be
> dragons if anyone tries to call this on i.MX6?

But the function will indeed toggle the right bits to initiate ltssm
disabling. If this is not useful or can't be used right then it's the
caller's problem :)

I can add a default: clause to the switch which returns -ENOSYS and let
IMX6Q fall that way, would that be OK? This would also help when adding
new variants.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
