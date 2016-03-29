Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:43951 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757497AbcC2Qoe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 12:44:34 -0400
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
To: Tim Harvey <tharvey@gateworks.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <23031613.R8qN30TbTq@wuerfel>
 <CAJ+vNU2BKLDREOWP8EWXZR43to10yw+qvKwv1MzS4a_L9n5ozg@mail.gmail.com>
 <5741237.2X2Q0sCFQj@wuerfel>
 <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
 <56FAA9C1.5060107@tekno-soft.it>
 <CAJ+vNU0bQVd0qyLg+09CUHx4WsrEqwZ4hLVuuvazR8DWpiHE_g@mail.gmail.com>
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
Message-ID: <56FAB0DB.3070303@tekno-soft.it>
Date: Tue, 29 Mar 2016 18:44:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU0bQVd0qyLg+09CUHx4WsrEqwZ4hLVuuvazR8DWpiHE_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/29/2016 06:40 PM, Tim Harvey wrote:
> On Tue, Mar 29, 2016 at 9:13 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>> On 03/29/2016 05:10 PM, Tim Harvey wrote:
>>> Arnd,
>>>
>>> Right, on the IMX the MSI interrupt is GIC-120 which is also the
>>> legacy INTD and I do see that if I happen to put a radio in a slot
>>> where due to swizzling its pin1 becomes INTD (GIC-120) the interrupt
>>> does fire and the device works. Any other slot using GIC-123 (INTA),
>>> GIC-122 (INTB), or GIC-121 (INTC) never fires so its very possible
>>> that something in the designware core is masking out the legacy irqs.
>>> I would also think this was something IMX specific, but I really don't
>>> see any codepaths in pci-imx6.c that would cause that: a driver
>>> requesting a legacy PCI would get a GIC interrupt which is handled by
>>> the IMX6 gpc interrupt controller.
>>>
>>> Any dra7xxx, exynos, spear13xx, keystone, layerscape, hisi, qcom SoC
>>> users of designware PCIe core out there that can verify PCI MSI and
>>> legacy are both working at the same time?
>>>
>>> Lucas is the expert here and I believe he has the documentation for
>>> the designware core that Freescale doens't provide with the IMX6
>>> documentation so hopefully he can provide some insight. He's the one
>>> that has authored all the MSI support and has been using it.
>>>
>>> I typically advise our users to 'not' enable MSI because
>>> architecturally you can spread 4 distinct legacy irq's across CPU's
>>> better than a single shared irq.
>> Don't know if I'm facing similar problem, however devices connected in miniPCI slot behind
>> a PCIe-to-PCI bridge (MSI is disabled) using INTA all is working ok, including shared IRQ.
>> In case of INTB will not work, and the GIC irq quite often get stuck.
>>
> Roberto,
>
> What board/platform is this and what does /proc/interrupts look like?

It's a custom board

root@voneus-janas-imx6q:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
 16:        936        637       2057        938       GIC  29 Edge      twd
 17:          0          0          0          0       GPC  55 Level     i.MX Timer Tick
 22:        247          0          0          0       GPC  26 Level     2020000.serial
 34:          0          0          0          0  gpio-mxc   6 Edge      Factory Reset Button
267:          0          0          0          0       GPC  49 Level     imx_thermal
272:          0          0          0          0       GPC  19 Level     rtc alarm
278:          0          0          0          0       GPC   2 Level     sdma
281:        361          0          0          0       GIC 150 Level     2188000.ethernet
282:          0          0          0          0       GIC 151 Level     2188000.ethernet
283:       2882          0          0          0       GPC  25 Level     mmc0
284:         95          0          0          0       GPC  37 Level     21a4000.i2c
290:      36546          0          0          0       GPC 123 Level     PCIe PME, b4xxp
291:          2          0          0          0       GIC 137 Level     2101000.jr0
292:          0          0          0          0       GIC 138 Level     2102000.jr1
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:       1642       1038       1626       1781  Rescheduling interrupts
IPI3:         95         95        122        119  Function call interrupts
IPI4:          3          0          2          0  Single function call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
IPI6:          0          0          0          0  IRQ work interrupts
IPI7:          0          0          0          0  completion interrupts
Err:          0


>
> This sounds like what would happen if the downstream interrupts on the
> PCIe-to-PCI bridge are not mapped properly as was the case with a
> board I support (in which case I had to work out a bootloader fixup
> that placed a non-standard interrupt-map in the device-tree for the
> bridge). What bridge are you using?

PCIe-to-PCI bridge is a Ti XIO2001 where we are using INTA/B only wired 1:1

>
> Tim
>

