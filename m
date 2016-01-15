Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39550 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcAOTCD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 14:02:03 -0500
Date: Fri, 15 Jan 2016 19:36:25 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2] pci: aer: wait till the workqueue completes before free
 memory
Message-ID: <20160115183625.GG3781@linutronix.de>
References: <20151217143243.GA9654@linutronix.de>
 <20160106232758.GE16231@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160106232758.GE16231@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I start a binary which should flash the FPGA and re-enumare the PCI-BUS
and find a new device. It works most of the time. With SLUB debug it
crashes on each iteration with something like this (compressed output):

| pcieport 0000:00:00.0: AER: Multiple Corrected error received: id=0000
| Unable to handle kernel paging request for data at address 0x27ef9e3e
| Faulting instruction address: 0x602f5328
| Oops: Kernel access of bad area, sig: 11 [#1]
| Workqueue: events aer_isr
| GPR24: dd6aa000 6b6b6b6b 605f8378 605f8360 d99b12c0 604fc674 606b1704 d99b12c0
| NIP [602f5328] pci_walk_bus+0xd4/0x104

Register 25 has the user-after magic. As it turns out, the old PCIe
device is leaving, generates an error before it left, aer_irq() is fired,
it schedules a work item. What happens now is that free_irq() is
invoked, all resources are gone *before* the aes_isr() work item is
completed.
So to fix this, I flush the workqueue to ensure that there is no more
work pending.
The wait_event() on wait_release should actually synchronized against
removal. However the condition (->prod_idx == ->cons_idx) is made true
before the function completes (aer_isr_one_error() is invoked right
after that) so it does not fulfill its purpose. Therefore I remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2:
    - remove wait_release since it is broken on SMP
    - don't flush the workqueue only if we have ->isr set because the
      workqueue could be scheduled via the inject module.

*compile* tested only because I don't have the HW at the moment.

Bjorn, this could deserve a stable tag. However it seems to have been
like that even in v2.6.20.

 drivers/pci/pcie/aer/aerdrv.c      | 4 +---
 drivers/pci/pcie/aer/aerdrv.h      | 1 -
 drivers/pci/pcie/aer/aerdrv_core.c | 2 --
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 0bf82a20a0fb..48d21e0edd56 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -262,7 +262,6 @@ static struct aer_rpc *aer_alloc_rpc(struct pcie_device *dev)
 	rpc->rpd = dev;
 	INIT_WORK(&rpc->dpc_handler, aer_isr);
 	mutex_init(&rpc->rpc_mutex);
-	init_waitqueue_head(&rpc->wait_release);
 
 	/* Use PCIe bus function to store rpc into PCIe device */
 	set_service_data(dev, rpc);
@@ -285,8 +284,7 @@ static void aer_remove(struct pcie_device *dev)
 		if (rpc->isr)
 			free_irq(dev->irq, dev);
 
-		wait_event(rpc->wait_release, rpc->prod_idx == rpc->cons_idx);
-
+		flush_work(&rpc->dpc_handler);
 		aer_disable_rootport(rpc);
 		kfree(rpc);
 		set_service_data(dev, NULL);
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 84420b7c9456..945c939a86c5 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -72,7 +72,6 @@ struct aer_rpc {
 					 * recovery on the same
 					 * root port hierarchy
 					 */
-	wait_queue_head_t wait_release;
 };
 
 struct aer_broadcast_data {
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index fba785e9df75..4e14de0f0f98 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -811,8 +811,6 @@ void aer_isr(struct work_struct *work)
 	while (get_e_source(rpc, &e_src))
 		aer_isr_one_error(p_device, &e_src);
 	mutex_unlock(&rpc->rpc_mutex);
-
-	wake_up(&rpc->wait_release);
 }
 
 /**
-- 
2.7.0.rc3

