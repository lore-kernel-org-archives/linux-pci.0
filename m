Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Yijing Wang <wangyijing@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v1 16/22] PCI/asus-wmi: use PCI bus lock to avoid race conditions
Date: Wed,  8 Aug 2012 00:10:56 +0800
Message-Id: <1344355862-2726-17-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1344355862-2726-1-git-send-email-jiang.liu@huawei.com>
References: <1344355862-2726-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch uses PCI bus lock mechanism to avoid race conditions when doing
PCI device hotplug by asum-wmi driver.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 drivers/platform/x86/asus-wmi.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 77aadde..9972bc7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -533,15 +533,20 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 		rfkill_set_sw_state(asus->wlan.rfkill, blocked);
 
 	if (asus->hotplug_slot) {
-		bus = pci_find_bus(0, 1);
+		bus = pci_get_bus(0, 1);
 		if (!bus) {
 			pr_warn("Unable to find PCI bus 1?\n");
 			goto out_unlock;
 		}
 
+		if (pci_bus_lock_states(bus, PCI_BUS_STATE_WORKING)) {
+			pr_warn("Unable to lock PCI bus 1?\n");
+			goto out_put_bus;
+		}
+
 		if (pci_bus_read_config_dword(bus, 0, PCI_VENDOR_ID, &l)) {
 			pr_err("Unable to read PCI config space?\n");
-			goto out_unlock;
+			goto out_unlock_bus;
 		}
 		absent = (l == 0xffffffff);
 
@@ -552,7 +557,7 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 				absent ? "absent" : "present");
 			pr_warn("skipped wireless hotplug as probably "
 				"inappropriate for this model\n");
-			goto out_unlock;
+			goto out_unlock_bus;
 		}
 
 		if (!blocked) {
@@ -560,7 +565,7 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 			if (dev) {
 				/* Device already present */
 				pci_dev_put(dev);
-				goto out_unlock;
+				goto out_unlock_bus;
 			}
 			dev = pci_scan_single_device(bus, 0);
 			if (dev) {
@@ -575,6 +580,11 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 				pci_dev_put(dev);
 			}
 		}
+
+out_unlock_bus:
+		pci_bus_unlock(bus);
+out_put_bus:
+		pci_bus_put(bus);
 	}
 
 out_unlock:
@@ -670,7 +680,7 @@ static void asus_hotplug_work(struct work_struct *work)
 static int asus_setup_pci_hotplug(struct asus_wmi *asus)
 {
 	int ret = -ENOMEM;
-	struct pci_bus *bus = pci_find_bus(0, 1);
+	struct pci_bus *bus = pci_get_bus(0, 1);
 
 	if (!bus) {
 		pr_err("Unable to find wifi PCI bus\n");
@@ -705,6 +715,8 @@ static int asus_setup_pci_hotplug(struct asus_wmi *asus)
 		goto error_register;
 	}
 
+	pci_bus_put(bus);
+
 	return 0;
 
 error_register:
@@ -715,6 +727,7 @@ error_info:
 error_slot:
 	destroy_workqueue(asus->hotplug_workqueue);
 error_workqueue:
+	pci_bus_put(bus);
 	return ret;
 }
 
-- 
1.7.9.5

