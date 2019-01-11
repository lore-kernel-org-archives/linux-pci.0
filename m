Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF7EC43444
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8020700
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Ro8MhW81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbfAKPn6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:58 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40086 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731971AbfAKPn5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D2DF0419C7
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221044; x=1549035445; bh=qptX74TZrbdrLiox0yDoNefTa4VBTR4ylDg
        syy3SwBg=; b=Ro8MhW81TAaRWoFRC6aOL2bIL/P4o2JPwJJPthwtJL0eeOS2y0s
        e706rpH+LHL2Ez80JiturbxgLCKaoqaDoEH++3eifA2Enk8Ca5N/8VGRIOZ/+fAO
        sf84XLqgeir6SYmDNm+w0O5JhvqCnx9lO0Ber25bdEVcrJwEOP+meYQ8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y-bBhlcEefV2 for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id C732D41961
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:22 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:22 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 06/21] PCI: Don't allow hotplugged devices to steal resources
Date:   Fri, 11 Jan 2019 18:36:52 +0300
Message-ID: <20190111153707.10140-7-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
References: <20190111153707.10140-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When movable BARs are enabled, the PCI subsystem at first releases
all the bridge windows and then performs an attempt to assign new
requested resources and re-assign the existing ones.

If a hotplugged device gets its resources first, there could be no
space left to re-assign resources of already working devices, which
is unacceptable. If this happens, this patch marks one of the new
devices with the new introduced flag PCI_DEV_IGNORE and retries the
resource assignment.

This patch adds a new res_mask bitmask to the struct pci_dev for
storing the indices of assigned resources.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/bus.c       |   5 ++
 drivers/pci/pci.h       |  11 +++++
 drivers/pci/probe.c     | 100 +++++++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-bus.c |  15 ++++++
 include/linux/pci.h     |   1 +
 5 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5cb40b2518f9..a9784144d6f2 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -311,6 +311,11 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	int retval;
 
+	if (pci_dev_is_ignored(dev)) {
+		pci_warn(dev, "%s: don't enable the ignored device\n", __func__);
+		return;
+	}
+
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e06e8692a7b1..56b905068ac5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -366,6 +366,7 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
+#define PCI_DEV_IGNORE 1
 
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
@@ -377,6 +378,16 @@ static inline bool pci_dev_is_added(const struct pci_dev *dev)
 	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
 }
 
+static inline void pci_dev_ignore(struct pci_dev *dev, bool ignore)
+{
+	assign_bit(PCI_DEV_IGNORE, &dev->priv_flags, ignore);
+}
+
+static inline bool pci_dev_is_ignored(const struct pci_dev *dev)
+{
+	return test_bit(PCI_DEV_IGNORE, &dev->priv_flags);
+}
+
 #ifdef CONFIG_PCIEAER
 #include <linux/aer.h>
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 964faa32e78a..b7d2769d4a0e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3171,6 +3171,23 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
 	return max;
 }
 
+static unsigned int pci_dev_res_mask(struct pci_dev *dev)
+{
+	unsigned int res_mask = 0;
+	int i;
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (!r->flags || (r->flags & IORESOURCE_UNSET) || !r->parent)
+			continue;
+
+		res_mask |= (1 << i);
+	}
+
+	return res_mask;
+}
+
 static void pci_bus_rescan_prepare(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -3178,6 +3195,8 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *child = dev->subordinate;
 
+		dev->res_mask = pci_dev_res_mask(dev);
+
 		if (child) {
 			pci_bus_rescan_prepare(child);
 		} else if (dev->driver &&
@@ -3222,6 +3241,84 @@ static void pci_setup_bridges(struct pci_bus *bus)
 		pci_setup_bridge(bus);
 }
 
+static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	if (!bus)
+		return NULL;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child_bus = dev->subordinate;
+
+		if (!pci_dev_is_added(dev) && !pci_dev_is_ignored(dev))
+			return dev;
+
+		if (child_bus) {
+			struct pci_dev *next_new_dev;
+
+			next_new_dev = pci_find_next_new_device(child_bus);
+			if (next_new_dev)
+				return next_new_dev;
+		}
+	}
+
+	return NULL;
+}
+
+static bool pci_bus_validate_resources(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	bool ret = true;
+
+	if (!bus)
+		return false;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child = dev->subordinate;
+		unsigned int res_mask = pci_dev_res_mask(dev);
+
+		if (pci_dev_is_ignored(dev))
+			continue;
+
+		if (dev->res_mask & ~res_mask) {
+			pci_err(dev, "%s: Non-re-enabled resources found: 0x%x -> 0x%x\n",
+				__func__, res_mask, dev->res_mask);
+			ret = false;
+		}
+
+		if (child && !pci_bus_validate_resources(child))
+			ret = false;
+	}
+
+	return ret;
+}
+
+static void pci_reassign_root_bus_resources(struct pci_bus *root)
+{
+	do {
+		struct pci_dev *next_new_dev;
+
+		pci_bus_release_root_bridge_resources(root);
+		pci_assign_unassigned_root_bus_resources(root);
+
+		if (pci_bus_validate_resources(root))
+			break;
+
+		next_new_dev = pci_find_next_new_device(root);
+		if (!next_new_dev) {
+			dev_err(&root->dev, "%s: failed to re-assign resources even after ignoring all the hotplugged devices\n",
+				__func__);
+			break;
+		}
+
+		dev_warn(&root->dev, "%s: failed to re-assign resources, disable the next hotplugged device %s and retry\n",
+			 __func__, dev_name(&next_new_dev->dev));
+
+		pci_dev_ignore(next_new_dev, true);
+	} while (true);
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3245,8 +3342,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 
 		max = pci_scan_child_bus(root);
 
-		pci_bus_release_root_bridge_resources(root);
-		pci_assign_unassigned_root_bus_resources(root);
+		pci_reassign_root_bus_resources(root);
 
 		pci_setup_bridges(root);
 		pci_bus_rescan_done(root);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a7594c302bd9..e0c5e2c947d6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -131,6 +131,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
 {
 	int i;
 
+	if (pci_dev_is_ignored(dev))
+		return;
+
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct pci_dev_resource *dev_res, *tmp;
@@ -181,6 +184,9 @@ static void __dev_sort_resources(struct pci_dev *dev,
 {
 	u16 class = dev->class >> 8;
 
+	if (pci_dev_is_ignored(dev))
+		return;
+
 	/* Don't touch classless devices or host bridges or ioapics.  */
 	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
 		return;
@@ -284,6 +290,9 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	int idx;
 
 	list_for_each_entry(dev_res, head, list) {
+		if (pci_dev_is_ignored(dev_res->dev))
+			continue;
+
 		res = dev_res->res;
 		idx = res - &dev_res->dev->resource[0];
 		if (resource_size(res) &&
@@ -1028,6 +1037,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
 
+		if (pci_dev_is_ignored(dev))
+			continue;
+
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
@@ -1385,6 +1397,9 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (pci_dev_is_ignored(dev))
+			continue;
+
 		pdev_assign_fixed_resources(dev);
 
 		b = dev->subordinate;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d87bbf9e0627..5a7d2b7ff31f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -369,6 +369,7 @@ struct pci_dev {
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	unsigned int	res_mask;		/* Bitmask of assigned resources */
 
 	bool		match_driver;		/* Skip attaching driver */
 
-- 
2.20.1

