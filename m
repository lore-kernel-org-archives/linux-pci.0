Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36977 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbcGUGpj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2016 02:45:39 -0400
Received: by mail-wm0-f49.google.com with SMTP id i5so11712734wmg.0
        for <linux-pci@vger.kernel.org>; Wed, 20 Jul 2016 23:45:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB26249037CC087F05C0BC467B8C080@VI1PR0401MB2624.eurprd04.prod.outlook.com>
References: <CAO1575Vzw5=JMVW4yh6HNz730r-RtONt_+J1A4BhygVowAWLZQ@mail.gmail.com>
 <CAO1575Wo_Qgk-YX7kZchUTEv7o3W5-b_DJQktoF2AR+OwvAxNg@mail.gmail.com>
 <VI1PR0401MB2624BC92B13026C53D4B13198C330@VI1PR0401MB2624.eurprd04.prod.outlook.com>
 <CAO1575VC_cVHMxnWWDHcJhrymchJM1zMmR4X2O38JdrGP4dJfA@mail.gmail.com>
 <VI1PR0401MB26249BF2429EF9FD6DB7F7EF8C330@VI1PR0401MB2624.eurprd04.prod.outlook.com>
 <CAO1575VjjoA3O-8big2NG7v=xCeeLjf1K0Ck7b9AUcZ=H8HL1w@mail.gmail.com>
 <VI1PR0401MB2624E3404F95241302CC4C9F8C360@VI1PR0401MB2624.eurprd04.prod.outlook.com>
 <CAO1575VCk2g0KwH=hEk4bHP1t75Pd09yCNV27r7ZfhLbUhV=eA@mail.gmail.com> <VI1PR0401MB26249037CC087F05C0BC467B8C080@VI1PR0401MB2624.eurprd04.prod.outlook.com>
From: Ivan Grimaldi <grimaldi.ivan@gmail.com>
Date: Thu, 21 Jul 2016 08:45:18 +0200
Message-ID: <CAO1575VPMTEUe+fuaYeaV=U_JW6EP=XPQzKjokNhno8GVFm+9Q@mail.gmail.com>
Subject: Re: PROBLEM: pcie imx6 link problem after a random number of reboot
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: "r65037@freescale.com" <r65037@freescale.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

 yes the hang is after "bridge, pass 1 pci_bus 0000:01: scanning bus";
I haven't a pcie analyzer.

IVan

2016-07-20 10:51 GMT+02:00 Richard Zhu <hongxing.zhu@nxp.com>:
> Hi Ivan:
> Sorry to reply late.
>
>> -----Original Message-----
>> From: Ivan Grimaldi [mailto:grimaldi.ivan@gmail.com]
>> Sent: Monday, July 18, 2016 6:45 PM
>> To: Richard Zhu <hongxing.zhu@nxp.com>
>> Cc: r65037@freescale.com; l.stach@pengutronix.de; linux-pci@vger.kernel.org;
>> bhelgaas@google.com; linux-arm-kernel@lists.infradead.org
>> Subject: Re: PROBLEM: pcie imx6 link problem after a random number of
>> reboot
>>
>> Hi,
>>
>>   i have enabled early printk and after a random number of restart the kernel
>> hangs occurs later in the log (Below kernel log).
>>
>> ...
>> imx6q-pcie 1ffc000.pcie: Link up, Gen=2
>> imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00 pci_bus 0000:00: root
>> bus resource [io  0x1000-0xffff] pci_bus 0000:00: root bus resource [mem
>> 0x01000000-0x01efffff] pci_bus 0000:00: root bus resource [bus 00-ff] pci_bus
>> 0000:00: scanning bus pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 pci
>> 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff] pci 0000:00:00.0: reg
>> 0x38: [mem 0x00000000-0x0000ffff pref] pci 0000:00:00.0: calling
>> pci_fixup_ide_bases+0x0/0x4c pci 0000:00:00.0: supports D1 pci 0000:00:00.0:
>> PME# supported from D0 D1 D3hot D3cold pci 0000:00:00.0: PME# disabled
>> pci_bus 0000:00: fixups for bus
>> PCI: bus0: Fast back to back transfers disabled pci 0000:00:00.0: scanning [bus
>> 01-01] behind bridge, pass 0 pci 0000:00:00.0: scanning [bus 00-00] behind
>> bridge, pass 1 pci_bus 0000:01: scanning bus
>>
>>
> [Zhu hongxing] The pcie link is up refer to the log.
> Is it hang here?
>
> If yes, I suspect that the link is not stable, and the link is down here.
> Can you use one pcie protocol analyzer to figure out what happen on the bus?
>
>>
>> IVan
>>
>>
> <snip...>
>
> Best Regards
> hongxing zhu
> Linux BSP team
> Office: 86-21-28937189
> Email: hongxing.zhu@nxp.com
>
