Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:59845 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaENEyf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 May 2014 00:54:35 -0400
Received: by mail-we0-f170.google.com with SMTP id u57so1364036wes.1
        for <linux-pci@vger.kernel.org>; Tue, 13 May 2014 21:54:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001801cf6f0f$cfd4b510$6f7e1f30$%han@samsung.com>
References: <fd5f29f175b2499e9d972629f1ccd74a@HKXPR06MB168.apcprd06.prod.outlook.com>
	<001801cf6f0f$cfd4b510$6f7e1f30$%han@samsung.com>
Date: Tue, 13 May 2014 21:54:33 -0700
Message-ID: <CAJ+vNU29uZn+TRx+X8miLuRXhQS32QQZkEF53y09ijNYm9NX7w@mail.gmail.com>
Subject: Re: [Q] Synopsys PCIe interrupts
From: Tim Harvey <tharvey@gateworks.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 13, 2014 at 5:59 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Wednesday, May 14, 2014 1:14 AM, Phil Edworthy wrote:
>>
>> Hi,
>>
>> I am currently writing another driver that uses the Synopsys Designware
>> PCIe host controller driver.
>>
>> In general, it all looks good thanks to all involved in this driver.
>> One area that I am having a little problem with is the interrupts.
>>  According to the documentation I have, the module has separate
>> interrupts for INTA, INTB, INTC, INTD, MSI, AER, bandwidth management,
>>  PME (and possibly a couple of others as well).
>>
>> However, so far it looks like the upstream implementations just use
>> a single interrupt for the module, is that correct? I notice that some
>>  DT bindings include other interrupts that are not part of the Designware
>> PCIe controller, but that's not what I'm talking about.
>
> (+cc Mohit Kumar, Pratyush Anand, Marek Vasut, Kishon Vijay Abraham I,
>        Lucas Stach, Tim Harvey, Arnd Bergmann)
>
> PCIe Interrupt mapping is specific for SoC.
>
> In the case of Exynos, there are three interrupts for
> Exynos PCIe; INTx, MSI, PHY Link, respectively as below.
>
> ./arch/arm/boot/dts/exynos5440.dtsi
>         interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
>
> <0 20 0>: PCIe RC0 pulse interrupt,
>              INTA, INTB, INTC and INTD, etc
> <0 21 0>: PCIe RC0 level interrupt,
>              MSI, etc
> <0 22 0>: PCIe RC0 special interrupt,
>              PHY Link related interrupts, etc
>
> So, there are three lines between GIC and PCIe. Also, IRQ mappings
> for other SoCs are different.
>
> For example, the IMX6 maps INTA/B/C/D to ARM GIC IRQ 155/154/153/152
> respectively.
>
> Then, how many lines are there between GIC and PCIe in your SoC?
> How does your SoC map interrupts to GIC?
>
>>
>> In existing implementations, does the hardware just OR
>> all these interrupts together?
>>

Phil,

There is not just a single interrupt for the upstream implementations.
See: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/host/pcie-designware.c#n742

of_irq_parse_and_map_pci(dev, slot, pin) is used to parse the
device-tree interrupt map which defines the multiple IRQ's that Jingoo
mentions above. For IMX6 these are defined in the imx6qdl.dtsi here:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6qdl.dtsi#n146.

So in other words, depending on the slot and pin (each legacy PCI
device can have 4 interrupt pins, INTA/B/C/D) the irq would get mapped
to a different interrupt. The interrupts are not OR'd together.

Tim

>
> Sorry, I cannot understand; other engineers will answer.
>
> Best regards,
> Jingoo Han
>
>> Thanks
>> Phil
>
