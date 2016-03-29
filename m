Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42195 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578AbcC2R4p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Mar 2016 13:56:45 -0400
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
To: Arnd Bergmann <arnd@arndb.de>, Tim Harvey <tharvey@gateworks.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <5741237.2X2Q0sCFQj@wuerfel>
 <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
 <3827347.i8fIQs6jUv@wuerfel>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?Q?Petr_=c5=a0tetiar?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <56FAC1D9.40404@arm.com>
Date: Tue, 29 Mar 2016 18:56:41 +0100
MIME-Version: 1.0
In-Reply-To: <3827347.i8fIQs6jUv@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/03/16 16:24, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 08:10:08 Tim Harvey wrote:
>> Arnd,
>>
>> Right, on the IMX the MSI interrupt is GIC-120 which is also the
>> legacy INTD and I do see that if I happen to put a radio in a slot
>> where due to swizzling its pin1 becomes INTD (GIC-120) the interrupt
>> does fire and the device works. Any other slot using GIC-123 (INTA),
>> GIC-122 (INTB), or GIC-121 (INTC) never fires so its very possible
>> that something in the designware core is masking out the legacy irqs.
> 
> Interesting. I was actually expecting the opposite here, having the
> IRQs only work if they are not IntD. 
> 
> 
>> I typically advise our users to 'not' enable MSI because
>> architecturally you can spread 4 distinct legacy irq's across CPU's
>> better than a single shared irq.
> 
> That is a very good point, I never understood why we want to enable
> MSI support on any PCI host bridge that just forwards all MSIs
> to a single IRQ line. Originally MSI was meant as a performance
> feature, but there is nothing in this setup that makes things go
> faster, and several things that make it go slower.

Feature-ticking exercise.

"We support MSI", never mind if that negating the benefits of the
mechanism and ending up with disastrous impacts on interrupt affinity,
and a set of open questions regarding the effect of the MSI as a DMA fence.

/me stops ranting for the day...

	M.
-- 
Jazz is not dead. It just smells funny...
