Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU1-M3qSODKHMf872kfOsH0g9xFgKNEgKqiJu6A8z-ChxA@mail.gmail.com>
References: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
 <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2Fb7gpO0LsoVpPbUX5rSyH3yC4K30JpAf5j7aQkDH9tw@mail.gmail.com>
 <1460708469.22710.4.camel@pengutronix.de>
 <CAJ+vNU1-M3qSODKHMf872kfOsH0g9xFgKNEgKqiJu6A8z-ChxA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 31 Mar 2017 09:05:08 -0700
Message-ID: <CAJ+vNU0+ksyYCpydpmcJOO-w0v4D0axvG84wK7f09iK_1yzo_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: imx_v6_v7_defconfig: enable PCI_MSI
To: Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 patchwork-lst@pengutronix.de,
 =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 30, 2017 at 4:42 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> On Fri, Apr 15, 2016 at 1:21 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> Am Donnerstag, den 14.04.2016, 08:13 -0700 schrieb Tim Harvey:
>>> On Mon, Nov 30, 2015 at 9:00 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>>> > This has been stable on i.MX6 for a good while now and there is no
>>> > reason to keep it disabled, as it allows to allocate non-shared
>>> > IRQs if several PCIe devices are connected to a single host.
>>> >
>>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>> > ---
>>> >  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>>> >  1 file changed, 1 insertion(+)
>>> >
>>> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
>>> > index 4187f69f6630..e2ce60d00e8a 100644
>>> > --- a/arch/arm/configs/imx_v6_v7_defconfig
>>> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
>>> > @@ -45,6 +45,7 @@ CONFIG_SOC_IMX7D=y
>>> >  CONFIG_SOC_LS1021A=y
>>> >  CONFIG_SOC_VF610=y
>>> >  CONFIG_PCI=y
>>> > +CONFIG_PCI_MSI=y
>>> >  CONFIG_PCI_IMX6=y
>>> >  CONFIG_SMP=y
>>> >  CONFIG_PREEMPT_VOLUNTARY=y
>>> > --
>>> > 2.6.2
>>> >
>>> >
>>> > _______________________________________________
>>> > linux-arm-kernel mailing list
>>> > linux-arm-kernel@lists.infradead.org
>>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>> Lucas,
>>>
>>> Any thoughts on why enabling MSI on IMX6 breaks legacy interrupts?
>>>
>>> Again, many PCI devices/drivers don't support MSI and thus enabling
>>> MSI as this patch does makes this config break many PCI devices on
>>> IMX6.
>>>
>>> I have found that MSI does indeed work on the IMX6 for cards/drivers
>>> that use MSI, but for those that don't the legacy interrupts never
>>> fire regardless of going through a bridge or directly hanging off the
>>> IMX6. I assume you can confirm this on your boards/devices as well?
>>>
>> No, this seems to be an errata in the DW PCIe core. The manual states
>> that legacy IRQs and MSIs can't be used together, but I thought this
>> only applies to the EP part of the core.
>>
>> We can probably fix the simple configuration by not enabling MSI support
>> until someone actually requests to set up an MSI IRQ, so both IRQ types
>> work when only one EP is connected.
>> I don't have any idea yet how to fix setups with a PCIe switch where
>> some connected EPs might like to use MSIs while some others can't use
>> them.
>>
>> Regards,
>> Lucas
>>
>
> Lucas,
>
> I feel a bit dumb here for forgetting about this issue and letting it
> drop, but I've just spent a day debugging an issue with the ath9k
> wireless driver only to realize it was that the ath9k card and/or
> driver doesn't support MSI interrupts and thus no longer work on
> mainline kernels that have MSI enabled. To be honest I'm not sure how
> many PCIe devices out there can't support MSI because of hardware
> limitations vs drivers that simply have not implemented it.
>
> To make matters worse 3ee803641e76bea76ec730c80dcc64739a9919ff makes
> it such that you can't disable MSI on the IMX6.
>
> Is there some fix you can think of to make the IMX6 PCIe host
> controller raise an interrupt for cards/drivers that use legacy irq's?
> If not, then we need to allow MSI to be disabled for IMX6 and default
> it to disabled for compatibility.
>

Joao / Jingoo,

(Adding linux-pci to the list to pick up maintainers of other DWC PCIe
core drivers)

Is Luca's statement that 'legacy IRQs and MSIs can't be used together'
true in general for the DW PCIe core? If any of the host controllers
using this core can't support both legacy and MSI irqs together I
still believe we shouldn't enable/require MSI as it breaks any
card/driver that only supports legacy interrupts (such as ath9k).

Regards,

Tim

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
