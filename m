Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36848C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063762082F
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="ojW7+VTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfBDPgd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:33 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49422 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbfBDPgc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1EB5441977;
        Mon,  4 Feb 2019 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294585; x=1551108986; bh=hZEDWvWqXBUqrszNs1idDsr9iYfPXn76G0M
        RQG+8EUo=; b=ojW7+VTq+Hv6nmHqhB3zJmfywtUkxaBaFP1XxJB8/gBw9neA4UZ
        naD+WqAZqmgF8ZzAWPhrtp9YbwhM5kzZ481r4dCHcmO+hmSDW7rsakMfZ1AdHdBC
        9qqdHjLEqCSWrUEqU5FMdfHMXTlDnR9ReRINattT0Tdx2LGM0VO7m1Yc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5pIpXL6tc9Qp; Mon,  4 Feb 2019 18:36:25 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1AC0341961;
        Mon,  4 Feb 2019 18:36:14 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:13 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v3 19/21] PCI: Prioritize fixed BAR assigning over the movable ones
Date:   Mon, 4 Feb 2019 18:35:59 +0300
Message-ID: <20190204153601.7576-20-s.miroshnichenko@yadro.com>
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

The allocated bridge windows are big enough to house all the children
bridges and BARs, but the fixed resources must be assigned first, so the
movable ones later divide the rest of the window. That's the assignment
order:

 1. Bridge windows with fixed areas;
 2. Fixed BARs;
 3. The rest of BARs and bridge windows.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 69 ++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index be6c64d9bf33..010911a0e458 100644
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
+		else if (assign_float_resources == step && (is_fixed || is_fixed_bridge))
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

