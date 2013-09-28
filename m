Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:46681 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221Ab3I1KMK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Sep 2013 06:12:10 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3633548pdj.12
        for <linux-pci@vger.kernel.org>; Sat, 28 Sep 2013 03:12:10 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, sachin.kamat@linaro.org
Subject: [PATCH 1/2] PCI: sysfs: Staticize local symbols
Date: Sat, 28 Sep 2013 15:42:00 +0530
Message-Id: <1380363121-1977-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Local variables used only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pci/pci-sysfs.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d8eb880..ec1dbea 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -304,7 +304,7 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 }
 static BUS_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, bus_rescan_store);
 
-struct attribute *pci_bus_attrs[] = {
+static struct attribute *pci_bus_attrs[] = {
 	&bus_attr_rescan.attr,
 	NULL,
 };
@@ -335,8 +335,9 @@ dev_rescan_store(struct device *dev, struct device_attribute *attr,
 	}
 	return count;
 }
-struct device_attribute dev_rescan_attr = __ATTR(rescan, (S_IWUSR|S_IWGRP),
-						 NULL, dev_rescan_store);
+static struct device_attribute dev_rescan_attr = __ATTR(rescan,
+							(S_IWUSR|S_IWGRP),
+							NULL, dev_rescan_store);
 
 static void remove_callback(struct device *dev)
 {
@@ -366,8 +367,9 @@ remove_store(struct device *dev, struct device_attribute *dummy,
 		count = ret;
 	return count;
 }
-struct device_attribute dev_remove_attr = __ATTR(remove, (S_IWUSR|S_IWGRP),
-						 NULL, remove_store);
+static struct device_attribute dev_remove_attr = __ATTR(remove,
+							(S_IWUSR|S_IWGRP),
+							NULL, remove_store);
 
 static ssize_t
 dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
@@ -554,7 +556,7 @@ boot_vga_show(struct device *dev, struct device_attribute *attr, char *buf)
 		!!(pdev->resource[PCI_ROM_RESOURCE].flags &
 		   IORESOURCE_ROM_SHADOW));
 }
-struct device_attribute vga_attr = __ATTR_RO(boot_vga);
+static struct device_attribute vga_attr = __ATTR_RO(boot_vga);
 
 static ssize_t
 pci_read_config(struct file *filp, struct kobject *kobj,
-- 
1.7.9.5

