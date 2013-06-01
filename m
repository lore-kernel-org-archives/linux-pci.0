Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56123 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3FAHZ1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 1 Jun 2013 03:25:27 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNP006ORDYEOXE0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Sat, 01 Jun 2013 16:25:26 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] PCI: sysfs: replace strict_strtoul() with kstrtoul()
Date: Sat, 01 Jun 2013 16:25:25 +0900
Message-id: <001001ce5e99$2f6c7f90$8e457eb0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The usage of strict_strtoul() is not preferred, because
strict_strtoul() is obsolete. Thus, kstrtoul() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/pci-sysfs.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5b4a9d9..0b56e08 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -66,7 +66,7 @@ static ssize_t broken_parity_status_store(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val) < 0)
+	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	pdev->broken_parity_status = !!val;
@@ -188,7 +188,7 @@ static ssize_t is_enabled_store(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
-	ssize_t result = strict_strtoul(buf, 0, &val);
+	ssize_t result = kstrtoul(buf, 0, &val);
 
 	if (result < 0)
 		return result;
@@ -259,7 +259,7 @@ msi_bus_store(struct device *dev, struct device_attribute *attr,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val) < 0)
+	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	/* bad things may happen if the no_msi flag is changed
@@ -291,7 +291,7 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 	unsigned long val;
 	struct pci_bus *b = NULL;
 
-	if (strict_strtoul(buf, 0, &val) < 0)
+	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	if (val) {
@@ -315,7 +315,7 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (strict_strtoul(buf, 0, &val) < 0)
+	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	if (val) {
@@ -342,7 +342,7 @@ remove_store(struct device *dev, struct device_attribute *dummy,
 	int ret = 0;
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val) < 0)
+	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	/* An attribute cannot be unregistered by one of its own methods,
@@ -362,7 +362,7 @@ dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
 	unsigned long val;
 	struct pci_bus *bus = to_pci_bus(dev);
 
-	if (strict_strtoul(buf, 0, &val) < 0)
+	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	if (val) {
@@ -384,7 +384,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
 
-	if (strict_strtoul(buf, 0, &val) < 0)
+	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
@@ -1236,7 +1236,7 @@ static ssize_t reset_store(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	unsigned long val;
-	ssize_t result = strict_strtoul(buf, 0, &val);
+	ssize_t result = kstrtoul(buf, 0, &val);
 
 	if (result < 0)
 		return result;
-- 
1.7.10.4


