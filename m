Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zimbra1.kalray.eu ([92.103.151.219]:40052 "EHLO
        zimbra1.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeCUMKd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2018 08:10:33 -0400
Date: Wed, 21 Mar 2018 13:10:31 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Ming Lei <ming.lei@redhat.com>
Cc: keith busch <keith.busch@intel.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Message-ID: <464125757.5843583.1521634231341.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20180321115037.GA26083@ming.t460p>
References: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu> <20180321115037.GA26083@ming.t460p>
Subject: Re: [RFC PATCH] nvme: avoid race-conditions when enabling devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Wed, Mar 21, 2018 at 12:00:49PM +0100, Marta Rybczynska wrote:
>> NVMe driver uses threads for the work at device reset, including enabling
>> the PCIe device. When multiple NVMe devices are initialized, their reset
>> works may be scheduled in parallel. Then pci_enable_device_mem can be
>> called in parallel on multiple cores.
>> 
>> This causes a loop of enabling of all upstream bridges in
>> pci_enable_bridge(). pci_enable_bridge() causes multiple operations
>> including __pci_set_master and architecture-specific functions that
>> call ones like and pci_enable_resources(). Both __pci_set_master()
>> and pci_enable_resources() read PCI_COMMAND field in the PCIe space
>> and change it. This is done as read/modify/write.
>> 
>> Imagine that the PCIe tree looks like:
>> A - B - switch -  C - D
>>                \- E - F
>> 
>> D and F are two NVMe disks and all devices from B are not enabled and bus
>> mastering is not set. If their reset work are scheduled in parallel the two
>> modifications of PCI_COMMAND may happen in parallel without locking and the
>> system may end up with the part of PCIe tree not enabled.
> 
> Then looks serialized reset should be used, and I did see the commit
> 79c48ccf2fe ("nvme-pci: serialize pci resets") fixes issue of 'failed
> to mark controller state' in reset stress test.
> 
> But that commit only covers case of PCI reset from sysfs attribute, and
> maybe other cases need to be dealt with in similar way too.
> 

It seems to me that the serialized reset works for multiple resets of the
same device, doesn't it? Our problem is linked to resets of different devices
that share the same PCIe tree.

You're right that the problem we face might also come with manual resets
under certain conditions (I think that all devices in a subtree would need
to be disabled).

Thanks,
Marta
