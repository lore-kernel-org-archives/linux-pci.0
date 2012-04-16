Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37352 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab2DPQcP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:32:15 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so7132053dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:32:15 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH RFC 01/17] PCI: introduce pci_bus_get()/pci_bus_put() to hide PCI implementation details
Date: Tue, 17 Apr 2012 00:28:55 +0800
Message-Id: <1334593751-5916-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
References: <1334593751-5916-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce pci_bus_get()/pci_bus_put() to hide PCI implementation details.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/bus.c   |   15 +++++++++++++++
 include/linux/pci.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 4ce5ef2..50f9c5d 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -35,6 +35,21 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 }
 EXPORT_SYMBOL(pci_add_resource_offset);
 
+struct pci_bus *pci_bus_get(struct pci_bus *bus)
+{
+	if (bus)
+		get_device(&bus->dev);
+	return bus;
+}
+EXPORT_SYMBOL(pci_bus_get);
+
+void pci_bus_put(struct pci_bus *bus)
+{
+	if (bus)
+		put_device(&bus->dev);
+}
+EXPORT_SYMBOL(pci_bus_put);
+
 void pci_add_resource(struct list_head *resources, struct resource *res)
 {
 	pci_add_resource_offset(resources, res, 0);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e444f5b..0603a60 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -912,6 +912,8 @@ int pci_request_selected_regions_exclusive(struct pci_dev *, int, const char *);
 void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
+struct pci_bus *pci_bus_get(struct pci_bus *bus);
+void pci_bus_put(struct pci_bus *bus);
 void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
-- 
1.7.5.4

