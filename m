Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:46425 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932824AbbLWM23 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Dec 2015 07:28:29 -0500
From: Geliang Tang <geliangtang@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: use to_pci_dev
Date: Wed, 23 Dec 2015 20:28:12 +0800
Message-Id: <8ab09476f7fb0283031b973808740f40522bebe1.1450873511.git.geliangtang@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use to_pci_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/pci/hotplug/shpchp_sysfs.c | 2 +-
 drivers/pci/pci.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
index 52875b3..392a40b 100644
--- a/drivers/pci/hotplug/shpchp_sysfs.c
+++ b/drivers/pci/hotplug/shpchp_sysfs.c
@@ -43,7 +43,7 @@ static ssize_t show_ctrl (struct device *dev, struct device_attribute *attr, cha
 	struct resource *res;
 	struct pci_bus *bus;
 
-	pdev = container_of (dev, struct pci_dev, dev);
+	pdev = to_pci_dev(dev);
 	bus = pdev->subordinate;
 
 	out += sprintf(buf, "Free resources: memory\n");
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1a7105..9356f90 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1417,7 +1417,7 @@ struct pci_devres {
 
 static void pcim_release(struct device *gendev, void *res)
 {
-	struct pci_dev *dev = container_of(gendev, struct pci_dev, dev);
+	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 	int i;
 
-- 
2.5.0


