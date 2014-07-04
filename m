Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:4095 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309AbaGDB6D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 21:58:03 -0400
Message-ID: <53B60A1D.2030900@huawei.com>
Date: Fri, 4 Jul 2014 09:57:49 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH 4/5] PCI/MSI: MSI cleanup, msi_setup_entry()
References: <1403166648-7932-1-git-send-email-wangyijing@huawei.com> <20140703233952.GB25980@google.com>
In-Reply-To: <20140703233952.GB25980@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> +	list_add_tail(&entry->list, &dev->msi_list);
>> +	return 0;
> 
> Why don't you just return "entry" here (and NULL for the failure above)?

Hmmm, this is a good idea, return the entry here will be better

> 
>> +}
>> +
>>  /**
>>   * msi_capability_init - configure device's MSI capability structure
>>   * @dev: pointer to the pci_dev data structure of MSI device function
>> @@ -597,51 +626,30 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>>  
>> -	if (control & PCI_MSI_FLAGS_64BIT)
>> -		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
>> -	else
>> -		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
>> +	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
>>  	/* All MSIs are unmasked by default, Mask them all */
>>  	if (entry->msi_attrib.maskbit)
>>  		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
>>  	mask = msi_mask(entry->msi_attrib.multi_cap);
>>  	msi_mask_irq(entry, mask, mask);
>>  
>> -	list_add_tail(&entry->list, &dev->msi_list);
> 
> And keep the list_add_tail() here.  Then you don't have the awkwardness of
> pulling the entry off the list after calling msi_setup_entry().
> 
> That also means the MSIs can be masked before putting the entry on
> dev->msi_list, as they were before.  It *might* be safe to change the order
> as you did, but it definitely takes some analysis to prove it, especially
> since pci_enable_msi_range() only WARNs but doesn't bail out if
> dev->msi_enabled already.
> 

Bjorn, Thanks for your review and comments, I will update this patch and resend it, Thanks!

>>  	/* Configure MSI capability structure */
>>  	ret = arch_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
>> -	if (ret) {
>> -		msi_mask_irq(entry, mask, ~mask);
>> -		free_msi_irqs(dev);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto err;
>>  
>>  	ret = populate_msi_sysfs(dev);
>> -	if (ret) {
>> -		msi_mask_irq(entry, mask, ~mask);
>> -		free_msi_irqs(dev);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto err;
>>  
>>  	/* Set MSI enabled bits	 */
>>  	pci_intx_for_msi(dev, 0);
>> @@ -650,6 +658,11 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>>  
>>  	dev->irq = entry->irq;
>>  	return 0;
>> +
>> +err:
>> +	msi_mask_irq(entry, mask, ~mask);
>> +	free_msi_irqs(dev);
>> +	return ret;
>>  }
>>  
>>  static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>> -- 
>> 1.7.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing

