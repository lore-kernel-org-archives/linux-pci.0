Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:39222 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755314AbdCUDz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2017 23:55:58 -0400
Message-ID: <58D0A433.8050608@rock-chips.com>
Date: Tue, 21 Mar 2017 11:55:31 +0800
From: jeffy <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: don't leak the PCI resource list
References: <20170320224936.28605-1-briannorris@chromium.org> <108a73fe-f186-f9ef-81be-7941f3db9d7f@rock-chips.com> <20170321022127.GA68526@google.com>
In-Reply-To: <20170321022127.GA68526@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi brian,

On 03/21/2017 10:21 AM, Brian Norris wrote:
> On Tue, Mar 21, 2017 at 09:25:16AM +0800, Shawn Lin wrote:
>> On 2017/3/21 6:49, Brian Norris wrote:
>>> This list is local to the probe() function. We should free it up in both
>>> the success case and the error case, but currently we're only freeing it
>>> in the error case (see commit f1d722b607d6 ("PCI: rockchip: Fix
>>> rockchip_pcie_probe() error path to free resource list")).
>>>
>>> Caught by kmemleak, when doing repeated bind/unbind tests.
>>>
>>
>> It doesn't look natural to free it in probe, instead it looks more
>> like we should do the cleanup work when calling .remove
>
> Hmm, I did write this one up pretty quickly, so I might have gotten it a
> bit wrong. It's not clear there's a *real* problem with this patch,
> since the bridge's window list doesn't actually get used much later, but
> I agree this isn't correct.
>
> And actually, I think my patch is a red herring; the leak is still
> there. I notice that the resource list is actually freed in
> pci_release_host_bridge_dev() already anyway.
>
>> I didn't know if there is something that still use this resource
>> , for instance, hotplug? But I noticed it from Bjron's statement[1]
>> that "The struct resource for each host bridge window must live as long
>> as the host bridge itself". So I didn't free it when finishing probe.
>> I guess the proper fix is to do it in pci_remove_root_bus or somewhere
>> of the cleanup code if I undertand it correctly.
>
> That thread is talking about a different issue; in that driver, the
> 'struct resource' is on the stack. That's not good. In our case, it's
> just the resource list head that's on the stack, which is fine. The
> relevant entries get spliced onto a longer-lived list in the end.
>
> But then, we have these to consider for leaks:
>
> (a) the 'resource_entry's allocated in
> of_pci_get_host_bridge_resources() (via pci_add_resource() and
> pci_add_resource_offset())
>
> (b) the 'resource's allocated in
> of_pci_get_host_bridge_resources(), to go with each of the
> 'resource_entry's from (b)
>
> As noted above, I think (a) is actually taken care of (and so my current
> patch is not needed). The problem is only with (b). (I think?)
yes, it looks like there's no way to free resources allocated in 
of_pci_get_host_bridge_resources, expect for the err path: 
kfree(window->res).

i think it's a common issue, which may not get fix in rockchip pci driver.

maybe we should modify of_pci_get_host_bridge_resources, pass the struct 
device to it, and change all kzalloc to devm_kzalloc(also remove the kfree)


>
> I'll double check this all tomorrow.
>
> Brian
>
>> [1]: https://lkml.org/lkml/2017/2/8/802
>>
>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>> ---
>>> drivers/pci/host/pcie-rockchip.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>>> index bd6df7254de4..8087a0698d65 100644
>>> --- a/drivers/pci/host/pcie-rockchip.c
>>> +++ b/drivers/pci/host/pcie-rockchip.c
>>> @@ -1396,6 +1396,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>>> 		goto err_free_res;
>>> 	}
>>> 	rockchip->root_bus = bus;
>>> +	pci_free_resource_list(&res);
>>>
>>> 	pci_bus_size_bridges(bus);
>>> 	pci_bus_assign_resources(bus);
>>>
>>
>
>
>
