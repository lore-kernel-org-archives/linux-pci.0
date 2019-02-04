Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E2C282D7
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E33E214DA
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="vO7UiyYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbfBDPgZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:25 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49270 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731330AbfBDPgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:24 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 388DB41949;
        Mon,  4 Feb 2019 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294582; x=1551108983; bh=NPALoNSPN/ZGR/JOuhWP/ys3Y1RWMqEvoA5
        Em/9/5wo=; b=vO7UiyYmZ21FFx2cMvN5NXbFYjhY+wAAALbKTPSm8OGGE+p+0Tq
        mBMFP+vH9nbfSewXigllwK+8TwGVmOBOc+K6E9HMDlzsxpevHz8LU5o+zpthJE5a
        /1n6PGpnp4H1GYEViIMDTGuRcIfQeZr2gdtVAt58fZSg8Br2JZgFZN94=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7SKxBz0YRsX3; Mon,  4 Feb 2019 18:36:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D50C041958;
        Mon,  4 Feb 2019 18:36:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:12 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v3 13/21] PCI: Include fixed BARs into the bus size calculating
Date:   Mon, 4 Feb 2019 18:35:53 +0300
Message-ID: <20190204153601.7576-14-s.miroshnichenko@yadro.com>
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

The only difference between the fixed and movable BARs is an offset
preservation during the release+reassign procedure on PCIe rescan.

When fixed BARs are included into the result of pbus_size_mem(), these
BARs can be restricted: assign them to direct parents only.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 92ce22d32f76..e6fba514e940 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1044,12 +1044,20 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			struct resource *r = &dev->resource[i];
 			resource_size_t r_size;
 
-			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+			if (r->parent ||
 			    ((r->flags & mask) != type &&
 			     (r->flags & mask) != type2 &&
 			     (r->flags & mask) != type3))
 				continue;
 			r_size = resource_size(r);
+
+			if (r->flags & IORESOURCE_PCI_FIXED) {
+				if (pci_movable_bars_enabled())
+					size += r_size;
+
+				continue;
+			}
+
 #ifdef CONFIG_PCI_IOV
 			/* put SRIOV requested res to the optional list */
 			if (realloc_head && i >= PCI_IOV_RESOURCES &&
@@ -1388,6 +1396,8 @@ static void pdev_assign_fixed_resources(struct pci_dev *dev)
 		while (b && !r->parent) {
 			assign_fixed_resource_on_bus(b, r);
 			b = b->parent;
+			if (!r->parent && pci_movable_bars_enabled())
+				break;
 		}
 	}
 }
-- 
2.20.1

