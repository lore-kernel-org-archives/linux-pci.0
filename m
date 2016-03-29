Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:43482 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcC2QOQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 12:14:16 -0400
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
To: Tim Harvey <tharvey@gateworks.com>, Arnd Bergmann <arnd@arndb.de>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <23031613.R8qN30TbTq@wuerfel>
 <CAJ+vNU2BKLDREOWP8EWXZR43to10yw+qvKwv1MzS4a_L9n5ozg@mail.gmail.com>
 <5741237.2X2Q0sCFQj@wuerfel>
 <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
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
Message-ID: <56FAA9C1.5060107@tekno-soft.it>
Date: Tue, 29 Mar 2016 18:13:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/29/2016 05:10 PM, Tim Harvey wrote:
> Arnd,
>
> Right, on the IMX the MSI interrupt is GIC-120 which is also the
> legacy INTD and I do see that if I happen to put a radio in a slot
> where due to swizzling its pin1 becomes INTD (GIC-120) the interrupt
> does fire and the device works. Any other slot using GIC-123 (INTA),
> GIC-122 (INTB), or GIC-121 (INTC) never fires so its very possible
> that something in the designware core is masking out the legacy irqs.
> I would also think this was something IMX specific, but I really don't
> see any codepaths in pci-imx6.c that would cause that: a driver
> requesting a legacy PCI would get a GIC interrupt which is handled by
> the IMX6 gpc interrupt controller.
>
> Any dra7xxx, exynos, spear13xx, keystone, layerscape, hisi, qcom SoC
> users of designware PCIe core out there that can verify PCI MSI and
> legacy are both working at the same time?
>
> Lucas is the expert here and I believe he has the documentation for
> the designware core that Freescale doens't provide with the IMX6
> documentation so hopefully he can provide some insight. He's the one
> that has authored all the MSI support and has been using it.
>
> I typically advise our users to 'not' enable MSI because
> architecturally you can spread 4 distinct legacy irq's across CPU's
> better than a single shared irq.

Don't know if I'm facing similar problem, however devices connected in miniPCI slot behind
a PCIe-to-PCI bridge (MSI is disabled) using INTA all is working ok, including shared IRQ.
In case of INTB will not work, and the GIC irq quite often get stuck.

