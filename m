Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alln-iport-4.cisco.com ([173.37.142.91]:19850 "EHLO
        alln-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdI3GAr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2017 02:00:47 -0400
Date: Fri, 29 Sep 2017 23:00:39 -0700
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: Sinan Kaya <okaya@codeaurora.org>
CC: <benve@cisco.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jlbec@evilplan.org>, <hch@lst.de>, <mingo@redhat.com>,
        <peterz@infradead.org>
Subject: Re: [PATCH 3/4] pci aer: fix deadlock in do_recovery
In-Reply-To: <0a2a41c5-2872-fdb6-8ad2-97b0b6dc69b1@codeaurora.org>
Message-ID: <alpine.LNX.2.20.1709292250520.24635@cae-iprp-alln-lb.cisco.com>
References: <20170927214220.41216-1-gvaradar@cisco.com> <20170927214220.41216-4-gvaradar@cisco.com> <2dc437fe-2ab4-23e3-44f3-f06feaf88d86@codeaurora.org> <alpine.LNX.2.20.1709281624330.24635@cae-iprp-alln-lb.cisco.com>
 <0a2a41c5-2872-fdb6-8ad2-97b0b6dc69b1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 29 Sep 2017, Sinan Kaya wrote:

> On 9/28/2017 7:46 PM, Govindarajulu Varadarajan wrote:
>>> How about releasing the device_lock here on CPU0?>
>>
>> pci_device_add() is called by driver's pci probe function. device_lock(dev)
>> should be held before calling pci driver probe function.
>
> I see. The goal of the lock held here is to protect probe() operation from
> being disrupted. I also don't think we can change this.
>
>>
>>> or in other words keep device_lock as short as possible?
>>
>> The problem is not the duration device_lock is held. It is the order two locks
>> are aquired. We cannot control or implement a restriction that during
>> device_lock() is held, driver probe should not call pci function which aquires
>> pci_bus_sem. And in case of pci aer, aer handler needs to call driver err_handler()
>> for which we need to hold device_lock() before calling err_handler(). In order
>> to find all the devices on a pci bus, we should hold pci_bus_sem to do
>> pci_walk_bus().
>
> I was reacting to this to see if there is a better way to do this.
>
> "Only fix I could think of is to lock &pci_bus_sem and try locking all
> device->mutex under that pci_bus. If it fails, unlock all device->mutex
> and &pci_bus_sem and try again."
>
> How about gracefully returning from report_error_detected() when we cannot obtain
> the device_lock() by replacing it with device_trylock()?
>

Some of the devices may miss the error reporthing. I have sent V2 where we do
a pci_bus_walk and adds all the devices to a list. After unlocking (up_read)
&pci_bus_sem, we go through the list and call err_handler of the devices with
devic_lock() held. This way, we dont try to hold both locks at same time and
we dont hold 50+ device_lock. Let me know if this approach is better.

> aer_pci_walk_bus() can still poll like you did until it gets the lock. At least,
> we don't get to introduce a new API, new lock semantics and code refactoring.
> __pci_bus_trylock() looked very powerful and also dangerously flexible to
> introduce new bugs to me.
>
> For instance, you called it like this.
>
> +		down_read(&pci_bus_sem);
> +		locked = __pci_bus_trylock(bus, pci_device_trylock,
> +					   pci_device_unlock);
>
> pci_bus_trylock() would obtain device + cfg locks whereas pci_device_trylock() only
> obtains the device lock. Can it race against cfg lock? It depends on the caller.
> Very subtle difference.
>
> -- 
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
>
