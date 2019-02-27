Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31118C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0383E2133D
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 12:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfB0McD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:32:03 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:51493 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfB0McD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 07:32:03 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id DF23030001EDC;
        Wed, 27 Feb 2019 13:31:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B62A6D1E10; Wed, 27 Feb 2019 13:31:59 +0100 (CET)
Date:   Wed, 27 Feb 2019 13:31:59 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        mika.westerberg@linux.intel.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Question about Hotplug and PME deadlock issue
Message-ID: <20190227123159.r5qts23qupqxiwcx@wunner.de>
References: <c7697e7c-e1af-13e4-8491-0a3996e6ab5d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7697e7c-e1af-13e4-8491-0a3996e6ab5d@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 07:52:16PM +0800, Dongdong Liu wrote:
> We do some test to trigger hotplug while do sysfs "remove" operation,
> then met a deadlock issue.
> 
> pciehp 0000:00:0c.0:pcie004: Slot(0-1): Link Up
> echo 1 > 0000\:00\:0c.0/remove
> 
> PME and hotplug share an MSI/MSI-X vector.
> The sysfs "remove" operation will call the below function.
> remove_store()
>   pci_stop_and_remove_bus_device_locked()
>     pci_lock_rescan_remove()
>     pci_stop_and_remove_bus_device()
>       ...
>       pcie_pme_remove()
>         synchronize_irq()   // Here will wait for hotplug IRQ handler
>     pci_unlock_rescan_remove();

This is (at least) a bug in the PME driver.  I'm not familiar with
that driver, so adding Keith Busch to cc.

The bug is that pcie_pme_remove() invokes pcie_pme_suspend(), which
calls synchronize_irq(), which waits for the hardirq handlers and
IRQ threads of all drivers sharing the IRQ to finish.

pcie_pme_remove() then calls free_irq() which *again* waits for a
running hardirq handler and thread to finish, however it does not
wait for those of drivers sharing the IRQ to finish since 4.19,
see commit 519cc8652b3a ("genirq: Synchronize only with single thread
on free_irq()").

I think the invocation of synchronize_irq() in pcie_pme_suspend() is
unnecessary when called from pcie_pme_remove(), it's been there since
the driver was added by Rafael with commit c7f486567c1d ("PCI PM: PCIe
PME root port service driver"), adding him to cc as well.

Thanks,
Lukas

> 
> Hotplug
> pciehp_ist()
>   pciehp_handle_presence_or_link_change()
>     pciehp_configure_device()
>       pci_lock_rescan_remove() // Here will wait the pci_unlock_rescan_remove()
> 
> So met the deadlock issue. Any idea to solve such issue ?
> 
> 2180.490703] INFO: task bash:10913 blocked for more than 120 seconds.
> [ 2180.503428]       Tainted: P           OE     4.19.5-1.1.29.aarch64 #1
> [ 2180.516496] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2180.532176] bash            D    0 10913   6565 0x00000200
> 
>  # ps -ax |grep D
>   PID TTY      STAT   TIME COMMAND
> 10913 ttyAMA0  Ds+    0:00 -bash
> 12945 ?        Ss     0:00 /usr/sbin/sshd -D
> 14022 ?        D      0:00 [irq/745-pciehp]
> 15972 pts/1    S+     0:00 grep --color=auto D
> # cat /proc/14022/stack
> [<0>] __switch_to+0x94/0xd8
> [<0>] pci_lock_rescan_remove+0x20/0x28
> [<0>] pciehp_configure_device+0x30/0x140
> [<0>] pciehp_handle_presence_or_link_change+0x324/0x458
> [<0>] pciehp_ist+0x1dc/0x1e0
> [<0>] irq_thread_fn+0x30/0x90
> [<0>] irq_thread+0x140/0x210
> [<0>] kthread+0x134/0x138
> [<0>] ret_from_fork+0x10/0x1c
> [<0>] 0xffffffffffffffff
>  # cat /proc/10913/stack
> [<0>] __switch_to+0x94/0xd8
> [<0>] synchronize_irq+0x8c/0xc0
> [<0>] pcie_pme_suspend+0xa4/0x118
> [<0>] pcie_pme_remove+0x20/0x40
> [<0>] pcie_port_remove_service+0x3c/0x58
> [<0>] device_release_driver_internal+0x1b4/0x250
> [<0>] device_release_driver+0x28/0x38
> [<0>] bus_remove_device+0xd4/0x160
> [<0>] device_del+0x128/0x348
> [<0>] device_unregister+0x24/0x78
> [<0>] remove_iter+0x48/0x58
> [<0>] device_for_each_child+0x6c/0xb8
> [<0>] pcie_port_device_remove+0x2c/0x48
> [<0>] pcie_portdrv_remove+0x68/0x78
> [<0>] pci_device_remove+0x48/0x120
> [<0>] device_release_driver_internal+0x1b4/0x250
> [<0>] device_release_driver+0x28/0x38
> [<0>] pci_stop_bus_device+0x84/0xc0
> [<0>] pci_stop_and_remove_bus_device_locked+0x24/0x40
> [<0>] remove_store+0xa4/0xb8
> [<0>] dev_attr_store+0x44/0x60
> [<0>] sysfs_kf_write+0x58/0x80
> [<0>] kernfs_fop_write+0xd8/0x1e0
> [<0>] __vfs_write+0x60/0x190
> [<0>] vfs_write+0xac/0x1c0
> [<0>] ksys_write+0x6c/0xd8
> [<0>] __arm64_sys_write+0x24/0x30
> [<0>] el0_svc_common+0x78/0x100
> [<0>] el0_svc_handler+0x38/0x88
> [<0>] el0_svc+0x8/0xc
> [<0>] 0xffffffffffffffff
> 
> Thanks,
> Dongdong
