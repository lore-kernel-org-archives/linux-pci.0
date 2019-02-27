Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA2C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 11:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995CB20863
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 11:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfB0Lwg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:52:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfB0Lwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Feb 2019 06:52:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 844C4F41D3665CC88976;
        Wed, 27 Feb 2019 19:52:33 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 19:52:27 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
Subject: Question about Hotplug and PME deadlock issue
To:     Bjorn Helgaas <bhelgaas@google.com>,
        <mika.westerberg@linux.intel.com>,
        "lukas@wunner.de" <lukas@wunner.de>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Message-ID: <c7697e7c-e1af-13e4-8491-0a3996e6ab5d@huawei.com>
Date:   Wed, 27 Feb 2019 19:52:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.141.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

We do some test to trigger hotplug while do sysfs "remove" operation,
then met a deadlock issue.

pciehp 0000:00:0c.0:pcie004: Slot(0-1): Link Up
echo 1 > 0000\:00\:0c.0/remove

PME and hotplug share an MSI/MSI-X vector.
The sysfs "remove" operation will call the below function.
remove_store()
   pci_stop_and_remove_bus_device_locked()
     pci_lock_rescan_remove()
     pci_stop_and_remove_bus_device()
       ...
       pcie_pme_remove()
         synchronize_irq()   // Here will wait for hotplug IRQ handler
     pci_unlock_rescan_remove();

Hotplug
pciehp_ist()
   pciehp_handle_presence_or_link_change()
     pciehp_configure_device()
       pci_lock_rescan_remove() // Here will wait the pci_unlock_rescan_remove()

So met the deadlock issue. Any idea to solve such issue ?

2180.490703] INFO: task bash:10913 blocked for more than 120 seconds.
[ 2180.503428]       Tainted: P           OE     4.19.5-1.1.29.aarch64 #1
[ 2180.516496] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2180.532176] bash            D    0 10913   6565 0x00000200

  # ps -ax |grep D
   PID TTY      STAT   TIME COMMAND
10913 ttyAMA0  Ds+    0:00 -bash
12945 ?        Ss     0:00 /usr/sbin/sshd -D
14022 ?        D      0:00 [irq/745-pciehp]
15972 pts/1    S+     0:00 grep --color=auto D
# cat /proc/14022/stack
[<0>] __switch_to+0x94/0xd8
[<0>] pci_lock_rescan_remove+0x20/0x28
[<0>] pciehp_configure_device+0x30/0x140
[<0>] pciehp_handle_presence_or_link_change+0x324/0x458
[<0>] pciehp_ist+0x1dc/0x1e0
[<0>] irq_thread_fn+0x30/0x90
[<0>] irq_thread+0x140/0x210
[<0>] kthread+0x134/0x138
[<0>] ret_from_fork+0x10/0x1c
[<0>] 0xffffffffffffffff
  # cat /proc/10913/stack
[<0>] __switch_to+0x94/0xd8
[<0>] synchronize_irq+0x8c/0xc0
[<0>] pcie_pme_suspend+0xa4/0x118
[<0>] pcie_pme_remove+0x20/0x40
[<0>] pcie_port_remove_service+0x3c/0x58
[<0>] device_release_driver_internal+0x1b4/0x250
[<0>] device_release_driver+0x28/0x38
[<0>] bus_remove_device+0xd4/0x160
[<0>] device_del+0x128/0x348
[<0>] device_unregister+0x24/0x78
[<0>] remove_iter+0x48/0x58
[<0>] device_for_each_child+0x6c/0xb8
[<0>] pcie_port_device_remove+0x2c/0x48
[<0>] pcie_portdrv_remove+0x68/0x78
[<0>] pci_device_remove+0x48/0x120
[<0>] device_release_driver_internal+0x1b4/0x250
[<0>] device_release_driver+0x28/0x38
[<0>] pci_stop_bus_device+0x84/0xc0
[<0>] pci_stop_and_remove_bus_device_locked+0x24/0x40
[<0>] remove_store+0xa4/0xb8
[<0>] dev_attr_store+0x44/0x60
[<0>] sysfs_kf_write+0x58/0x80
[<0>] kernfs_fop_write+0xd8/0x1e0
[<0>] __vfs_write+0x60/0x190
[<0>] vfs_write+0xac/0x1c0
[<0>] ksys_write+0x6c/0xd8
[<0>] __arm64_sys_write+0x24/0x30
[<0>] el0_svc_common+0x78/0x100
[<0>] el0_svc_handler+0x38/0x88
[<0>] el0_svc+0x8/0xc
[<0>] 0xffffffffffffffff

Thanks,
Dongdong


