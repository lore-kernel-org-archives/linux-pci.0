Return-Path: <SRS0=VK9V=S5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E8EC43219
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B292087C
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="WDBMFNsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfD0TNS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:13:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41348 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD0TNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Apr 2019 15:13:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id g8so4440422otl.8
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2019 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Taxar/tS066Rb3ge8ultgK1SdxHnCGiKwsi4apng9DM=;
        b=WDBMFNsBJoL+IlyPxySaxkgxgr5zphNohGgVD5EatKxVHkNzcjVzLVocc0N9cIdnwU
         fzJODsCbG9U+GXtB3JLwO2JpHxOHcAei86cbuGLiihWaPKdxgtpBkcisGyA+ZvyZY0Va
         MG9vwyvPJ0MycXks/K+yUKbwsx+7YfoWKBooPmDUw9VDLVCvRCRztLWg9ZXVPc5exgG6
         WKE469iiJiRdwRmyBiplzbP2HpJ9/TJVUfDurj/nXcosRyuGXVM3/Yh7IdLSs9yapfgQ
         8DAHZwbiQthDLccZqRHLTO4C9CxndbOVNDdLw81ES1q3RpZabiKdJZr18hFs160JGQT8
         PMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Taxar/tS066Rb3ge8ultgK1SdxHnCGiKwsi4apng9DM=;
        b=qaLPstV3oen41nw6l8zt4DIbq20xjmUm/azVIORTY++REy01c25XMDM/fIbRsjLdXG
         DrlMGPhTI5ulp/8ZThNuuorhvazulq1jDwGrUDBO2OFs4ZIxuBgyKZQa2lVZSiygAwVE
         nCQhY07CawnvM0wEBaJdBc9JoU7S2jLE1/kQnPZpjrSmupfRLOLyWebR5We8wU6hQTzI
         guFgzp8hiIrwRgvwkBJIVedFzoTi7YYyFtxtrMhh0ZlsX+EtrGv5GgjU0HWAhzlK1E7x
         6744ZnhIr3Wjyujtg8WwkTnF7pkPVR2u72ktohKx3xJOz1Nl3XO7qnPpGFR5kjJq+YUI
         hmYg==
X-Gm-Message-State: APjAAAXgGHHcYtC+UdsnhwAS1XJJiBIVQav2DiovEp0flkVN4aF5vm3w
        j0pjleb1bmtyGQQIm4zlaHeF2vD7kZ5PIw==
X-Google-Smtp-Source: APXvYqxbfNFZaVxqWrMc4B8Ggs+xvZYXSRYe4u1YZCl/2Fd1nVEj7dPqK9j7ZvzIJ0z7t2hVueZP+g==
X-Received: by 2002:a9d:604c:: with SMTP id v12mr1101973otj.304.1556392396768;
        Sat, 27 Apr 2019 12:13:16 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:3d43:9acc:6ecc:a72c])
        by smtp.gmail.com with ESMTPSA id n10sm11810956otl.58.2019.04.27.12.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 12:13:15 -0700 (PDT)
