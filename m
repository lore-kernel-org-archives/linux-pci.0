Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:34569 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab2ISGNI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2012 02:13:08 -0400
Message-ID: <50596209.5060201@huawei.com>
Date: Wed, 19 Sep 2012 14:11:21 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/6] PCI/AER: introduce pci_bus_ops_free to free pci_bus_ops
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>  <1348022442-7816-6-git-send-email-wangyijing@huawei.com> <1348034627.8212.136.camel@yhuang-dev>
In-Reply-To: <1348034627.8212.136.camel@yhuang-dev>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/9/19 14:03, Huang Ying wrote:
> On Wed, 2012-09-19 at 10:40 +0800, Yijing Wang wrote:
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/pcie/aer/aer_inject.c |   14 +++++++++++---
>>  1 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
>> index 0a12ac7..79b611d 100644
>> --- a/drivers/pci/pcie/aer/aer_inject.c
>> +++ b/drivers/pci/pcie/aer/aer_inject.c
>> @@ -162,6 +162,16 @@ static struct pci_bus_ops *pci_bus_ops_pop(void)
>>  	return bus_ops;
>>  }
>>  
>> +static void pci_bus_ops_free(void)
>> +{
>> +	struct pci_bus_ops *bus_ops, *tmp_ops;
>> +
>> +	list_for_each_entry_safe(bus_ops, tmp_ops, &pci_bus_ops_list, list) {
>> +		list_del(&bus_ops->list);
>> +		kfree(bus_ops);
>> +	}
>> +}
> 
> IMHO, this can be inlined into aer_inject_exit
> 
>>  static struct pci_bus_ops *pci_bus_ops_get(struct pci_bus_ops *from)
>>  {
>>  	struct pci_bus_ops *bus_ops = NULL;
>> @@ -641,9 +651,7 @@ static void __exit aer_inject_exit(void)
>>  	 * module exit
>>  	 */
>>  	clean_untracked_pci_ops_aer();
>> -
>> -	while ((bus_ops = pci_bus_ops_pop()))
> 
> You can remove pci_bus_ops_pop now.
> 

OK, I will move pci_bus_ops_free inlined into aer_inject_exit and remove pci_bus_ops_pop in this patch.

> Best Regards,
> Huang Ying
> 
>> -		kfree(bus_ops);
>> +	pci_bus_ops_free();
>>  
>>  	spin_lock_irqsave(&inject_lock, flags);
>>  	list_for_each_entry_safe(err, err_next, &einjected, list) {
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing

