Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 02/10] PCI: Move back pci_proc_attach_devices calling
Date: Mon, 25 Nov 2013 17:28:02 -0800
Message-Id: <1385429290-25397-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1385429290-25397-1-git-send-email-yinghai@kernel.org>
References: <1385429290-25397-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We stop detach proc when pci_stop_device.
So should attach that during pci_bus_add_device.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/bus.c   | 1 +
 drivers/pci/probe.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index fc1b740..1ffd95b 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -175,6 +175,7 @@ int pci_bus_add_device(struct pci_dev *dev)
 	 * are not assigned yet for some devices.
 	 */
 	pci_fixup_device(pci_fixup_final, dev);
+	pci_proc_attach_device(dev);
 	pci_create_sysfs_dev_files(dev);
 
 	dev->match_driver = true;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 38e403d..173a9cf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1381,8 +1381,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
-
-	pci_proc_attach_device(dev);
 }
 
 struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
-- 
1.8.1.4

