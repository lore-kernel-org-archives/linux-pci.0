Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35847 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbbHLLEb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 07:04:31 -0400
Received: by ykay144 with SMTP id y144so10500964yka.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2015 04:04:30 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: designware: Mark the msi cascade handler IRQF_NO_THREAD
Date: Wed, 12 Aug 2015 19:04:17 +0800
Message-Id: <1439377457-3296-1-git-send-email-haokexin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The primary irq handler is supposed to run in hard irq context and
the desc->lock also need to be acquired with irq disabled. Violating
these rules will definitely cause deadlock or weird things.

For a cascade irq handler we must make sure that it can't be threaded,
otherwise the primary irq handler of the second level will be executed
in the thread context. The following is the kernel waring after we
force threading of all the irq handlers vi kernel command parameter
"threadirqs" on a imx6q-sabresd board:
   [ INFO: inconsistent lock state ]
   4.2.0-rc3-next-20150723 #28 Not tainted
   ---------------------------------
   inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
   irq/21-mx6-pcie/62 [HC0[0]:SC0[2]:HE1:SE0] takes:
    (&irq_desc_lock_class){?.-...}, at: [<80078d94>] handle_simple_irq+0x1c/0xc0
   {IN-HARDIRQ-W} state was registered at:
     [<8006aa70>] lock_acquire+0x74/0x94
     [<807acc6c>] _raw_spin_lock+0x34/0x44
     [<8007900c>] handle_fasteoi_irq+0x20/0x1b8
     [<80075720>] generic_handle_irq+0x28/0x38
     [<80075864>] __handle_domain_irq+0x6c/0xe0
     [<80009558>] gic_handle_irq+0x28/0x68
     [<80013b64>] __irq_svc+0x44/0x5c
     [<807ad400>] _raw_spin_unlock_irq+0x30/0x34
     [<8004cffc>] finish_task_switch+0xc0/0x218
     [<807a7a10>] __schedule+0x248/0x6e0
     [<807a7fac>] schedule+0x38/0x9c
     [<807a8240>] schedule_preempt_disabled+0x10/0x14
     [<80063f8c>] cpu_startup_entry+0xfc/0x1f8
     [<8079f640>] rest_init+0x130/0x16c
     [<80a55ca4>] start_kernel+0x374/0x3e8
     [<1000807c>] 0x1000807c
   irq event stamp: 16
   hardirqs last  enabled at (15): [<807ad3fc>] _raw_spin_unlock_irq+0x2c/0x34
   hardirqs last disabled at (14): [<807acd80>] _raw_spin_lock_irq+0x20/0x58
   softirqs last  enabled at (0): [<800283d8>] copy_process.isra.58+0x3bc/0x1504
   softirqs last disabled at (16): [<80076f08>] irq_forced_thread_fn+0x0/0x68

   other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(&irq_desc_lock_class);
     <Interrupt>
       lock(&irq_desc_lock_class);

    *** DEADLOCK ***

   no locks held by irq/21-mx6-pcie/62.

   stack backtrace:
   CPU: 0 PID: 62 Comm: irq/21-mx6-pcie Not tainted 4.2.0-rc3-next-20150723 #28
   Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
   Backtrace:
   [<80012dc4>] (dump_backtrace) from [<80012f64>] (show_stack+0x18/0x1c)
    r6:be3eeb78 r5:00000000 r4:00000000 r3:00000000
   [<80012f4c>] (show_stack) from [<807a4b50>] (dump_stack+0x80/0x9c)
   [<807a4ad0>] (dump_stack) from [<807a2efc>] (print_usage_bug+0x270/0x2e4)
    r5:be3ee780 r4:80c579ec
   [<807a2c8c>] (print_usage_bug) from [<8006874c>] (mark_lock+0x5b4/0x6e0)
    r10:80c579ec r9:800678e0 r8:be3ee780 r7:00000000 r6:80c579ec r5:be3eeb78
    r4:00000002
   [<80068198>] (mark_lock) from [<80068f70>] (__lock_acquire+0x6f8/0x1e20)
    r10:00000001 r9:be3eeb78 r8:be3ee780 r7:00000008 r6:000003f8 r5:be3ee780
    r4:00000000
   [<80068878>] (__lock_acquire) from [<8006aa70>] (lock_acquire+0x74/0x94)
    r10:00000001 r9:00000001 r8:00000000 r7:00000001 r6:00000001 r5:60030013
    r4:00000000
   [<8006a9fc>] (lock_acquire) from [<807acc6c>] (_raw_spin_lock+0x34/0x44)
    r6:0000012c r5:00000001 r4:be1f4d64
   [<807acc38>] (_raw_spin_lock) from [<80078d94>] (handle_simple_irq+0x1c/0xc0)
    r5:be1f4d64 r4:be1f4d00
   [<80078d78>] (handle_simple_irq) from [<80075720>] (generic_handle_irq+0x28/0x38)
    r5:be28ee20 r4:0000012c
   [<800756f8>] (generic_handle_irq) from [<80321914>] (dw_handle_msi_irq+0x68/0x90)
    r4:00000001 r3:00000002
   [<803218ac>] (dw_handle_msi_irq) from [<8032265c>] (imx6_pcie_msi_handler+0x14/0x18)
    r7:80076f08 r6:be39efc0 r5:be154000 r4:be39efc0
   [<80322648>] (imx6_pcie_msi_handler) from [<80076f38>] (irq_forced_thread_fn+0x30/0x68)
   [<80076f08>] (irq_forced_thread_fn) from [<80076cb4>] (irq_thread+0x14c/0x19c)
    r6:be39efc0 r5:be154000 r4:be39efe0 r3:00000004
   [<80076b68>] (irq_thread) from [<80047f80>] (kthread+0xdc/0xf8)
    r10:00000000 r9:00000000 r8:00000000 r7:80076b68 r6:be39efc0 r5:be3a1000
    r4:00000000
   [<80047ea4>] (kthread) from [<8000fa38>] (ret_from_fork+0x14/0x3c)
    r7:00000000 r6:00000000 r5:80047ea4 r4:be3a1000

