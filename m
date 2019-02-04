Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E368C282CC
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A1F20823
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="qg/CSOhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfBDPg2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:28 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49270 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbfBDPg1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:27 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4EE37418BF;
        Mon,  4 Feb 2019 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294584; x=1551108985; bh=lnObJzqSWpLmiOuecnBxX8dHIT4V7sqiszw
        829Ke50s=; b=qg/CSOhfC3HoOvT8lmyp2yyOUqdB5zK6cSgQ2Vdnp7AQCokvM9p
        BToN+/mwEIBqVS6GdNTDOCCi0LbBaVJOVoWqZ5Wsdw59MJ9pzS+zav5GNxlj5EV1
        +8GEsKyQIq3FdvGhS8lI/8F0rauBxavsooKL+HiRkHXNnK+Q3k3Kq8vM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rbfhejt_fIt3; Mon,  4 Feb 2019 18:36:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 738A04195A;
        Mon,  4 Feb 2019 18:36:13 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:13 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v3 16/21] PCI: Calculate fixed areas of bridge windows based on fixed BARs
Date:   Mon, 4 Feb 2019 18:35:56 +0300
Message-ID: <20190204153601.7576-17-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204153601.7576-1-s.miroshnichenko@yadro.com>
References: <20190204153601.7576-1-s.miroshnichenko@yadro.com>
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

For every (IO, MEM, MEM64) bridge window, count the fixed resources of
its children endpoints and children bridge windows:

| <- BAR -> |    | <- child bus fixed_range_hard -> |   | <- fixed BAR -> |
                 | <-            bus's fixed_range_hard                -> |
| <-                       bus's bridge window                         -> |

These ranges will be later used to arrange bridge windows in a way which
covers every immovable BAR as well as the movable ones during hotplug.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       | 14 +++++++
 drivers/pci/probe.c     | 82 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c | 17 +++++++++
 include/linux/pci.h     |  6 +++
 4 files changed, 119 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 56b905068ac5..14e3ebe68010 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -364,6 +364,20 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 	return dev->error_state == pci_channel_io_perm_failure;
 }
 
+static inline int pci_get_bridge_resource_idx(struct resource *r)
+{
+	int idx = 1;
+
+	if (r->flags & IORESOURCE_IO)
+		idx = 0;
+	else if (!(r->flags & IORESOURCE_PREFETCH))
+		idx = 1;
+	else if (r->flags & IORESOURCE_MEM_64)
+		idx = 2;
+
+	return idx;
+}
+
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
 #define PCI_DEV_IGNORE 1
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c1d88721697e..cc302a5798bf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -500,6 +500,7 @@ void pci_read_bridge_bases(struct pci_bus *child)
 static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 {
 	struct pci_bus *b;
+	int idx;
 
 	b = kzalloc(sizeof(*b), GFP_KERNEL);
 	if (!b)
@@ -516,6 +517,11 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	if (parent)
 		b->domain_nr = parent->domain_nr;
 #endif
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		b->fixed_range_hard[idx].start = (resource_size_t)-1;
+		b->fixed_range_hard[idx].end = 0;
+	}
+
 	return b;
 }
 
@@ -3261,6 +3267,81 @@ static void pci_setup_bridges(struct pci_bus *bus)
 		pci_setup_bridge(bus);
 }
 
