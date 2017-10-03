Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alln-iport-5.cisco.com ([173.37.142.92]:55345 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdJCATj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2017 20:19:39 -0400
Date: Mon, 2 Oct 2017 17:19:31 -0700
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: Sinan Kaya <okaya@codeaurora.org>
CC: <benve@cisco.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jlbec@evilplan.org>, <hch@lst.de>, <mingo@redhat.com>,
        <peterz@infradead.org>
Subject: Re: [PATCH V2] PCI: AER: fix deadlock in do_recovery
In-Reply-To: <a9b14502-4ac6-58dc-89ee-a91354f4d2da@codeaurora.org>
Message-ID: <alpine.LNX.2.20.1710021714260.30867@cae-iprp-alln-lb.cisco.com>
References: <20170930054938.43271-1-gvaradar@cisco.com> <a9b14502-4ac6-58dc-89ee-a91354f4d2da@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 30 Sep 2017, Sinan Kaya wrote:

> On 9/30/2017 1:49 AM, Govindarajulu Varadarajan wrote:
>> This patch does a pci_bus_walk and adds all the devices to a list. After
>> unlocking (up_read) &pci_bus_sem, we go through the list and call
>> err_handler of the devices with devic_lock() held. This way, we dont try
>> to hold both locks at same time.
>
> I do like this approach with some more feedback.
>
> I need a little bit of help here from someone that knows get/put device calls.
>
> I understand get_device() and put_device() are there to increment/decrement
> reference counters. This patch seems to use them as an alternative for device_lock()
> and device_unlock() API.
>

get/put_deivce is not used as an alternative to device_lock() here. We are
incrementing the counter to make sure no one else free the device while they
are in our list. report_error_detected() and other cb will still acquire
device_lock().


> If this is a good assumption, then you can get away with just replacing device_lock()
> with get_device() and device_unlock() with put_device() in the existing code as
> well. Then, you don't need to build a linklist.
