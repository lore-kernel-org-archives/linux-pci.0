Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:51327 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbcC3IA4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 04:00:56 -0400
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
To: Tim Harvey <tharvey@gateworks.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <23031613.R8qN30TbTq@wuerfel>
 <CAJ+vNU2BKLDREOWP8EWXZR43to10yw+qvKwv1MzS4a_L9n5ozg@mail.gmail.com>
 <5741237.2X2Q0sCFQj@wuerfel>
 <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
 <56FAA9C1.5060107@tekno-soft.it>
 <CAJ+vNU0bQVd0qyLg+09CUHx4WsrEqwZ4hLVuuvazR8DWpiHE_g@mail.gmail.com>
 <56FAB0DB.3070303@tekno-soft.it>
 <CAJ+vNU3yh8ivb+axTwXawSbtCTa+kHUsJY=EGoziT8WSEW1CHQ@mail.gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56FB87A1.4020505@tekno-soft.it>
Date: Wed, 30 Mar 2016 10:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU3yh8ivb+axTwXawSbtCTa+kHUsJY=EGoziT8WSEW1CHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/29/2016 07:31 PM, Tim Harvey wrote:
> On Tue, Mar 29, 2016 at 9:44 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>>
>>> Roberto,
>>>
>>> What board/platform is this and what does /proc/interrupts look like?
>> It's a custom board
>>
>> root@voneus-janas-imx6q:~# cat /proc/interrupts
>>            CPU0       CPU1       CPU2       CPU3
>>  16:        936        637       2057        938       GIC  29 Edge      twd
>>  17:          0          0          0          0       GPC  55 Level     i.MX Timer Tick
>>  22:        247          0          0          0       GPC  26 Level     2020000.serial
>>  34:          0          0          0          0  gpio-mxc   6 Edge      Factory Reset Button
>> 267:          0          0          0          0       GPC  49 Level     imx_thermal
>> 272:          0          0          0          0       GPC  19 Level     rtc alarm
>> 278:          0          0          0          0       GPC   2 Level     sdma
>> 281:        361          0          0          0       GIC 150 Level     2188000.ethernet
>> 282:          0          0          0          0       GIC 151 Level     2188000.ethernet
>> 283:       2882          0          0          0       GPC  25 Level     mmc0
>> 284:         95          0          0          0       GPC  37 Level     21a4000.i2c
>> 290:      36546          0          0          0       GPC 123 Level     PCIe PME, b4xxp
>> 291:          2          0          0          0       GIC 137 Level     2101000.jr0
>> 292:          0          0          0          0       GIC 138 Level     2102000.jr1
>> IPI0:          0          0          0          0  CPU wakeup interrupts
>> IPI1:          0          0          0          0  Timer broadcast interrupts
>> IPI2:       1642       1038       1626       1781  Rescheduling interrupts
>> IPI3:         95         95        122        119  Function call interrupts
>> IPI4:          3          0          2          0  Single function call interrupts
>> IPI5:          0          0          0          0  CPU stop interrupts
>> IPI6:          0          0          0          0  IRQ work interrupts
>> IPI7:          0          0          0          0  completion interrupts
>> Err:          0
>>
>>
>>> This sounds like what would happen if the downstream interrupts on the
>>> PCIe-to-PCI bridge are not mapped properly as was the case with a
>>> board I support (in which case I had to work out a bootloader fixup
>>> that placed a non-standard interrupt-map in the device-tree for the
>>> bridge). What bridge are you using?
>> PCIe-to-PCI bridge is a Ti XIO2001 where we are using INTA/B only wired 1:1
>>
> Roberto,
>
> That's right, we've talked about your bridge on IMX community.
>
> I don't see anything in your proc/interrupts other than GPC 123 - you
> probably only had one device populated when you did that. 

Yep! That was the case

> Put devices
> in all for slots then show me 'cat /proc/interrupts' as well as 'lspci
> -vv' (so that I can see what interrupt was given to pin1 and what
> interrupt that maps to on the IMX6).

GPC 123 is serving J2 and J1, and looks ok

root@voneus-janas-imx6q:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 16:       7409      25043       2869      71444       GIC  29 Edge      twd
 17:          0          0          0          0       GPC  55 Level     i.MX Timer Tick
 22:        526          0          0          0       GPC  26 Level     2020000.serial
 34:          0          0          0          0  gpio-mxc   6 Edge      Factory Reset Button
267:          0          0          0          0       GPC  49 Level     imx_thermal
272:          0          0          0          0       GPC  19 Level     rtc alarm
278:          0          0          0          0       GPC   2 Level     sdma
281:       8808          0          0          0       GIC 150 Level     2188000.ethernet
282:          0          0          0          0       GIC 151 Level     2188000.ethernet
283:       2529          0          0          0       GPC  25 Level     mmc0
284:         95          0          0          0       GPC  37 Level     21a4000.i2c
290:    2391578          0          0          0       GPC 123 Level     PCIe PME, b4xxp, b4xxp
291:          2          0          0          0       GIC 137 Level     2101000.jr0
292:          0          0          0          0       GIC 138 Level     2102000.jr1
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:       1122       3838       2051       9631  Rescheduling interrupts
IPI3:         60         56         48         54  Function call interrupts
IPI4:          2          1          2          3  Single function call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
IPI6:          0          0          0          0  IRQ work interrupts
IPI7:          0          0          0          0  completion interrupts
Err:          0


root@voneus-janas-imx6q:~# lspci -vv -s 02:
02:00.0 ISDN controller: Cologne Chip Designs GmbH ISDN network Controller [HFC-4S] (rev 01)
        Subsystem: Cologne Chip Designs GmbH HFC-4S [OpenVox B200P / B400P]
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 290
        Region 0: I/O ports at 1000 [size=8]
        Region 1: Memory at 01100000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: wcb4xxp
        Kernel modules: wcb4xxp

02:04.0 ISDN controller: Cologne Chip Designs GmbH ISDN network Controller [HFC-4S] (rev 01)
        Subsystem: Cologne Chip Designs GmbH HFC-4S [OpenVox B200P / B400P]
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 290
        Region 0: I/O ports at 1008 [size=8]
        Region 1: Memory at 01101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: wcb4xxp
        Kernel modules: wcb4xxp


>
> Check your XIO2001 routing and insure the following for proper IRQ mapping:
> Slot12: IDSEL A28: socket INTA = XIO2001 INTA
> Slot13: IDSEL A29: socket INTA = XIO2001 INTB
> Slot14: IDSEL A30: socket INTA = XIO2001 INTC
> Slot15: IDSEL A31: socket INTA = XIO2001 INTD

After crosschecking with our hardware designer the PCB IRQ mapping is the following:

J2 : IDSEL  A16: => Device 0 : socket INTA = XIO2001 INTA
J3 : IDSEL  A18: => Device 2 : socket INTA = XIO2001 INTA* **(This should be INTC)*         
J11: IDSEL A20: => Device 4 : socket INTA = XIO2001 INTA

The interrupt routing for J3 is wrong. The XIO2001 driver may expect Device 2 to interrupt on INTC - but it will
interrupt on INTA.

>
> The relationship between slot number of IDSEL is based on the PCI
> specification. The XIO2001 int mapping to socket mapping is based on
> Table 2 in the XIO2001 implementation guide. In my case what the
> hardware designer flipped the IDSEL mappings above such that slot12's
> idsel was hooked to A31 (so it was really slot15) etc, which created a
> non-standard mapping that required what ended up being a very time
> consuming and difficult to figure out software fixup (to say the
> least).

Yep! I have read it

>
> Tim
>

