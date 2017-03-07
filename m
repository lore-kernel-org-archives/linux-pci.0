Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755925AbdCGVb0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Mar 2017 16:31:26 -0500
Date: Tue, 7 Mar 2017 15:20:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/aspm: Fix link->downstream setting
Message-ID: <20170307212059.GH21358@bhelgaas-glaptop.roam.corp.google.com>
References: <20170301082540.23995-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170301082540.23995-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 01, 2017 at 12:25:40AM -0800, Yinghai Lu wrote:
> ~ # echo 1 > /sys/bus/pci/devices/0000\:0b\:00.0/remove
> ...
>  BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
>  IP: pcie_config_aspm_link+0x5d/0x2b0
>  Call Trace:
>   pcie_aspm_exit_link_state+0x75/0x130
>   pci_stop_bus_device+0xa4/0xb0
>   pci_stop_and_remove_bus_device_locked+0x1a/0x30
>   remove_store+0x50/0x70
>   dev_attr_store+0x18/0x30
>   sysfs_kf_write+0x44/0x60
>   kernfs_fop_write+0x10e/0x190
>   __vfs_write+0x28/0x110
>   ? rcu_read_lock_sched_held+0x5d/0x80
>   ? rcu_sync_lockdep_assert+0x2c/0x60
>   ? __sb_start_write+0x173/0x1a0
>   ? vfs_write+0xb3/0x180
>   vfs_write+0xc4/0x180
>   SyS_write+0x49/0xa0
>   do_syscall_64+0xa6/0x1c0
>   entry_SYSCALL64_slow_path+0x25/0x25
>  ---[ end trace bd187ee0267df5d9 ]---
> 
> set downstream even with blacklist path.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Applied with Rajat's ack to for-linus for v4.11, thanks!

I added a stable tag, since I think this bug has been there a long time and
it causes a NULL pointer dereference.

> ---
>  drivers/pci/pcie/aspm.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/pci/pcie/aspm.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pcie/aspm.c
> +++ linux-2.6/drivers/pci/pcie/aspm.c
> @@ -478,7 +478,7 @@ static void aspm_calc_l1ss_info(struct p
>  
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
> -	struct pci_dev *child, *parent = link->pdev;
> +	struct pci_dev *child = link->downstream, *parent = link->pdev;
>  	struct pci_bus *linkbus = parent->subordinate;
>  	struct aspm_register_info upreg, dwreg;
>  
> @@ -491,9 +491,7 @@ static void pcie_aspm_cap_init(struct pc
>  
>  	/* Get upstream/downstream components' register state */
>  	pcie_get_aspm_reg(parent, &upreg);
> -	child = pci_function_0(linkbus);
>  	pcie_get_aspm_reg(child, &dwreg);
> -	link->downstream = child;
>  
>  	/*
>  	 * If ASPM not supported, don't mess with the clocks and link,
> @@ -800,6 +798,7 @@ static struct pcie_link_state *alloc_pci
>  	INIT_LIST_HEAD(&link->children);
>  	INIT_LIST_HEAD(&link->link);
>  	link->pdev = pdev;
> +	link->downstream = pci_function_0(pdev->subordinate);
>  
>  	/*
>  	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
