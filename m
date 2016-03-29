Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33616 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbcC2O3f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 10:29:35 -0400
Received: by mail-ob0-f172.google.com with SMTP id x3so13135543obt.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2016 07:29:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23031613.R8qN30TbTq@wuerfel>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<1459248921.2565.15.camel@pengutronix.de>
	<CAJ+vNU3o98T2cev1Pj0VJR884kOxVxhrzmowDixGuV2Tb=Sh1Q@mail.gmail.com>
	<23031613.R8qN30TbTq@wuerfel>
Date: Tue, 29 Mar 2016 07:29:34 -0700
Message-ID: <CAJ+vNU2BKLDREOWP8EWXZR43to10yw+qvKwv1MzS4a_L9n5ozg@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Tim Harvey <tharvey@gateworks.com>
To: Arnd Bergmann <arnd@arndb.de>, Lucas Stach <l.stach@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 29, 2016 at 6:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 March 2016 06:32:29 Tim Harvey wrote:
>> >
>> > There is no upstream driver for this chip, so I don't know where to look
>> > to find out if the driver tries to enable MSI.
>> >
>> > Is what you are saying that if you enable MSI support in the kernel, it
>> > breaks legacy IRQs?
>>
>> Yes - any driver that does not support MSI will use legacy IRQ's and
>> they never fire.
>>
>> The Ventana GW53xx and GW54xx boards have a Marvell PCIe GigE
>> supported by the sky2 driver as eth1 which does support MSI and I
>> verified it gets an MSI interrupt and does work (along ath9k devices
>> with legacy interrupts that fail to work).
>>
>> root@ventana:~# cat /proc/interrupts | grep MSI
>> 299:          0          0   PCI-MSI   0 Edge      PCIe PME, aerdrv
>> 308:       8726          0   PCI-MSI   9 Edge      eth1
>>
>> So it appears that MSI works for those drivers that use it, but does
>> somehow cause legacy IRQ's to break.
>>
>> I sent you a GW5400 dev kit over a while back to use for through
>> bridge testing on IMX6 that you should be able to repeat this with
>> assuming you have a PCIe card with a driver that doesn't support MSI
>> (or that you can tweak its driver to not support MSI).
>>
>> I think 31e98e0d24cd2537a63e06e235e050a06b175df7 "ARM:
>> imx_v6_v7_defconfig: enable PCI_MSI" should be reverted as well until
>> we figure this out.
>
> That doesn't sound like a helpful solution, multi_v7_defconfig for
> instance will still be broken because it enables PCI_MSI, and so
> will be all major distros.

Arnd,

True, but keep in mind that as far as I can tell this behavior has
been around since MSI was added to the IMX6 (breakage of devices that
use legacy irq's if MSI is enabled) which was in 3.16.

>
> What happens if we patch the pci-imx6 driver to not make use of
> its MSI support even when that is enabled in the kernel? Does that
> get both devices in your GW5xxx to work with legacy interrupts or
> is one or both of them still broken?
>
>         Arnd
>
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index eb5a2755a164..d7607b2695c6 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -470,7 +470,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>
>         imx6_pcie_establish_link(pp);
>
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> +       if (0 && IS_ENABLED(CONFIG_PCI_MSI))
>                 dw_pcie_msi_init(pp);
>  }
>
> @@ -490,7 +490,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  {
>         int ret;
>
> -       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +       if (0 && IS_ENABLED(CONFIG_PCI_MSI)) {
>                 pp->msi_irq = platform_get_irq_byname(pdev, "msi");
>                 if (pp->msi_irq <= 0) {
>                         dev_err(&pdev->dev, "failed to get MSI irq\n");
>

That is not enough - we would also need to disable a couple more in
the designware core that imx6 uses, which is also used by several
other SoC's. We should probably get some feedback from people with
those SoC's regarding MSI breaking legacy irqs.

PCI_MSI was enabled in imx_v6_v7_defconfig in 4.5 and enabled in
multi_v7_defconfig back in 3.16. PCI MSI was first introduced for the
IMX6 host controller in 3.16 as well. I verified that the same issue
exists all the way back to 3.16.

I don't know if its worse to disable PCI MSI for IMX6/designware all
the way back to 3.16 or to disable it just back to 4.5 where imx_v6_v7
enabled it, or perhaps just figure out the actual issue and get that
backported?

Lucas, have you had any thoughts or time yet to think about why
enabling MSI breaks legacy IRQs?

Tim
