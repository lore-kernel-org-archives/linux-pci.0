Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:38564 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeGSUrV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jul 2018 16:47:21 -0400
From: Thomas Tai <thomas.tai@oracle.com>
To: thomas.tai@oracle.com, bhelgaas@google.com, keith.busch@intel.com
Cc: linux-pci@vger.kernel.org, poza@codeaurora.org
Subject: [PATCH V3, 1/1] PCI/AER: fix use-after-free in pcie_do_fatal_recovery
Date: Thu, 19 Jul 2018 14:02:35 -0600
Message-Id: <1532030555-7177-2-git-send-email-thomas.tai@oracle.com>
In-Reply-To: <1532030555-7177-1-git-send-email-thomas.tai@oracle.com>
References: <1532030555-7177-1-git-send-email-thomas.tai@oracle.com>
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
 FS:  0000000000000000(0000) GS:ffff8c2d7fc00000(0000)
knlGS:0000000000000000
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

To fix this issue, pci_dev_get is used to keep the device around.
After all error devices are processed, pci_dev_put is then called
to decrement the reference count for all error devices.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 drivers/pci/pcie/aer.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..6e5e6a5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -657,6 +657,10 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
 	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
+		/* increment reference count to keep the dev
+		 * around until remove_source_device()
+		 */
+		pci_dev_get(dev);
 		e_info->dev[e_info->error_dev_num] = dev;
 		e_info->error_dev_num++;
 		return 0;
@@ -665,6 +669,21 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 }
 
 /**
+ * remove_source_device -remove error devices from the e_info
+ * @e_info: pointer to error info
+ */
+static void remove_source_device(struct aer_err_info *e_info)
+{
+	struct pci_dev *dev;
+
+	while (e_info->error_dev_num > 0) {
+		e_info->error_dev_num--;
+		dev = e_info->dev[e_info->error_dev_num];
+		pci_dev_put(dev);
+	}
+}
+
+/**
  * is_error_source - check whether the device is source of reported error
  * @dev: pointer to pci_dev to be checked
  * @e_info: pointer to reported error info
@@ -976,8 +995,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 			e_info->multi_error_valid = 0;
 		aer_print_port_info(pdev, e_info);
 
-		if (find_source_device(pdev, e_info))
+		if (find_source_device(pdev, e_info)) {
 			aer_process_err_devices(e_info);
+			remove_source_device(e_info);
+		}
 	}
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
@@ -995,8 +1016,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 
 		aer_print_port_info(pdev, e_info);
 
-		if (find_source_device(pdev, e_info))
+		if (find_source_device(pdev, e_info)) {
 			aer_process_err_devices(e_info);
+			remove_source_device(e_info);
+		}
 	}
 }
 
-- 
1.8.3.1
