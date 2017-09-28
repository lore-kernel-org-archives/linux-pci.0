Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdI1Qrs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2017 12:47:48 -0400
Subject: Re: [PATCH 3/4] pci aer: fix deadlock in do_recovery
To: Govindarajulu Varadarajan <gvaradar@cisco.com>, benve@cisco.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org
References: <20170927214220.41216-1-gvaradar@cisco.com>
 <20170927214220.41216-4-gvaradar@cisco.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2dc437fe-2ab4-23e3-44f3-f06feaf88d86@codeaurora.org>
Date: Thu, 28 Sep 2017 12:47:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170927214220.41216-4-gvaradar@cisco.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/27/2017 5:42 PM, Govindarajulu Varadarajan wrote:
> CPU0					CPU1
> ---------------------------------------------------------------------
> __driver_attach()
> device_lock(&dev->mutex) <--- device mutex lock here
> driver_probe_device()
> pci_enable_sriov()
> pci_iov_add_virtfn()
> pci_device_add()
> 					aer_isr()		<--- pci aer error
> 					do_recovery()
> 					broadcast_error_message()
> 					pci_walk_bus()
> 					down_read(&pci_bus_sem) <--- rd sem

How about releasing the device_lock here on CPU0? or in other words keep
device_lock as short as possible?

> down_write(&pci_bus_sem) <-- stuck on wr sem
> 					report_error_detected()
> 					device_lock(&dev->mutex)<--- DEAD LOCK


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
