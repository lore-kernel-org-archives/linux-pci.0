Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44991 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933920AbaKMXSX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 18:18:23 -0500
Message-ID: <54653C42.7050405@ti.com>
Date: Thu, 13 Nov 2014 18:18:26 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jingoo Han <jg1.han@samsung.com>, <linux-pci@vger.kernel.org>,
	"'Santosh Shilimkar'" <ssantosh@kernel.org>
Subject: Re: [PATCH] PCI: keystone: Remove unnecessary OOM message
References: <002601cffe27$f7bca9f0$e735fdd0$%han@samsung.com> <20141113174756.GL5064@google.com>
In-Reply-To: <20141113174756.GL5064@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/13/2014 12:47 PM, Bjorn Helgaas wrote:
> On Wed, Nov 12, 2014 at 12:22:56PM +0900, Jingoo Han wrote:
>> The site-specific OOM messages are unnecessary, because they
>> duplicate the MM subsystem generic OOM message. This patch
>> fixes the following checkpatch warning.
>>
>>    WARNING: Possible unnecessary 'out of memory' message
>>
>> Signed-off-by: Jingoo Han<jg1.han@samsung.com>
> Applied to pci/host-keystone for v3.19, thanks!
>
> Murali, let me know if you object.  I'm trying to clear the easy stuff out
> of my queue.
I think this checkpatch warning is due to recent update to checkpatch.pl 
script. Looks good to apply.  Thanks

Murali
>> ---
>>   drivers/pci/host/pci-keystone.c |    5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
>> index 1b893bc..62b9454 100644
>> --- a/drivers/pci/host/pci-keystone.c
>> +++ b/drivers/pci/host/pci-keystone.c
>> @@ -353,10 +353,9 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>
>>   	ks_pcie = devm_kzalloc(&pdev->dev, sizeof(*ks_pcie),
>>   				GFP_KERNEL);
>> -	if (!ks_pcie) {
>> -		dev_err(dev, "no memory for keystone pcie\n");
>> +	if (!ks_pcie)
>>   		return -ENOMEM;
>> -	}
>> +
>>   	pp =&ks_pcie->pp;
>>
>>   	/* initialize SerDes Phy if present */
>> -- 
>> 1.7.9.5
>>
>>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments

