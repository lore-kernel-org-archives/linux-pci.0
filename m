Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Roberto Fichera <kernel@tekno-soft.it>,
	Tim Harvey <tharvey@gateworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Petr =?utf-8?B?xaB0ZXRpYXI=?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
Date: Wed, 30 Mar 2016 12:10:29 +0200
Message-ID: <5245625.0MITzPXo6V@wuerfel>
In-Reply-To: <56FB87A1.4020505@tekno-soft.it>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <CAJ+vNU3yh8ivb+axTwXawSbtCTa+kHUsJY=EGoziT8WSEW1CHQ@mail.gmail.com> <56FB87A1.4020505@tekno-soft.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 30 March 2016 10:00:33 Roberto Fichera wrote:
> >
> > Check your XIO2001 routing and insure the following for proper IRQ mapping:
> > Slot12: IDSEL A28: socket INTA = XIO2001 INTA
> > Slot13: IDSEL A29: socket INTA = XIO2001 INTB
> > Slot14: IDSEL A30: socket INTA = XIO2001 INTC
> > Slot15: IDSEL A31: socket INTA = XIO2001 INTD
> 
> After crosschecking with our hardware designer the PCB IRQ mapping is the following:
> 
> J2 : IDSEL  A16: => Device 0 : socket INTA = XIO2001 INTA
> J3 : IDSEL  A18: => Device 2 : socket INTA = XIO2001 INTA* **(This should be INTC)*         
> J11: IDSEL A20: => Device 4 : socket INTA = XIO2001 INTA
> 
> The interrupt routing for J3 is wrong. The XIO2001 driver may expect Device 2 to interrupt on INTC - but it will
> interrupt on INTA.

What does your interrupt-map property look like then? Note that you
have to override both map and map-mask in this case.

	Arnd
