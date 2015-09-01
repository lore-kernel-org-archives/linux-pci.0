Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:61982 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbIAA7q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Aug 2015 20:59:46 -0400
Subject: Re: [PATCH] PCI/ASPM: Don't remove pcie_link_state until we stop the
 last device
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1438229360-370-1-git-send-email-wangyijing@huawei.com>
 <20150829122020.GD27890@google.com> <55E3ACE8.20002@huawei.com>
 <20150831135601.GC647@google.com>
CC: <linux-pci@vger.kernel.org>
From: wangyijing <wangyijing@huawei.com>
Message-ID: <55E4F872.3040504@huawei.com>
Date: Tue, 1 Sep 2015 08:59:30 +0800
MIME-Version: 1.0
In-Reply-To: <20150831135601.GC647@google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



在 2015/8/31 21:56, Bjorn Helgaas 写道:
> On Mon, Aug 31, 2015 at 09:24:56AM +0800, wangyijing wrote:
>> 在 2015/8/29 20:20, Bjorn Helgaas 写道:
>>> On Thu, Jul 30, 2015 at 12:09:20PM +0800, Yijing Wang wrote:
>>>> Now we stop the pci_bus->devices in reverse order, but in
>>>> pcie_aspm_exit_link_state(), we only would do something when
>>>> the device is the last one.
>>>>
>>>> void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>>>> {
>>>> 	...
>>>> 	if (!list_is_last(&pdev->bus_list, &parent->subordinate->devices))
>> ...
> 
>>> What seems wrong to me is that when we're removing device X, we free the
>>> link_state for a *parent* of X.  I think the code would be much simpler and
>>
>> What I am worried about here is if we hot remove a endpoint device here, and leave
>> the parent device, so we don't call pci_aspm_exit_link_state() for this link anymore ?
>>
>>                   pcie link
>> downstream port ---------- endpoint device
> 
> If we remove the endpoint and leave the parent, we do call
> pcie_aspm_exit_link_state() for the endpoint.  I'm proposing to change
> that path so that when the endpoint is removed, we do whatever is
> necessary for changing the ASPM configuration on the link, but leave
> the ASPM structure allocated, since the parent still exists.
> 
> Today we allocate link_state only when a port has a downstream link
> *and* there's a device on the other end of the link.  I'm proposing
> that we allocate link_state even if there's no downstream device.
> 
> Then the alloc/free path is always tied directly to the parent.  We
> can still change ASPM configuration as needed when downstream devices
> are added or removed.  It's not a trivial change, but it seems
> possible.
> 

Basically, I agree with you, but it's not a trival change, and now
we have no platform in hand, so I think it's better to leave it until we have
platform to reproduce it.


>>> easier to get right if we freed the link_state for X when we remove X.
>>>
>>> Can you look at fixing the problem that way?
>>
>> I'm sorry, I don't have the platform now, this issue was found in product department, and they moved
>> the platform away.
> 
> OK.  I'll drop this patch for now.  I definitely agree this is a
> problem, but the fact that you don't have the platform any more
> doesn't mean we need to throw in a band-aid instead of designing a
> better solution.

OK.

> 
> This problem should be pretty easy to reproduce on any platform,
> possibly with a little bit of scaffolding to tweak the topology.
> 
>>>> 		goto out;
>>>> 	...
>>>> }
>>>>
>>>> So if we have the following pcie tree, system may crash.
>>>>
>>>> [b7-bd]--+-02.0-[bb-bd]--+-00.0-[bc-bd]----01.0-[bd]----00.0  PLX Technology, Inc. Device 0002
>>>>                          +-00.1  PLX Technology, Inc. Device 0002
>>>>                          +-00.2  PLX Technology, Inc. Device 0002
>>>>                          +-00.3  PLX Technology, Inc. Device 0002
>> ...
>>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>>> CC: stable@vger.kernel.org #3.4+
>>>
>>> I need a clue about why you picked v3.4 here.  Is it because ac205b7bb72f
>>> ("PCI: make sriov work with hotplug remove") appeared in v3.4?
>>
>> Actually, this issue was found at v3.4 stable kernel, which was introduced in
>> 3419c75e15f8 ("PCI: properly clean up ASPM link state on device remove") I think.
> 
> Did you bisect to this or figure it out by analysis?  It's good to
> mention the actual commit that broke it so people backporting can
> figure out if they need the fix.

By analysis, if I have the platform agagin, I would try to bisect it.

Thanks!
Yijing.


> 
> Bjorn
> 
> 

