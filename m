Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <e36fac6f4907288c58a7dfa112541e73de957d46.camel@nxp.com>
References: <cover.1527621510.git.leonard.crestez@nxp.com>
 <a6176c8bcfbca08ce4e93e304bdcd48c4600f8e2.1527621510.git.leonard.crestez@nxp.com>
 <1528468422.26356.20.camel@pengutronix.de>
 <02207512447db4585a4e879e2a059ba223d57dbe.camel@nxp.com>
 <1530607328.22468.102.camel@pengutronix.de>
 <e36fac6f4907288c58a7dfa112541e73de957d46.camel@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Jul 2018 12:26:12 +0200
Message-ID: <CAPDyKFqdJ72ad4Ljz95TFxuNs_T1npSzBU7VCqFLExpC+2DW6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx: Initial imx7d pm support
To: Leonard Crestez <leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 Anson Huang <anson.huang@nxp.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 9 July 2018 at 16:59, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On Tue, 2018-07-03 at 10:42 +0200, Lucas Stach wrote:
>> Am Montag, den 02.07.2018, 17:18 +0000 schrieb Leonard Crestez:
>> > On Fri, 2018-06-08 at 16:33 +0200, Lucas Stach wrote:
>> > > Am Dienstag, den 29.05.2018, 22:39 +0300 schrieb Leonard Crestez:
>> > > > On imx7d the phy is turned off in suspend and must be reset on resume.
>> > > > Right now lspci -v fails after a suspend/resume cycle, fix this by
>> > > > adding minimal suspend/resume code from the nxp vendor tree.
>> > > >
>> > > > This is currently only enabled for imx7 but the same sequence can be
>> > > > applied to other imx pcie variants.
>> > > > +#ifdef CONFIG_PM_SLEEP
>> >
>> > Another issue that should be discussed here is that on 6sx and 7d the
>> > gpc PCIE power domain is not defined correctly: the PCIE block is in
>> > the DISPMIX domain on both SOCs and it is only PCIE_PHY which has a
>> > separate power domain.
>> >
>> > This matters: enabling power-gating for displays will break pcie if
>> > this relationship is not taken into account. Here are some options:
>> >
>> > 1) Make &pd_pcie a child of &pd_disp by hacking into gpc probe
>> > functions and calling pm_genpd_add_subdomain. Not very nice.
>> >
>> > 2) Support nesting PGCs in GPC code? Lots of code and still an
>> > incorrect representation of hardware.
>> >
>> > 3) Set power-domains = <&pd_disp> and enable runtime PM on &pd_pcie?
>> >
>> > 4) Add separate devices for the pcie-phy. These would be mostly empty
>> > but still different, for example on imx6sx the PHY is not even
>> > accessible on the bus but only though PCIE registers.
>>
>> 5) Take a look at the linux-pm list. ;) The power domain framework has
>> just gained support for multiple power domains per device. I think that
>>  is the right solution for this, as like you mentioned the PHY isn't
>> really a separate block on i.MX6, but part of the PCIe controller
>> device.

Yep, it sounds like the PCIe controller device is partitioned across
multiple PM domains.

>
> Yes, I noticed that earlier but not that it was merged recently. It is
> a better solution.
>
> Unfortunately the multiple power-domain code seems to require devices
> to explicitly fetch references to the power domains and manipulate
> them.

Actually, it's the other way around.

You need only one device to attach the PM domains. However, in genpd,
one device will be created per PM domain and its that device you get
back to operate upon.

Typically the returned device(s) should be linked with the "master"
device, device_link_add().

> As far as I can tell this means that every device using multiple
> power domains has to be modified to do so. In this particular case it
> would be useful to just have all power domains turned on before probe,
> just like when a single power-domain is specified:

I you need them to be powered on, just use the corresponding device
links flags when you create the link during probe.

Something along the lines of this:

device_link_add(dev, genpd_dev0, DL_FLAG_STATELESS |
DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);

>
>     power-domains = <&pd_pci>, <&pd_disp>;
>
> But this issue is not strictly related to imx7d pci hanging on
> suspend/resume, it can be dealt with later.

Maybe not, I don't have the complete picture.

However, you do get the opportunity to use the genpd infrastructure,
which calls the ->power_on|off() callbacks of the PM domain during
suspend/resume. And by using the dev_link_add(), you can make sure
that the PM domain gets powered on/off in the order as the
corresponding supplier device.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
