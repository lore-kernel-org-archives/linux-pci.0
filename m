Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:27856 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933624AbbA1Bmb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 20:42:31 -0500
Message-ID: <54C83E77.2030800@huawei.com>
Date: Wed, 28 Jan 2015 09:42:15 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Add guard to avoid mapping a invalid msix base address
References: <1422348253-13990-1-git-send-email-wangyijing@huawei.com> <20150127174129.GE4063@google.com>
In-Reply-To: <20150127174129.GE4063@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index fd60806..cd401a2 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -699,6 +699,9 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>>  	pci_read_config_dword(dev, dev->msix_cap + PCI_MSIX_TABLE,
>>  			      &table_offset);
>>  	bir = (u8)(table_offset & PCI_MSIX_TABLE_BIR);
>> +	if (!pci_resource_flags(dev, bir))
>> +		return NULL;
> 
> This definitely seems like a good idea.  We should not just assume that
> space has been assigned for the BAR.  
> 
> However, I don't think we should test the resource flags for zero.
> reset_resource() does set the flags to zero, but I think that is a mistake.
> The PCI core should retain the information about the type and size of the
> BAR, even if it was unable to assign space for it.  So eventually
> reset_resource() should be reworked somehow.
> 
> I would like reset_resource() to set the IORESOURCE_UNSET bit in the flags.
> That would let %pR print it correctly, e.g., "[mem size 0x1000]".  But I
> don't know what other code in setup-bus.c depends on the assumption that
> "flags == 0" means something important.

Agree, "flags == 0" is not clear enough to point the status of the resource.

> 
> In the meantime, I guess you could do something like:
> 
>   flags = pci_resource_flags(dev, bir);
>   if (!flags || (flags & IORESOURCE_UNSET))
>     return NULL;

OK, I will update it, thanks.

Thanks!
Yijing.

> 
>> +
>>  	table_offset &= PCI_MSIX_TABLE_OFFSET;
>>  	phys_addr = pci_resource_start(dev, bir) + table_offset;
>>  
>> -- 
>> 1.7.1
>>
> 
> .
> 


-- 
Thanks!
Yijing

