Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alln-iport-2.cisco.com ([173.37.142.89]:28664 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdI1Xqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2017 19:46:46 -0400
Date: Thu, 28 Sep 2017 16:46:23 -0700
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: Sinan Kaya <okaya@codeaurora.org>
CC: <benve@cisco.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jlbec@evilplan.org>, <hch@lst.de>, <mingo@redhat.com>,
        <peterz@infradead.org>
Subject: Re: [PATCH 3/4] pci aer: fix deadlock in do_recovery
In-Reply-To: <2dc437fe-2ab4-23e3-44f3-f06feaf88d86@codeaurora.org>
Message-ID: <alpine.LNX.2.20.1709281624330.24635@cae-iprp-alln-lb.cisco.com>
References: <20170927214220.41216-1-gvaradar@cisco.com> <20170927214220.41216-4-gvaradar@cisco.com> <2dc437fe-2ab4-23e3-44f3-f06feaf88d86@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Sep 2017, Sinan Kaya wrote:

> On 9/27/2017 5:42 PM, Govindarajulu Varadarajan wrote:
>> CPU0					CPU1
>> ---------------------------------------------------------------------
>> __driver_attach()
>> device_lock(&dev->mutex) <--- device mutex lock here
>> driver_probe_device()
>> pci_enable_sriov()
>> pci_iov_add_virtfn()
>> pci_device_add()
>> 					aer_isr()		<--- pci aer error
>> 					do_recovery()
>> 					broadcast_error_message()
>> 					pci_walk_bus()
>> 					down_read(&pci_bus_sem) <--- rd sem
>
> How about releasing the device_lock here on CPU0?>

pci_device_add() is called by driver's pci probe function. device_lock(dev)
should be held before calling pci driver probe function.

> or in other words keep device_lock as short as possible?

The problem is not the duration device_lock is held. It is the order two locks
are aquired. We cannot control or implement a restriction that during
device_lock() is held, driver probe should not call pci function which aquires
pci_bus_sem. And in case of pci aer, aer handler needs to call driver err_handler()
for which we need to hold device_lock() before calling err_handler(). In order
to find all the devices on a pci bus, we should hold pci_bus_sem to do
pci_walk_bus().

>> down_write(&pci_bus_sem) <-- stuck on wr sem
>> 					report_error_detected()
>> 					device_lock(&dev->mutex)<--- DEAD LOCK
