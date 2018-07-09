Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:58980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeGIXpz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2018 19:45:55 -0400
From: Thomas Tai <thomas.tai@oracle.com>
To: thomas.tai@oracle.com, bhelgaas@google.com, poza@codeaurora.org
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI/AER: fix use-after-free in pcie_do_fatal_recovery
Date: Mon,  9 Jul 2018 17:45:52 -0600
Message-Id: <1531179952-11060-1-git-send-email-thomas.tai@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When an fatal error is recevied by a non-bridge device,
the device is removed from the pci bus and the device structure
is freed by pci_stop_and_remove_bus_device(). The freed device
structure is used in the subsequence pci_info() to printout the
message. It causes a corrupt printout. If slub_debug=FZP is used,
it will cause following protection fault after a fatal error is
received.

general protection fault: 0000 [#1] SMP PTI
CPU: 104 PID: 1077 Comm: kworker/104:1 Not tainted 4.18.0-rc1ttai #5
Hardware name: Oracle Corporation ORACLE SERVER X5-4/ASSY,MB WITH TRAY,
BIOS 36030500 11/16/2016
Workqueue: events aer_isr
 RIP: 0010:__dev_printk+0x2e/0x90
 Code: 00 55 49 89 d1 48 89 e5 53 48 89 fb 48 83 ec 18 48 85 f6
 74 5f 4c 8b 46 50 4d 85 c0 74 2b 48 8b 86 88 00 00 00 48 85 c0
 74 25 <48> 8b 08 0f be 7b 01 48 c7 c2 83 d4 71 99 31 c0 83 ef
 30 e8 4a ff 
 RSP: 0018:ffffb6b88fa57cf8 EFLAGS: 00010202
 RAX: 6b6b6b6b6b6b6b6b RBX: ffffffff996ba720 RCX: 0000000000000000
 RDX: ffffb6b88fa57d28 RSI: ffff8c4d7af94128 RDI: ffffffff996ba720
 RBP: ffffb6b88fa57d18 R08: 6b6b6b6b6b6b6b6b R09: ffffb6b88fa57d28
 R10: ffffffff99baca80 R11: 0000000000000000 R12: ffff8c4d7ae95990
 R13: ffff8c2d7a840008 R14: ffff8c4d7af94088 R15: ffff8c4d7af90008
 FS:  0000000000000000(0000) GS:ffff8c2d7fc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f22c0839000 CR3: 000000136bc0a001 CR4: 00000000001606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  ? pci_bus_add_device+0x4f/0xa0
  _dev_info+0x6c/0x90
  pcie_do_fatal_recovery+0x1d5/0x230
  aer_isr+0x3e5/0x950
  ? add_timer_on+0xcc/0x160
  process_one_work+0x168/0x370
  worker_thread+0x4f/0x3d0
  kthread+0x105/0x140
  ? max_active_store+0x80/0x80
  ? kthread_bind+0x20/0x20
  ret_from_fork+0x35/0x40

To fix this issue, the driver and device name is stored in a
variable before freeing the device to avoid the use-after-free
problem.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 drivers/pci/pcie/err.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb..66e16de 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -287,6 +287,13 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	struct pci_bus *parent;
 	struct pci_dev *pdev, *temp;
 	pci_ers_result_t result;
+	const char *driver_str;
+	const char *name_str;
+	u8 hdr_type = dev->hdr_type;
+
+	/* copy the device driver name and device name for printing purpose */
+	driver_str = kstrdup(dev_driver_string(&dev->dev), GFP_KERNEL);
+	name_str = kstrdup(dev_name(&dev->dev), GFP_KERNEL);
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
 		udev = dev;
@@ -309,7 +316,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	result = reset_link(udev, service);
 
 	if ((service == PCIE_PORT_SERVICE_AER) &&
-	    (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
+	    (hdr_type == PCI_HEADER_TYPE_BRIDGE)) {
 		/*
 		 * If the error is reported by a bridge, we think this error
 		 * is related to the downstream link of the bridge, so we
@@ -322,13 +329,18 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	if (result == PCI_ERS_RESULT_RECOVERED) {
 		if (pcie_wait_for_link(udev, true))
 			pci_rescan_bus(udev->bus);
-		pci_info(dev, "Device recovery from fatal error successful\n");
+		pr_info("%s %s: Device recovery from fatal error successful\n",
+			driver_str, name_str);
 	} else {
 		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
-		pci_info(dev, "Device recovery from fatal error failed\n");
+		pr_info("%s %s: Device recovery from fatal error failed\n",
+			driver_str, name_str);
 	}
 
 	pci_unlock_rescan_remove();
+
+	kfree(driver_str);
+	kfree(name_str);
 }
 
 /**
-- 
1.8.3.1
