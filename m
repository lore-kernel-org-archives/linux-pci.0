Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:42331 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab3HEP4K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 11:56:10 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so6524298oag.4
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 08:56:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2381207.2TMynsda9i@al>
References: <2381207.2TMynsda9i@al>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Aug 2013 09:55:48 -0600
Message-ID: <CAErSpo4w9P_XNYANifwHs49k3LzKgVAJf4jaMx-YS2qE-FgbiQ@mail.gmail.com>
Subject: Re: Lockdep warning on rescan (pci_remove_rescan_mutex)
To: Peter Wu <lekensteyn@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 3, 2013 at 4:33 AM, Peter Wu <lekensteyn@gmail.com> wrote:
> Hi,
>
> When trying to rescan for PCI devices (after removing a child), I get a
> lockdep warning in my logs. The commands were:
>
>     # tee /sys/bus/pci/devices/0000\:03\:00.0/remove <<<1
>     1
>     # tee /sys/bus/pci/devices/0000\:02\:00.0/rescan <<<1
>     1
>
> I did not experience actual issues, just letting you know about this. I can
> reproduce this on every reboot:
> 1. Boot
> 2. (pci-stub owns the device)
> 4. remove from parent bus
> 5. rescan
> 6. Lockdep warning found.
> (7. pci-stub claims device again)
>
> Interestingly, I can only reproduce this after freshly rebooting.
> Repeating steps 4 and 5 do not trigger a new lockdep warning.

Thanks for the report!  I opened
https://bugzilla.kernel.org/show_bug.cgi?id=60695 to keep track of it.
 It looks related to https://bugzilla.kernel.org/show_bug.cgi?id=60672
also.

We have some ongoing refcounting cleanup that should help with this
when it is eventually completed.  Or at least, it might help us see a
better way of fixing this.

Oh, can you attach the output of "lspci -vv" and a complete dmesg log
including the boot, device remove, and rescan, to the bugzilla?  That
will have some additional information like the device topology.

Bjorn


