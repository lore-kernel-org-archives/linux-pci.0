Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34263 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbcC2Nca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 09:32:30 -0400
Received: by mail-oi0-f42.google.com with SMTP id o62so21524652oig.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Mar 2016 06:32:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459248921.2565.15.camel@pengutronix.de>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
	<CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
	<CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
	<CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
	<CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
	<CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
	<CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
	<CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
	<1459241739.2565.9.camel@pengutronix.de>
	<m3shz9in52.fsf@t19.piap.pl>
	<1459248921.2565.15.camel@pengutronix.de>
Date: Tue, 29 Mar 2016 06:32:29 -0700
Message-ID: <CAJ+vNU3o98T2cev1Pj0VJR884kOxVxhrzmowDixGuV2Tb=Sh1Q@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Tim Harvey <tharvey@gateworks.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
	Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 29, 2016 at 3:55 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 29.03.2016, 12:39 +0200 schrieb Krzysztof Hałasa:
>> Lucas Stach <l.stach@pengutronix.de> writes:
>>
>> > Is this working with v4.4 and PCI_MSI enabled? I'm sure I've tested MSI
>> > IRQs before enabling them in the defconfig and they have been working
>> > for me for a long time before that. Tested with i210 on Gateworks
>> > Ventana.
>>
>> MSI never worked for me on Ventana. I have been using 4.2 extensively,
>> and now I'm switching to 4.5 (which doesn't work either).
>>
>> Could it be a DTS (bridge) problem(?)

Lucas,

It's not the bridge - its the fact that not all drivers support MSI interrupts.

One of the most common uses of PCI on Ventana is 802.11n radios and of
them the ath9k driver is very commonly used and does not request an
MSI interrupt (drivers/net/wireless/ath/ath9k/pci.c)

>>
>> On 4.5, trying to use it with TW6869 frame buffer and GW5410:
>>
>> TW6869: PCI 0000:04:00.0, IRQ 336, MMIO 0x1100000
>> TW686x 0000:04:00.0: enabling device (0140 -> 0142)
>>
> I don't see whee the device even tries to use MSI IRQs. Even if the
> infrastructure is enabled it opts to use legacy INTA.

yes, that's what many drivers do.

>
> There is no upstream driver for this chip, so I don't know where to look
> to find out if the driver tries to enable MSI.
>
> Is what you are saying that if you enable MSI support in the kernel, it
> breaks legacy IRQs?

Yes - any driver that does not support MSI will use legacy IRQ's and
they never fire.

The Ventana GW53xx and GW54xx boards have a Marvell PCIe GigE
supported by the sky2 driver as eth1 which does support MSI and I
verified it gets an MSI interrupt and does work (along ath9k devices
with legacy interrupts that fail to work).

root@ventana:~# cat /proc/interrupts | grep MSI
299:          0          0   PCI-MSI   0 Edge      PCIe PME, aerdrv
308:       8726          0   PCI-MSI   9 Edge      eth1

So it appears that MSI works for those drivers that use it, but does
somehow cause legacy IRQ's to break.

I sent you a GW5400 dev kit over a while back to use for through
bridge testing on IMX6 that you should be able to repeat this with
assuming you have a PCIe card with a driver that doesn't support MSI
(or that you can tweak its driver to not support MSI).

I think 31e98e0d24cd2537a63e06e235e050a06b175df7 "ARM:
imx_v6_v7_defconfig: enable PCI_MSI" should be reverted as well until
we figure this out.

Tim
