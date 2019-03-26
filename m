Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28AC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 11:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E72206DF
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 11:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCZLni (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:43:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfCZLnh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 07:43:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 925B01654239544FE959;
        Tue, 26 Mar 2019 19:43:35 +0800 (CST)
Received: from [127.0.0.1] (10.63.141.25) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 19:43:27 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <lukas@wunner.de>, <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Question about Hotplug driver deadlock issue
Message-ID: <351f898c-f9e9-69e0-b023-cf72e0d7792b@huawei.com>
Date:   Tue, 26 Mar 2019 19:43:17 +0800
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

Current we met another deadlock issue in hotplug driver. The calltrace is as below.
The deadlock triggered by a hotplug event during a sysfs "remove" operation.
Any suggestion to fix such deadlock ?

[ 4112.297250] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4112.305069] bash            D    0  6502   2207 0x00000200
[ 4112.310544] Call trace:
[ 4112.312981]  __switch_to+0x94/0xe8
[ 4112.316373]  __schedule+0x270/0x8b0
[ 4112.319852]  schedule+0x2c/0x88
[ 4112.322981]  schedule_timeout+0x224/0x448
[ 4112.326979]  wait_for_common+0x198/0x2a0
[ 4112.330892]  wait_for_completion+0x28/0x38
[ 4112.334979]  kthread_stop+0x60/0x190
[ 4112.338544]  __free_irq+0x1c0/0x348
[ 4112.342022]  free_irq+0x40/0x88
[ 4112.345153]  pcie_shutdown_notification+0x54/0x80
[ 4112.349847]  pciehp_remove+0x30/0x50
[ 4112.353413]  pcie_port_remove_service+0x3c/0x58
[ 4112.357932]  device_release_driver_internal+0x1b4/0x250
[ 4112.363146]  device_release_driver+0x28/0x38
[ 4112.367406]  bus_remove_device+0xd4/0x160
[ 4112.371405]  device_del+0x128/0x348
[ 4112.374880]  device_unregister+0x24/0x78
[ 4112.378792]  remove_iter+0x48/0x58
[ 4112.382183]  device_for_each_child+0x6c/0xb8
[ 4112.386443]  pcie_port_device_remove+0x2c/0x48
[ 4112.390876]  pcie_portdrv_remove+0x5c/0x68
[ 4112.394963]  pci_device_remove+0x48/0xd8
[ 4112.398874]  device_release_driver_internal+0x1b4/0x250
[ 4112.404088]  device_release_driver+0x28/0x38
[ 4112.408348]  pci_stop_bus_device+0x84/0xb8
[ 4112.412434]  pci_stop_and_remove_bus_device_locked+0x24/0x40
[ 4112.418083]  remove_store+0xa4/0xb8
[ 4112.421560]  dev_attr_store+0x44/0x60
[ 4112.425213]  sysfs_kf_write+0x58/0x80
[ 4112.428864]  kernfs_fop_write+0xe8/0x1f0
[ 4112.432776]  __vfs_write+0x60/0x190
[ 4112.436255]  vfs_write+0xac/0x1c0
[ 4112.439560]  ksys_write+0x6c/0xd8
[ 4112.442861]  __arm64_sys_write+0x24/0x30
[ 4112.446773]  el0_svc_common+0xa0/0x180
[ 4112.450511]  el0_svc_handler+0x38/0x78
[ 4112.454249]  el0_svc+0x8/0xc
[ 4112.457122] INFO: task irq/97-pciehp:17365 blocked for more than 120 seconds.
[ 4112.464248]       Tainted: P        W  OE     4.19.25-vhulk1901.1.0.h111.aarch64+ #2
[ 4112.471980] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4112.479798] irq/97-pciehp   D    0 17365      2 0x00000228
[ 4112.485273] Call trace:
[ 4112.487710]  __switch_to+0x94/0xe8
[ 4112.491098]  __schedule+0x270/0x8b0
[ 4112.494575]  schedule+0x2c/0x88
[ 4112.497706]  schedule_preempt_disabled+0x14/0x20
[ 4112.502313]  __mutex_lock.isra.1+0x1fc/0x540
[ 4112.506572]  __mutex_lock_slowpath+0x24/0x30
[ 4112.510833]  mutex_lock+0x80/0xa8
[ 4112.514138]  pci_lock_rescan_remove+0x20/0x28
[ 4112.518485]  pciehp_configure_device+0x30/0x140
[ 4112.523005]  pciehp_handle_presence_or_link_change+0x35c/0x4b0
[ 4112.528826]  pciehp_ist+0x1cc/0x1d0
[ 4112.532305]  irq_thread_fn+0x30/0x80
[ 4112.535870]  irq_thread+0x128/0x200
[ 4112.539349]  kthread+0x134/0x138
[ 4112.542563]  ret_from_fork+0x10/0x18

Thanks,
Dongdong

