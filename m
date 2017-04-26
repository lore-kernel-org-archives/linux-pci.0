Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1493207459.2891.41.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: imx_v6_v7_defconfig: enable PCI_MSI
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 26 Apr 2017 13:50:59 +0200
In-Reply-To: <CAJ+vNU2MG66ruQ87TmSrVCtWfHwGc3s=_NG-ysgV2uyJzzskiQ@mail.gmail.com>
References: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
 <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2Fb7gpO0LsoVpPbUX5rSyH3yC4K30JpAf5j7aQkDH9tw@mail.gmail.com>
 <1460708469.22710.4.camel@pengutronix.de>
 <CAJ+vNU1-M3qSODKHMf872kfOsH0g9xFgKNEgKqiJu6A8z-ChxA@mail.gmail.com>
 <CAJ+vNU0+ksyYCpydpmcJOO-w0v4D0axvG84wK7f09iK_1yzo_A@mail.gmail.com>
 <001c01d2ad85$b06af1a0$1140d4e0$@gmail.com>
 <6eb58d54-b6e8-b709-c7f9-fa19d52cd492@synopsys.com>
 <1491394571.2904.44.camel@pengutronix.de>
 <CAJ+vNU2MG66ruQ87TmSrVCtWfHwGc3s=_NG-ysgV2uyJzzskiQ@mail.gmail.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>,
 patchwork-lst@pengutronix.de,
 Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
 Sascha Hauer <kernel@pengutronix.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim,

Am Dienstag, den 11.04.2017, 09:05 -0700 schrieb Tim Harvey:
> On Wed, Apr 5, 2017 at 5:16 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Am Mittwoch, den 05.04.2017, 13:07 +0100 schrieb Joao Pinto:
> > [...]
> >> >>> Lucas,
> >> >>>
> >> >>> I feel a bit dumb here for forgetting about this issue and letting it
> >> >>> drop, but I've just spent a day debugging an issue with the ath9k
> >> >>> wireless driver only to realize it was that the ath9k card and/or
> >> >>> driver doesn't support MSI interrupts and thus no longer work on
> >> >>> mainline kernels that have MSI enabled. To be honest I'm not sure how
> >> >>> many PCIe devices out there can't support MSI because of hardware
> >> >>> limitations vs drivers that simply have not implemented it.
> >> >>>
> >> >>> To make matters worse 3ee803641e76bea76ec730c80dcc64739a9919ff makes
> >> >>> it such that you can't disable MSI on the IMX6.
> >> >>>
> >> >>> Is there some fix you can think of to make the IMX6 PCIe host
> >> >>> controller raise an interrupt for cards/drivers that use legacy irq's?
> >> >>> If not, then we need to allow MSI to be disabled for IMX6 and default
> >> >>> it to disabled for compatibility.
> >> >>>
> >> >>
> >> >> Joao / Jingoo,
> >> >>
> >> >> (Adding linux-pci to the list to pick up maintainers of other DWC PCIe
> >> >> core drivers)
> >> >>
> >> >> Is Luca's statement that 'legacy IRQs and MSIs can't be used together'
> >> >> true in general for the DW PCIe core? If any of the host controllers
> >> >> using this core can't support both legacy and MSI irqs together I
> >> >> still believe we shouldn't enable/require MSI as it breaks any
> >> >> card/driver that only supports legacy interrupts (such as ath9k).
> >> >
> >> > If there are 2 DW PCIe controllers, one controller can be used for legacy
> >> > and another controller can be used for MSI.
> >> >
> >> > But, I am not sure that one DW PCIe controller can support both MSI device
> >> > and legacy interrupt device at the same time.
> >> >
> >> > To Joao Pinto,
> >> > Will you confirm this?
> >> >
> >>
> >> Hi Jingoo,
> >> I confirm that if a RC has MSI enable, it won't support legacy interrupts.
> >
> > Okay, so the only way to solve this in a generic way, that I can see at
> > the moment is to defer MSI enable until the downstream device actually
> > requests an MSI irq.
> >
> > Also we need to disable the MSI capability if any bridge device turns up
> > during the bus topology scan, as we can have devices with conflicting
> > requirements connected to the RC in that case.
> >
> > I'll cook up some patches to implement this.
> >
> 
> Lucas,
> 
> Any thoughts yet? I'll likely want to backport this to stable although
> the restructuring to drivers/pci/dwc and subsequent changes since 4.10
> will likely require a re-written patch.

I have a fix for this, that I'm currently testing on different setups.
I'll probably send it out in a few hours.

Regards,
Lucas


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
