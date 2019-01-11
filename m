Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADDFC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CCD20700
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="nqvTq8bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbfAKPnz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:43:55 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:40078 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731904AbfAKPny (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 10:43:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id ACEB0419CE
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1547221051; x=1549035452; bh=9Mgh16usuR991UNp6SjMLom44ODQbZVtZFO
        vTV5kUF0=; b=nqvTq8bCImar+0CUbQ3/VfMxk42VsQJj473qffeF52DhRX1iWpn
        N+jIS7I8XsZaMV/5wsgjOVJ1l1HP6HBpd6u7iYIAliOUYr6s62E4cpFl+melNuUb
        C+NU4un3PTRkYLikSKLVo+WHw9WkQfRMaX1xzShemLVERaRdYhsjFDDs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W8jilzyt-GXb for <linux-pci@vger.kernel.org>;
        Fri, 11 Jan 2019 18:37:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8A5E9419C4
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2019 18:37:25 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 11
 Jan 2019 18:37:25 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC v2 20/21] PCI: Wake up bridges during rescan when movable BARs enabled
Date:   Fri, 11 Jan 2019 18:37:06 +0300
Message-ID: <20190111153707.10140-21-s.miroshnichenko@yadro.com>
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

Use the PM runtime methods to wake up the bridges before accessing
their config space.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4726049a19ad..a80978906ac3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3199,6 +3199,8 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pm_runtime_get_sync(&bus->dev);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *child = dev->subordinate;
 
@@ -3242,6 +3244,8 @@ static void pci_bus_rescan_done(struct pci_bus *bus)
 			dev->driver->rescan_done(dev);
 		}
 	}
+
+	pm_runtime_put(&bus->dev);
 }
 
 static void pci_setup_bridges(struct pci_bus *bus)
-- 
2.20.1

