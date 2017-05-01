Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:49605 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165096AbdEAMKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2017 08:10:21 -0400
Message-Id: <6535c2f2caaa88fc7e0be14884c816b58ec1c674.1493631639.git.lukas@wunner.de>
In-Reply-To: <cover.1493631639.git.lukas@wunner.de>
References: <cover.1493631639.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 1 May 2017 14:06:39 +0200
Subject: [PATCH 4/5] PCI: pciehp: Remain in D0 if poll mode is enabled
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Erik Veijola <erik.veijola@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Krishna Dhulipala <krishnad@fb.com>, Wei Zhang <wzhang@fb.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The slot status is polled from a timer, i.e. in softirq context, and
pm_runtime_get_sync() may sleep.  Hence it's not an option to runtime
resume the port whenever its slot status is polled.  It would also be
silly to continuously switch back and forth between D0 and D3hot, so
keep it runtime active if poll mode is enabled.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Erik Veijola <erik.veijola@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Krishna Dhulipala <krishnad@fb.com>
Cc: Wei Zhang <wzhang@fb.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 70dd9ae4c097..20170bcf9862 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -86,6 +86,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 	if (pciehp_poll_mode) {
 		init_timer(&ctrl->poll_timer);
 		start_int_poll_timer(ctrl, 10);
+		pm_runtime_get(&ctrl->pcie->port->dev);
 		return 0;
 	}
 
@@ -99,9 +100,10 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 
 static inline void pciehp_free_irq(struct controller *ctrl)
 {
-	if (pciehp_poll_mode)
+	if (pciehp_poll_mode) {
 		del_timer_sync(&ctrl->poll_timer);
-	else
+		pm_runtime_put(&ctrl->pcie->port->dev);
+	} else
 		free_irq(ctrl->pcie->irq, ctrl);
 }
 
-- 
2.11.0
