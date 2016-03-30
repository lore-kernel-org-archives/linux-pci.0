Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:56516 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbcC3PVA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 11:21:00 -0400
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
To: Tim Harvey <tharvey@gateworks.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAJ+vNU3yh8ivb+axTwXawSbtCTa+kHUsJY=EGoziT8WSEW1CHQ@mail.gmail.com>
 <56FB87A1.4020505@tekno-soft.it> <5245625.0MITzPXo6V@wuerfel>
 <56FBCBA2.6050903@tekno-soft.it>
 <CAJ+vNU3CcXgMBfTnazofZVt5Z4vi9bf7SkbJ9=DMQ-xksTQJJA@mail.gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56FBEEC6.6050105@tekno-soft.it>
Date: Wed, 30 Mar 2016 17:20:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU3CcXgMBfTnazofZVt5Z4vi9bf7SkbJ9=DMQ-xksTQJJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/30/2016 03:38 PM, Tim Harvey wrote:
> On Wed, Mar 30, 2016 at 5:50 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>> On 03/30/2016 12:10 PM, Arnd Bergmann wrote:
>>> On Wednesday 30 March 2016 10:00:33 Roberto Fichera wrote:
>>>>> Check your XIO2001 routing and insure the following for proper IRQ mapping:
>>>>> Slot12: IDSEL A28: socket INTA = XIO2001 INTA
>>>>> Slot13: IDSEL A29: socket INTA = XIO2001 INTB
>>>>> Slot14: IDSEL A30: socket INTA = XIO2001 INTC
>>>>> Slot15: IDSEL A31: socket INTA = XIO2001 INTD
>>>> After crosschecking with our hardware designer the PCB IRQ mapping is the following:
>>>>
>>>> J2 : IDSEL  A16: => Device 0 : socket INTA = XIO2001 INTA
>>>> J3 : IDSEL  A18: => Device 2 : socket INTA = XIO2001 INTA* **(This should be INTC)*
>>>> J11: IDSEL A20: => Device 4 : socket INTA = XIO2001 INTA
>>>>
>>>> The interrupt routing for J3 is wrong. The XIO2001 driver may expect Device 2 to interrupt on INTC - but it will
>>>> interrupt on INTA.
>>> What does your interrupt-map property look like then?
>> Unfortunately it seems that J3 slot doesn't work anymore. Inserting a card there, PCIe link will not come up anymore.
>> Likely I broke it. Looking at some spare logs I have, a card inserted in J3 will get another interrupt, was 291 however
>> unfortunately I don't have an usefull lspci -vv output, sorry! Will check in it against another PCB when I can.
>>
>>> Note that you have to override both map and map-mask in this case.
>> Can you please give more details where should I have a look?
>>
>>>       Arnd
>>>
> Robert,
>
> The interrupt-map / interrupt-map-mask properties are the ones that
> dictate irq mapping. In most cases they are defined at the host
> controller only and the kernel will assume standard interrupt
> swizzling (aka barber pole'ing) through bridges and will rotate
> interrupts (swizzle) for each bridge you go through. It is only if the
> interrupts are 'not' mapped properly (as in your case, and as was mine
> on a specific add-in card) that you need to define interrupt-map /
> interrupt-map-mask for the actual bridge with the interrupt mapping
> issue. So in other words, you won't have an interrupt-map/mask for
> your TI XIO2001 'currently', but you need to add one to describe its
> non-standard mapping.
>
> If you look at imx6qdl.dtsi you'll see the interrupt-map/mask for
> standard mapping is:
>
> interrupt-map-mask = <0 0 0 0x7>;
> interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>                           <0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
>                           <0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
>                           <0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
>
> This is because on the IMX6 INTA=GIC_123, INTB=GIC_122, INTC=GIC_121,
> INTD=GIC_120. The interrupt-map-mask is important because it decribes
> which bits of the 'unit interrupt specifier' each map pertains to. For
> the standard mapping above only the pin is important because this is
> the mapping for each slot so only the last three bits of the 'unit
> interrupt specifier' which has four cells is specified in the mask
> (0x7).
>
> In your case you will need to describe a map that depends not only on
> pin but on slot. The first 32bit cell in the 'unit interrupt
> specifier' defines the bus/domain/function (BDF) as: bus << 16 | dev
> << 11 | func <<8. This is also the same format for the first cell in
> the 'reg' property that describes each PCI device.
>
> If you are saying that your hardware did not swizzle the interrupts
> for the various slots then that means the above mapping needs to be
> applied to each slot the same. I
>
> You need to nest PCI devices as they appear on the bus, specifying reg
> properly. So, in your case you have a XIO2001 bridge hanging off of
> the IMX6 root complex. The root complex is at BDF 0:00.0, the XIO2001
> is at BDF 1:00.0, and its sockets are at bus=2. So you will need to
> add the following to your device-tree (fixing pinctrl and reset-gpio
> per your board specifics):
>
> &pcie {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_pcie>;
>         reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
>         status = "okay";
>
>        /* 0:00.0 root complex */
>        pcie@0,0,0 {
>                reg = <0 0 0 0 0>; /* bus=0, dev=0, func=0 */
>
>                /* 1:00.0 TI bridge with reversed IRQ mapping */
>                pcie@1,0,0 {
>                        device_type = "pci";
>                        #address-cells = <3>;
>                        #size-cells = <2>;
>                        reg = <0x010000 0 0 0 0>; /* bus=1, dev=0, func=0 */
>                        #interrupt-cells = <1>;
>                        interrupt-map-mask = <0xfff00 0 0 0x7>; /*
> match bus and device as well as pin */
>                        interrupt-map =
>                                /* MAP for INTA/B/C/D in slot 2:00.00 -
> standard mapping */
>                                <0x26000 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_H
>                                <0x26000 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_H
>                                <0x26000 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_H
>                                <0x26000 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_H
>                                /* MAP for INTA/B/C/D in slot 2:02.00 -
> wrong mapping */
>                                <0x26800 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_H
>                                <0x26800 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_H
>                                <0x26800 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_H
>                                <0x26800 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_H
>                                /* MAP for INTA/B/C/D in slot 2:04.00 -
> standard mapping */
>                                <0x27000 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_H
>                                <0x27000 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_H
>                                <0x27000 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_H
>                                <0x27000 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_H
> ...
>                };
>        };
> };
>
> You will need to provide a full mapping which means you'll need to
> know how INTA/B/C/D are mapped to each slot. MiniPCIe only users
> INTA/B but afaik you have to specify all four. I 'think' what you are
> elluding to is that the hardware engineer didn't swizzle the slots at
> all so all slots are mapped with INTA->INTA, INTB->INTB, INTC->INTC,
> INTD->INTD. If this is the case then you just copy the above for all
> slots taking care to specify the first cell properly with b<<16 |
> d<<11.
>
> You may find http://devicetree.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
> to be helpful as well.

Tim,

thanks for the detailed information. Will have a look soon.


>
> Regards,
>
> Tim
>

