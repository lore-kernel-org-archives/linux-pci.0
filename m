Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B381FC282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F24217F9
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="P1Cichr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfBDPg2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:28 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49282 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731340AbfBDPg2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2B6094195A;
        Mon,  4 Feb 2019 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294585; x=1551108986; bh=ES4IHYHawY+rGNAmCsSDSgYU25ke2e/UjSw
        9HcjfDXE=; b=P1Cichr7yw9/3ggUl1eSYtH3CCgSB/q53Nl4TIlELVWenZoM6Ye
        45e6EOzYwVlvzYgIrhFNCrTdQsR4/M3c/nDxqtt7r0pqj/HypgOMlMUhFmyzSaXG
        xZRzDIOZ/CNuzTNpYPG2jIQxWD6/Bf/jQBYbL4sM/TqzEs1jjzuVuaq0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uXIebw9GMRtv; Mon,  4 Feb 2019 18:36:25 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id DB89941960;
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
Subject: [PATCH RFC v3 18/21] PCI: Make sure bridge windows include their fixed BARs
Date:   Mon, 4 Feb 2019 18:35:58 +0300
Message-ID: <20190204153601.7576-19-s.miroshnichenko@yadro.com>
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

Consider previously calculated boundaries when allocating a bridge
window, setting the lowest allowed address and checking the result.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/bus.c       |  2 +-
 drivers/pci/setup-res.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index a9784144d6f2..ce2d2aeedbd3 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -192,7 +192,7 @@ static int pci_bus_alloc_from_region(struct pci_bus *bus, struct resource *res,
 		 * this is an already-configured bridge window, its start
 		 * overrides "min".
 		 */
-		if (avail.start)
+		if (min_used < avail.start)
 			min_used = avail.start;
 
 		max = avail.end;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 732d18f60f1b..04442339548d 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -248,9 +248,22 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	struct resource *res = dev->resource + resno;
 	resource_size_t min;
 	int ret;
+	resource_size_t start = (resource_size_t)-1;
+	resource_size_t end = 0;
 
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
+	if (dev->subordinate && resno >= PCI_BRIDGE_RESOURCES) {
+		struct pci_bus *child_bus = dev->subordinate;
+		int b_resno = resno - PCI_BRIDGE_RESOURCES;
+		resource_size_t soft_start = child_bus->fixed_range_soft[b_resno].start;
+
+		start = child_bus->fixed_range_hard[b_resno].start;
+		end = child_bus->fixed_range_hard[b_resno].end;
+		if (start < end)
+			min = soft_start;
+	}
+
 	/*
 	 * First, try exact prefetching match.  Even if a 64-bit
 	 * prefetchable bridge window is below 4GB, we can't put a 32-bit
@@ -262,7 +275,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
 				     pcibios_align_resource, dev);
 	if (ret == 0)
-		return 0;
+		goto check_fixed;
 
 	/*
 	 * If the prefetchable window is only 32 bits wide, we can put
@@ -274,7 +287,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 					     IORESOURCE_PREFETCH,
 					     pcibios_align_resource, dev);
 		if (ret == 0)
-			return 0;
+			goto check_fixed;
 	}
 
 	/*
@@ -287,6 +300,20 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
 					     pcibios_align_resource, dev);
 
+check_fixed:
+	if (ret == 0 && start < end) {
+		if (res->start > start || res->end < end) {
+			dev_err(&bus->dev, "%s: fixed area 0x%llx-0x%llx for %s doesn't fit in the allocated %pR (0x%llx-0x%llx)",
+				__func__,
+				(unsigned long long)start, (unsigned long long)end,
+				dev_name(&dev->dev),
+				res, (unsigned long long)res->start,
+				(unsigned long long)res->end);
+			release_resource(res);
+			return -1;
+		}
+	}
+
 	return ret;
 }
 
-- 
2.20.1

