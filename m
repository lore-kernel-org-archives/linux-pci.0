Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5581FC282D7
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2A120823
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 15:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="RvKBOAtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfBDPgV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:36:21 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:49282 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbfBDPgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 10:36:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 65DB241969;
        Mon,  4 Feb 2019 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1549294578; x=1551108979; bh=jwH0P9Xag/Shas342g+4t1xNKBCTKGrg818
        /YDwT5ow=; b=RvKBOAtfHDU2AK6iq2KyidYbTzkcBoNsS6qZJ6g5WWDYeAL1JPR
        Y6ie+vvJ6Jlt7PU3plNmPSuuckZo388fhXMGy8jgpvfvQYBMMoIHb1vTZiL/rVEg
        hgxgUP/kbb0Ae/FG1ogf6LNk1/IVGmGOciM6le5Al7IBrp8BO/NSyKMM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AHYuLdBfHVnP; Mon,  4 Feb 2019 18:36:18 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id B11AF41258;
        Mon,  4 Feb 2019 18:36:11 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 4 Feb
 2019 18:36:11 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v3 09/21] PCI: Mark immovable BARs with PCI_FIXED
Date:   Mon, 4 Feb 2019 18:35:49 +0300
Message-ID: <20190204153601.7576-10-s.miroshnichenko@yadro.com>
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

If a PCIe device driver doesn't yet have support for movable BARs,
mark device's BARs with IORESOURCE_PCI_FIXED.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7fe68b4f04bf..1f50eb556d28 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3186,6 +3186,21 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
 		} else if (dev->driver &&
 			   dev->driver->rescan_prepare) {
 			dev->driver->rescan_prepare(dev);
+		} else if (dev->driver || ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA)) {
+			int i;
+
+			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+				struct resource *r = &dev->resource[i];
+
+				if (!r->flags || !r->parent ||
+				    (r->flags & IORESOURCE_UNSET) ||
+				    (r->flags & IORESOURCE_PCI_FIXED))
+					continue;
+
+				r->flags |= IORESOURCE_PCI_FIXED;
+				pci_warn(dev, "%s: no support for movable BARs, mark BAR %d (%pR) as fixed\n",
+					 __func__, i, r);
+			}
 		}
 	}
 }
-- 
2.20.1

