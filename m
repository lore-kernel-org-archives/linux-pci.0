Return-Path: <wangyijing@huawei.com>
Return-Path: <wangyijing@huawei.com>
Subject: Re: [PATCH] PCI: release pci_host_bridge resource after remove root
 bus
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1466682138-25281-1-git-send-email-wangyijing@huawei.com>
 <20160822172821.GG18628@localhost> <57BBB383.50503@huawei.com>
 <20160824213921.GH23914@localhost>
CC: <bhelgaas@google.com>, <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
From: wangyijing <wangyijing@huawei.com>
Message-ID: <57BEA5D7.6090007@huawei.com>
Date: Thu, 25 Aug 2016 16:01:27 +0800
MIME-Version: 1.0
In-Reply-To: <20160824213921.GH23914@localhost>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

>>>> 1. For pci devices, we would release their resources in
>>>>    pci_destroy_dev() regardless of pci device refcount.
>>>> 2. When we try to remove pci root bus, there is no devices
>>>>    need to use the pci_host_bridge resources again, release
>>>>    pci_host_bridge resources is safe.
>>>> 3. In some cases, users woule make mistake, for example,
>>>>    user get a pci device(increase refcount), but forget to
>>>>    put this device, then if we do hotplug pci root bus,
>>>>    it would make all pci devices cannot work after hot add.
>>>
>>> Can you explain this a little more?  Are you talking about a *driver*
>>> that forgets to put the device?
>>
>> Yes, may some pci drivers make a mistake, the refcount control the device object
>> release is fine, but I think move the mem resource release out is better.
> 
> If this is caused by driver bugs, I think we need to fix the driver
> bugs.

Agree, but it's better if pci root bus hotplug could work well regardless of the drviers' bug.
After we stop all pci devices, I think no one could uses the resources again,
it's no need to free host bridge resource until its refcount reach 0.

But this is just my personal opinion :)

> 
> So far all I see here is "it works when I do this."  What we need is
> an argument for "it's correct to do this."  It's certainly possible
> that you're already making that argument and I'm just not
> understanding it.
> 
>>>> I found this issue in the following case:
>>>> 1. I have a raid pci device in my system;
>>>> 2. I mount a disk which connect to this raid.
>>>> 3. hot remove the pci root bus.
>>>> 4. hot add the pci root bus.
>>>> 5. found the resource conflicts for the children pci devices under this root bus.
>>>>
>>>> pci_root_bus increase a refcount at pci_host_bridge.
>>>> pci_root_bus decrease a refcount at pci_host_bridge in
>>>>   release_pcibus_dev() when pci_root_bus device refcount reach 0.
>>>>
>>>> pci_dev increase a refcount at pci_bus in pci_alloc_dev().
>>>> pci_dev decrease a refcount at pci_bus in pci_release_dev()
>>>> when pci_dev refcount reach 0.
>>>>
>>>> If any pci device refcount cannot reach 0, then its pci_bus
>>>> refcount cannot reach 0 too, the result is pci_host_bridge
>>>> refcount cannot reach 0.
>>>
>>> .
>>>
>>
> 
> .
> 
