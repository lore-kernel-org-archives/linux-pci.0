Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:24519 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab2IMK44 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2012 06:56:56 -0400
Message-ID: <5051BB6C.8020002@huawei.com>
Date: Thu, 13 Sep 2012 18:54:36 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI/AER: clean all untracked pci_ops_aer when
 rmmod aer_inject
References: <1347453225-7704-1-git-send-email-wangyijing@huawei.com>  <1347453225-7704-2-git-send-email-wangyijing@huawei.com> <1347500602.30040.142.camel@yhuang-dev>
In-Reply-To: <1347500602.30040.142.camel@yhuang-dev>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/9/13 9:43, Huang Ying wrote:
> On Wed, 2012-09-12 at 20:33 +0800, Yijing Wang wrote:
>> Since hot plug for pci devices while doing aer inject, some newly created child buses'
>> pci_ops will be assigned to pci_ops_aer. Aer_inject does not track these pci_ops_aer(not
>> list in pci_bus_ops_list),we should clean all of these when rmmod aer_inject module.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  drivers/pci/pcie/aer/aer_inject.c |   32 ++++++++++++++++++++++++++++++++
>>  1 files changed, 32 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
>> index 0816483..9d195ae 100644
>> --- a/drivers/pci/pcie/aer/aer_inject.c
>> +++ b/drivers/pci/pcie/aer/aer_inject.c
>> @@ -283,6 +283,28 @@ static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
>>  	bus_ops->ops = ops;
>>  }
>>  
>> +static void pci_clean_child_aer_ops(struct pci_bus *bus)
>> +{
>> +	struct pci_bus *child;
>> +
>> +	list_for_each_entry(child, &bus->children, node) {
>> +		if (child->ops == &pci_ops_aer)
>> +			pci_bus_set_ops(child, bus->ops);
>> +		pci_clean_child_aer_ops(child);
>> +	}
>> +}
>> +
>> +/* find pci_ops_aer from root bus, and replace it by parent bus's pci_ops.
>> + * pci_ops of root bus won't be pci_ops_aer here*/
> 
> Why scan all pci buses?  Is it possible just to check buses in
> pci_bus_ops_list.
> 

Hi Huang Ying,
   Some buses' pci_ops_aer may be not assigned by pci_bus_set_aer_ops() function,
As the first patch [PATCH v2 1/4] said. Some newly created buses' pci_ops assigned to
pci_ops_aer because their parent just doing aer inject, parent bus's pci_ops was pci_ops_aer.
So when we rmmod aer_inject module, these buses' pci_ops_aer will be invalid.

1、Tracked pci_ops_aer will be cleaned and pci_ops will reassign to their original pci_ops saved in pci_bus_ops_list.
2、Un-tracked pci_ops_aer won't be cleaned.so we need to fix it.

> Best Regards,
> Huang Ying
> 
>> +static void clean_untracked_pci_ops_aer(void)
>> +{
>> +	struct pci_bus *bus = NULL;
>> +
>> +	while ((bus = pci_find_next_bus(bus)) != NULL)
>> +		pci_clean_child_aer_ops(bus);
>> +}
>> +
>> +
>>  static int pci_bus_set_aer_ops(struct pci_bus *bus)
>>  {
>>  	struct pci_ops *ops;
>> @@ -546,6 +568,8 @@ static void __exit aer_inject_exit(void)
>>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
>>  		kfree(bus_ops);
>>  	}
>> +
>> +	clean_untracked_pci_aer_ops();
>>  
>>  	spin_lock_irqsave(&inject_lock, flags);
>>  	list_for_each_entry_safe(err, err_next, &einjected, list) {
>> @@ -553,6 +577,14 @@ static void __exit aer_inject_exit(void)
>>  		kfree(err);
>>  	}
>>  	spin_unlock_irqrestore(&inject_lock, flags);
>> +
>> +	/* Inject aer errors and hotplug the same pcie device
>> +	 * maybe assign some newly created buses' pci_ops pci_ops_aer.
>> +	 * Since these pci_ops_aer are not tracked in pci_bus_ops_list,
>> +	 * we need to find and clean untracked pci_ops_aer before aer_inject
>> +	 * module exit
>> +	 */
>> +	clean_untracked_pci_ops_aer();
>>  }
>>  
>>  module_init(aer_inject_init);
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing

