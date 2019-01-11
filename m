Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74250C43614
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1E32184C
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="t74pPX8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbfAKPoA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:44:00 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40072 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbfAKPny (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 935E7419A3
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221042; x=1549035443; bh=TZdUArR/IO2LVbq+K7IE2oXSwBkExscQpAN
        CTOIzSAc=; b=t74pPX8J9AkQGanT2gAYbVlBfryR2l1Vmz+ZgOfLHApkbmbIrz2
        SMpLQKJEK20D059dNzSuOOA8OPa0ePyjVg8JN7/vr2JnQeHtxsAdzcf2vRniOfc2
        YY1Xm9RQxLD8N0OkJtjYTHVk0JyeffFl6Ppt1KT/qifKM8hQaiFUvD9Q=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hwTmKe1IAuRr for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id F210C41973
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:21 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:21 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 02/21] PCI: Define PCI-specific version of the release_child_resources()
Date:   Fri, 11 Jan 2019 18:36:48 +0300
Message-ID: <20190111153707.10140-3-s.miroshnichenko@yadro.com>
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

Make the released resources of a bridge valid for later re-assignment:
clear the STARTALIGN flad.

Resources marked with PCI_FIXED must preserve their offset and size.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 44 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed960436df5e..bd728160c517 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1520,6 +1520,48 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
 	 IORESOURCE_MEM_64)
 
+/*
+ * Similar to release_child_resources(), but aware of PCI_FIXED and STARTALIGN flags
+ */
+static void pci_release_child_resources(struct resource *r)
+{
+	struct resource *tmp, *p;
+
+	if (!r)
+		return;
+
+	p = r->child;
+	r->child = NULL;
+	while (p) {
+		resource_size_t size = resource_size(p);
+
+		tmp = p;
+		p = p->sibling;
+
+		tmp->parent = NULL;
+		tmp->sibling = NULL;
+		pci_release_child_resources(tmp);
+
+		if (!tmp->flags)
+			continue;
+
+		if (tmp->flags & IORESOURCE_PCI_FIXED) {
+			pr_debug("PCI: release fixed %pR (%s), keep its flags, base and size\n",
+				 tmp, tmp->name);
+			continue;
+		}
+
+		pr_debug("PCI: release %pR (%s)\n", tmp, tmp->name);
+
+		/* need to restore size, and keep all the flags but STARTALIGN */
+		tmp->start = 0;
+		tmp->end = size - 1;
+
+		tmp->flags &= ~IORESOURCE_STARTALIGN;
+		tmp->flags |= IORESOURCE_SIZEALIGN;
+	}
+}
+
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					  unsigned long type)
 {
@@ -1565,7 +1607,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 	 * if there are children under that, we should release them
 	 *  all
 	 */
-	release_child_resources(r);
+	pci_release_child_resources(r);
 	if (!release_resource(r)) {
 		type = old_flags = r->flags & PCI_RES_TYPE_MASK;
 		pci_printk(KERN_DEBUG, dev, "resource %d %pR released\n",
-- 
2.20.1

