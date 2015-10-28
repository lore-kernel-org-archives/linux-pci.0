Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0066.outbound.protection.outlook.com ([157.56.110.66]:44256
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751673AbbJ1SM1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Oct 2015 14:12:27 -0400
Subject: Re: [PATCH V4 7/8] PCI: OF: Move of_pci_dma_configure() to
 pci_dma_configure()
To: Hanjun Guo <guohanjun@huawei.com>, <bhelgaas@google.com>,
	<rjw@rjwysocki.net>, <lenb@kernel.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>
References: <1445442731-28819-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1445442731-28819-8-git-send-email-Suravee.Suthikulpanit@amd.com>
 <562B36EC.3040406@huawei.com>
CC: <thomas.lendacky@amd.com>, <herbert@gondor.apana.org.au>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	<hanjun.guo@linaro.org>, <davem@davemloft.net>,
	<linux-arm-kernel@lists.infradead.org>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <56311004.6090809@amd.com>
Date: Wed, 28 Oct 2015 13:12:20 -0500
MIME-Version: 1.0
In-Reply-To: <562B36EC.3040406@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hanjun,

On 10/24/15 02:44, Hanjun Guo wrote:
> Hi Suravee,
>
> Some minor comments  below:
>
> On 2015/10/21 23:52, Suravee Suthikulpanit wrote:
> [...]
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index eea8b42..09264f8 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -6,12 +6,14 @@
>>   #include <linux/delay.h>
>>   #include <linux/init.h>
>>   #include <linux/pci.h>
>> -#include <linux/of_pci.h>
>> +#include <linux/of_device.h>
>
> Seems it's needed for GICv2m patch but not this one?
This one is needed since we are making use of the new of_dma_configure 
instead of the of_pci_dma_configure.

>
>>   #include <linux/pci_hotplug.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/pci-aspm.h>
>> +#include <linux/acpi.h>
>
> I think acpi.h should be introduced by the next patch.
You are right. I'll update this one.

>
>> +#include <linux/property.h>
>
> And property.h is also not needed for this patch set.

You are right. I'll remove this

Thanks,
Suravee


