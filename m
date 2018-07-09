Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Leonard Crestez <leonard.crestez@nxp.com>
To: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "andrew.smirnov@gmail.com"
 <andrew.smirnov@gmail.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
Date: Mon, 9 Jul 2018 14:59:33 +0000
Message-ID: <e36fac6f4907288c58a7dfa112541e73de957d46.camel@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
 <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
 <1528468422.26356.20.camel@pengutronix.de>
 <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
 <1530607328.22468.102.camel@pengutronix.de>
In-Reply-To: <1530607328.22468.102.camel@pengutronix.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-07-03 at 10:42 +0200, Lucas Stach wrote:
> Am Montag, den 02.07.2018, 17:18 +0000 schrieb Leonard Crestez:
> > On Fri, 2018-06-08 at 16:33 +0200, Lucas Stach wrote:
> > > Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
> > > > On imx7d the phy is turned off in suspend and must be reset on resume.
> > > > Right now lspci -v fails after a suspend/resume cycle, fix this by
> > > > adding minimal suspend/resume code from the nxp vendor tree.
> > > > 
> > > > This is currently only enabled for imx7 but the same sequence can be
> > > > applied to other imx pcie variants.
> > > > +#ifdef CONFIG_PM_SLEEP
> > 
> > Another issue that should be discussed here is that on 6sx and 7d the
> > gpc PCIE power domain is not defined correctly: the PCIE block is in
> > the DISPMIX domain on both SOCs and it is only PCIE_PHY which has a
> > separate power domain.
> > 
> > This matters: enabling power-gating for displays will break pcie if
> > this relationship is not taken into account. Here are some options:
> > 
> > 1) Make &pd_pcie a child of &pd_disp by hacking into gpc probe
> > functions and calling pm_genpd_add_subdomain. Not very nice.
> > 
> > 2) Support nesting PGCs in GPC code? Lots of code and still an
> > incorrect representation of hardware.
> > 
> > 3) Set power-domains = <&pd_disp> and enable runtime PM on &pd_pcie?
> > 
> > 4) Add separate devices for the pcie-phy. These would be mostly empty
> > but still different, for example on imx6sx the PHY is not even
> > accessible on the bus but only though PCIE registers.
> 
> 5) Take a look at the linux-pm list. ;) The power domain framework has
> just gained support for multiple power domains per device. I think that
>  is the right solution for this, as like you mentioned the PHY isn't
> really a separate block on i.MX6, but part of the PCIe controller
> device.

Yes, I noticed that earlier but not that it was merged recently. It is
a better solution.

Unfortunately the multiple power-domain code seems to require devices
to explicitly fetch references to the power domains and manipulate
them. As far as I can tell this means that every device using multiple
power domains has to be modified to do so. In this particular case it
would be useful to just have all power domains turned on before probe,
just like when a single power-domain is specified:

    power-domains = <&pd_pci>, <&pd_disp>;

But this issue is not strictly related to imx7d pci hanging on
suspend/resume, it can be dealt with later.

--
Regards,
Leonard
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
