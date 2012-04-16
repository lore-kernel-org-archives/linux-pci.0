Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35016 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2DPQdz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:33:55 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so7133149dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:33:55 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Murray <scott@spiteful.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 15/17] PCI: hold a reference count to the PCI bus used by cpcihp drivers
Date: Tue, 17 Apr 2012 00:29:09 +0800
Message-Id: <1334593751-5916-16-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI bus used by cpcihp drivers may be removed at runtime through
/sys/devices/pcissss:bb/ssss\:bb\:dd.f/.../remove interface, so hold
a reference count to the PCI bus to avoid invalid memory access.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/hotplug/cpcihp_generic.c |    7 +++++--
 drivers/pci/hotplug/cpcihp_zt5550.c  |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
index 518f387..f002be5 100644
--- a/drivers/pci/hotplug/cpcihp_generic.c
+++ b/drivers/pci/hotplug/cpcihp_generic.c
@@ -163,7 +163,7 @@ static int __init cpcihp_generic_init(void)
 			err("Invalid bridge device %s", bridge);
 			bus = NULL;
 		} else
-			bus = dev->subordinate;
+			bus = pci_bus_get(dev->subordinate);
 		pci_dev_put(dev);
 	}
 	if (!bus) {
@@ -179,7 +179,7 @@ static int __init cpcihp_generic_init(void)
 	if(status != 0) {
 		err("Could not register cPCI hotplug controller");
 		status = -ENODEV;
-		goto init_find_bus_error;
+		goto init_register_controller_error;
 	}
 	dbg("registered controller");
 
@@ -202,6 +202,8 @@ init_start_error:
 	cpci_hp_unregister_bus(bus);
 init_bus_register_error:
 	cpci_hp_unregister_controller(&generic_hpc);
+init_register_controller_error:
+	pci_bus_put(bus);
 init_find_bus_error:
 	release_region(port, 1);
 	err("status = %d", status);
@@ -214,6 +216,7 @@ static void __exit cpcihp_generic_exit(void)
 	cpci_hp_stop();
 	cpci_hp_unregister_bus(bus);
 	cpci_hp_unregister_controller(&generic_hpc);
+	pci_bus_put(bus);
 	release_region(port, 1);
 }
 
diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 8a6f968..6606520 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -241,9 +241,9 @@ static int zt5550_hc_init_one (struct pci_dev *pdev, const struct pci_device_id
 	if(!(bus0_dev = pci_get_device(PCI_VENDOR_ID_DEC,
 					 PCI_DEVICE_ID_DEC_21154, NULL))) {
 		status = -ENODEV;
-		goto init_register_error;
+		goto init_find_bus_error;
 	}
-	bus0 = bus0_dev->subordinate;
+	bus0 = pci_bus_get(bus0_dev->subordinate);
 	pci_dev_put(bus0_dev);
 
 	status = cpci_hp_register_bus(bus0, 0x0a, 0x0f);
@@ -265,6 +265,8 @@ static int zt5550_hc_init_one (struct pci_dev *pdev, const struct pci_device_id
 init_start_error:
 	cpci_hp_unregister_bus(bus0);
 init_register_error:
+	pci_bus_put(bus0);
+init_find_bus_error:
 	cpci_hp_unregister_controller(&zt5550_hpc);
 init_hc_error:
 	err("status = %d", status);
@@ -278,6 +280,7 @@ static void __devexit zt5550_hc_remove_one(struct pci_dev *pdev)
 	cpci_hp_stop();
 	cpci_hp_unregister_bus(bus0);
 	cpci_hp_unregister_controller(&zt5550_hpc);
+	pci_bus_put(bus0);
 	zt5550_hc_cleanup();
 }
 
-- 
1.7.5.4

