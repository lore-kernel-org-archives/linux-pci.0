Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:54864 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcC3MvC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2016 08:51:02 -0400
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAJ+vNU3yh8ivb+axTwXawSbtCTa+kHUsJY=EGoziT8WSEW1CHQ@mail.gmail.com>
 <56FB87A1.4020505@tekno-soft.it> <5245625.0MITzPXo6V@wuerfel>
Cc: Tim Harvey <tharvey@gateworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56FBCBA2.6050903@tekno-soft.it>
Date: Wed, 30 Mar 2016 14:50:42 +0200
MIME-Version: 1.0
In-Reply-To: <5245625.0MITzPXo6V@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/30/2016 12:10 PM, Arnd Bergmann wrote:
> On Wednesday 30 March 2016 10:00:33 Roberto Fichera wrote:
>>> Check your XIO2001 routing and insure the following for proper IRQ mapping:
>>> Slot12: IDSEL A28: socket INTA = XIO2001 INTA
>>> Slot13: IDSEL A29: socket INTA = XIO2001 INTB
>>> Slot14: IDSEL A30: socket INTA = XIO2001 INTC
>>> Slot15: IDSEL A31: socket INTA = XIO2001 INTD
>> After crosschecking with our hardware designer the PCB IRQ mapping is the following:
>>
>> J2 : IDSEL  A16: => Device 0 : socket INTA = XIO2001 INTA
>> J3 : IDSEL  A18: => Device 2 : socket INTA = XIO2001 INTA* **(This should be INTC)*         
>> J11: IDSEL A20: => Device 4 : socket INTA = XIO2001 INTA
>>
>> The interrupt routing for J3 is wrong. The XIO2001 driver may expect Device 2 to interrupt on INTC - but it will
>> interrupt on INTA.
> What does your interrupt-map property look like then? 

Unfortunately it seems that J3 slot doesn't work anymore. Inserting a card there, PCIe link will not come up anymore.
Likely I broke it. Looking at some spare logs I have, a card inserted in J3 will get another interrupt, was 291 however
unfortunately I don't have an usefull lspci -vv output, sorry! Will check in it against another PCB when I can.

> Note that you have to override both map and map-mask in this case.

Can you please give more details where should I have a look?

>
> 	Arnd
>

