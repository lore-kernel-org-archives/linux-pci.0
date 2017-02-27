Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1050.oracle.com ([141.146.126.70]:22241 "EHLO
        aserp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdB0Hx4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2017 02:53:56 -0500
From: Ethan Zhao <ethan.zhao@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ethan.kernel@gmail.com, ethan.zhao@oracle.com,
        babu.moger@oracle.com
Subject: [PATCH] pci: Prevent VPD access for QLogic ISP2722
Date: Mon, 27 Feb 2017 17:08:44 +0900
Message-Id: <1488182924-23334-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

QLogic ISP2722-based 16/32Gb Fibre Channel to PCIe Adapter has the VPD
access issue too, while read the common pci-sysfs access interface shown as

 /sys/devices/pci0000:00/0000:00:03.2/0000:0b:00.0/vpd

with simple 'cat' could cause system hang and panic:

[   48.219586] Kernel panic - not syncing: An NMI occurred. Depending on your system
 the reason for the NMI is logged in any one of the following resources:
[   48.219586] 1. Integrated Management Log (IML)
[   48.219586] 2. OA Syslog
[   48.219586] 3. OA Forward Progress Log
[   48.219586] 4. iLO Event Log
[   48.352034] CPU: 0 PID: 15070 Comm: udevadm Not tainted 4.1.12
[   48.390989] Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 12/27/2015
[   48.431201]  0000000000000086 000000007f0cdf51 ffff880c4fa05d58 ffffffff817193de
[   48.467185]  ffffffffa00b42d8 0000000000000075 ffff880c4fa05dd8 ffffffff81714072
[   48.502631]  0000000000000008 ffff880c4fa05de8 ffff880c4fa05d88 000000007f0cdf51
[   48.538427] Call Trace:
[   48.549991]  <NMI>  [<ffffffff817193de>] dump_stack+0x63/0x81
[   48.577496]  [<ffffffff81714072>] panic+0xd0/0x20e
[   48.600598]  [<ffffffffa00b390d>] hpwdt_pretimeout+0xdd/0xe0 [hpwdt]
[   48.630913]  [<ffffffff81021fc9>] ? sched_clock+0x9/0x10
[   48.656286]  [<ffffffff8101c101>] nmi_handle+0x91/0x170
[   48.681362]  [<ffffffff8101c10c>] ? nmi_handle+0x9c/0x170
[   48.707383]  [<ffffffff8101c5fe>] io_check_error+0x1e/0xa0
[   48.733603]  [<ffffffff8101c719>] default_do_nmi+0x99/0x140
[   48.759570]  [<ffffffff8101c8b4>] do_nmi+0xf4/0x170
[   48.782977]  [<ffffffff817232c5>] end_repeat_nmi+0x1a/0x1e
[   48.809290]  [<ffffffff815d724b>] ? pci_conf1_read+0xeb/0x120
[   48.837782]  [<ffffffff815d724b>] ? pci_conf1_read+0xeb/0x120
[   48.865045]  [<ffffffff815d724b>] ? pci_conf1_read+0xeb/0x120
[   48.892877]  <<EOE>>  [<ffffffff815db4b3>] raw_pci_read+0x23/0x40
[   48.923060]  [<ffffffff815db4fc>] pci_read+0x2c/0x30
[   48.947340]  [<ffffffff8136f612>] pci_user_read_config_word+0x72/0x110
[   48.978937]  [<ffffffff8136f746>] pci_vpd_pci22_wait+0x96/0x130
[   49.007983]  [<ffffffff8136ff9b>] pci_vpd_pci22_read+0xdb/0x1a0
[   49.036370]  [<ffffffff8136ea30>] pci_read_vpd+0x20/0x30
[   49.062608]  [<ffffffff8137d590>] read_vpd_attr+0x30/0x40
[   49.088627]  [<ffffffff8128e037>] sysfs_kf_bin_read+0x47/0x70
[   49.116383]  [<ffffffff8128d24e>] kernfs_fop_read+0xae/0x180
[   49.143396]  [<ffffffff8120dd97>] __vfs_read+0x37/0x100
[   49.169059]  [<ffffffff812ba7e4>] ? security_file_permission+0x84/0xa0
[   49.200526]  [<ffffffff8120e366>] ? rw_verify_area+0x56/0xe0
[   49.227578]  [<ffffffff8120e476>] vfs_read+0x86/0x140
[   49.252842]  [<ffffffff8120f3f5>] SyS_read+0x55/0xd0
[   49.277378]  [<ffffffff81720f2e>] system_call_fastpath+0x12/0x71
[   50.349812] Shutting down cpus with NMI
[   50.368388] Kernel Offset: disabled
[   50.385327] drm_kms_helper: panic occurred, switching back to text console

So blacklist the access to its VPD.

Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3a035e07..087a218 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2173,6 +2173,7 @@ static void quirk_blacklist_vpd(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
 		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
 
 /*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
-- 
1.8.3.1
