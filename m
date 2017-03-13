Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:38025 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933046AbdCMC0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Mar 2017 22:26:25 -0400
Subject: Re: [PATCH v2 3/5] PCI: rockchip: add remove() support
To: Brian Norris <briannorris@chromium.org>
References: <20170310024617.67303-1-briannorris@chromium.org>
 <20170310024617.67303-3-briannorris@chromium.org>
 <de4d1e8a-c971-1f4d-2996-883341d287b3@rock-chips.com>
 <5cec190e-4eee-fc55-7039-2336ba5253f3@rock-chips.com>
 <20170310194011.GA16352@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e41ab95e-9f65-2822-1ec2-a02a4766d53d@rock-chips.com>
Date: Mon, 13 Mar 2017 10:26:12 +0800
MIME-Version: 1.0
In-Reply-To: <20170310194011.GA16352@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/3/11 3:40, Brian Norris wrote:
> On Fri, Mar 10, 2017 at 12:20:54PM +0800, Shawn Lin wrote:
>> On 2017/3/10 11:22, Shawn Lin wrote:
>>> On 2017/3/10 10:46, Brian Norris wrote:
>>>> Currently, if we try to unbind the platform device, the remove will
>>>> succeed, but the removal won't undo most of the registration, leaving
>>>> partially-configured PCI devices in the system.
>>>>
>>>> This allows, for example, a simple 'lspci' to crash the system, as it
>>>> will try to touch the freed (via devm_*) driver structures.
>>>>
>>>> So let's implement device remove().
>>>>
>>>
>>> As this patchset seems to be merged together so I think the following
>>> warning will be ok? if my git-am robot only pick your patch 1->compile->
>>> patch 2->compile->patch 3 then
>>>
>>> drivers/pci/host/pcie-rockchip.c: In function 'rockchip_pcie_remove':
>>> drivers/pci/host/pcie-rockchip.c:1435:2: error: implicit declaration of
>>> function 'pci_unmap_iospace' [-Werror=implicit-function-declaration]
>>>  pci_unmap_iospace(rockchip->io);
>
> I'm not sure what you're doing here, but when I test patches 1-3, this
> all compiles fine for me. Maybe you're testing an old kernel that does
> not have pci_unmap_iospace()?
>
>>> but I guess you may need to move your patch 4 ahead of patch 3?
>
> No. Patch 4 is only necessary for building modules that can use those
> functions; your PCIe driver doesn't build as a module until patch 5.
>
> I'm going to guess that you're testing your hacky vendor tree, and not
> pure upstream.
>
>> Well, I am not sure if something is wrong here.
>>
>> But when booting up the system for the first time, we got
>> [    0.527263] PCI host bridge /pcie@f8000000 ranges:
>> [    0.527293]   MEM 0xfa000000..0xfa5fffff -> 0xfa000000
>> [    0.527308]    IO 0xfa600000..0xfa6fffff -> 0xfa600000
>> [    0.527544] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:0
>>
>> so the hierarchy(lspci -t) looks like:
>> lspci -t
>> -[0000:00]---00.0-[01]----00.0
>>
>> and lspci
>> 0000:00:00.0 Class 0604: Device 1d87:0100
>> 0001:01:00.0 Class 0108: Device 8086:f1a5 (rev 03)
>>
>> but if I did unbind and bind, the bus number is different.
>>
>> lspci
>> 0001:00:00.0 Class 0604: Device 1d87:0100
>> 0001:01:00.0 Class 0108: Device 8086:f1a5 (rev 03)
>>
>> lspci -t
>> -+-[0001:00]---00.0-[01]----00.0
>>  \-[0000:00]-
>>
>> This hierarchy looks wrong to me.
>
> That looks like it's somewhat an artifact of lspci's tree view, which
> manufactures the 0000:00 root.
>
> I might comment on your "RFT" patch too but... it does touch on the
> problem (that the domain numbers don't get reused), but I don't think
> it's a good idea. What if we add another domain after the Rockchip
> PCIe domain? You'll clobber all the domain allocations the first time
> you remove the Rockchip one. Instead, if we want to actually stabilize
> this indexing across hotplug, we need the core PCI code to take care of
> this for us. e.g., maybe use one of the existing indexing ID mechanisms
> in the kernel, like IDR?
>
> Anyway, other than the bad lspci -t output, is there any actual bug
> here? I didn't think the domain numbers were actually so special.
>

No, it works fine. But I am going to guess
(1) is there any code or user-space binary care about the domain
numbers, so it will complain about this?
(2) if there are two doamins for PCI hierarchy, so when I unbind
and bind one of them continuously, is it possible that finally they
will share the same domain number as the domain number would be
overflow ? But actually they didn't share the same domain. :)

I just thought we should fix the domain number here by adding
"linux,pci-domain = <0>" for rk3399.dtsi, which seems more wise
to me now. Does it make sense to you?


> Brian
>
>
>


-- 
Best Regards
Shawn Lin
