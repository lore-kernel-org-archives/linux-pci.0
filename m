Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F91C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 08:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CCB2075E
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 08:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfC0IAV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:00:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbfC0IAV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 04:00:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CA302498761A95BE3B6;
        Wed, 27 Mar 2019 16:00:18 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Mar 2019
 16:00:10 +0800
Subject: Re: Question about Hotplug driver deadlock issue
To:     Lukas Wunner <lukas@wunner.de>
References: <351f898c-f9e9-69e0-b023-cf72e0d7792b@huawei.com>
 <20190326124449.3vdjmescrvswirop@wunner.de>
CC:     <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
From:   Dongdong Liu <liudongdong3@huawei.com>
Message-ID: <6f57df12-07f9-c401-dabf-2b7af0ec5797@huawei.com>
Date:   Wed, 27 Mar 2019 16:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190326124449.3vdjmescrvswirop@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas
Many thanks for your reply.

在 2019/3/26 20:44, Lukas Wunner 写道:
> On Tue, Mar 26, 2019 at 07:43:17PM +0800, Dongdong Liu wrote:
>> Current we met another deadlock issue in hotplug driver. The calltrace is as below.
>> The deadlock triggered by a hotplug event during a sysfs "remove" operation.
>> Any suggestion to fix such deadlock ?
>
> That's a known problem, deadlocks may occur if hotplug ports are
> cascaded.  I came up with a kludge to work around it but withdrew
> the patch:
> https://patchwork.ozlabs.org/patch/930403/

It seems the reason of two deadlock issues are not the same.
This deadlock issue triggered by a hotplug event during a sysfs "remove" operation.
pciehp 0000:00:0c.0:pcie004: Slot(0-1): Card present
pciehp 0000:00:0c.0:pcie004: Slot(0-1): Link Up
echo 1 > 0000\:00\:0c.0/remove

The sysfs "remove" side is:
       remove_store
         pci_stop_and_remove_bus_device_locked
          pci_lock_rescan_remove
          pci_stop_and_remove_bus_device
            ...
            pciehp_remove
              free_irq
                   kthread_stop         # wait for hotplug IRQ handler
          pci_unlock_rescan_remove

The hotplug side is:
         pciehp_ist
            pciehp_handle_presence_or_link_change
          pciehp_configure_device
            pci_lock_rescan_remove     # wait for pci_unlock_rescan_remove()

>
> The real solution is to make the sections protected by
> pci_lock_rescan_remove() smaller or eliminate them as far as
> possible.  So, no good solution available right now, sorry.
>
Thanks, any suggestion is appreciated.

Thanks,
Dongdong.

> Thanks,
>
> Lukas
>
>>
>> [ 4112.297250] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4112.305069] bash            D    0  6502   2207 0x00000200
>> [ 4112.310544] Call trace:
>> [ 4112.312981]  __switch_to+0x94/0xe8
>> [ 4112.316373]  __schedule+0x270/0x8b0
>> [ 4112.319852]  schedule+0x2c/0x88
>> [ 4112.322981]  schedule_timeout+0x224/0x448
>> [ 4112.326979]  wait_for_common+0x198/0x2a0
>> [ 4112.330892]  wait_for_completion+0x28/0x38
>> [ 4112.334979]  kthread_stop+0x60/0x190
>> [ 4112.338544]  __free_irq+0x1c0/0x348
>> [ 4112.342022]  free_irq+0x40/0x88
>> [ 4112.345153]  pcie_shutdown_notification+0x54/0x80
>> [ 4112.349847]  pciehp_remove+0x30/0x50
>> [ 4112.353413]  pcie_port_remove_service+0x3c/0x58
>> [ 4112.357932]  device_release_driver_internal+0x1b4/0x250
>> [ 4112.363146]  device_release_driver+0x28/0x38
>> [ 4112.367406]  bus_remove_device+0xd4/0x160
>> [ 4112.371405]  device_del+0x128/0x348
>> [ 4112.374880]  device_unregister+0x24/0x78
>> [ 4112.378792]  remove_iter+0x48/0x58
>> [ 4112.382183]  device_for_each_child+0x6c/0xb8
>> [ 4112.386443]  pcie_port_device_remove+0x2c/0x48
>> [ 4112.390876]  pcie_portdrv_remove+0x5c/0x68
>> [ 4112.394963]  pci_device_remove+0x48/0xd8
>> [ 4112.398874]  device_release_driver_internal+0x1b4/0x250
>> [ 4112.404088]  device_release_driver+0x28/0x38
>> [ 4112.408348]  pci_stop_bus_device+0x84/0xb8
>> [ 4112.412434]  pci_stop_and_remove_bus_device_locked+0x24/0x40
>> [ 4112.418083]  remove_store+0xa4/0xb8
>> [ 4112.421560]  dev_attr_store+0x44/0x60
>> [ 4112.425213]  sysfs_kf_write+0x58/0x80
>> [ 4112.428864]  kernfs_fop_write+0xe8/0x1f0
>> [ 4112.432776]  __vfs_write+0x60/0x190
>> [ 4112.436255]  vfs_write+0xac/0x1c0
>> [ 4112.439560]  ksys_write+0x6c/0xd8
>> [ 4112.442861]  __arm64_sys_write+0x24/0x30
>> [ 4112.446773]  el0_svc_common+0xa0/0x180
>> [ 4112.450511]  el0_svc_handler+0x38/0x78
>> [ 4112.454249]  el0_svc+0x8/0xc
>> [ 4112.457122] INFO: task irq/97-pciehp:17365 blocked for more than 120 seconds.
>> [ 4112.464248]       Tainted: P        W  OE     4.19.25-vhulk1901.1.0.h111.aarch64+ #2
>> [ 4112.471980] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [ 4112.479798] irq/97-pciehp   D    0 17365      2 0x00000228
>> [ 4112.485273] Call trace:
>> [ 4112.487710]  __switch_to+0x94/0xe8
>> [ 4112.491098]  __schedule+0x270/0x8b0
>> [ 4112.494575]  schedule+0x2c/0x88
>> [ 4112.497706]  schedule_preempt_disabled+0x14/0x20
>> [ 4112.502313]  __mutex_lock.isra.1+0x1fc/0x540
>> [ 4112.506572]  __mutex_lock_slowpath+0x24/0x30
>> [ 4112.510833]  mutex_lock+0x80/0xa8
>> [ 4112.514138]  pci_lock_rescan_remove+0x20/0x28
>> [ 4112.518485]  pciehp_configure_device+0x30/0x140
>> [ 4112.523005]  pciehp_handle_presence_or_link_change+0x35c/0x4b0
>> [ 4112.528826]  pciehp_ist+0x1cc/0x1d0
>> [ 4112.532305]  irq_thread_fn+0x30/0x80
>> [ 4112.535870]  irq_thread+0x128/0x200
>> [ 4112.539349]  kthread+0x134/0x138
>> [ 4112.542563]  ret_from_fork+0x10/0x18
>
> .
>

