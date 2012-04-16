Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807Ab2DPQdG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:33:06 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so7133149dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:33:05 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Zink <dan.zink@compaq.com>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Dely Sy <dely.l.sy@intel.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 08/17] PCI: fix two race windows when probing/removing SHPC controller
Date: Tue, 17 Apr 2012 00:29:02 +0800
Message-Id: <1334593751-5916-9-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With current shpchp implementation, interrupt is enabled before corresponding
slot data structures are created. If interrupt happens immediately after
enabling the hotplug interrupt, shpchp_find_slot() may return NULL, thus
causes NULL pointer dereference. So create slot data structures before
enabling interrupt.

And cleanup_slots() is called to destroy slot data structures before disabling
interrupt, which may cause invalid memory access in shpc_isr().  So call
cleanup_slots() after disabling interrupt/removing the poll timer.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/shpchp.h      |    1 +
 drivers/pci/hotplug/shpchp_core.c |    6 +++---
 drivers/pci/hotplug/shpchp_hpc.c  |   36 +++++++++++++++++++++---------------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index ca64932..6691dc4 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -182,6 +182,7 @@ extern int shpchp_unconfigure_device(struct slot *p_slot);
 extern void cleanup_slots(struct controller *ctrl);
 extern void shpchp_queue_pushbutton_work(struct work_struct *work);
 extern int shpc_init( struct controller *ctrl, struct pci_dev *pdev);
+extern void shpc_enable_intr(struct controller *ctrl);
 
 static inline const char *slot_name(struct slot *slot)
 {
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 7414fd9..aaa66be 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -318,14 +318,14 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_release_ctlr;
 	}
 
+	shpc_enable_intr(ctrl);
+
 	rc = shpchp_create_ctrl_files(ctrl);
 	if (rc)
-		goto err_cleanup_slots;
+		goto err_out_release_ctlr;
 
 	return 0;
 
-err_cleanup_slots:
-	cleanup_slots(ctrl);
 err_out_release_ctlr:
 	ctrl->hpc_ops->release_ctlr(ctrl);
 err_out_free_ctrl:
diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index 75ba231..2bc6182 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -592,6 +592,13 @@ static void hpc_release_ctlr(struct controller *ctrl)
 		shpc_writel(ctrl, SLOT_REG(i), slot_reg);
 	}
 
+	if (shpchp_poll_mode)
+		del_timer(&ctrl->poll_timer);
+	else {
+		free_irq(ctrl->pci_dev->irq, ctrl);
+		pci_disable_msi(ctrl->pci_dev);
+	}
+
 	cleanup_slots(ctrl);
 
 	/*
@@ -603,13 +610,6 @@ static void hpc_release_ctlr(struct controller *ctrl)
 	serr_int &= ~SERR_INTR_RSVDZ_MASK;
 	shpc_writel(ctrl, SERR_INTR_ENABLE, serr_int);
 
-	if (shpchp_poll_mode)
-		del_timer(&ctrl->poll_timer);
-	else {
-		free_irq(ctrl->pci_dev->irq, ctrl);
-		pci_disable_msi(ctrl->pci_dev);
-	}
-
 	iounmap(ctrl->creg);
 	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
 }
@@ -1081,6 +1081,20 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
 	shpc_get_max_bus_speed(ctrl);
 	shpc_get_cur_bus_speed(ctrl);
 
+	return 0;
+
+	/* We end up here for the many possible ways to fail this API.  */
+abort_iounmap:
+	iounmap(ctrl->creg);
+abort:
+	return rc;
+}
+
+void shpc_enable_intr(struct controller *ctrl)
+{
+	u8 hp_slot;
+	u32 tempdword, slot_reg;
+
 	/*
 	 * Unmask all event interrupts of all slots
 	 */
@@ -1102,12 +1116,4 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
 		tempdword = shpc_readl(ctrl, SERR_INTR_ENABLE);
 		ctrl_dbg(ctrl, "SERR_INTR_ENABLE = %x\n", tempdword);
 	}
-
-	return 0;
-
-	/* We end up here for the many possible ways to fail this API.  */
-abort_iounmap:
-	iounmap(ctrl->creg);
-abort:
-	return rc;
 }
-- 
1.7.5.4

