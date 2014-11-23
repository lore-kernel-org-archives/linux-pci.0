Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10068 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbaKWN2a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 23 Nov 2014 08:28:30 -0500
Message-ID: <5471E0F9.7080003@linux.intel.com>
Date: Sun, 23 Nov 2014 21:28:25 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch irqdomain: Enhance irq_domain_free_irqs_common() to support
 parentless irqdomain
References: <1416540206-18103-1-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1411231132160.6439@nanos> <alpine.DEB.2.11.1411231135190.6439@nanos>
In-Reply-To: <alpine.DEB.2.11.1411231135190.6439@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/11/23 18:36, Thomas Gleixner wrote:
> On Sun, 23 Nov 2014, Thomas Gleixner wrote:
> 
>> On Fri, 21 Nov 2014, Jiang Liu wrote:
>>
>>> Originally irq_domain_free_irqs_common() is designed to be used by
>>> irqdomains with parent. But there are desires to reuse for parentless
>>> irqdomains for code reduction.
>>> So check domain->parent before invoking irq_domain_free_irqs_parent().
>>>
>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>> ---
>>> Hi Thomas,
>>> 	This patch applies to tip/irq/irqdomain, it helps to reduce code
>>> size on ARM. Seems we still have chance to merge it into tip/irq/irqdomain:)
>>> Regards!
>>> Gerry
>>> ---
>>>  kernel/irq/irqdomain.c |    3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>> index 029acf11efed..0449d2869e17 100644
>>> --- a/kernel/irq/irqdomain.c
>>> +++ b/kernel/irq/irqdomain.c
>>> @@ -975,7 +975,8 @@ void irq_domain_free_irqs_common(struct irq_domain *domain, unsigned int virq,
>>>  		if (irq_data)
>>>  			irq_domain_reset_irq_data(irq_data);
>>>  	}
>>> -	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>>> +	if (domain->parent)
>>> +		irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>>
>> irq_domain_free_irqs_parent()
>> {
>> 	if (domain->parent && domain->parent->ops->free)
>> 	   	...
>> }
>>
>> So the above is redundant and does not change anything.
> 
> Except that this function gets replaced later in the series and drops
> the parent check.
> 
> Though we should not put the conditionals on the call sites. We want
> the functions handle it.
> 
> /me goes fixing.
Thanks, Thomas!

> 
> Thanks,
> 
> 	tglx
> 
