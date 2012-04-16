Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab2DPQd2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:33:28 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so7133149dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:33:28 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Murray <scott@spiteful.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 11/17] PCI: release IO resource in error handling path in cpcihp_generic_init()
Date: Tue, 17 Apr 2012 00:29:05 +0800
Message-Id: <1334593751-5916-12-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Release IO resource in error handling path in function cpcihp_generic_init().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/cpcihp_generic.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
index 81af764..518f387 100644
--- a/drivers/pci/hotplug/cpcihp_generic.c
+++ b/drivers/pci/hotplug/cpcihp_generic.c
@@ -157,16 +157,19 @@ static int __init cpcihp_generic_init(void)
 	bus = pci_find_bus(0, bridge_busnr);
 	if (!bus) {
 		err("Invalid bus number %d", bridge_busnr);
-		return -EINVAL;
-	}
-	dev = pci_get_slot(bus, PCI_DEVFN(bridge_slot, 0));
-	if(!dev || dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
-		err("Invalid bridge device %s", bridge);
+	} else {
+		dev = pci_get_slot(bus, PCI_DEVFN(bridge_slot, 0));
+		if (!dev || dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
+			err("Invalid bridge device %s", bridge);
+			bus = NULL;
+		} else
+			bus = dev->subordinate;
 		pci_dev_put(dev);
-		return -EINVAL;
 	}
-	bus = dev->subordinate;
-	pci_dev_put(dev);
+	if (!bus) {
+		status = -EINVAL;
+		goto init_find_bus_error;
+	}
 
 	memset(&generic_hpc, 0, sizeof (struct cpci_hp_controller));
 	generic_hpc_ops.query_enum = query_enum;
@@ -175,7 +178,8 @@ static int __init cpcihp_generic_init(void)
 	status = cpci_hp_register_controller(&generic_hpc);
 	if(status != 0) {
 		err("Could not register cPCI hotplug controller");
-		return -ENODEV;
+		status = -ENODEV;
+		goto init_find_bus_error;
 	}
 	dbg("registered controller");
 
@@ -193,10 +197,13 @@ static int __init cpcihp_generic_init(void)
 	}
 	dbg("started cpci hp system");
 	return 0;
+
 init_start_error:
 	cpci_hp_unregister_bus(bus);
 init_bus_register_error:
 	cpci_hp_unregister_controller(&generic_hpc);
+init_find_bus_error:
+	release_region(port, 1);
 	err("status = %d", status);
 	return status;
 
-- 
1.7.5.4