From:   fred@fredlawl.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 2/4] PCI: pciehp: Replace ctrl_*() with pci_*()
Date:   Sat, 27 Apr 2019 14:13:02 -0500
Message-Id: <20190427191304.32502-3-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427191304.32502-1-fred@fredlawl.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Hotplug useses custom ctrl_*() dev_*() printk wrappers for logging
messages. To make hotplug conform to pci logging, replace uses of these
wrappers with pci_*() printk wrappers. In addition, replace any
printk() calls with pr_*() wrappers.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/hotplug/pciehp_core.c |  22 +++--
 drivers/pci/hotplug/pciehp_ctrl.c |  86 +++++++++--------
 drivers/pci/hotplug/pciehp_hpc.c  | 149 ++++++++++++++++--------------
 drivers/pci/hotplug/pciehp_pci.c  |  10 +-
 4 files changed, 145 insertions(+), 122 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index fc5366b50e95..430a47556813 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -51,6 +51,7 @@ static int get_adapter_status(struct hotplug_slot *slot, u8 *value);
 
 static int init_slot(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl->pcie->port;
 	struct hotplug_slot_ops *ops;
 	char name[SLOT_NAME_SIZE];
 	int retval;
@@ -82,7 +83,7 @@ static int init_slot(struct controller *ctrl)
 	retval = pci_hp_initialize(&ctrl->hotplug_slot,
 				   ctrl->pcie->port->subordinate, 0, name);
 	if (retval) {
-		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
+		pci_err(pdev, "pci_hp_initialize failed: error %d\n", retval);
 		kfree(ops);
 	}
 	return retval;
@@ -175,6 +176,7 @@ static int pciehp_probe(struct pcie_device *dev)
 {
 	int rc;
 	struct controller *ctrl;
+	struct pci_dev *pdev;
 
 	/* If this is not a "hotplug" service, we have no business here. */
 	if (dev->service != PCIE_PORT_SERVICE_HP)
@@ -182,39 +184,39 @@ static int pciehp_probe(struct pcie_device *dev)
 
 	if (!dev->port->subordinate) {
 		/* Can happen if we run out of bus numbers during probe */
-		dev_err(&dev->device,
-			"Hotplug bridge without secondary bus, ignoring\n");
+		pci_err(dev->port, "Hotplug bridge without secondary bus, ignoring\n");
 		return -ENODEV;
 	}
 
 	ctrl = pcie_init(dev);
 	if (!ctrl) {
-		dev_err(&dev->device, "Controller initialization failed\n");
+		pci_err(dev->port, "Controller initialization failed\n");
 		return -ENODEV;
 	}
 	set_service_data(dev, ctrl);
+	pdev = ctrl->pcie->port;
 
 	/* Setup the slot information structures */
 	rc = init_slot(ctrl);
 	if (rc) {
 		if (rc == -EBUSY)
-			ctrl_warn(ctrl, "Slot already registered by another hotplug driver\n");
+			pci_warn(pdev, "Slot already registered by another hotplug driver\n");
 		else
-			ctrl_err(ctrl, "Slot initialization failed (%d)\n", rc);
+			pci_err(pdev, "Slot initialization failed (%d)\n", rc);
 		goto err_out_release_ctlr;
 	}
 
 	/* Enable events after we have setup the data structures */
 	rc = pcie_init_notification(ctrl);
 	if (rc) {
-		ctrl_err(ctrl, "Notification initialization failed (%d)\n", rc);
+		pci_err(pdev, "Notification initialization failed (%d)\n", rc);
 		goto err_out_free_ctrl_slot;
 	}
 
 	/* Publish to user space */
 	rc = pci_hp_add(&ctrl->hotplug_slot);
 	if (rc) {
-		ctrl_err(ctrl, "Publication to user space failed (%d)\n", rc);
+		pci_err(pdev, "Publication to user space failed (%d)\n", rc);
 		goto err_out_shutdown_notification;
 	}
 
@@ -328,9 +330,9 @@ int __init pcie_hp_init(void)
 	int retval = 0;
 
 	retval = pcie_port_service_register(&hpdriver_portdrv);
-	dbg("pcie_port_service_register = %d\n", retval);
+	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
-		dbg("Failure to register service\n");
+		pr_debug("Failure to register service\n");
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c29f6e..345c02b1e8d7 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -54,6 +54,7 @@ static void set_slot_off(struct controller *ctrl)
 static int board_added(struct controller *ctrl)
 {
 	int retval = 0;
+	struct pci_dev *pdev = ctrl->pcie->port;
 	struct pci_bus *parent = ctrl->pcie->port->subordinate;
 
 	if (POWER_CTRL(ctrl)) {
@@ -68,13 +69,13 @@ static int board_added(struct controller *ctrl)
 	/* Check link training status */
 	retval = pciehp_check_link_status(ctrl);
 	if (retval) {
-		ctrl_err(ctrl, "Failed to check link status\n");
+		pci_err(pdev, "Failed to check link status\n");
 		goto err_exit;
 	}
 
 	/* Check for a power fault */
 	if (ctrl->power_fault_detected || pciehp_query_power_fault(ctrl)) {
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+		pci_err(pdev, "Slot(%s): Power fault\n", slot_name(ctrl));
 		retval = -EIO;
 		goto err_exit;
 	}
@@ -82,8 +83,8 @@ static int board_added(struct controller *ctrl)
 	retval = pciehp_configure_device(ctrl);
 	if (retval) {
 		if (retval != -EEXIST) {
-			ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
-				 pci_domain_nr(parent), parent->number);
+			pci_err(pdev, "Cannot add device at %04x:%02x:00\n",
+				pci_domain_nr(parent), parent->number);
 			goto err_exit;
 		}
 	}
@@ -152,18 +153,20 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 
 void pciehp_handle_button_press(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl->pcie->port;
+
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
 	case OFF_STATE:
 	case ON_STATE:
 		if (ctrl->state == ON_STATE) {
 			ctrl->state = BLINKINGOFF_STATE;
-			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Powering off due to button press\n",
+				 slot_name(ctrl));
 		} else {
 			ctrl->state = BLINKINGON_STATE;
-			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s) Powering on due to button press\n",
+				 slot_name(ctrl));
 		}
 		/* blink green LED and turn off amber */
 		pciehp_green_led_blink(ctrl);
@@ -177,7 +180,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		 * press the attention again before the 5 sec. limit
 		 * expires to cancel hot-add or hot-remove
 		 */
-		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(ctrl));
+		pci_info(pdev, "Slot(%s): Button cancel\n", slot_name(ctrl));
 		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
