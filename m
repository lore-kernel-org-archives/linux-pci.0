Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH part1 v5 6/7] PCI: Check pci device serial number when scan device
Date: Mon, 10 Feb 2014 12:04:10 +0800
Message-ID: <1392005051-54508-7-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1392005051-54508-1-git-send-email-wangyijing@huawei.com>
References: <1392005051-54508-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sometimes pci device will be removed and reinsert
while suspended. In this case system can not identify
the device has been changed. Now PCIe support Device
Serial Number Capability which has the unique number.
So make system check pci device DSN during scanning
device if support.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27d3e6f..370b25c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1383,11 +1383,22 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
 {
 	struct pci_dev *dev;
+	int rescan = 0;
 
 	dev = pci_get_slot(bus, devfn);
 	if (dev) {
+		/* only check func 0 device */
+		if (PCI_FUNC(devfn) == 0) {
+			if (pci_serial_number_changed(dev)) {
+				pci_bus_freeze_device(bus);
+				pci_stop_and_remove_bus_device(dev);
+				pci_bus_unfreeze_device(bus);
+				rescan = 1;
+			}
+		}
 		pci_dev_put(dev);
-		return dev;
+		if (!rescan)
+			return dev;
 	}
 
 	dev = pci_scan_device(bus, devfn);
-- 
1.7.1


