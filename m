Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D79C43612
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD4D20874
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="eW/tZb2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfAKPnw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:52 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40058 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbfAKPnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 66092419BB
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221048; x=1549035449; bh=CYWyPQs/QFu4sPDIapOVamTOlt1BY8q50vj
        BXf4I488=; b=eW/tZb2KxDoL2cHJ0vCxNPe8Y5aLo9iEwvwyJWdoLlKBu7gl3A4
        dsxebfRo/YkE2mLKT2yRr0kYbtIBlteshKH+Md12zvdTXvKSxCJwN6XW/XsNLhqJ
        zDIjnmDydvKj3u7OY9L++vn6NpP9sMtFyqOFG9xS7s4wx3a2mRSidjUY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jEFAW9iL72k7 for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:28 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 607AC419BC
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:24 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:24 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 14/21] PCI: Prioritize fixed BAR assigning over the movable ones
Date:   Fri, 11 Jan 2019 18:37:00 +0300
Message-ID: <20190111153707.10140-15-s.miroshnichenko@yadro.com>
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

The allocated bridge windows are big enough to house all the children
bridges and BARs, but the fixed resources must be assigned first, so the
movable ones later divide the rest of the window. That's the assignment
order:

 1. Bridge windows with fixed areas;
 2. The rest of bridge windows;
 3. Fixed BARs of direct children EPs;
 4. The rest of BARs.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 69 ++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 09226a201119..10ddf08b1625 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -272,31 +272,54 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 	}
 }
 
-/**
- * assign_requested_resources_sorted() - satisfy resource requests
- *
- * @head : head of the list tracking requests for resources
- * @fail_head : head of the list tracking requests that could
- *		not be allocated
- *
- * Satisfy resource requests of each element in the list. Add
- * requests that could not satisfied to the failed_list.
- */
-static void assign_requested_resources_sorted(struct list_head *head,
-				 struct list_head *fail_head)
+enum assign_step {
+	assign_fixed_bridge_windows,
+	assign_fixed_resources,
+	assign_float_resources,
+};
+
+static void _assign_requested_resources_sorted(struct list_head *head,
+					       struct list_head *fail_head,
+					       enum assign_step step)
 {
 	struct resource *res;
 	struct pci_dev_resource *dev_res;
 	int idx;
 
 	list_for_each_entry(dev_res, head, list) {
+		bool is_fixed;
+		bool is_fixed_bridge;
+		bool is_bridge;
+
 		if (pci_dev_is_ignored(dev_res->dev))
 			continue;
 
 		res = dev_res->res;
+		if (!resource_size(res))
+			continue;
+
 		idx = res - &dev_res->dev->resource[0];
-		if (resource_size(res) &&
-		    pci_assign_resource(dev_res->dev, idx)) {
+		is_fixed = res->flags & IORESOURCE_PCI_FIXED;
+		is_bridge = dev_res->dev->subordinate && idx >= PCI_BRIDGE_RESOURCES;
+
+		if (is_bridge) {
+			struct pci_bus *child = dev_res->dev->subordinate;
+			int b_res_idx = pci_get_bridge_resource_idx(res);
+			struct resource *fixed_res = &child->fixed_range_hard[b_res_idx];
+
+			is_fixed_bridge = fixed_res->start < fixed_res->end;
+		} else {
+			is_fixed_bridge = false;
+		}
+
+		if (assign_fixed_bridge_windows == step && !is_fixed_bridge)
+			continue;
+		else if (assign_fixed_resources == step && (!is_fixed || is_bridge))
+			continue;
+		else if (assign_float_resources == step && is_fixed)
+			continue;
+
+		if (pci_assign_resource(dev_res->dev, idx)) {
 			if (fail_head) {
 				/*
 				 * if the failed res is for ROM BAR, and it will
@@ -315,6 +338,24 @@ static void assign_requested_resources_sorted(struct list_head *head,
 	}
 }
 
+/**
+ * assign_requested_resources_sorted() - satisfy resource requests
+ *
+ * @head : head of the list tracking requests for resources
+ * @fail_head : head of the list tracking requests that could
+ *		not be allocated
+ *
+ * Satisfy resource requests of each element in the list. Add
+ * requests that could not satisfied to the failed_list.
+ */
+static void assign_requested_resources_sorted(struct list_head *head,
+					      struct list_head *fail_head)
+{
+	_assign_requested_resources_sorted(head, fail_head, assign_fixed_bridge_windows);
+	_assign_requested_resources_sorted(head, fail_head, assign_fixed_resources);
+	_assign_requested_resources_sorted(head, fail_head, assign_float_resources);
+}
+
 static unsigned long pci_fail_res_type_mask(struct list_head *fail_head)
 {
 	struct pci_dev_resource *fail_res;
-- 
2.20.1