@@ -187,12 +190,12 @@ void pciehp_handle_button_press(struct controller *ctrl)
 			pciehp_green_led_off(ctrl);
 		}
 		pciehp_set_attention_status(ctrl, 0);
-		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
-			  slot_name(ctrl));
+		pci_info(pdev, "Slot(%s): Action canceled due to button press\n",
+			 slot_name(ctrl));
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
+		pci_err(pdev, "Slot(%s): Ignoring invalid state %#x\n",
+			slot_name(ctrl), ctrl->state);
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
@@ -216,6 +219,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	bool present, link_active;
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
@@ -230,11 +234,11 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (events & PCI_EXP_SLTSTA_DLLSC)
-			ctrl_info(ctrl, "Slot(%s): Link Down\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Link Down\n",
+				 slot_name(ctrl));
 		if (events & PCI_EXP_SLTSTA_PDC)
-			ctrl_info(ctrl, "Slot(%s): Card not present\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Card not present\n",
+				 slot_name(ctrl));
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
@@ -259,11 +263,11 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (present)
-			ctrl_info(ctrl, "Slot(%s): Card present\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Card present\n",
+				 slot_name(ctrl));
 		if (link_active)
-			ctrl_info(ctrl, "Slot(%s): Link Up\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Link Up\n",
+				 slot_name(ctrl));
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
@@ -274,13 +278,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 
 static int __pciehp_enable_slot(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl->pcie->port;
 	u8 getstatus = 0;
 
 	if (MRL_SENS(ctrl)) {
 		pciehp_get_latch_status(ctrl, &getstatus);
 		if (getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Latch open\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Latch open\n",
+				 slot_name(ctrl));
 			return -ENODEV;
 		}
 	}
@@ -288,8 +293,8 @@ static int __pciehp_enable_slot(struct controller *ctrl)
 	if (POWER_CTRL(ctrl)) {
 		pciehp_get_power_status(ctrl, &getstatus);
 		if (getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Already enabled\n",
+				 slot_name(ctrl));
 			return 0;
 		}
 	}
@@ -316,13 +321,14 @@ static int pciehp_enable_slot(struct controller *ctrl)
 
 static int __pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
 {
+	struct pci_dev *pdev = ctrl->pcie->port;
 	u8 getstatus = 0;
 
 	if (POWER_CTRL(ctrl)) {
 		pciehp_get_power_status(ctrl, &getstatus);
 		if (!getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-				  slot_name(ctrl));
+			pci_info(pdev, "Slot(%s): Already disabled\n",
+				 slot_name(ctrl));
 			return -EINVAL;
 		}
 	}
