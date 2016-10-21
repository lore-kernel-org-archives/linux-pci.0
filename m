Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:47423 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753520AbcJUQgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2016 12:36:24 -0400
Date: Fri, 21 Oct 2016 18:36:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, Wei Zhang <wzhang@fb.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCHv3 2/5] pci: Add is_removed state
Message-ID: <20161021163655.GC4221@wunner.de>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
 <1475007815-28354-3-git-send-email-keith.busch@intel.com>
 <20161021153714.GA4221@wunner.de>
 <20161021161515.GA8596@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021161515.GA8596@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 21, 2016 at 12:15:16PM -0400, Keith Busch wrote:
> On Fri, Oct 21, 2016 at 05:37:14PM +0200, Lukas Wunner wrote:
> > With your patch above, the is_removed bit is only set on 0000:09:00.0
> > but not on its children.  Consequently the "tg3" driver tries to
> > access the hot-removed Broadcom 57762 Ethernet chip as before,
> > causing a soft lockup.
> 
> Is that something that can be fixed in the tg3 driver? I don't think
> drivers can rely on this patch to fense off their unintended access since
> we can't stop tg3 from accesses a removed device before 'is_removed'
> is set.

I haven't tested yet what happens when the adapter is unplugged while
packets are in-flight, but at least unplugging works fine when the
adapter is idle (with your series plus the small changes I outlined).

*Without* your series, I have to set the interface to down with ifconfig
before unplugging.  If I ever forget that, the machine locks up:


NMI watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [kworker/2:2:299]
...
Workqueue: pciehp-4 pciehp_power_thread
RIP: 0010:[<ffffffffa105b01d>]  [<ffffffffa105b01d>] tg3_read32+0xd/0x10 [tg3]
...
Call Trace:
 [<ffffffffa1063610>] ? tg3_stop_block.constprop.126+0x80/0x110 [tg3]
 [<ffffffffa1066298>] ? tg3_abort_hw+0x68/0x2f0 [tg3]
 [<ffffffffa106654d>] ? tg3_halt+0x2d/0x180 [tg3]
 [<ffffffffa1072a07>] ? tg3_stop+0x157/0x210 [tg3]
 [<ffffffffa1072aeb>] ? tg3_close+0x2b/0xe0 [tg3]
 [<ffffffff81465ff4>] ? __dev_close_many+0x84/0xd0
 [<ffffffff814660b4>] ? dev_close_many+0x74/0x100
 [<ffffffff8146790b>] ? rollback_registered_many+0xfb/0x2e0
 [<ffffffff81467b19>] ? rollback_registered+0x29/0x40
 [<ffffffff81468950>] ? unregister_netdevice_queue+0x40/0x90
 [<ffffffff814689b8>] ? unregister_netdev+0x18/0x20
 [<ffffffffa106604b>] ? tg3_remove_one+0x8b/0x130 [tg3]
 [<ffffffff8130b556>] ? pci_device_remove+0x36/0xb0
 [<ffffffff813df92a>] ? __device_release_driver+0x9a/0x140
 [<ffffffff813df9ee>] ? device_release_driver+0x1e/0x30
 [<ffffffff81304bf4>] ? pci_stop_bus_device+0x84/0xa0
 [<ffffffff81304b9b>] ? pci_stop_bus_device+0x2b/0xa0
 [<ffffffff81304b9b>] ? pci_stop_bus_device+0x2b/0xa0
 [<ffffffff81304cee>] ? pci_stop_and_remove_bus_device+0xe/0x20
 [<ffffffff8131ecea>] ? pciehp_unconfigure_device+0x9a/0x180
 [<ffffffff8131e7ef>] ? pciehp_disable_slot+0x3f/0xb0
 [<ffffffff8131e8e5>] ? pciehp_power_thread+0x85/0xa0
 [<ffffffff810855df>] ? process_one_work+0x19f/0x3d0
 [<ffffffff8108585d>] ? worker_thread+0x4d/0x450
 [<ffffffff81085810>] ? process_one_work+0x3d0/0x3d0
 [<ffffffff8108b32d>] ? kthread+0xbd/0xe0
 [<ffffffff8108b270>] ? kthread_create_on_node+0x170/0x170
 [<ffffffff8155ee1f>] ? ret_from_fork+0x3f/0x70
 [<ffffffff8108b270>] ? kthread_create_on_node+0x170/0x170


Being able to just unplug without having to think of ifconfig is already
a massive improvement.

Thanks,

Lukas
