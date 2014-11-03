Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0103.outbound.protection.outlook.com ([157.56.110.103]:36507
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752340AbaKCT5m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Nov 2014 14:57:42 -0500
Message-ID: <5457DE24.9030302@amd.com>
Date: Mon, 3 Nov 2014 13:57:24 -0600
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Marc Zyngier <marc.zyngier@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	"Catalin.Marinas@arm.com" <Catalin.Marinas@arm.com>,
	"Will.Deacon@arm.com" <Will.Deacon@arm.com>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>,
	"Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [V9 PATCH 2/2] irqchip: gicv2m: Add supports for ARM GICv2m MSI(-X)
References: <1414743990-28421-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1414743990-28421-3-git-send-email-suravee.suthikulpanit@amd.com>
 <alpine.DEB.2.11.1410311014050.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410311014050.5308@nanos>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2014 4:40 AM, Thomas Gleixner wrote:
> On Fri, 31 Oct 2014, suravee.suthikulpanit@amd.com wrote:
>> +/*
>> + * alloc_msi_irq - Allocate MSIs from available MSI bitmap.
>> + * @data: Pointer to v2m_data
>> + * @nvec: Number of interrupts to allocate
>> + * @irq: Pointer to the allocated irq
>> + *
>> + * Allocates interrupts only if the contiguous range of MSIs
>> + * with specified nvec are available. Otherwise return the number
>> + * of available interrupts. If none are available, then returns -ENOENT.
>
> And the exact purpose of returning the number of available interrupts
> is?

Initially, I intended to use this function to allocate irqs for both MSI 
and multi-MSI case. But I'll simplify this and revisit it again when 
adding the multi-MSI.

>
>> +	virq = __irq_domain_alloc_irqs(v2m->domain, hwirq,
>> +				       1, NUMA_NO_NODE, v2m, true);
>
> And surely the ability of alloc_msi_irq() to allocate a contiguous
> vector space is required to satisfy an hardcoded allocation of ONE
> interrupt.
>
> What is guaranteeing that the caller only requests a single interrupt?

Since this is calling from gicv2m_setup_msi_irq(), it should only setup 
1 MSI interrupt.

 >[...]
>> +err_out:
>
> Single error exit which undoes the stuff in the same order it got
> initialized is just plain wrong. Ever looked at proper error exits in
> other kernel files?
>

I'll clean this up in V10. Thanks for pointing this out.

Suravee