@@ -349,6 +355,7 @@ static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
@@ -365,18 +372,18 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 			   !atomic_read(&ctrl->pending_events));
 		return ctrl->request_result;
 	case POWERON_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
-			  slot_name(ctrl));
+		pci_info(pdev, "Slot(%s): Already in powering on state\n",
+			 slot_name(ctrl));
 		break;
 	case BLINKINGOFF_STATE:
 	case ON_STATE:
 	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-			  slot_name(ctrl));
+		pci_info(pdev, "Slot(%s): Already enabled\n",
+			 slot_name(ctrl));
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
+		pci_err(pdev, "Slot(%s): Invalid state %#x\n",
+			slot_name(ctrl), ctrl->state);
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
@@ -387,6 +394,7 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
@@ -398,18 +406,18 @@ int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 			   !atomic_read(&ctrl->pending_events));
 		return ctrl->request_result;
 	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
-			  slot_name(ctrl));
+		pci_info(pdev, "Slot(%s): Already in powering off state\n",
+			 slot_name(ctrl));
 		break;
 	case BLINKINGON_STATE:
 	case OFF_STATE:
 	case POWERON_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-			  slot_name(ctrl));
+		pci_info(pdev, "Slot(%s): Already disabled\n",
+			 slot_name(ctrl));
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
+		pci_err(pdev, "Slot(%s): Invalid state %#x\n",
+			slot_name(ctrl), ctrl->state);
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6a2365cd794e..5e5631fd0171 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -36,6 +36,7 @@ static int pciehp_poll(void *data);
 static inline int pciehp_request_irq(struct controller *ctrl)
 {
 	int retval, irq = ctrl->pcie->irq;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 
 	if (pciehp_poll_mode) {
 		ctrl->poll_thread = kthread_run(&pciehp_poll, ctrl,
@@ -48,8 +49,8 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
 				      IRQF_SHARED, MY_NAME, ctrl);
 	if (retval)
-		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
-			 irq);
+		pci_err(pdev, "Cannot get irq %d for the hotplug controller\n",
+			irq);
 	return retval;
 }
 
@@ -69,8 +70,8 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 	while (true) {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 		if (slot_status == (u16) ~0) {
-			ctrl_info(ctrl, "%s: no response from device\n",
-				  __func__);
+			pci_info(pdev, "%s: no response from device\n",
+				 __func__);
 			return 0;
 		}
 
@@ -89,6 +90,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 
 static void pcie_wait_cmd(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
 	unsigned long duration = msecs_to_jiffies(msecs);
 	unsigned long cmd_timeout = ctrl->cmd_started + duration;
@@ -122,9 +124,9 @@ static void pcie_wait_cmd(struct controller *ctrl)
 		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
 
 	if (!rc)
-		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
-			  ctrl->slot_ctrl,
-			  jiffies_to_msecs(jiffies - ctrl->cmd_started));
+		pci_info(pdev, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
+			 ctrl->slot_ctrl,
+			 jiffies_to_msecs(jiffies - ctrl->cmd_started));
 }
 
 #define CC_ERRATUM_MASK		(PCI_EXP_SLTCTL_PCC |	\
@@ -147,7 +149,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	if (slot_ctrl == (u16) ~0) {
-		ctrl_info(ctrl, "%s: no response from device\n", __func__);
+		pci_info(pdev, "%s: no response from device\n", __func__);
 		goto out;
 	}
 
@@ -209,7 +211,7 @@ bool pciehp_check_link_active(struct controller *ctrl)
 	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
 
 	if (ret)
-		ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
+		pci_dbg(pdev, "%s: lnk_status = %x\n", __func__, lnk_status);
 
 	return ret;
 }
@@ -233,9 +235,9 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	} while (delay > 0);
 
 	if (count > 1 && pciehp_debug)
-		printk(KERN_DEBUG "pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
-			pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			PCI_FUNC(devfn), count, step, l);
+		pr_debug("pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
+			 pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn), count, step, l);
 
 	return found;
 }
@@ -258,11 +260,11 @@ int pciehp_check_link_status(struct controller *ctrl)
 			   &ctrl->pending_events);
 
 	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
