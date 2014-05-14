Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16156 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaENA7y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 May 2014 20:59:54 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5J00LTHHFSZQ10@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 14 May 2014 09:59:52 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Phil Edworthy' <phil.edworthy@renesas.com>
Cc: linux-pci@vger.kernel.org, 'Richard Zhu' <r65037@freescale.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Marek Vasut' <marex@denx.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Lucas Stach' <l.stach@pengutronix.de>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <fd5f29f175b2499e9d972629f1ccd74a@HKXPR06MB168.apcprd06.prod.outlook.com>
In-reply-to: <fd5f29f175b2499e9d972629f1ccd74a@HKXPR06MB168.apcprd06.prod.outlook.com>
Subject: Re: [Q] Synopsys PCIe interrupts
Date: Wed, 14 May 2014 09:59:51 +0900
Message-id: <001801cf6f0f$cfd4b510$6f7e1f30$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, May 14, 2014 1:14 AM, Phil Edworthy wrote:
> 
> Hi,
> 
> I am currently writing another driver that uses the Synopsys Designware
> PCIe host controller driver.
> 
> In general, it all looks good thanks to all involved in this driver.
> One area that I am having a little problem with is the interrupts.
>  According to the documentation I have, the module has separate
> interrupts for INTA, INTB, INTC, INTD, MSI, AER, bandwidth management,
>  PME (and possibly a couple of others as well).
> 
> However, so far it looks like the upstream implementations just use
> a single interrupt for the module, is that correct? I notice that some
>  DT bindings include other interrupts that are not part of the Designware
> PCIe controller, but that's not what I'm talking about.

(+cc Mohit Kumar, Pratyush Anand, Marek Vasut, Kishon Vijay Abraham I,
       Lucas Stach, Tim Harvey, Arnd Bergmann)

PCIe Interrupt mapping is specific for SoC.

In the case of Exynos, there are three interrupts for
Exynos PCIe; INTx, MSI, PHY Link, respectively as below. 

./arch/arm/boot/dts/exynos5440.dtsi
	interrupts = <0 20 0>, <0 21 0>, <0 22 0>;

<0 20 0>: PCIe RC0 pulse interrupt,
             INTA, INTB, INTC and INTD, etc
<0 21 0>: PCIe RC0 level interrupt,
             MSI, etc
<0 22 0>: PCIe RC0 special interrupt,
             PHY Link related interrupts, etc

So, there are three lines between GIC and PCIe. Also, IRQ mappings
for other SoCs are different.

For example, the IMX6 maps INTA/B/C/D to ARM GIC IRQ 155/154/153/152
respectively.

Then, how many lines are there between GIC and PCIe in your SoC?
How does your SoC map interrupts to GIC?

> 
> In existing implementations, does the hardware just OR
> all these interrupts together?
>

Sorry, I cannot understand; other engineers will answer.

Best regards,
Jingoo Han

> Thanks
> Phil

