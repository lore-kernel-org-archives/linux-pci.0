Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, Richard Zhu
 <hongxing.zhu@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Initial imx7d pm support
Date: Mon, 23 Jul 2018 12:37:31 +0000
Message-ID: <e8be199b2d5559001a93abb52ba46c283e4454a9.camel@nxp.com>
References: <cover.1532090446.git.leonard.crestez@nxp.com>
 <e42a6bb8ff0ddd6eaa31fe381875425a3730a73f.1532090446.git.leonard.crestez@nxp.com>
 <1532338685.3163.93.camel@pengutronix.de>
In-Reply-To: <1532338685.3163.93.camel@pengutronix.de>
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

On Mon, 2018-07-23 at 11:38 +0200, Lucas Stach wrote:
> Hi Leonard,
> 
> Am Freitag, den 20.07.2018, 15:47 +0300 schrieb Leonard Crestez:
> > On imx7d the pcie-phy power domain is turned off in suspend and this can
> > make the system hang after resume when attempting any read from PCI.
> > 
> > Fix this by adding minimal suspend/resume code from the nxp internal
> > tree. This will prepare for powering down on suspend and reset the block
> > on resume.
> > 
> > Code is only for imx7d but a very similar sequence can be used for
> > other socs.
> > 
> > +static void imx6_pcie_ltssm_disable(struct device *dev)
> > +{
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > +
> > +	switch (imx6_pcie->variant) {
> > +	case IMX6Q:
> > +	case IMX6SX:
> > +	case IMX6QP:
> > +		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +				   IMX6Q_GPR12_PCIE_CTL_2, 0);
> 
> Has this been tested on i.MX6? LTSSM disable requires a more complex
> sequence on this SoC to avoid hanging the system. See commit
> 3e3e406e3807 "PCI: imx6: Put LTSSM in "Detect" state before disabling
> it".

This patch only enables suspend/resume for imx7d with other SOCs to
follow later. The ltssm_disable function is just symmetric with
ltssm_enable.

The 6Q parts are affected by errata "ERR005723 PCIe: PCIe does not
support L2 power down [i.MX 6Dual/6Quad Only]".

This design error seems to have the same root cause as your problem (no
dedicated reset control) so this works out quite nicely: the solution
is to never power down pci on affected chips.

> > +static int imx6_pcie_resume_noirq(struct device *dev)
> > +{
> > +	int ret = 0;
> > +	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> > +	struct pcie_port *pp = &imx6_pcie->pci->pp;
> > +
> > +	if (imx6_pcie->variant != IMX7D)
> > +		return 0;
> > +
> > +	imx6_pcie_assert_core_reset(imx6_pcie);
> > +	imx6_pcie_init_phy(imx6_pcie);
> > +	imx6_pcie_deassert_core_reset(imx6_pcie);
> > +	dw_pcie_setup_rc(pp);
> > +
> > +	ret = imx6_pcie_establish_link(imx6_pcie);
> > +	if (ret < 0)
> > +		pr_err("pcie link is down after resume.\n");
> 
> dev_err(), please.

The imx6_pcie_establish_link function already seems to link error
information so the message could be dropped. However it's still helpful
to know that those pci link errors are specifically related to resume.

Fabio suggested I propagate the return code but I'm not sure that's
helpful since "link down" is what happens when the slot is empty and
this is clearly not a "error" or "failure". It's not clear if "slot
empty" can be distinguished in some way.

I'll switch to dev_info and drop the error code, is this OK?


One aspect that I skipped is PME_Turn_Off support: The PCI standard
mandates that this is sent before entering L2/L3 and the designware
core supports this but it's not part of this patch.

Is it fine if I post this separately or should it be part of the same
series? The turnoff bit is in IOMUX gpr for imx6 but SRC for imx7 so it
would require additional patches in reset, dts and then pci.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
