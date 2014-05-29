Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:63994 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbaE2HCr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 03:02:47 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/3] platform/x86: remove the unnecessary checking for pci_bus_add_device
Date: Thu, 29 May 2014 15:01:05 +0800
Message-ID: <1401346866-11648-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1401346866-11648-1-git-send-email-wangyijing@huawei.com>
References: <1401346866-11648-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Pci_bus_add_device() always return 0, remove the unnecessary checking
for pci_bus_add_device().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/platform/x86/asus-wmi.c     |    3 +--
 drivers/platform/x86/eeepc-laptop.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c5e082f..91ef69a 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -642,8 +642,7 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 			dev = pci_scan_single_device(bus, 0);
 			if (dev) {
 				pci_bus_assign_resources(bus);
-				if (pci_bus_add_device(dev))
-					pr_err("Unable to hotplug wifi\n");
+				pci_bus_add_device(dev);
 			}
 		} else {
 			dev = pci_get_slot(bus, 0);
diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 399e8c5..9b0c57c 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -633,8 +633,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 			dev = pci_scan_single_device(bus, 0);
 			if (dev) {
 				pci_bus_assign_resources(bus);
-				if (pci_bus_add_device(dev))
-					pr_err("Unable to hotplug wifi\n");
+				pci_bus_add_device(dev);
 			}
 		} else {
 			dev = pci_get_slot(bus, 0);
-- 
1.7.1