> ======================================================
> [ INFO: possible circular locking dependency detected ]
> 3.11.0-rc2-cold-00096-gae2ad35-dirty #1 Tainted: G           O
> -------------------------------------------------------
> tee/29902 is trying to acquire lock:
>  (pci_remove_rescan_mutex){+.+.+.}, at: [<ffffffff8134be96>] dev_rescan_store+0x56/0x80
>
> but task is already holding lock:
>  (s_active#296){++++.+}, at: [<ffffffff811fddad>] sysfs_write_file+0xcd/0x170
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (s_active#296){++++.+}:
>        [<ffffffff810aabaa>] check_prevs_add+0xda/0x140
>        [<ffffffff810ab1ba>] validate_chain.isra.35+0x5aa/0x7a0
>        [<ffffffff810ad02a>] __lock_acquire+0x3ca/0xab0
>        [<ffffffff810addc0>] lock_acquire+0x90/0x140
>        [<ffffffff811ff086>] sysfs_deactivate+0x116/0x160
>        [<ffffffff811ffb7b>] sysfs_addrm_finish+0x3b/0x70
>        [<ffffffff811fdb0b>] sysfs_hash_and_remove+0x5b/0xb0
>        [<ffffffff81201991>] remove_files.isra.1+0x41/0x80
>        [<ffffffff81201ec4>] sysfs_remove_group+0x54/0xf0
>        [<ffffffff8141415b>] device_remove_groups+0x3b/0x60
>        [<ffffffff814144a3>] device_remove_attrs+0x53/0x90
>        [<ffffffff81414e7b>] device_del+0x12b/0x1c0
>        [<ffffffff8134506c>] pci_stop_bus_device+0x9c/0xb0
>        [<ffffffff81345216>] pci_stop_and_remove_bus_device+0x16/0x30
>        [<ffffffff8134c10b>] remove_callback+0x2b/0x40
>        [<ffffffff811fde68>] sysfs_schedule_callback_work+0x18/0x80
>        [<ffffffff8106a621>] process_one_work+0x1d1/0x570
>        [<ffffffff8106b80b>] worker_thread+0x11b/0x370
>        [<ffffffff81072c2a>] kthread+0xea/0xf0
>        [<ffffffff8168239c>] ret_from_fork+0x7c/0xb0
>
> -> #0 (pci_remove_rescan_mutex){+.+.+.}:
>        [<ffffffff810aaac8>] check_prev_add+0x778/0x780
>        [<ffffffff810aabaa>] check_prevs_add+0xda/0x140
>        [<ffffffff810ab1ba>] validate_chain.isra.35+0x5aa/0x7a0
>        [<ffffffff810ad02a>] __lock_acquire+0x3ca/0xab0
>        [<ffffffff810addc0>] lock_acquire+0x90/0x140
>        [<ffffffff816744a0>] mutex_lock_nested+0x70/0x380
>        [<ffffffff8134be96>] dev_rescan_store+0x56/0x80
>        [<ffffffff81413758>] dev_attr_store+0x18/0x30
>        [<ffffffff811fddc6>] sysfs_write_file+0xe6/0x170
>        [<ffffffff81187c5e>] vfs_write+0xce/0x200
>        [<ffffffff81188165>] SyS_write+0x55/0xa0
>        [<ffffffff81682442>] system_call_fastpath+0x16/0x1b
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(s_active#296);
>                                lock(pci_remove_rescan_mutex);
>                                lock(s_active#296);
>   lock(pci_remove_rescan_mutex);
>
>  *** DEADLOCK ***
>
> 3 locks held by tee/29902:
>  #0:  (sb_writers#6){.+.+.+}, at: [<ffffffff81187d63>] vfs_write+0x1d3/0x200
>  #1:  (&buffer->mutex){+.+.+.}, at: [<ffffffff811fdd24>] sysfs_write_file+0x44/0x170
>  #2:  (s_active#296){++++.+}, at: [<ffffffff811fddad>] sysfs_write_file+0xcd/0x170
>
> stack backtrace:
> CPU: 2 PID: 29902 Comm: tee Tainted: G           O 3.11.0-rc2-cold-00096-gae2ad35-dirty #1
> Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./Z68X-UD3H-B3, BIOS U1l 03/08/2013
>  ffff880597c7c6c8 ffff880544e69b28 ffffffff8166cea7 0000000000000000
>  0000000000000000 ffff880544e69b78 ffffffff81662c09 ffffffff821ac670
>  ffff880544e69ba0 ffff880544e69b78 ffff880597c7c6a0 ffff880597c7c6c8
> Call Trace:
>  [<ffffffff8166cea7>] dump_stack+0x55/0x76
>  [<ffffffff81662c09>] print_circular_bug+0xd3/0xe4
>  [<ffffffff810aaac8>] check_prev_add+0x778/0x780
>  [<ffffffff8112f60e>] ? get_page_from_freelist+0x23e/0x5f0
>  [<ffffffff810aabaa>] check_prevs_add+0xda/0x140
>  [<ffffffff810ab1ba>] validate_chain.isra.35+0x5aa/0x7a0
>  [<ffffffff810ad02a>] __lock_acquire+0x3ca/0xab0
>  [<ffffffff81130092>] ? __alloc_pages_nodemask+0x162/0x980
>  [<ffffffff8134be96>] ? dev_rescan_store+0x56/0x80
>  [<ffffffff810addc0>] lock_acquire+0x90/0x140
>  [<ffffffff8134be96>] ? dev_rescan_store+0x56/0x80
>  [<ffffffff816744a0>] mutex_lock_nested+0x70/0x380
>  [<ffffffff8134be96>] ? dev_rescan_store+0x56/0x80
>  [<ffffffff811fddad>] ? sysfs_write_file+0xcd/0x170
>  [<ffffffff81329fac>] ? _kstrtoull+0x2c/0x90
>  [<ffffffff8134be96>] dev_rescan_store+0x56/0x80
>  [<ffffffff81413758>] dev_attr_store+0x18/0x30
>  [<ffffffff811fddc6>] sysfs_write_file+0xe6/0x170
>  [<ffffffff81187c5e>] vfs_write+0xce/0x200
>  [<ffffffff81188165>] SyS_write+0x55/0xa0
>  [<ffffffff81682442>] system_call_fastpath+0x16/0x1b
> pci_bus 0000:02: scanning bus
> pci 0000:02:00.0: scanning [bus 03-03] behind bridge, pass 0
> pci_bus 0000:03: scanning bus
> pci 0000:03:00.0: [10ec:8129] type 00 class 0x020000
> pci 0000:03:00.0: reg 0x10: [io  0xe000-0xe0ff]
> pci 0000:03:00.0: reg 0x14: [mem 0xf7b41000-0xf7b410ff]
> pci 0000:03:00.0: reg 0x30: [mem 0xf7b00000-0xf7b3ffff pref]
> pci 0000:03:00.0: PME# supported from D3cold
> pci 0000:03:00.0: PME# disabled
> pci_bus 0000:03: bus scan returning with max=03
> pci 0000:02:00.0: scanning [bus 03-03] behind bridge, pass 1
> pci_bus 0000:02: bus scan returning with max=03
> pci 0000:02:00.0: BAR 15: assigned [mem 0xdfb00000-0xdfbfffff pref]
> pci 0000:03:00.0: BAR 6: assigned [mem 0xdfb00000-0xdfb3ffff pref]
> pci 0000:03:00.0: BAR 0: assigned [io  0xe000-0xe0ff]
> pci 0000:03:00.0: BAR 0: set to [io  0xe000-0xe0ff] (PCI address [0xe000-0xe0ff])
> pci 0000:03:00.0: BAR 1: assigned [mem 0xf7b00000-0xf7b000ff]
> pci 0000:03:00.0: BAR 1: set to [mem 0xf7b00000-0xf7b000ff] (PCI address [0xf7b00000-0xf7b000ff])
> pci-stub 0000:03:00.0: claimed by stub
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
