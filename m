Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:34837 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbCQTLg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2015 15:11:36 -0400
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAA93t1qpPqbih+UB0McA_d_+2rVaNkXsinAUxYzK9+JXSS+L-g@mail.gmail.com>
References: <CAA93t1qpPqbih+UB0McA_d_+2rVaNkXsinAUxYzK9+JXSS+L-g@mail.gmail.com>
Date: Tue, 17 Mar 2015 12:11:35 -0700
Message-ID: <CAA93t1ohiz+21DsKpjYueiUDsrO_yeKccwhYF9HO7BxNuXrQ6w@mail.gmail.com>
Subject: Re: Hit a deadlock: between AER and pcieport/pciehp
From: Rajat Jain <rajatxjain@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <groeck@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>, rthirumal@juniper.net,
	sanjayj@juniper.net
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I was wondering if any one has a any suggestions to make here. I
believe this is a pretty serious deadlock - and I'm looking for ideas
on what should be the right way to fix this.

Thanks,

Rajat


On Wed, Mar 11, 2015 at 6:48 PM, Rajat Jain <rajatxjain@gmail.com> wrote:
> Hello,
>
>
> I have hit a kernel deadlock situation on my system that has
> hierarchical hot plug situations (i.e. we can hot-plug a card, that
> itself may have a hot-plug slot for another level of hot-pluggable
> add-on cards). In summary, I see 2 threads that are both waiting on
> mutexes that is acquired by the other one. The mutexes are the
> (global) "pci_bus_sem" and "device->mutex" respectively.
>
>
> Thread1
>  =======
>  This is the pciehp worker thread, that scans a new card, and on
> finding that there is a hotplug slot downstream, tries to
> pci_create_slot().
>  pciehp_power_thread()
>    -> pciehp_enable_slot()
>      -> pciehp_configure_device()
>        -> pci_bus_add_devices() discovers all devices including a new
> hotplug slot.
>          -> ....(etc)...
>          -> device_attach(dev) (for the newly discovered HP slot /
> downstream port)
>            -> device_lock(dev) SUCCESSFULLY ACQUIRES dev->mutex for
> the new slot.
>          -> ....(etc)...
>          -> ... (goes on)
>          -> pciehp_probe(dev)
>              -> __pci_hp_register()
>                 -> pci_create_slot()
>                      -> down_write(pci_bus_sem); /* Deadlocked */
>
>  This how the stack looks like:
>   [<ffffffff814e9923>] call_rwsem_down_write_failed+0x13/0x20
>  [<ffffffff81522d4f>] pci_create_slot+0x3f/0x280
>  [<ffffffff8152c030>] __pci_hp_register+0x70/0x400
>  [<ffffffff8152cf49>] pciehp_probe+0x1a9/0x450
>  [<ffffffff8152865d>] pcie_port_probe_service+0x3d/0x90
>  [<ffffffff815c45b9>] driver_probe_device+0xf9/0x350
>  [<ffffffff815c490b>] __device_attach+0x4b/0x60
>  [<ffffffff815c25a6>] bus_for_each_drv+0x56/0xa0
>  [<ffffffff815c4468>] device_attach+0xa8/0xc0
>  [<ffffffff815c38d0>] bus_probe_device+0xb0/0xe0
>  [<ffffffff815c16ce>] device_add+0x3de/0x560
>  [<ffffffff815c1a2e>] device_register+0x1e/0x30
>  [<ffffffff81528aef>] pcie_port_device_register+0x32f/0x510
>  [<ffffffff81528eb8>] pcie_portdrv_probe+0x48/0x80
>  [<ffffffff8151b17c>] pci_device_probe+0x9c/0xf0
>  [<ffffffff815c45b9>] driver_probe_device+0xf9/0x350
>  [<ffffffff815c490b>] __device_attach+0x4b/0x60
>  [<ffffffff815c25a6>] bus_for_each_drv+0x56/0xa0
>  [<ffffffff815c4468>] device_attach+0xa8/0xc0
>  [<ffffffff815116c1>] pci_bus_add_device+0x41/0x70
>  [<ffffffff81511a41>] pci_bus_add_devices+0x41/0x90
>  [<ffffffff81511a6f>] pci_bus_add_devices+0x6f/0x90
>  [<ffffffff8152e7e2>] pciehp_configure_device+0xa2/0x140
>  [<ffffffff8152df08>] pciehp_enable_slot+0x188/0x2d0
>  [<ffffffff8152e3d1>] pciehp_power_thread+0x2b1/0x3c0
>  [<ffffffff810d92a0>] process_one_work+0x1d0/0x510
>  [<ffffffff810d9cc1>] worker_thread+0x121/0x440
>  [<ffffffff810df0bf>] kthread+0xef/0x110
>  [<ffffffff81a4d8ac>] ret_from_fork+0x7c/0xb0
>  [<ffffffffffffffff>] 0xffffffffffffffff
>
>
>  Thread2
>  =======
>  While the above thread is doing its work, the root port gets a
> completion timeout. And thus the AER Error recovery worker thread
> kicks in to handle that error. And as part of that error recovery -
> since the completion timeout was detected at root port, attempts to
> see for ALL the devices downstream if they have an error handler that
> need to be called. Here is what happens:
>
>
> aer_isr()
>    -> aer_isr_one_error()
>      -> aer_process_err_device()
>         -> ... (etc)...
>           -> do_recovery()
>             -> broadcast_error_message()
>               -> pci_walk_bus( ..., report_error_detected,...) /*
> effectively for all buses below root port */
>                     -> down_read(&pci_bus_sem);  /* SUCCESSFULLY
> ACQUIRES the semaophore */
>                     -> report_error_detected(dev) /* for the newly
> detected slot */
>                          -> device_lock(dev) /* Deadlocked */
>
>  This is how the stack looks like:
>  [<ffffffff81529e7e>] report_error_detected+0x4e/0x170 <--- Waiting on
> device_lock()
>  [<ffffffff8151162e>] pci_walk_bus+0x4e/0xa0
>  [<ffffffff81529b84>] broadcast_error_message+0xc4/0xf0
>  [<ffffffff81529bed>] do_recovery+0x3d/0x280
>  [<ffffffff8152a5d0>] aer_isr+0x300/0x3e0
>  [<ffffffff810d92a0>] process_one_work+0x1d0/0x510
>  [<ffffffff810d9cc1>] worker_thread+0x121/0x440
>  [<ffffffff810df0bf>] kthread+0xef/0x110
>  [<ffffffff81a4d8ac>] ret_from_fork+0x7c/0xb0
>  [<ffffffffffffffff>] 0xffffffffffffffff
>
>
> As a temporary work around to let me proceed, I was thinking may be I
> could change in report_error_detected() such that completion timeouts
> errors may not be broadcast (do we really have any drivers that have
> aer handlers that handle such an error? What would the handler do
> anyway to fix such an error?)
>
>
> But not sure what the right solution might look like. I thought about
> whether these locks should have been taken in a particular order in
> order to avoid this problem, but looking at the stack there seems to
> be no other way. What do you think is the best way to fix this
> deadlock?
>
> Any help or suggestions in this regard are greatly appreciated.
>
>  Thanks,
>
> Rajat
