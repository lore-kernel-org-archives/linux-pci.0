Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31714 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298Ab2IUGPp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Sep 2012 02:15:45 -0400
Message-ID: <1348208142.23395.28.camel@yhuang-dev>
Subject: Re: [PATCH v4 3/5] PCI/AER: clean all untracked pci_ops_aer when
 rmmod aer_inject
From: Huang Ying <ying.huang@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Gong <gong.chen@linux.intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Date: Fri, 21 Sep 2012 14:15:42 +0800
In-Reply-To: <505BFF8A.2080404@huawei.com>
References: <1348199056-7696-1-git-send-email-wangyijing@huawei.com>
	  <1348199056-7696-4-git-send-email-wangyijing@huawei.com>
	 <1348204383.23395.22.camel@yhuang-dev> <505BFF8A.2080404@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2012-09-21 at 13:47 +0800, Yijing Wang wrote:
> On 2012/9/21 13:13, Huang Ying wrote:
> > On Fri, 2012-09-21 at 11:44 +0800, Yijing Wang wrote:
> >> When we do hot plug for pci devices that were injected aer errors, some newly created child buses'
> >> pci_ops will be assigned to pci_ops_aer. Aer_inject module will not track these pci_ops_aer(not
> >> list in pci_bus_ops_list),so we should clean all of these when rmmod aer_inject module.
> >>
> >> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> >> Signed-off-by: Huang Ying <ying.huang@intel.com>

Please remove my signed-off.

> >> ---
> >>  drivers/pci/pcie/aer/aer_inject.c |   24 ++++++++++++++++++++++++
> >>  1 files changed, 24 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
> >> index 0123120..e04cf24 100644
> >> --- a/drivers/pci/pcie/aer/aer_inject.c
> >> +++ b/drivers/pci/pcie/aer/aer_inject.c
> >> @@ -299,6 +299,29 @@ static void pci_bus_ops_init(struct pci_bus_ops *bus_ops,
> >>  	bus_ops->ops = ops;
> >>  }
> >>  
> >> +static void pci_clean_child_aer_ops(struct pci_bus *bus)
> >> +{
> >> +	struct pci_bus *child;
> >> +
> >> +	list_for_each_entry(child, &bus->children, node) {
> >> +		if (child->ops == &pci_ops_aer)
> >> +			pci_bus_set_ops(child, bus->ops);
> >> +		pci_clean_child_aer_ops(child);
> >> +	}
> >> +}
> >> +
> >> +/* find pci_ops_aer from root bus, and replace it by parent bus's pci_ops.
> >> + * pci_ops of root bus won't be pci_ops_aer here*/
> >> +static void clean_untracked_pci_ops_aer(void)
> >> +{
> >> +	struct pci_bus_ops *bus_ops;
> >> +
> >> +	list_for_each_entry(bus_ops, &pci_bus_ops_list, list) {
> >> +		if (pci_is_root_bus(bus_ops->bus))
> > 
> > Why do cleanup only for root bus?
> > 
> 
> Because the bus with untracked pci_ops_aer always is the child bus of the root bus
> whose pci_ops_aer is tracked in pci_bus_ops_list. So here only do cleanup for root bus to
> avoid unnecessary pci_clean_child_aer_ops() called.
> eg.
> If inject aer errors into 0000:46:00.0, so the pci_ops of bus 0000:40 and bus 0000:46 will be assign to pci_ops_aer
> hot remove and hot add 0000:46:00.0, so newly created bus 0000:47 0000:48 and 0000:49 have untracked pci_ops_aer;
> In this case 0000:40 and 0000:46 are tracked in pci_bus_ops_list, but 0000:47 0000:48 and 0000:49 are not.
> So when we clean untracked pci_ops_aer, I think only cleanup root bus's child bus is enough. cleanup bus 0000:46's child bus
> is unnecessary.
> 
>  |           +-07.0-[0000:46-49]----00.0-[0000:47-49]--+-02.0-[0000:48]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
>  |           |                                         |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection
>  |           |                                         \-04.0-[0000:49]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
>  |           |                                                           \-00.1  Intel Corporation 82576 Gigabit Network Connection

I see.

Reviewed-by: Huang Ying <ying.huang@intel.com>

Best Regards,
Huang Ying

> Thanks
> Yijing
> 
> 
> > Best Regards,
> > Huang Ying
> > 
> >> +			pci_clean_child_aer_ops(bus_ops->bus);
> >> +	}
> >> +}
> >> +
> >>  static int pci_bus_set_aer_ops(struct pci_bus *bus)
> >>  {
> >>  	struct pci_ops *ops;
> >> @@ -560,6 +583,7 @@ static void __exit aer_inject_exit(void)
> >>  	while ((bus_ops = pci_bus_ops_get(bus_ops)))
> >>  		pci_bus_set_ops(bus_ops->bus, bus_ops->ops);
> >>  
> >> +	clean_untracked_pci_ops_aer();
> >>  	while ((bus_ops = pci_bus_ops_pop()))
> >>  		kfree(bus_ops);
> >>  
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > .
> > 
> 
> 


