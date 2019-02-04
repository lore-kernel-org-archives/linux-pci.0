Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D5DC282CB
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D5C2082F
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="ETHMorzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfBDPg1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:27 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49396 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731330AbfBDPg0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2A82B41957;
        Mon,  4 Feb 2019 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294584; x=1551108985; bh=Iht5/V7FVxHsASr0t5ZmGU1zlKkIy70F5Le
        ldIDJduo=; b=ETHMorzfeJaW5iopcBxM3p0i/gG6h/PUK0yILoX51s30/SeQ4Dl
        qt4HkG3bxbrIbMB9xrY713dxAO2KtV/ew5ykHRIieIYF8p5BeeSIOGSMQCQ/qzgy
        fxZ/VgBFGMWMiqyj3XDQdBqHuB5gV+N6uCGq/gCT8RfxpdfCev7jgkCg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id adglySAQPIJ4; Mon,  4 Feb 2019 18:36:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AC12F418BF;
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
Subject: [PATCH RFC v3 17/21] PCI: Calculate boundaries for bridge windows
Date:   Mon, 4 Feb 2019 18:35:57 +0300
Message-ID: <20190204153601.7576-18-s.miroshnichenko@yadro.com>
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

If a bridge window contains fixed areas (there are PCIe devices with
immovable BARs located on this bus), this window must be allocated
within the bound memory area, limited by windows size and by address
range of fixed resources, calculated as follows:

           | <--     bus's fixed_range_hard   --> |
  | <--  fixed_range_hard.end - window size   --> |
           | <--  fixed_range_hard.start + window size   --> |
  | <--                bus's fixed_range_soft            --> |

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 56 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  4 ++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 59af85029869..be6c64d9bf33 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1846,6 +1846,61 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
 }
 #endif
 
+static void pci_bus_update_fixed_range_soft(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	struct pci_bus *parent = bus->parent;
+	int idx;
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pci_bus_update_fixed_range_soft(dev->subordinate);
+
+	if (!parent || !bus->self)
+		return;
+
+	for (idx = 0; idx < ARRAY_SIZE(bus->fixed_range_hard); ++idx) {
+		struct resource *r;
+		resource_size_t soft_start, soft_end;
+		resource_size_t hard_start = bus->fixed_range_hard[idx].start;
+		resource_size_t hard_end = bus->fixed_range_hard[idx].end;
+
+		if (hard_start > hard_end)
+			continue;
+
+		r = bus->resource[idx];
+
+		soft_start = hard_end - resource_size(r) + 1;
+		soft_end = hard_start + resource_size(r) - 1;
+
+		if (soft_start > hard_start)
+			soft_start = hard_start;
+
+		if (soft_end < hard_end)
+			soft_end = hard_end;
+
+		list_for_each_entry(dev, &parent->devices, bus_list) {
+			struct pci_bus *sibling = dev->subordinate;
+			resource_size_t s_start, s_end;
+
+			if (!sibling || sibling == bus)
+				continue;
+
+			s_start = sibling->fixed_range_hard[idx].start;
+			s_end = sibling->fixed_range_hard[idx].end;
+
+			if (s_start > s_end)
+				continue;
+
+			if (s_end < hard_start && s_end > soft_start)
+				soft_start = s_end;
+		}
+
+		bus->fixed_range_soft[idx].start = soft_start;
+		bus->fixed_range_soft[idx].end = soft_end;
+	}
+}
+
 /*
  * first try will not touch pci bridge res
  * second and later try will clear small leaf bridge res
@@ -1884,6 +1939,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	/* Depth first, calculate sizes and alignments of all
 	   subordinate buses. */
 	__pci_bus_size_bridges(bus, add_list);
+	pci_bus_update_fixed_range_soft(bus);
 
 	/* Depth last, allocate resources and update the hardware. */
 	__pci_bus_assign_resources(bus, add_list, &fail_head);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2b4742c477a..311d51d0a59a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -571,9 +571,11 @@ struct pci_bus {
 
 	/*
 	 * If there are fixed resources in the bridge window, the hard range
-	 * contains the lowest and the highest addresses of them.
+	 * contains the lowest and the highest addresses of them, and this
+	 * bridge window must reside within the soft range.
 	 */
 	struct resource fixed_range_hard[PCI_BRIDGE_RESOURCE_NUM];
+	struct resource fixed_range_soft[PCI_BRIDGE_RESOURCE_NUM];
 
 	struct pci_ops	*ops;		/* Configuration access functions */
 	struct msi_controller *msi;	/* MSI controller */
-- 
2.20.1

