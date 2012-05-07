Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:58853 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756890Ab2EGPEH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 May 2012 11:04:07 -0400
Message-ID: <4FA7D894.3040700@fold.natur.cuni.cz>
Date: Mon, 07 May 2012 16:13:40 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 10/19] PCI: serialize hotplug operaitons triggered
 by the shpchp driver
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com> <1335539820-11232-11-git-send-email-jiang.liu@huawei.com> <4FA4F3E5.5040600@fold.natur.cuni.cz> <4FA5EF97.8010306@gmail.com> <20120506152036.GA31551@kroah.com> <4FA7D882.3070903@gmail.com> <4FA7D839.9090109@fold.natur.cuni.cz>
In-Reply-To: <4FA7D839.9090109@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Martin Mokrejs wrote:
> Hi Greg and Jiang,
>   I am confirming this issue still happens for me with my changed motherboard and express card slot
> of my Dell Vostro 3550 laptop. :( I trigger this when unplugging a FireWire express card. Not always
> but does happen. attached is a camera picture of the Oops.
> 
> 
> wq_worker_sleeping
> __schedule
> schedule
> do_exit
> oops_end
> no_context
> __bad_area_nosemaphore
> ? put_dec
> bad_area_nosemaphore
> do_page_fault
> ? pointer.clone
> ? vsnprintf
> page_fault
> ? sysfs_name_hash
> sysfs_find_dirent
> sysfs_hash_and_remove
> sysfs_remove_bin_file
> pci_remove_resource_files
> pci_remove_sysfs_dev_files
> pci_stop_bus_device
> pci_stop_and_remove_bus_device
> pciehp_unconfigure_device
> pciehp_disable_slot
> ? pciehp_disable_slot
> pciehp_power_thread
> process_one_work
> worker_thread
> ? manage_workers.clone
> ? manage_workers.clone
> kthread
> kernel_thread_helper
> ? kthread_freezable_should_stop
> ? gs_change

On linux-3.4-rc5 ...

