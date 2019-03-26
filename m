Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BF6C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A822075D
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 12:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfCZMox (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:44:53 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:51907 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfCZMow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 08:44:52 -0400
Received: from h08.hostsharing.net (unknown [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7D1622800B3CC;
        Tue, 26 Mar 2019 13:44:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 112A22FE95; Tue, 26 Mar 2019 13:44:49 +0100 (CET)
Date:   Tue, 26 Mar 2019 13:44:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     mika.westerberg@linux.intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Question about Hotplug driver deadlock issue
Message-ID: <20190326124449.3vdjmescrvswirop@wunner.de>
References: <351f898c-f9e9-69e0-b023-cf72e0d7792b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <351f898c-f9e9-69e0-b023-cf72e0d7792b@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 26, 2019 at 07:43:17PM +0800, Dongdong Liu wrote:
> Current we met another deadlock issue in hotplug driver. The calltrace is as below.
> The deadlock triggered by a hotplug event during a sysfs "remove" operation.
> Any suggestion to fix such deadlock ?

That's a known problem, deadlocks may occur if hotplug ports are
cascaded.  I came up with a kludge to work around it but withdrew
the patch:
https://patchwork.ozlabs.org/patch/930403/

The real solution is to make the sections protected by
pci_lock_rescan_remove() smaller or eliminate them as far as
possible.  So, no good solution available right now, sorry.

Thanks,

Lukas

> 
> [ 4112.297250] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4112.305069] bash            D    0  6502   2207 0x00000200
> [ 4112.310544] Call trace:
> [ 4112.312981]  __switch_to+0x94/0xe8
> [ 4112.316373]  __schedule+0x270/0x8b0
> [ 4112.319852]  schedule+0x2c/0x88
> [ 4112.322981]  schedule_timeout+0x224/0x448
> [ 4112.326979]  wait_for_common+0x198/0x2a0
> [ 4112.330892]  wait_for_completion+0x28/0x38
> [ 4112.334979]  kthread_stop+0x60/0x190
> [ 4112.338544]  __free_irq+0x1c0/0x348
> [ 4112.342022]  free_irq+0x40/0x88
> [ 4112.345153]  pcie_shutdown_notification+0x54/0x80
> [ 4112.349847]  pciehp_remove+0x30/0x50
> [ 4112.353413]  pcie_port_remove_service+0x3c/0x58
> [ 4112.357932]  device_release_driver_internal+0x1b4/0x250
> [ 4112.363146]  device_release_driver+0x28/0x38
> [ 4112.367406]  bus_remove_device+0xd4/0x160
> [ 4112.371405]  device_del+0x128/0x348
> [ 4112.374880]  device_unregister+0x24/0x78
> [ 4112.378792]  remove_iter+0x48/0x58
> [ 4112.382183]  device_for_each_child+0x6c/0xb8
> [ 4112.386443]  pcie_port_device_remove+0x2c/0x48
> [ 4112.390876]  pcie_portdrv_remove+0x5c/0x68
> [ 4112.394963]  pci_device_remove+0x48/0xd8
> [ 4112.398874]  device_release_driver_internal+0x1b4/0x250
> [ 4112.404088]  device_release_driver+0x28/0x38
> [ 4112.408348]  pci_stop_bus_device+0x84/0xb8
> [ 4112.412434]  pci_stop_and_remove_bus_device_locked+0x24/0x40
> [ 4112.418083]  remove_store+0xa4/0xb8
> [ 4112.421560]  dev_attr_store+0x44/0x60
> [ 4112.425213]  sysfs_kf_write+0x58/0x80
> [ 4112.428864]  kernfs_fop_write+0xe8/0x1f0
> [ 4112.432776]  __vfs_write+0x60/0x190
> [ 4112.436255]  vfs_write+0xac/0x1c0
> [ 4112.439560]  ksys_write+0x6c/0xd8
> [ 4112.442861]  __arm64_sys_write+0x24/0x30
> [ 4112.446773]  el0_svc_common+0xa0/0x180
> [ 4112.450511]  el0_svc_handler+0x38/0x78
> [ 4112.454249]  el0_svc+0x8/0xc
> [ 4112.457122] INFO: task irq/97-pciehp:17365 blocked for more than 120 seconds.
> [ 4112.464248]       Tainted: P        W  OE     4.19.25-vhulk1901.1.0.h111.aarch64+ #2
> [ 4112.471980] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 4112.479798] irq/97-pciehp   D    0 17365      2 0x00000228
> [ 4112.485273] Call trace:
> [ 4112.487710]  __switch_to+0x94/0xe8
> [ 4112.491098]  __schedule+0x270/0x8b0
> [ 4112.494575]  schedule+0x2c/0x88
> [ 4112.497706]  schedule_preempt_disabled+0x14/0x20
> [ 4112.502313]  __mutex_lock.isra.1+0x1fc/0x540
> [ 4112.506572]  __mutex_lock_slowpath+0x24/0x30
> [ 4112.510833]  mutex_lock+0x80/0xa8
> [ 4112.514138]  pci_lock_rescan_remove+0x20/0x28
> [ 4112.518485]  pciehp_configure_device+0x30/0x140
> [ 4112.523005]  pciehp_handle_presence_or_link_change+0x35c/0x4b0
> [ 4112.528826]  pciehp_ist+0x1cc/0x1d0
> [ 4112.532305]  irq_thread_fn+0x30/0x80
> [ 4112.535870]  irq_thread+0x128/0x200
> [ 4112.539349]  kthread+0x134/0x138
> [ 4112.542563]  ret_from_fork+0x10/0x18