In general, we can use function irq_set_chained_handler_and_data()
to prevent the above happen. But for a irq which may be shared with
other device or function, we have no choice but use the
devm_request_irq() with IRQF_NO_THREAD set explicitly.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2:
  - Update commit log
  - Squash the changes for other drivers into this one

 drivers/pci/host/pci-dra7xx.c     | 3 ++-
 drivers/pci/host/pci-exynos.c     | 3 ++-
 drivers/pci/host/pci-imx6.c       | 3 ++-
 drivers/pci/host/pcie-spear13xx.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 80db09e47800..66aa9286cfc8 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -284,7 +284,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	}
 
 	ret = devm_request_irq(&pdev->dev, pp->irq,
-			       dra7xx_pcie_msi_irq_handler, IRQF_SHARED,
+			       dra7xx_pcie_msi_irq_handler,
+			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "dra7-pcie-msi",	pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
index f9f468d9a819..7b6be7791d33 100644
--- a/drivers/pci/host/pci-exynos.c
+++ b/drivers/pci/host/pci-exynos.c
@@ -523,7 +523,8 @@ static int __init exynos_add_pcie_port(struct pcie_port *pp,
 
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
 					exynos_pcie_msi_irq_handler,
-					IRQF_SHARED, "exynos-pcie", pp);
+					IRQF_SHARED | IRQF_NO_THREAD,
+					"exynos-pcie", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request msi irq\n");
 			return ret;
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 233a196c6e66..fd5eb2e34fc0 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -544,7 +544,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 
 		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
 				       imx6_pcie_msi_handler,
-				       IRQF_SHARED, "mx6-pcie-msi", pp);
+				       IRQF_SHARED | IRQF_NO_THREAD,
+				       "mx6-pcie-msi", pp);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to request MSI irq\n");
 			return -ENODEV;
diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index c49fbdc0f6e4..338788b28631 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -280,7 +280,8 @@ static int spear13xx_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
-			       IRQF_SHARED, "spear1340-pcie", pp);
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       "spear1340-pcie", pp);
 	if (ret) {
 		dev_err(dev, "failed to request irq %d\n", pp->irq);
 		return ret;
-- 
2.1.0

