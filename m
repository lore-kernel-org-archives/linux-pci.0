Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdI3Nbj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2017 09:31:39 -0400
Subject: Re: [PATCH V2] PCI: AER: fix deadlock in do_recovery
To: Govindarajulu Varadarajan <gvaradar@cisco.com>, benve@cisco.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org
References: <20170930054938.43271-1-gvaradar@cisco.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a9b14502-4ac6-58dc-89ee-a91354f4d2da@codeaurora.org>
Date: Sat, 30 Sep 2017 09:31:35 -0400
MIME-Version: 1.0
In-Reply-To: <20170930054938.43271-1-gvaradar@cisco.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/30/2017 1:49 AM, Govindarajulu Varadarajan wrote:
> This patch does a pci_bus_walk and adds all the devices to a list. After
> unlocking (up_read) &pci_bus_sem, we go through the list and call
> err_handler of the devices with devic_lock() held. This way, we dont try
> to hold both locks at same time.

I do like this approach with some more feedback.

I need a little bit of help here from someone that knows get/put device calls.

I understand get_device() and put_device() are there to increment/decrement
reference counters. This patch seems to use them as an alternative for device_lock()
and device_unlock() API. 

If this is a good assumption, then you can get away with just replacing device_lock()
with get_device() and device_unlock() with put_device() in the existing code as
well. Then, you don't need to build a linklist.

A nit is your history messages in the commit message belongs to a cover letter.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
