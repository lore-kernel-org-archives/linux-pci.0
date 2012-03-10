Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 14/37] PCI: Rescan bus or bridge using callback method too
Date: Fri,  9 Mar 2012 23:00:14 -0800
Message-Id: <1331362837-10740-15-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Just like removal.

Because We could add new bus under the bridges...

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2049b2f..1794508 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -325,21 +325,31 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static void bridge_rescan_callback(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	mutex_lock(&pci_remove_rescan_mutex);
+	pci_rescan_bus_bridge_resize(pdev);
+	mutex_unlock(&pci_remove_rescan_mutex);
+}
+
 static ssize_t
 dev_bridge_rescan_store(struct device *dev, struct device_attribute *attr,
 		 const char *buf, size_t count)
 {
+	int ret = 0;
 	unsigned long val;
-	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val) {
-		mutex_lock(&pci_remove_rescan_mutex);
-		pci_rescan_bus_bridge_resize(pdev);
-		mutex_unlock(&pci_remove_rescan_mutex);
-	}
+	if (val)
+		ret = device_schedule_callback(dev, bridge_rescan_callback);
+
+	if (ret)
+		count = ret;
+
 	return count;
 }
 
@@ -375,21 +385,30 @@ remove_store(struct device *dev, struct device_attribute *dummy,
 	return count;
 }
 
+static void bus_rescan_callback(struct device *dev)
+{
+	struct pci_bus *bus = to_pci_bus(dev);
+
+	mutex_lock(&pci_remove_rescan_mutex);
+	pci_rescan_bus(bus);
+	mutex_unlock(&pci_remove_rescan_mutex);
+}
 static ssize_t
 dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
 		 const char *buf, size_t count)
 {
+	int ret = 0;
 	unsigned long val;
-	struct pci_bus *bus = to_pci_bus(dev);
 
 	if (strict_strtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val) {
-		mutex_lock(&pci_remove_rescan_mutex);
-		pci_rescan_bus(bus);
-		mutex_unlock(&pci_remove_rescan_mutex);
-	}
+	if (val)
+		ret = device_schedule_callback(dev, bus_rescan_callback);
+
+	if (ret)
+		count = ret;
+
 	return count;
 }
 
-- 
1.7.7

