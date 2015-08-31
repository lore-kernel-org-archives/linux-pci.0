Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:6734 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbbHaBZA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 30 Aug 2015 21:25:00 -0400
Subject: Re: [PATCH] PCI/ASPM: Don't remove pcie_link_state until we stop the
 last device
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1438229360-370-1-git-send-email-wangyijing@huawei.com>
 <20150829122020.GD27890@google.com>
CC: <linux-pci@vger.kernel.org>
From: wangyijing <wangyijing@huawei.com>
Message-ID: <55E3ACE8.20002@huawei.com>
Date: Mon, 31 Aug 2015 09:24:56 +0800
MIME-Version: 1.0
In-Reply-To: <20150829122020.GD27890@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



在 2015/8/29 20:20, Bjorn Helgaas 写道:
> Hi Yijing,
> 
> On Thu, Jul 30, 2015 at 12:09:20PM +0800, Yijing Wang wrote:
>> Now we stop the pci_bus->devices in reverse order, but in
>> pcie_aspm_exit_link_state(), we only would do something when
>> the device is the last one.
>>
>> void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>> {
>> 	...
>> 	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
> 
> Ugh.  This was caused by a confusion between two different meanings of
> "last":
> 
>   1) the element at the end of the list, and
>   2) the only remaining element in the list
> 
> 3419c75e15f8 ("PCI: properly clean up ASPM link state on device remove"),
> which added this line, clearly intended the second, but list_is_last()
> implements the first.
> 
> But that's a trivial problem.  I think the real problem is that the way we
> manage ASPM link_state is a complete disaster.  I want to make steps toward
> cleaning that up rather than apply band-aids to a broken design.
> 
> I struggled to understand this, so I'm going to ramble a bit to see if I
> understand the problem correctly.  Your hierarchy is this:
> 
>   b7:02.0 bridge to [bus bb-bd]  Downstream Port; ASPM on Link to bus bb
>   bb:00.0 bridge to [bus bc-bd]  Switch Upstream Port; no ASPM
>   bb:00.1 endpoint
>   bb:00.2 endpoint
>   bb:00.3 endpoint
>   bb:00.4 endpoint
>   bc:01.0 bridge to [bus bd]     Switch Downstream Port; ASPM on Link to bus bd
>   bd:00.0 endpoint
> 
> There are only two Links in this picture:
> 
>   1) from b7:02.0 to bb:00.0
>   2) from bc:01.0 to bd:00.0
> 
> Those are the two Links where ASPM is important.  Bus bc is the switch's
> internal bus, so the connection from bb:00.0 to bc:01.0 is not a Link and
> ASPM is not applicable.
> 
> Both ends of the Link participate in ASPM, but we allocate ASPM link_state
> only for the component on the *upstream* end of a Link.  We do the
> allocation during enumeration, like this:
> 
>   pcie_aspm_init_link_state(pdev=b7:02.0)
>     alloc_pcie_link_state(pdev=b7:02.0)
>       link = kzalloc(...)
>       link->pdev = pdev                       # b7:02.0
>       pdev->link_state = link                 # alloc link_state for link #1
> 
>   pcie_aspm_init_link_state(pdev=bc:01.0)
>     alloc_pcie_link_state(pdev=bc:01.0)
>       link = kzalloc(...)
>       link->pdev = pdev                       # bc:01.0
>       link->parent = pdev->bus->parent->self->link_state      # b7:02.0 link_state
>       pdev->link_state = link                 # alloc link_state for link #2
> 
> The allocation path makes sense, at least in the sense that we allocate
> link_state for device X when we enumerate device X.  Now we remove the tree
> rooted at b7:02.0:
> 
>   pci_stop_bus_device(pdev=b7:02.0)
>     pci_stop_bus_device(pdev=bb:00.4)         # iterate in reverse
>       pci_stop_dev(pdev=bb:00.4)
>         pcie_aspm_exit_link_state(pdev=bb:00.4)
>           parent = pdev->bus->self            # parent=b7:02.0
>           link = parent->link_state
>           free_link_state(link)               # b7:02.0 link_state
>             link->pdev->link_state = NULL
>   A         kfree(link)                       # free link_state for #1
>     pci_stop_bus_device(pdev=bb:00.3)
>       pci_stop_dev(pdev=bb:00.3)
>         pcie_aspm_exit_link_state(pdev=bb:00.3)
>           parent = pdev->bus->self            # parent=b7:02.0
>           return                              # parent->link_state == NULL
>     ...
>     pci_stop_bus_device(pdev=bb:00.0)
>       pci_stop_bus_device(pdev=bc:01.0)
>         pci_stop_bus_device(pdev=bd:00.0)
>           pci_stop_dev(pdev=bd:00.0)
>             pcie_aspm_exit_link_state(pdev=bd:00.0)
>               parent = pdev->bus->self        # parent=bc:01.0
>               link = parent->link_state       # bc:01.0 link_state
>               parent_link = link->parent      # b7:02.0 link_state
>               free_link_state(link)           # bc:01.0 link_state
>   B             kfree(link)                   # free link_state for #2
>   C           pcie_config_aspm_path(b7:02.0 link_state)   # use link_state for #1
> 
> At "C", we try to use the b7:02.0 link_state, which we've already
> deallocated at "A", so this is a "use-after-free" problem.

Yes, I agree with you.


> 
> What seems wrong to me is that when we're removing device X, we free the
> link_state for a *parent* of X.  I think the code would be much simpler and

What I am worried about here is if we hot remove a endpoint device here, and leave
the parent device, so we don't call pci_aspm_exit_link_state() for this link anymore ?

                  pcie link
downstream port ---------- endpoint device


> easier to get right if we freed the link_state for X when we remove X.
> 
> Can you look at fixing the problem that way?

I'm sorry, I don't have the platform now, this issue was found in product department, and they moved
the platform away.

> 
>> 		goto out;
>> 	...
>> }
>>
>> So if we have the following pcie tree, system may crash.
>>
>> [b7-bd]--+-02.0-[bb-bd]--+-00.0-[bc-bd]----01.0-[bd]----00.0  PLX Technology, Inc. Device 0002
>>                          +-00.1  PLX Technology, Inc. Device 0002
>>                          +-00.2  PLX Technology, Inc. Device 0002
>>                          +-00.3  PLX Technology, Inc. Device 0002
...
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: stable@vger.kernel.org #3.4+
> 
> I need a clue about why you picked v3.4 here.  Is it because ac205b7bb72f
> ("PCI: make sriov work with hotplug remove") appeared in v3.4?

Actually, this issue was found at v3.4 stable kernel, which was introduced in
3419c75e15f8 ("PCI: properly clean up ASPM link state on device remove") I think.

Thanks!
Yijing.


> 
> Bjorn
> 
>> ---
>>  drivers/pci/pcie/aspm.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 317e355..c81f549 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -648,7 +648,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>  	 * All PCIe functions are in one slot, remove one function will remove
>>  	 * the whole slot, so just wait until we are the last function left.
>>  	 */
>> -	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
>> +	if (!(pdev == list_first_entry(&parent->subordinate->devices,
>> +					struct pci_dev, bus_list)))
>>  		goto out;
>>  
>>  	link = parent->link_state;
>> -- 
>> 1.7.1
>>
> 
> .
> 

