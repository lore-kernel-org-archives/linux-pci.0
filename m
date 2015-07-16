Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0064.outbound.protection.outlook.com ([65.55.169.64]:40736
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754905AbbGPROS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Jul 2015 13:14:18 -0400
Message-ID: <55A7E663.9030000@caviumnetworks.com>
Date: Thu, 16 Jul 2015 10:14:11 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Robert Richter <rrichter@cavium.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 4/5] irqchip: gic-v3: Add gic_get_irq_domain() to get
 the irqdomain of the GIC.
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com> <1436979285-8177-5-git-send-email-ddaney.cavm@gmail.com> <55A6947F.8070903@arm.com> <55A6AD1F.902@caviumnetworks.com> <55A75F8B.3080009@arm.com> <55A7E0C2.8020704@caviumnetworks.com> <55A7E52D.9080201@arm.com>
In-Reply-To: <55A7E52D.9080201@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/16/2015 10:09 AM, Marc Zyngier wrote:
> On 16/07/15 17:50, David Daney wrote:
[...]
>>> Patch 5 has established that you're using "virtual wire" SPIs, so we
>>> need to work on exposing that with the normal kernel abstraction, and
>>> not by messing with the internals of the GIC.
>>>
>>
>> Agreed.
>>
>> The MSI system has pci_enable_msix()/pci_disable_msix().
>>
>> I would propose something like:
>>
>> struct gic_spi_entry {
>> 	int spi   /* SPI number */
>> 	int irq;  /* kernel irq number mapped to the spi*/
>> 	u32 msg;  /* message to be written */
>> 	u64 assert_addr;
>> 	u64 deassert_addr;
>> };
>>
>> /* Fill in the SPI processing information */
>> int gic_map_spi(int spi, struct gic_spi_entry *data);
>
> Neither.
>
> The way to do it is to make this a *separate* IRQ domain stacked onto
> the SPI domain. No funky hook on the side. If it doesn't go through the
> normal kernel API, it doesn't reach the GIC.

Yes, the irqdomain does handle mapping SPI -> irq, and the message can 
be derived from the SPI.  However, the irqdomain infrastructure cannot 
supply values for either assert_addr or deassert_addr.

Those are needed in order to use SPI.  How would you suggest that they 
be obtained?


David Daney


>
> 	M.
>

