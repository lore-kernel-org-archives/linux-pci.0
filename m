Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:53810 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab2ISGhk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2012 02:37:40 -0400
Message-ID: <505967D3.60903@huawei.com>
Date: Wed, 19 Sep 2012 14:36:03 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/6] PCI/AER: clean all untracked pci_ops_aer when rmmod
 aer_inject
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>   <1348022442-7816-4-git-send-email-wangyijing@huawei.com>  <1348034243.8212.134.camel@yhuang-dev> <505961B5.8070108@huawei.com> <1348035521.8212.142.camel@yhuang-dev>
In-Reply-To: <1348035521.8212.142.camel@yhuang-dev>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/9/19 14:18, Huang Ying wrote:
> On Wed, 2012-09-19 at 14:09 +0800, Yijing Wang wrote:
>> On 2012/9/19 13:57, Huang Ying wrote:
>>> On Wed, 2012-09-19 at 10:40 +0800, Yijing Wang wrote:
>>>> Since hot plug for pci devices while doing aer inject, some newly created child buses'
>>>> pci_ops will be assigned to pci_ops_aer. Aer_inject does not track these pci_ops_aer(not
>>>> list in pci_bus_ops_list),we should clean all of these when rmmod aer_inject module.
>>>>
>>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>>> ---
>>>>  drivers/pci/pcie/aer/aer_inject.c |   35 +++++++++++++++++++++++++++++++++++
>>>>  1 files changed, 35 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
>>>> index 442147b..e2400b5 100644
>>>> --- a/drivers/pci/pcie/aer/aer_inject.c
>>>> +++ b/drivers/pci/pcie/aer/aer_inject.c
>>>> @@ -299,6 +299,32 @@ static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
>>>>  	bus_ops->ops = ops;
>>>>  }
>>>>  
>>>> +static void pci_clean_child_aer_ops(struct pci_bus *bus)
>>>> +{
>>>> +	struct pci_bus *child;
>>>> +
>>>> +	list_for_each_entry(child, &bus->children, node) {
>>>> +		if (child->ops == &pci_ops_aer)
>>>> +			pci_bus_set_ops(child, bus->ops);
>>>> +		pci_clean_child_aer_ops(child);
>>>> +	}
>>>
>>> Why not use pci_walk_bus?
>>>
>>
>> I think here walk all child buses is enough, pci_walk_bus will walk all child devices under this bus.
>>
>>>> +}
>>>> +
>>>> +/* find pci_ops_aer from root bus, and replace it by parent bus's pci_ops.
>>>> + * pci_ops of root bus won't be pci_ops_aer here*/
>>>> +static void clean_untracked_pci_ops_aer(void)
>>>> +{
>>>> +	struct pci_bus_ops *bus_ops;
>>>> +
>>>> +	list_for_each_entry(bus_ops, &pci_bus_ops_list, list) {
>>>> +		/* the bus with untracked pci_ops_aer always the
>>>> +		 * child bus of root bus tracked in pci_bus_ops_list
>>>> +		 */
>>>> +		if (pci_is_root_bus(bus_ops->bus))
>>>> +			pci_clean_child_aer_ops(bus_ops->bus);
>>>> +	}
>>>> +}
>>>> +
>>>>  static int pci_bus_set_aer_ops(struct pci_bus *bus)
>>>>  {
>>>>  	struct pci_ops *ops;
>>>> @@ -558,9 +584,18 @@ static void __exit aer_inject_exit(void)
>>>>  
>>>>  	misc_deregister(&aer_inject_device);
>>>>  
>>>> +	/* clean pci_bus_ops tracked in pci_bus_ops_list */
>>>>  	while ((bus_ops = pci_bus_ops_get(bus_ops)))
>>>>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
>>>
>>> Why not do clean here inside loop?
>>>
>>
>> Because I also need these bus_ops to scan untracked pci_ops_aer.
> 
> I mean why not call pci_clean_child_aer_ops() inside loop.
> 

My idea is first clean all pci_ops_aer tracked in pci_bus_ops_list, second clean all untracked pci_ops_aer.
If put pci_clean_child_aer_ops inside loop, when I clean tracked pci_ops_aer for root bus 0, next I will use
bus 0 's pci_ops to clean bus 1 's pci_ops_aer. Actually maybe bus 1 have its own pci_ops_aer tracked in pci_bus_ops_list.
So I think use every bus's own bus_ops to clean pci_ops_aer first is better.

 \-[0000:00]-+-00.0  Intel Corporation 5500 I/O Hub to ESI Port
             +-01.0-[01]--+-00.0  Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet
             |            \-00.1  Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet


> Best Regards,
> Huang Ying
> 
>>>
>>>>  
>>>> +	/* Inject aer errors and hotplug the same pcie device
>>>> +	 * maybe assign some newly created buses' pci_ops pci_ops_aer.
>>>> +	 * Since these pci_ops_aer are not tracked in pci_bus_ops_list,
>>>> +	 * we need to find and clean untracked pci_ops_aer before aer_inject
>>>> +	 * module exit
>>>> +	 */
>>>> +	clean_untracked_pci_ops_aer();
>>>> +
>>>>  	while ((bus_ops = pci_bus_ops_pop()))
>>>>  		kfree(bus_ops);
>>>>  
>>>
>>>
>>>
>>> .
>>>
>>
>>
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing

