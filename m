Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF3C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 19:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5CE2075C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 19:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714968;
	bh=7wUPbZkJITs8WNWaUZ2FE8UIAYfVCDgYIHQi6Mz7fTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DRN+zZ5myqtEqR6Tk4uNFB7SO7X4TN5hTttw6/pSjB537jFeRHUOZ6Olj5C/DSbJx
	 ba9KtqWJhNFU/wl5dTCt+WYA79MdcliwBK9FhVO3ABGV6j1dSCq2NrQG3rqYJDUHWn
	 AHjnlbKITQofZQiFsNeZSSzNxfJ57tVFLXKflXz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfC0SDv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732879AbfC0SDu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32E02082F;
        Wed, 27 Mar 2019 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709829;
        bh=7wUPbZkJITs8WNWaUZ2FE8UIAYfVCDgYIHQi6Mz7fTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fA7QzsmwKEPte3aF1varQjBXcoPkgU7297OMsbSC8RhHDGwNG/K6Y0BoTM8dVcopH
         xoaM7xRxjaULNR1QBqv0AjrpW/+hxRT7ctKmFqRhlMIPO2fYzAmUbof7Wj3yWb4yrO
         6LoXN3Gm4N43O5sT7is+ny/JwoksTu15M1D5p8WY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 062/262] PCI/PME: Fix hotplug/sysfs remove deadlock in pcie_pme_remove()
Date:   Wed, 27 Mar 2019 13:58:37 -0400
Message-Id: <20190327180158.10245-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 95c80bc6952b6a5badc7b702d23e5bf14d251e7c ]

Dongdong reported a deadlock triggered by a hotplug event during a sysfs
"remove" operation:

  pciehp 0000:00:0c.0:pcie004: Slot(0-1): Link Up
  # echo 1 > 0000:00:0c.0/remove

  PME and hotplug share an MSI/MSI-X vector.  The sysfs "remove" side is:

    remove_store
       pci_stop_and_remove_bus_device_locked
	 pci_lock_rescan_remove
	 pci_stop_and_remove_bus_device
	   ...
	   pcie_pme_remove
	     pcie_pme_suspend
	       synchronize_irq        # wait for hotplug IRQ handler
	 pci_unlock_rescan_remove

  The hotplug side is:

    pciehp_ist
       pciehp_handle_presence_or_link_change
	 pciehp_configure_device
	   pci_lock_rescan_remove     # wait for pci_unlock_rescan_remove()

  INFO: task bash:10913 blocked for more than 120 seconds.

  # ps -ax |grep D
   PID TTY      STAT   TIME COMMAND
  10913 ttyAMA0  Ds+    0:00 -bash
  14022 ?        D      0:00 [irq/745-pciehp]

  # cat /proc/14022/stack
  __switch_to+0x94/0xd8
  pci_lock_rescan_remove+0x20/0x28
  pciehp_configure_device+0x30/0x140
  pciehp_handle_presence_or_link_change+0x324/0x458
  pciehp_ist+0x1dc/0x1e0

  # cat /proc/10913/stack
  __switch_to+0x94/0xd8
  synchronize_irq+0x8c/0xc0
  pcie_pme_suspend+0xa4/0x118
  pcie_pme_remove+0x20/0x40
  pcie_port_remove_service+0x3c/0x58
  ...
  pcie_port_device_remove+0x2c/0x48
  pcie_portdrv_remove+0x68/0x78
  pci_device_remove+0x48/0x120
  ...
  pci_stop_bus_device+0x84/0xc0
  pci_stop_and_remove_bus_device_locked+0x24/0x40
  remove_store+0xa4/0xb8
  dev_attr_store+0x44/0x60
  sysfs_kf_write+0x58/0x80

It is incorrect to call pcie_pme_suspend() from pcie_pme_remove() for two
reasons.

First, pcie_pme_suspend() calls synchronize_irq(), which will wait for the
native hotplug interrupt handler as well as for the PME one, because they
share one IRQ (as per the spec).  That may deadlock if hotplug is signaled
while pcie_pme_remove() is running and the latter calls
pci_lock_rescan_remove() before the former.

Second, if pcie_pme_suspend() figures out that wakeup needs to be enabled
for the port, it will return without disabling the interrupt as expected by
pcie_pme_remove() which was overlooked by commit c7b5a4e6e8fb ("PCI / PM:
Fix native PME handling during system suspend/resume").

To fix that, rework pcie_pme_remove() to disable the PME interrupt, clear
its status and prevent the PME worker function from re-enabling it before
calling free_irq() on it, which should be sufficient.

Fixes: c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system suspend/resume")
Link: https://lore.kernel.org/linux-pci/c7697e7c-e1af-13e4-8491-0a3996e6ab5d@huawei.com
Reported-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[bhelgaas: add URL and deadlock details from Dongdong]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/pme.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 1a8b85051b1b..efa5b552914b 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -363,6 +363,16 @@ static bool pcie_pme_check_wakeup(struct pci_bus *bus)
 	return false;
 }
 
+static void pcie_pme_disable_interrupt(struct pci_dev *port,
+				       struct pcie_pme_service_data *data)
+{
+	spin_lock_irq(&data->lock);
+	pcie_pme_interrupt_enable(port, false);
+	pcie_clear_root_pme_status(port);
+	data->noirq = true;
+	spin_unlock_irq(&data->lock);
+}
+
 /**
  * pcie_pme_suspend - Suspend PCIe PME service device.
  * @srv: PCIe service device to suspend.
@@ -387,11 +397,7 @@ static int pcie_pme_suspend(struct pcie_device *srv)
 			return 0;
 	}
 
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(port, false);
-	pcie_clear_root_pme_status(port);
-	data->noirq = true;
-	spin_unlock_irq(&data->lock);
+	pcie_pme_disable_interrupt(port, data);
 
 	synchronize_irq(srv->irq);
 
@@ -427,9 +433,11 @@ static int pcie_pme_resume(struct pcie_device *srv)
  */
 static void pcie_pme_remove(struct pcie_device *srv)
 {
-	pcie_pme_suspend(srv);
+	struct pcie_pme_service_data *data = get_service_data(srv);
+
+	pcie_pme_disable_interrupt(srv->port, data);
 	free_irq(srv->irq, srv);
-	kfree(get_service_data(srv));
+	kfree(data);
 }
 
 static struct pcie_port_service_driver pcie_pme_driver = {
-- 
2.19.1

