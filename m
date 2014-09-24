Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:15196 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbaIXDPu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 23:15:50 -0400
Message-ID: <54223755.5010202@huawei.com>
Date: Wed, 24 Sep 2014 11:15:33 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] PCI/MSI: Simplify default_restore_msi_irq()
References: <1410399055-27562-1-git-send-email-wangyijing@huawei.com> <20140923182421.GD6776@google.com>
In-Reply-To: <20140923182421.GD6776@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/9/24 2:24, Bjorn Helgaas wrote:
> On Thu, Sep 11, 2014 at 09:30:55AM +0800, Yijing Wang wrote:
>> Both MSI and MSI-X irq will be associate to msi_desc,
>> Use irq_get_msi_desc() to get the msi_desc for MSI-X
>> to simplify code. Also use __write_msi_msg() instead
>> of write_msi_msg() to avoid the redundant calls.
> 
> Again, this should mention exactly where the MSI and MSI-X IRQs are
> associated with the msi_desc.

As mentioned in another mail, ARCH MSI code call irq_set_msi_desc() regardless of MSI or MSI-X type.

So I think use irq_get_msi_desc() for MSI-X is ok .

Thanks!
Yijing.

> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/msi.c |   13 ++-----------
>>  1 files changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 5a40516..9ad920a 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -119,18 +119,9 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>>  {
>>  	struct msi_desc *entry;
>>  
>> -	entry = NULL;
>> -	if (dev->msix_enabled) {
>> -		list_for_each_entry(entry, &dev->msi_list, list) {
>> -			if (irq == entry->irq)
>> -				break;
>> -		}
>> -	} else if (dev->msi_enabled)  {
>> -		entry = irq_get_msi_desc(irq);
>> -	}
>> -
>> +	entry = irq_get_msi_desc(irq);
>>  	if (entry)
>> -		write_msi_msg(irq, &entry->msg);
>> +		__write_msi_msg(entry, &entry->msg);
>>  }
>>  
>>  void __weak arch_restore_msi_irqs(struct pci_dev *dev)
>> -- 
>> 1.7.1
>>
> 
> 


-- 
Thanks!
Yijing

