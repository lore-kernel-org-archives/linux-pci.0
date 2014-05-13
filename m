Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:5719 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933744AbaEMQOc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 May 2014 12:14:32 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Jingoo Han <jg1.han@samsung.com>,
	Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [Q] Synopsys PCIe interrupts
Date: Tue, 13 May 2014 16:14:26 +0000
Message-ID: <fd5f29f175b2499e9d972629f1ccd74a@HKXPR06MB168.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I am currently writing another driver that uses the Synopsys Designware PCIe host controller driver.

In general, it all looks good thanks to all involved in this driver. One area that I am having a little problem with is the interrupts. According to the documentation I have, the module has separate interrupts for INTA, INTB, INTC, INTD, MSI, AER, bandwidth management,  PME (and possibly a couple of others as well).

However, so far it looks like the upstream implementations just use a single interrupt for the module, is that correct? I notice that some DT bindings include other interrupts that are not part of the Designware PCIe controller, but that's not what I'm talking about.

In existing implementations, does the hardware just OR all these interrupts together?

Thanks
Phil
