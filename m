Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADAC43444
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD3020874
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="IuwkuCfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfAKPnw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:52 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40060 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731088AbfAKPnw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:52 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 680CA419C9
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221046; x=1549035447; bh=wsOGUF0tnZahxUl8QCTD7BjM7tC0TeVABzj
        L0cOpQow=; b=IuwkuCfPgSGSdX14fI6MdRXHVgjvHBhpJ855hgFt+fBFBLemqHM
        GFO8rj0yu/gUjcysZ93jkLe030TDeLIZtVhvtAEzPrzmwRnZE0aHebEfOQnGVIP6
        /U1Iju+mUyIs4f04iBFbuaK7huy85ySPuvKkytENPjKUG71tCUcPuPFg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qdNpJCKLjHoS for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:26 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 91733419A2
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:23 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:23 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 10/21] PCI: Allow the failed resources to be reassigned later
Date:   Fri, 11 Jan 2019 18:36:56 +0300
Message-ID: <20190111153707.10140-11-s.miroshnichenko@yadro.com>
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

Don't lose the size of the requested EP's BAR if it can't be fit
in a current trial, so this can be retried.

But a failed bridge window must be dropped and recalculated in the
next trial.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c |  3 ++-
 drivers/pci/setup-res.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3ed13abdf937..9b228a181e5c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -309,7 +309,8 @@ static void assign_requested_resources_sorted(struct list_head *head,
 						    0 /* don't care */,
 						    0 /* don't care */);
 			}
-			reset_resource(res);
+			if (!pci_movable_bars_enabled())
+				reset_resource(res);
 		}
 	}
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index d8ca40a97693..d28b8ca47b91 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -298,6 +298,20 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
+		if (pci_movable_bars_enabled()) {
+			if (resno >= PCI_BRIDGE_RESOURCES &&
+			    resno <= PCI_BRIDGE_RESOURCE_END) {
+				struct resource *res = dev->resource + resno;
+
+				pci_err(dev, "%s: dropping the bridge window BAR %d (%s)\n",
+					__func__, resno, res->name);
+				res->start = 0;
+				res->end = 0;
+				res->flags = 0;
+			}
+			break;
+		}
+
 		if (!bus->parent || !bus->self->transparent)
 			break;
 		bus = bus->parent;
-- 
2.20.1