+	pci_dbg(pdev, "%s: lnk_status = %x\n", __func__, lnk_status);
 	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
 	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
-		ctrl_err(ctrl, "link training error: status %#06x\n",
-			 lnk_status);
+		pci_err(pdev, "link training error: status %#06x\n",
+			lnk_status);
 		return -1;
 	}
 
@@ -287,7 +289,7 @@ static int __pciehp_link_set(struct controller *ctrl, bool enable)
 		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
 
 	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
-	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
+	pci_dbg(pdev, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
 	return 0;
 }
 
@@ -319,8 +321,8 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 	pci_config_pm_runtime_get(pdev);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
 	pci_config_pm_runtime_put(pdev);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
+	pci_dbg(pdev, "%s: SLOTCTRL %x, value read %x\n", __func__,
+		pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
 	switch (slot_ctrl & PCI_EXP_SLTCTL_AIC) {
 	case PCI_EXP_SLTCTL_ATTN_IND_ON:
@@ -346,8 +348,8 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status)
 	u16 slot_ctrl;
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
+	pci_dbg(pdev, "%s: SLOTCTRL %x value read %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL, slot_ctrl);
 
 	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
 	case PCI_EXP_SLTCTL_PWR_ON:
@@ -418,6 +420,7 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 
 void pciehp_set_attention_status(struct controller *ctrl, u8 value)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_cmd;
 
 	if (!ATTN_LED(ctrl))
@@ -437,44 +440,50 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
 		return;
 	}
 	pcie_write_cmd_nowait(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL, slot_cmd);
 }
 
 void pciehp_green_led_on(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+
 	if (!PWR_LED(ctrl))
 		return;
 
 	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
 			      PCI_EXP_SLTCTL_PIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_IND_ON);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL,
+		PCI_EXP_SLTCTL_PWR_IND_ON);
 }
 
 void pciehp_green_led_off(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+
 	if (!PWR_LED(ctrl))
 		return;
 
 	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
 			      PCI_EXP_SLTCTL_PIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_IND_OFF);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL,
+		PCI_EXP_SLTCTL_PWR_IND_OFF);
 }
 
 void pciehp_green_led_blink(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+
 	if (!PWR_LED(ctrl))
 		return;
 
 	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
 			      PCI_EXP_SLTCTL_PIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_IND_BLINK);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL,
+		PCI_EXP_SLTCTL_PWR_IND_BLINK);
 }
 
 int pciehp_power_on_slot(struct controller *ctrl)
@@ -491,23 +500,25 @@ int pciehp_power_on_slot(struct controller *ctrl)
 	ctrl->power_fault_detected = 0;
 
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_ON);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL,
+		PCI_EXP_SLTCTL_PWR_ON);
 
 	retval = pciehp_link_enable(ctrl);
 	if (retval)
-		ctrl_err(ctrl, "%s: Can not enable the link!\n", __func__);
+		pci_err(pdev, "%s: Can not enable the link!\n", __func__);
 
 	return retval;
 }
 
 void pciehp_power_off_slot(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_OFF);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL,
+		PCI_EXP_SLTCTL_PWR_OFF);
 }
 
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
@@ -542,7 +553,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
 	if (status == (u16) ~0) {
-		ctrl_info(ctrl, "%s: no response from device\n", __func__);
+		pci_info(pdev, "%s: no response from device\n", __func__);
 		if (parent)
 			pm_runtime_put(parent);
 		return IRQ_NONE;
@@ -570,7 +581,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
-	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
+	pci_dbg(pdev, "pending interrupts %#06x from Slot Status\n", events);
 	if (parent)
 		pm_runtime_put(parent);
 
@@ -590,7 +601,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	}
 
 	if (pdev->ignore_hotplug) {
-		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", events);
+		pci_dbg(pdev, "ignoring hotplug event %#06x\n", events);
 		return IRQ_HANDLED;
 	}
 
