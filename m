Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:31089 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab3HTMXe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2013 08:23:34 -0400
Message-ID: <52135FB3.3090700@huawei.com>
Date: Tue, 20 Aug 2013 20:23:15 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH v5 1/2] PCI: fix the only slot identification in pcie_find_smpss()
References: <1376533135-36708-1-git-send-email-wangyijing@huawei.com> <1376533135-36708-2-git-send-email-wangyijing@huawei.com> <20130816221716.GA25780@google.com> <521187A5.6030002@huawei.com> <CAPoiz9zpovgcnx=DG-g4v7VpA17H5P2EYv1spm7TGLOwO6zYCQ@mail.gmail.com> <CAErSpo7kxfJDrm1QwNrGd4onfKBzUW+jVV-8p14i1yJqkMFobg@mail.gmail.com> <CAErSpo7tf+9NUGT2U5WBcQUtZb9=ZT_4wAjxzhiiWh9n_KEbAA@mail.gmail.com> <CAPoiz9wMo+sr1EWp+fPdwKTBoJpQGjZg-dASRMHAtvPBE+G4Eg@mail.gmail.com> <5212DA84.6070409@huawei.com> <20130820044416.GA22188@google.com>
In-Reply-To: <20130820044416.GA22188@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> 3.                              (hotplug bridge)
>> root port ----Upstream port---->Downstream port A -------->[slot]
>> 				 |
>> 				 |Downstream port B -------->[slot]  ?
>>
>> This topo is common, but DP A is not directly connected to root
>> port, so the original patch can not cover this case. 
> 
> This is a very good observation: only Root Ports and Downstream
> Ports can have slots.  That means the following existing code:
> 
>     if (dev->is_hotplug_bridge &&
>         ((dev->bus->self &&
>           pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))
> 
> doesn't make sense.  "dev->bus->self" is the bridge immediately
> upstream from "dev".  If "dev" is a Port with a slot, it must be
> either a Root Port or a Downstream Port.  A Root Port *has* no
> upstream bridge, and the bridge immediately upstream from a
> Downstream Port is always an Upstream Port.
> 
> So we should just write this instead:
> 
>     if (dev->is_hotplug_bridge &&
>         pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)))
>             *smpss = 0;
> 
> That means we'll set MPS=128 for Downstream Ports leading to
> slots, which is safe for anything we can plug in.

I agree, Jon, what do you think?
And I test this code in my machine, result is ok.


pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  128), Max Read Rq  512
pcieport 0000:40:07.0: PCI-E Max Payload Size set to  256/ 256 (was  256), Max Read Rq  128
pci 0000:46:00.0: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512
pci 0000:46:00.1: PCI-E Max Payload Size set to  256/ 512 (was  256), Max Read Rq  512

> 
> Apparently we don't enforce MPS=128 for Root Ports because we
> assume either (a) there is no peer-to-peer traffic, or (b)
> peer-to-peer traffic is not routed between Root Ports.  I don't
> know if those are valid assumptions, but you're not changing
> anything there, so I guess we can keep them.
> 
> I don't think we should look at the dev->bus->devices list at all
> because that only applies to the current configuration and
> doesn't account for any future hot-plugs.

I think so.

If Jon agree too , I will update this patch.

>  
>> If DP B is
>> not exist. there is only one Downstream port A, like:
> 
>>
>>                                (hotplug bridge)
>> root port ----Upstream port--->Downstream port A -------->[slot]
>>
>> In this case, we can also configure mps after a pcie card
>> inserted into slot, because although the system is running,
>> because root port UP port DP port A and slot are not running.
>> But this case is rare.
> 
>> So, Jon, does your original patch want to cover the case 1 or case 2 ?
>> For case 1, we can remove the list_is_singular() check.
>> For case 2, do you have some example hardware platform ?
>> Or there are other pcie topos not exist here?
>>
>> Thanks!
>> Yijing.
> 
> .
> 


-- 
Thanks!
Yijing

