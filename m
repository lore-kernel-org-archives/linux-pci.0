Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35350 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbbCYKMw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 06:12:52 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NLR00L4UJ1FSTA0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 25 Mar 2015 19:12:51 +0900 (KST)
Message-id: <55128A23.4000903@samsung.com>
Date: Wed, 25 Mar 2015 19:12:51 +0900
From: Jaehoon Chung <jh80.chung@samsung.com>
MIME-version: 1.0
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"cpgs@samsung.com" <cpgs@samsung.com>
Subject: Re: [PATCH] pci: pci-exynos: fixed the sentence error
References: <1427260392-4186-1-git-send-email-jh80.chung@samsung.com>
 <20150325094440.GJ14917@e106497-lin.cambridge.arm.com>
In-reply-to: <20150325094440.GJ14917@e106497-lin.cambridge.arm.com>
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear, Liviu.

On 03/25/2015 06:44 PM, Liviu Dudau wrote:
> On Wed, Mar 25, 2015 at 05:13:12AM +0000, Jaehoon Chung wrote:
>> There is the sentence error.
>> Changed the semicolon instead of comma.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/pci/host/pci-exynos.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
>> index d202b37..c139237 100644
>> --- a/drivers/pci/host/pci-exynos.c
>> +++ b/drivers/pci/host/pci-exynos.c
>> @@ -396,7 +396,7 @@ static void exynos_pcie_enable_irq_pulse(struct pcie_port *pp)
>>  
>>  	/* enable INTX interrupt */
>>  	val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
>> -		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT,
>> +		IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
>>  	exynos_elb_writel(exynos_pcie, val, PCIE_IRQ_EN_PULSE);
>>  }
> 
> Well spotted. The original change dates from July 2013, I'm guessing no one uses
> PCIe on Exynos?

pci-exynos.c based on Exynos5440. I can't also see whoever use it.
But exynos5433 is used the PCIe.
There is difference between exynos5440 and exynos5433.
(i.e. Register base and offset..)
If exynos5440 is not used, i want to update pci-exynos.c to base on exynos5433.
In future, exynos should be use the PCIe...

ASAP, I will send the patch-set for exynos5433.
Before sending patch-set, just sent the patch for fixing it.
(Also, working on supporting ARM64 at pcie-designware.c)

Best Regards,
Jaehoon Chung

> 
> Best regards,
> Liviu
> 
>>  
>> -- 
>> 1.9.1
>>
>>
> 

