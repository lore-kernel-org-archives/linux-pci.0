Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34190 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbcCaQTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2016 12:19:32 -0400
Received: by mail-ob0-f173.google.com with SMTP id kf9so101709718obc.1
        for <linux-pci@vger.kernel.org>; Thu, 31 Mar 2016 09:19:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <m3oa9widxk.fsf@t19.piap.pl>
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
	<m3oa9widxk.fsf@t19.piap.pl>
Date: Thu, 31 Mar 2016 09:19:31 -0700
Message-ID: <CAJ+vNU0iKSXrKmA6jzdw5R5K3TnR3qftVn-8Ou5chHdz5aTpTA@mail.gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
From: Tim Harvey <tharvey@gateworks.com>
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Lucas Stach <l.stach@pengutronix.de>,
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

On Wed, Mar 30, 2016 at 1:10 AM, Krzysztof Hałasa <khalasa@piap.pl> wrote:
> Lucas Stach <l.stach@pengutronix.de> writes:
>
>>> TW6869: PCI 0000:04:00.0, IRQ 336, MMIO 0x1100000
>>> TW686x 0000:04:00.0: enabling device (0140 -> 0142)
>>>
>> I don't see whee the device even tries to use MSI IRQs. Even if the
>> infrastructure is enabled it opts to use legacy INTA.
>
> It only tries to use normal IRQ.
>
>> There is no upstream driver for this chip, so I don't know where to look
>> to find out if the driver tries to enable MSI.
>
> It's been posted on linux-media list... I added pci_enable_msi() to this
> driver and it didn't help.
>
>> Is what you are saying that if you enable MSI support in the kernel, it
>> breaks legacy IRQs?
>
> Precisely.
>
> However, MSI doesn't seem to work either. Could be a problem specific to
> this TW6869 card.
>
> Ventana GW5410 has 5 mPCIe slots, and (with MSI enabled in the system)
> those IRQs (non-MSI) don't work in any slot:
>
> 304: 0 0 0 0  PCI-MSI   0 Edge   PCIe PME, aerdrv
> 336: 0 0 0 0      GPC 123 Level  TW8689 in J7 slot
> 337: 0 0 0 0      GPC 122 Level  TW8689 in J8, J10, J11
> 338: 0 0 0 0      GPC 121 Level  TW8689 in J6)
>
> If I enable MSI on this card (adding pci_enable_msi()):
> 313: 0 0 0 0  PCI-MSI   9 Edge   TW6869 in J7 slot
>
> The only way I can get it to work is by disabling MSI (system wide).

Krzysztof,

I have found that MSI does work on IMX6 through a bridge (as on the
GW5410) and not, for devices/drivers that support MSI, but it does
break devices/drivers that use legacy irqs as we've discussed.

The MSI capable devices/drivers I've been able to show working with
MSI enabled are:
 - Marvell sky2 GigE (present on GW53xx and GW54xx both through a PEX switch)
 - Ath10k 802.11n radio miniPCIe socket (tested on GW51xx with no
switch and GW53xx with switch).

So perhaps there is something else going on with the tw8689
device/driver that is causing it to not work with MSI. We have an
avc8000 miniPCIe with tw8689 here and can test if you send me your
patches that enable tw8689 with msi.

Regardless of MSI working in our tests we still disable it because of
it breaking legacy irqs and for performance reasons.

Regards,

Tim
