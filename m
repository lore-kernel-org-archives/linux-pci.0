Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:13920 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab3I3HDF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2013 03:03:05 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	"Hanjun Guo" <guohanjun@huawei.com>
Subject: [PATCH] PCI: Introudce pci_dev_show_local_cpu() to simplify code
Date: Mon, 30 Sep 2013 15:02:38 +0800
Message-ID: <1380524558-25188-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Local_cpus_show() and local_cpulist_show() are almost the same,
introudce a new helper function pci_dev_show_local_cpu() to simplify
code.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci-sysfs.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7128cfd..3b41405 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -74,9 +74,11 @@ static ssize_t broken_parity_status_store(struct device *dev,
 	return count;
 }
 
-static ssize_t local_cpus_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{		
+static ssize_t pci_dev_show_local_cpu(struct device *dev,
+		int type,
+		struct device_attribute *attr,
+		char *buf)
+{
 	const struct cpumask *mask;
 	int len;
 
@@ -86,29 +88,25 @@ static ssize_t local_cpus_show(struct device *dev,
 #else
 	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
 #endif
-	len = cpumask_scnprintf(buf, PAGE_SIZE-2, mask);
+	len = type ?
+		cpumask_scnprintf(buf, PAGE_SIZE-2, mask) :
+		cpulist_scnprintf(buf, PAGE_SIZE-2, mask);
+
 	buf[len++] = '\n';
 	buf[len] = '\0';
 	return len;
 }
 
+static ssize_t local_cpus_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	return pci_dev_show_local_cpu(dev, 1, attr, buf);
+}
 
 static ssize_t local_cpulist_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	const struct cpumask *mask;
-	int len;
-
-#ifdef CONFIG_NUMA
-	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
-					  cpumask_of_node(dev_to_node(dev));
-#else
-	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
-#endif
-	len = cpulist_scnprintf(buf, PAGE_SIZE-2, mask);
-	buf[len++] = '\n';
-	buf[len] = '\0';
-	return len;
+	return pci_dev_show_local_cpu(dev, 0, attr, buf);
 }
 
 /*
-- 
1.7.1