+static void pci_bus_update_fixed_range_hard(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	int idx;
+	resource_size_t start, end;
+
+	for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+		bus->fixed_range_hard[idx].start = (resource_size_t)-1;
+		bus->fixed_range_hard[idx].end = 0;
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_fixed_range_hard(dev->subordinate);
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		int i;
+
+		for (i = 0; i < PCI_BRIDGE_RESOURCES; ++i) {
+			struct resource *r = &dev->resource[i];
+
+			if (!r->flags || (r->flags & IORESOURCE_UNSET) || !r->parent)
+				continue;
+
+			if (r->flags & IORESOURCE_PCI_FIXED) {
+				idx = pci_get_bridge_resource_idx(r);
+				start = bus->fixed_range_hard[idx].start;
+				end = bus->fixed_range_hard[idx].end;
+
+				if (start > r->start)
+					start = r->start;
+				if (end < r->end)
+					end = r->end;
+
+				if (bus->fixed_range_hard[idx].start != start ||
+				    bus->fixed_range_hard[idx].end != end) {
+					dev_dbg(&bus->dev, "%s: Found fixed 0x%llx-0x%llx in %s, expand the fixed bridge window %d to 0x%llx-0x%llx\n",
+						__func__,
+						(unsigned long long)r->start,
+						(unsigned long long)r->end,
+						dev_name(&dev->dev), idx,
+						(unsigned long long)start,
+						(unsigned long long)end);
+					bus->fixed_range_hard[idx].start = start;
+					bus->fixed_range_hard[idx].end = end;
+				}
+			}
+		}
+
+		if (dev->subordinate) {
+			struct pci_bus *child = dev->subordinate;
+
+			for (idx = 0; idx < PCI_BRIDGE_RESOURCE_NUM; ++idx) {
+				start = bus->fixed_range_hard[idx].start;
+				end = bus->fixed_range_hard[idx].end;
+
+				if (start > child->fixed_range_hard[idx].start)
+					start = child->fixed_range_hard[idx].start;
+				if (end < child->fixed_range_hard[idx].end)
+					end = child->fixed_range_hard[idx].end;
+
+				if (start < bus->fixed_range_hard[idx].start ||
+				    end > bus->fixed_range_hard[idx].end) {
+					dev_dbg(&bus->dev, "%s: Expand the fixed bridge window %d from %s to 0x%llx-0x%llx\n",
+						__func__, idx, dev_name(&child->dev),
+						(unsigned long long)start,
+						(unsigned long long)end);
+					bus->fixed_range_hard[idx].start = start;
+					bus->fixed_range_hard[idx].end = end;
+				}
+			}
+		}
+	}
+}
+
 static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -3361,6 +3442,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_bus_rescan_prepare(root);
 
 		max = pci_scan_child_bus(root);
+		pci_bus_update_fixed_range_hard(root);
 
 		pci_reassign_root_bus_resources(root);
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a1b1b1cda3e8..59af85029869 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -916,9 +916,17 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
+	resource_size_t fixed_start = bus->fixed_range_hard[0].start;
+	resource_size_t fixed_end = bus->fixed_range_hard[0].end;
+	resource_size_t fixed_size = (fixed_start < fixed_end) ?
+		(fixed_end - fixed_start + 1) : 0;
+
 	if (!b_res)
 		return;
 
+	if (min_size < fixed_size)
+		min_size = fixed_size;
+
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
@@ -1027,6 +1035,15 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	bool is_mem64 = (mask & IORESOURCE_MEM_64);
+
+	resource_size_t fixed_start = bus->fixed_range_hard[is_mem64 ? 2 : 1].start;
+	resource_size_t fixed_end = bus->fixed_range_hard[is_mem64 ? 2 : 1].end;
+	resource_size_t fixed_size = (fixed_start < fixed_end) ?
+		(fixed_end - fixed_start + 1) : 0;
+
+	if (min_size < fixed_size)
+		min_size = fixed_size;
 
 	if (!b_res)
 		return -ENOSPC;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c739bf0c94f..e2b4742c477a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -569,6 +569,12 @@ struct pci_bus {
 	struct list_head resources;	/* Address space routed to this bus */
 	struct resource busn_res;	/* Bus numbers routed to this bus */
 
+	/*
+	 * If there are fixed resources in the bridge window, the hard range
+	 * contains the lowest and the highest addresses of them.
+	 */
+	struct resource fixed_range_hard[PCI_BRIDGE_RESOURCE_NUM];
+
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
 	void		*sysdata;	/* Hook for sys-specific extension */
-- 
2.20.1

