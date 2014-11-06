Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0147.outbound.protection.outlook.com ([157.56.110.147]:3728
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751051AbaKFAFu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 5 Nov 2014 19:05:50 -0500
Message-ID: <545ABB4C.8010103@amd.com>
Date: Wed, 5 Nov 2014 18:05:32 -0600
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>, <marc.zyngier@arm.com>,
	<mark.rutland@arm.com>, <jason@lakedaemon.net>,
	<tglx@linutronix.de>
CC: <Catalin.Marinas@arm.com>, <Will.Deacon@arm.com>,
	<liviu.dudau@arm.com>, <Harish.Kasiviswanathan@amd.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [V10 PATCH 2/2] irqchip: gicv2m: Add supports for ARM GICv2m
 MSI(-X)
References: <1415052977-26036-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415052977-26036-3-git-send-email-suravee.suthikulpanit@amd.com>
 <5458CE31.3040404@linux.intel.com>
In-Reply-To: <5458CE31.3040404@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/4/2014 7:01 AM, Jiang Liu wrote:
> Hi Suravee,
> 	You may build a two level hierarchy irqdomains. Use the
> utilities in this thread
> http://www.spinics.net/lists/arm-kernel/msg374722.html  to build an MSI
> irqdomain to manage MSI controllers
> in PCI devices. And build another irqdomain to manage SPI allocation
> in GICv2.
> 	That is: MSI irqdomain (program MSI registers)  -->
> GIV irqdomain (manage SPIs in GICv2 controller)
>
> Regards!
> Gerry

Gerry,

I try out your patch from the link above, and I have a couple 
questions/issues.

1. In the drivers/pci/msi.c: msi_irq_domain_alloc_irqs(), it seems that 
the hwirq comes from msi_get_hwirq(dev, msidesc). In GICv2m, hwirq for 
MSI is fixed over a specific range. This might require arch-specific
callback.

2. In msi_domain_activate, why "if (!irq_data->chip_data)"?

3. In, msi_domain_alloc():

- There should be a way to specify other types of irq handler besides 
the "handle_edge_irq". In case of GIC, it needs handle_fasteoi_irq.

- When calling irq_domain_set_hwirq_and_chip(), you are passing "(void 
*)(long)i" for the "void *chip_data" parameter. What is this used for, 
and where?  Shouldn't this be pointing to arch-specific data structure?

- The code is calling irq_domain_alloc_irqs_parent before the loop, 
which calls irq_domain_set_hwirq_and_chip() and __irq_set_handler. 
Shouldn't the order be switched?

- Overall, it seems that msi_domain_alloc() could be quite different 
across architectures. Would it be possible to declare this function as 
weak, and allow arch to override (similar to arch_setup_msi_irq)?

Thanks,

Suravee