@@ -627,15 +638,15 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
-		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
-			  slot_name(ctrl));
+		pci_info(pdev, "Slot(%s): Attention button pressed\n",
+			 slot_name(ctrl));
 		pciehp_handle_button_press(ctrl);
 	}
 
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+		pci_err(pdev, "Slot(%s): Power fault\n", slot_name(ctrl));
 		pciehp_set_attention_status(ctrl, 1);
 		pciehp_green_led_off(ctrl);
 	}
@@ -679,6 +690,7 @@ static int pciehp_poll(void *data)
 
 static void pcie_enable_notification(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 cmd, mask;
 
 	/*
@@ -711,12 +723,13 @@ static void pcie_enable_notification(struct controller *ctrl)
 		PCI_EXP_SLTCTL_DLLSCE);
 
 	pcie_write_cmd_nowait(ctrl, cmd, mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL, cmd);
 }
 
 static void pcie_disable_notification(struct controller *ctrl)
 {
+	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 mask;
 
 	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
@@ -724,8 +737,8 @@ static void pcie_disable_notification(struct controller *ctrl)
 		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
 		PCI_EXP_SLTCTL_DLLSCE);
 	pcie_write_cmd(ctrl, 0, mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL, 0);
 }
 
 void pcie_clear_hotplug_events(struct controller *ctrl)
@@ -785,15 +798,15 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	stat_mask |= PCI_EXP_SLTSTA_DLLSC;
 
 	pcie_write_cmd(ctrl, 0, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL, 0);
 
 	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
+	pci_dbg(pdev, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		pci_pcie_cap(pdev) + PCI_EXP_SLTCTL, ctrl_mask);
 
 	up_write(&ctrl->reset_lock);
 	return rc;
@@ -825,11 +838,11 @@ static inline void dbg_ctrl(struct controller *ctrl)
 	if (!pciehp_debug)
 		return;
 
-	ctrl_info(ctrl, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
+	pci_info(pdev, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &reg16);
-	ctrl_info(ctrl, "Slot Status            : 0x%04x\n", reg16);
+	pci_info(pdev, "Slot Status            : 0x%04x\n", reg16);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &reg16);
-	ctrl_info(ctrl, "Slot Control           : 0x%04x\n", reg16);
+	pci_info(pdev, "Slot Control           : 0x%04x\n", reg16);
 }
 
 #define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
@@ -881,19 +894,19 @@ struct controller *pcie_init(struct pcie_device *dev)
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
 		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
 
-	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
-		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
-		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_AIP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_PIP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_HPC),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
-		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
-		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
+	pci_info(pdev, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
+		 (slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_AIP),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_PIP),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_HPC),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
+		 FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
+		 FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
+		 pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
 
 	/*
 	 * If empty slot's power status is on, turn power off.  The IRQ isn't
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index b9c1396db6fe..55967ce567f6 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -42,8 +42,8 @@ int pciehp_configure_device(struct controller *ctrl)
 		 * The device is already there. Either configured by the
 		 * boot firmware or a previous hotplug event.
 		 */
-		ctrl_dbg(ctrl, "Device %s already exists at %04x:%02x:00, skipping hot-add\n",
-			 pci_name(dev), pci_domain_nr(parent), parent->number);
+		pci_dbg(bridge, "Device %s already exists at %04x:%02x:00, skipping hot-add\n",
+			pci_name(dev), pci_domain_nr(parent), parent->number);
 		pci_dev_put(dev);
 		ret = -EEXIST;
 		goto out;
@@ -51,7 +51,7 @@ int pciehp_configure_device(struct controller *ctrl)
 
 	num = pci_scan_slot(parent, PCI_DEVFN(0, 0));
 	if (num == 0) {
-		ctrl_err(ctrl, "No new device found\n");
+		pci_err(bridge, "No new device found\n");
 		ret = -ENODEV;
 		goto out;
 	}
@@ -85,8 +85,8 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	struct pci_bus *parent = ctrl->pcie->port->subordinate;
 	u16 command;
 
-	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
-		 __func__, pci_domain_nr(parent), parent->number);
+	pci_dbg(ctrl->pcie->port, "%s: domain:bus:dev = %04x:%02x:00\n",
+		__func__, pci_domain_nr(parent), parent->number);
 
 	if (!presence)
 		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
-- 
2.17.1

