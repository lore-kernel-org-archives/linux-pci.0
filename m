Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 4 Jul 2018 17:37:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180704163723.GB13155@red-moon>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
 <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
 <1528468422.26356.20.camel@pengutronix.de>
 <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
 <1530607328.22468.102.camel@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <1530607328.22468.102.camel@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Leonard Crestez <leonard.crestez@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 10:42:08AM +0200, Lucas Stach wrote:
> Am Montag, den 02.07.2018, 17:18 +0000 schrieb Leonard Crestez:
> > On Fri, 2018-06-08 at 16:33 +0200, Lucas Stach wrote:
> > > Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
> > > > On imx7d the phy is turned off in suspend and must be reset on resu=
me.
> > > > Right now lspci -v fails after a suspend/resume cycle, fix this by
> > > > adding minimal suspend/resume code from the nxp vendor tree.
> > > > =

> > > > This is currently only enabled for imx7 but the same sequence can be
> > > > applied to other imx pcie variants.
> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +static int imx6_pcie_suspend_noirq(struct device *dev)
> > > > +{
> > > > > > > +	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
> > > > +
> > > > +	if (imx6_pcie->variant =3D=3D IMX7D) {
> > > =

> > > Instead of this large indented block, please just have an early return
> > > at the start of this function, like:
> > > =

> > > if (imx6_pcie->variant !=3D IMX7D)
> > > 	return 0;
> > > =

> > > Same for the resume function.
> > =

> > OK. The resume sequence is mostly the same for all SOCs where it
> > applies.
> > =

> > > > +static int imx6_pcie_resume_noirq(struct device *dev)
> > > > +{
> > > > > > > +	int ret =3D 0;
> > > > > > > +	struct imx6_pcie *imx6_pcie =3D dev_get_drvdata(dev);
> > > > > > > +	struct pcie_port *pp =3D &imx6_pcie->pci->pp;
> > > > =

> > > > +
> > > > > > > +	if (imx6_pcie->variant =3D=3D IMX7D) {
> > > > +		imx6_pcie_ltssm_disable(dev);
> > > =

> > > The LTSSM disable seems misplaced here. I would have expected it to be
> > > in the suspend function.
> > =

> > This is a requirement for reinitializing the core: LTSSM needs to be
> > turned off during initialization.
> =

> If you disable LTSSM during suspend, it should be off when entering
> this resume function, no?
> =

> > > > +		/*
> > > > > > > +		=A0* controller maybe turn off, re-configure again
> > > > > > > +		=A0*/
> > > > > > > +		dw_pcie_setup_rc(pp);
> > > > +
> > > > > > > +		imx6_pcie_ltssm_enable(dev);
> > > > +
> > > > > > > +		ret =3D imx6_pcie_wait_for_link(imx6_pcie);
> > > > > > > +		if (ret < 0)
> > > > +			pr_info("pcie link is down after resume.\n");
> > > =

> > > If the PHY has been powered down and LTSSM stopped I guess we need to
> > > do the full imx6_pcie_establish_link() dance again here to reliably r=
e-
> > > establish the link. The above seems unsafe.
> > =

> > What imx6_pcie_establish_link does additionally is some workaround for
> > link gen detection. I agree that it should be included.
> > =

> > This would make resume mostly the same as imx_pcie_host_init except for
> > dw_pcie_msi_init; that needs to be saved/restored separately.
> =

> Right, so maybe we can even cut down on lines of code by splitting and
> reusing existing functions.
> =

> > =

> > Another issue that should be discussed here is that on 6sx and 7d the
> > gpc PCIE power domain is not defined correctly: the PCIE block is in
> > the DISPMIX domain on both SOCs and it is only PCIE_PHY which has a
> > separate power domain.
> > =

> > This matters: enabling power-gating for displays will break pcie if
> > this relationship is not taken into account. Here are some options:
> > =

> > 1) Make &pd_pcie a child of &pd_disp by hacking into gpc probe
> > functions and calling pm_genpd_add_subdomain. Not very nice.
> > =

> > 2) Support nesting PGCs in GPC code? Lots of code and still an
> > incorrect representation of hardware.
> > =

> > 3) Set power-domains =3D <&pd_disp> and enable runtime PM on &pd_pcie?
> > =

> > 4) Add separate devices for the pcie-phy. These would be mostly empty
> > but still different, for example on imx6sx the PHY is not even
> > accessible on the bus but only though PCIE registers.
> =

> 5) Take a look at the linux-pm list. ;) The power domain framework has
> just gained support for multiple power domains per device. I think that
>  is the right solution for this, as like you mentioned the PHY isn't
> really a separate block on i.MX6, but part of the PCIe controller
> device.

>From the discussion I take this as there is going to be a v2 so
I will mark this as Changes Requested, please let me know if that's
a problem.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
