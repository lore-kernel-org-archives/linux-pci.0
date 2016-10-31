Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:35865 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933787AbcJaKo6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 06:44:58 -0400
Message-Id: <c32129ab921613c41635a572356dc312df304199.1477909752.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 31 Oct 2016 11:44:52 +0100
Subject: [PATCH] PCI: Equate surprise removal with channel error
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Surprise removal of an Apple Thunderbolt Gigabit Ethernet adapter
results in a soft lockup because the tg3 driver busy-waits while trying
to shut down all function blocks of the hot-removed device in
tg3_abort_hw().  The soft lockup can be avoided if the network interface
is shut down before unplugging the device, but that's easily forgotten
and shouldn't be punished with an unusable machine.

tg3_abort_hw() uses pci_channel_offline() to check the AER status of the
device and refrains from accessing it if a channel error has occurred.
Many other drivers follow the same pattern.

We've just added an is_removed flag to struct pci_dev which enables
detection of surprise removal.  Checking this flag in
pci_channel_offline() is sufficient to fix the soft lockup. Even hot
removing the device while packets are in-flight works fine.

Scrolling on the console still becomes sluggish for about 1 sec on
unplug and there's an occassional error "hrtimer: interrupt took
192490781 ns".  This seems to be caused by accesses to the device in the
time window between unplug and removal of the driver, either by
tg3_msi() or tg3_poll().  It may be possible to mitigate this effect by
checking the is_removed flag in both of them and by setting the
is_removed flag quicker in pciehp.  However on macOS, when hot removing
the adapter while audio is playing, a sub-second interruption of
playback is audible, suggesting that it may be impossible to make this
perfectly seamless.

Stacktrace of the soft lockup for posterity:

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

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Prashant Sreedharan <prashant@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Depends on Keith Busch's patch "pci: Add is_removed state":
https://patchwork.ozlabs.org/patch/688659/

 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1f39500..af4178e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -406,7 +406,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 static inline int pci_channel_offline(struct pci_dev *pdev)
 {
-	return (pdev->error_state != pci_channel_io_normal);
+	return pdev->error_state != pci_channel_io_normal || pdev->is_removed;
 }
 
 static inline int pci_set_removed(struct pci_dev *pdev, void *unused)
-- 
2.9.3

