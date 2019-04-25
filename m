Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C187BC43219
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CB72088F
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfDYQUE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:20:04 -0400
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.118]:56746 "EHLO
        atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbfDYQUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2019 12:20:04 -0400
Received: from atl4mhob21.registeredsite.com (atl4mhob21.registeredsite.com [209.17.115.115])
        by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x3PGBKYU006579
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:11:20 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail03pod6.registeredsite.com [10.30.71.211])
        by atl4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id x3PGBIRH154917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:11:18 -0400
Received: (qmail 12040 invoked by uid 0); 25 Apr 2019 16:11:18 -0000
X-TCPREMOTEIP: 12.206.222.2
X-Authenticated-UID: amikhak@wirelessfabric.com
Received: from unknown (HELO nuc7.sifive.com) (amikhak@wirelessfabric.com@12.206.222.2)
  by 0 with ESMTPA; 25 Apr 2019 16:11:17 -0000
From:   Alan Mikhak <amikhak@wirelessfabric.com>
To:     kishon@ti.com
Cc:     linux-pci@vger.kernel.org, Alan Mikhak <amikhak@wirelessfabric.com>
Subject: [PATCH] Avoid setting odd BAR if skipping reserved 64bit BAR
Date:   Thu, 25 Apr 2019 09:11:05 -0700
Message-Id: <1556208665-1954-1-git-send-email-amikhak@wirelessfabric.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <amikhak@wirelessfabric.com>

Check 64bit flag before skipping reserved BARs
in pci_epf_test_set_bar(). Otherwise it will call
pci_epc_set_bar() on odd loop index when skipping
reserved 64bit BAR.

Signed-off-by: Alan Mikhak <amikhak@wirelessfabric.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d0b91da..64d5a57 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -389,7 +389,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 
 static int pci_epf_test_set_bar(struct pci_epf *epf)
 {
-	int bar;
+	int bar, add;
 	int ret;
 	struct pci_epf_bar *epf_bar;
 	struct pci_epc *epc = epf->epc;
@@ -400,8 +400,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 
 	epc_features = epf_test->epc_features;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = BAR_0; bar <= BAR_5; bar += add) {
 		epf_bar = &epf->bar[bar];
+		/*
+		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
+		 * if the specific implementation required a 64-bit BAR,
+		 * even if we only requested a 32-bit BAR.
+		 */
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
 
 		if (!!(epc_features->reserved_bar & (1 << bar)))
 			continue;
@@ -413,13 +419,6 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 			if (bar == test_reg_bar)
 				return ret;
 		}
-		/*
-		 * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
-		 * if the specific implementation required a 64-bit BAR,
-		 * even if we only requested a 32-bit BAR.
-		 */
-		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
-			bar++;
 	}
 
 	return 0;
-- 
2.7.4

