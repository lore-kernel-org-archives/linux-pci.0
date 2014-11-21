Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0113.outbound.protection.outlook.com ([157.56.110.113]:53888
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756487AbaKUDHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Nov 2014 22:07:04 -0500
Message-ID: <546EAC4E.9050808@amd.com>
Date: Thu, 20 Nov 2014 21:06:54 -0600
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: <marc.zyngier@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqdomain: Fix NULL pointer dererence in irq_domain_free_irqs_parent
References: <1416531745-24661-1-git-send-email-suravee.suthikulpanit@amd.com>
 <alpine.DEB.2.11.1411210219370.6439@nanos> <546E9E8E.5000303@amd.com>
 <546EA823.8030401@linux.intel.com>
In-Reply-To: <546EA823.8030401@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/20/2014 08:49 PM, Jiang Liu wrote:
>
>
> On 2014/11/21 10:08, Suravee Suthikulpanit wrote:
>> On 11/20/2014 07:32 PM, Thomas Gleixner wrote:
>>> On Thu, 20 Nov 2014, suravee.suthikulpanit@amd.com wrote:
>>>> This patch checks if the parent domain is NULL before recursively
>>>> freeing
>>>> irqs in the parent domains.
>>>
>>> Which is nonsense, because if the thing has not been allocated in the
>>> first place, then it cannot explode in the free path magically, except
>>> there is a missing check in the allocation path error handling.
>>>
>>> And that's obviously not the case simply because this originates from:
>>>> [<fffffe0000449278>] pci_disable_msix+0x40/0x50
>>>
>>
>> Thomas,
>>
>> In this case, I have the following irq domain hierarchy:
>>
>> [GIC] -- [GICv2m] -- [MSI]
>>
>> which recursively calling the freeing function:
>>
>> In GIC domain, it currently defines the struct irq_domain_ops.free() with :
>>    --> irq_domain_free_irqs_top()
>>      |--> irq_domain_free_irqs_common()
>>        |--> irq_domain_free_irq_parent()
>>          |--> irq_domain_free_irqs_recursive()
>>
>> and there is no check before passing the NULL domain->parent into the
>> irq_domain_free_irqs_recursive(), which causes the error.
>>
>> Since the GIC is the top most domain, it does not have parent domain.
>> So, I'm not sure what is missing from the allocation path error
>> handling, as you mentioned.
> Hi Thomas,
> 	We have had a discussion about this issue in another thread.
> Originally irq_domain_free_irqs_common() is designed to be used by
> irqdomains with parent. But there are desires to reuse it to support
> irqdomains without parent too for code reduction.
> So I suggest to change irq_domain_free_irqs_common() instead of
> irq_domain_free_irqs_parent() because caller of
> irq_domain_free_irqs_parent() should guarantee current domain do have
> a parent.
> I'm preparing a patch for this:)
> Regards!
> Gerry

Thanks Gerry and Thomas.

Suravee

>>
>> Thanks,
>>
>> Suravee
