Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:23339 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758536Ab3DSJqe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Apr 2013 05:46:34 -0400
Message-ID: <51711214.8050606@cn.fujitsu.com>
Date: Fri, 19 Apr 2013 17:44:52 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>,
	li guang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] PCI: Introduce  pci_alloc_dev(struct pci_bus*) to replace
 alloc_pci_dev()
References: <516FB647.5030203@cn.fujitsu.com> <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com>
In-Reply-To: <CAErSpo65ARR_fZwsGCZDJqbPWktHYUkufgPt-2mWwur=nPR1Qg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 906167d9a09babbe189f62944ecb8c0b198a0f64 Mon Sep 17 00:00:00 2001
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Fri, 19 Apr 2013 18:12:32 +0900
Subject: [PATCH 1/2] PCI: Introduce  pci_alloc_dev(struct pci_bus*) to replace alloc_pci_dev()

Now here we introduce a new struct pci_dev *pci_alloc_dev(struct pci_bus *bus) to replace alloc_pci_dev().
It take a "struct pci_bus *" argument, so we can alloc a pci device on a target pci bus, and it acquire
the reference of the pci_bus.
Since the old alloc_pci_dev() is exported, so we still keep it for a while but mark it as __deprecated.  

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 drivers/pci/probe.c |   21 ++++++++++++++++++++-
 include/linux/pci.h |    4 +++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b494066..5233fb6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1199,7 +1199,7 @@ static void pci_release_bus_bridge_dev(struct device *dev)
 	kfree(bridge);
 }
 
-struct pci_dev *alloc_pci_dev(void)
+struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
@@ -1209,6 +1209,25 @@ struct pci_dev *alloc_pci_dev(void)
 
 	INIT_LIST_HEAD(&dev->bus_list);
 
+	if (bus) {
+		get_device(&bus->dev);
+		dev->bus = bus;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(pci_alloc_dev);
+
+__deprecated struct pci_dev *alloc_pci_dev(void)
+{
+	struct pci_dev *dev;
+	printk(KERN_DEBUG "alloc_pci_dev is deprecated, please use pci_alloc_dev(struct pci_bus *) instead!\n");
+	dev = kzalloc(sizeof(struct pci_dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	INIT_LIST_HEAD(&dev->bus_list);
+
 	return dev;
 }
 EXPORT_SYMBOL(alloc_pci_dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 710067f..682de2b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -348,7 +348,9 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 	return dev;
 }
 
-extern struct pci_dev *alloc_pci_dev(void);
+extern struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
+
+extern __deprecated struct pci_dev *alloc_pci_dev(void);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
-- 
1.7.1

