Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B500C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7F520823
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="YJy5Vp6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfBDPgS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:18 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49282 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBDPgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:18 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3310441911;
        Mon,  4 Feb 2019 15:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294575; x=1551108976; bh=ZFSpeWXC0G6p3BEjk1YvsGQE5boQjBUMxO0
        HRmXCPoU=; b=YJy5Vp6BGkXWZ6z7H4JsavNrPhnh130b9PCKUY+zQj/UaoD5q2p
        923xIkIbPPdAemGZ/5pb6nZMWCWZUpiXotk0J0+9Foa/kid+dpncCbKz2O7bb8pp
        2pN16+72D0+wLkMWNWr5pY0UwghFeYL+8zURBDhti34RriCHmd/rmmx4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T-SJkHKIRIRw; Mon,  4 Feb 2019 18:36:15 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9935241925;
        Mon,  4 Feb 2019 18:36:10 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:10 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v3 04/21] PCI: Define PCI-specific version of the release_child_resources()
Date:   Mon, 4 Feb 2019 18:35:44 +0300
Message-ID: <20190204153601.7576-5-s.miroshnichenko@yadro.com>
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

Make the released resources of a bridge valid for later re-assignment:
clear the STARTALIGN flag.

Resources marked with PCI_FIXED must preserve their offset and size.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 47 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ed960436df5e..cca23c393e29 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1520,6 +1520,51 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
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
+	if (r->flags & IORESOURCE_PCI_FIXED)
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
@@ -1565,7 +1610,7 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
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

