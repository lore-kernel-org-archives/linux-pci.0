Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:64001 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757406Ab2IMK7f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2012 06:59:35 -0400
Message-ID: <5051BC88.7040804@huawei.com>
Date: Thu, 13 Sep 2012 18:59:20 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: fix a small race condition window when
 rmmod aer_inject
References: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>  <1347453225-7704-4-git-send-email-wangyijing@huawei.com> <1347499761.30040.138.camel@yhuang-dev>
In-Reply-To: <1347499761.30040.138.camel@yhuang-dev>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/9/13 9:29, Huang Ying wrote:
> On Wed, 2012-09-12 at 20:33 +0800, Yijing Wang wrote:
>> Fix a small race condition window between pci_bus_ops_pop() and
>> pci_bus_set_ops() functions.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> ---
>>  drivers/pci/pcie/aer/aer_inject.c |    8 ++------
>>  1 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
>> index bd043db..69c2d77 100644
>> --- a/drivers/pci/pcie/aer/aer_inject.c
>> +++ b/drivers/pci/pcie/aer/aer_inject.c
>> @@ -141,12 +141,11 @@ static struct pci_ops *__find_pci_bus_ops(struct pci_bus *bus)
>>  	return NULL;
>>  }
>>  
>> +/* inject_lock must be held before calling */
>>  static struct pci_bus_ops *pci_bus_ops_pop(void)
>>  {
>> -	unsigned long flags;
>>  	struct pci_bus_ops *bus_ops = NULL;
>>  
>> -	spin_lock_irqsave(&inject_lock, flags);
>>  	if (list_empty(&pci_bus_ops_list))
>>  		bus_ops = NULL;
>>  	else {
>> @@ -154,7 +153,6 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
>>  		list_del(lh);
>>  		bus_ops = list_entry(lh, struct pci_bus_ops, list);
>>  	}
>> -	spin_unlock_irqrestore(&inject_lock, flags);
>>  	return bus_ops;
>>  }
>>  
>> @@ -610,14 +608,12 @@ static void __exit aer_inject_exit(void)
>>  	bus_unregister_notifier(&pci_bus_type, &aerinj_hp_notifier);
>>  	misc_deregister(&aer_inject_device);
>>  
>> +	spin_lock_irqsave(&inject_lock, flags);
>>  	while ((bus_ops = pci_bus_ops_pop())) {
>>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
>>  		kfree(bus_ops);
>>  	}
>>  	
>> -	clean_untracked_pci_aer_ops();
>> -
>> -	spin_lock_irqsave(&inject_lock, flags);
>>  	list_for_each_entry_safe(err, err_next, &einjected, list) {
>>  		list_del(&err->list);
>>  		kfree(err);
> 
> This may trigger a AB BA dead lock.  In aer_inject_exit, the lock
> sequence is:
> 
> inject_lock -> pci_lock
> 
> In pci config read/write path, the lock sequence is:
> 
> pci_lock -> inject_lock
> 
> With lockdep enabled, you may found warning on that.

OK, I will carry out a detailed test with lockdep enabled, and try to improve this patch.
Thanks for review and comments!

------
Thanks
Yijing

> 
> Best Regards,
> Huang YIng
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing

