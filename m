Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DDEC282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FA62082F
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="b2RO3nD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfBDPgZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:25 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49282 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbfBDPgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:24 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4BE0841931;
        Mon,  4 Feb 2019 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294580; x=1551108981; bh=LfYwMoeGy/M1ZEnk8iKUjneOEQTHSScnchE
        56SOIn5A=; b=b2RO3nD4R+kbv4Y2zdysWXmMixx02kMz220kgEygrl6s6H9Oy1I
        mXklmfTQIR8ZsreJ7nexPDDDTwlA8jqwS7o0cr8bHeHShSZV7Be2Cb3QDi78TEEA
        zhOE3ZgpoxjLPCSdrCifLX7o56SZLBi5n796j3CldpbEdIGfBZLvB1G8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i79Tz5L8_5L0; Mon,  4 Feb 2019 18:36:20 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 76C0641949;
        Mon,  4 Feb 2019 18:36:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:11 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v3 11/21] PCI: Release and reassign the root bridge resources during rescan
Date:   Mon, 4 Feb 2019 18:35:51 +0300
Message-ID: <20190204153601.7576-12-s.miroshnichenko@yadro.com>
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

When the movable BARs feature is enabled, don't rely on the memory gaps
reserved by the BIOS/bootloader/firmware, but instead rearrange the BARs
and bridge windows starting from the root.

Endpoint device's BARs, after being released, are resorted and written
back by the pci_assign_unassigned_root_bus_resources().

The last step of writing the recalculated windows to the bridges is done
by the new pci_setup_bridges() function.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.h       |  1 +
 drivers/pci/probe.c     | 22 ++++++++++++++++++++++
 drivers/pci/setup-bus.c | 11 ++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 224d88634115..e06e8692a7b1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -248,6 +248,7 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *realloc_head,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
+void pci_bus_release_root_bridge_resources(struct pci_bus *bus);
 
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1f50eb556d28..de808ca28797 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3223,6 +3223,25 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
 	pm_runtime_put(&bus->dev);
 }
 
+static void pci_setup_bridges(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *child;
+
+		if (!pci_dev_is_added(dev) || pci_dev_is_ignored(dev))
+			continue;
+
+		child = dev->subordinate;
+		if (child)
+			pci_setup_bridges(child);
+	}
+
+	if (bus->self)
+		pci_setup_bridge(bus);
+}
+
 /**
  * pci_rescan_bus - Scan a PCI bus for devices
  * @bus: PCI bus to scan
@@ -3245,8 +3264,11 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_bus_rescan_prepare(root);
 
 		max = pci_scan_child_bus(root);
+
+		pci_bus_release_root_bridge_resources(root);
 		pci_assign_unassigned_root_bus_resources(root);
 
+		pci_setup_bridges(root);
 		pci_bus_rescan_done(root);
 	} else {
 		max = pci_scan_child_bus(bus);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b1eec758d2c1..07c6d9cc209f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1621,7 +1621,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
 					PCI_BRIDGE_RESOURCES + idx, r);
 		/* keep the old size */
-		r->end = resource_size(r) - 1;
+		r->end = pci_movable_bars_enabled() ? 0 : (resource_size(r) - 1);
 		r->start = 0;
 		r->flags = 0;
 
@@ -1674,6 +1674,15 @@ static void pci_bus_release_bridge_resources(struct pci_bus *bus,
 		pci_bridge_release_resources(bus, type);
 }
 
+void pci_bus_release_root_bridge_resources(struct pci_bus *root_bus)
+{
+	pci_bus_release_bridge_resources(root_bus, IORESOURCE_IO, whole_subtree);
+	pci_bus_release_bridge_resources(root_bus, IORESOURCE_MEM, whole_subtree);
+	pci_bus_release_bridge_resources(root_bus,
+					 IORESOURCE_MEM_64 | IORESOURCE_PREFETCH,
+					 whole_subtree);
+}
+
 static void pci_bus_dump_res(struct pci_bus *bus)
 {
 	struct resource *res;
-- 
2.20.1

