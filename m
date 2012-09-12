Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48249 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759101Ab2ILOYx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2012 10:24:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2343679pbb.19
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2012 07:24:53 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <liuj97@gmail.com>, huxinwei@huawei.com,
	Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH] eeepc-laptop: fix device reference count leakage in eeepc_rfkill_hotplug()
Date: Wed, 12 Sep 2012 22:24:29 +0800
Message-Id: <1347459869-5709-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAErSpo5ZQmzusUMuB7TobCH-Bzw=r78h8SGQ88-WqaH7nRSXkQ@mail.gmail.com>
References: <CAErSpo5ZQmzusUMuB7TobCH-Bzw=r78h8SGQ88-WqaH7nRSXkQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix a device reference count leakage issue in function
eeepc_rfkill_hotplug().
---
 drivers/platform/x86/eeepc-laptop.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index dab91b4..5ca2641 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -610,12 +610,12 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 
 		if (!bus) {
 			pr_warn("Unable to find PCI bus 1?\n");
-			goto out_unlock;
+			goto out_put_dev;
 		}
 
 		if (pci_bus_read_config_dword(bus, 0, PCI_VENDOR_ID, &l)) {
 			pr_err("Unable to read PCI config space?\n");
-			goto out_unlock;
+			goto out_put_dev;
 		}
 
 		absent = (l == 0xffffffff);
@@ -627,7 +627,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 				absent ? "absent" : "present");
 			pr_warn("skipped wireless hotplug as probably "
 				"inappropriate for this model\n");
-			goto out_unlock;
+			goto out_put_dev;
 		}
 
 		if (!blocked) {
@@ -635,7 +635,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 			if (dev) {
 				/* Device already present */
 				pci_dev_put(dev);
-				goto out_unlock;
+				goto out_put_dev;
 			}
 			dev = pci_scan_single_device(bus, 0);
 			if (dev) {
@@ -650,6 +650,8 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 				pci_dev_put(dev);
 			}
 		}
+out_put_dev:
+		pci_dev_put(port);
 	}
 
 out_unlock:
-- 
1.7.9.5

