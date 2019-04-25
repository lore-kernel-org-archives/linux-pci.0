Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF49C43218
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D6D20651
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDYQPQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:16 -0400
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:34526 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729039AbfDYQPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2019 12:15:15 -0400
Received: from atl4mhob20.registeredsite.com (atl4mhob20.registeredsite.com [209.17.115.114])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x3PGAAem007345
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:10:10 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail03pod6.registeredsite.com [10.30.71.211])
        by atl4mhob20.registeredsite.com (8.14.4/8.14.4) with ESMTP id x3PGA8un012326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:10:08 -0400
Received: (qmail 2062 invoked by uid 0); 25 Apr 2019 16:10:07 -0000
X-TCPREMOTEIP: 12.206.222.2
X-Authenticated-UID: amikhak@wirelessfabric.com
Received: from unknown (HELO nuc7.sifive.com) (amikhak@wirelessfabric.com@12.206.222.2)
  by 0 with ESMTPA; 25 Apr 2019 16:10:07 -0000
From:   Alan Mikhak <amikhak@wirelessfabric.com>
To:     kishon@ti.com
Cc:     linux-pci@vger.kernel.org, Alan Mikhak <amikhak@wirelessfabric.com>
Subject: [PATCH] Allocate enough space for fixed size BAR
Date:   Thu, 25 Apr 2019 09:09:52 -0700
Message-Id: <1556208592-1750-1-git-send-email-amikhak@wirelessfabric.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <amikhak@wirelessfabric.com>

In pci_epf_test_alloc_space(), check if BAR being
used for test register space is a fixed size BAR.
If so, allocate the required fixed size.

Signed-off-by: Alan Mikhak <amikhak@wirelessfabric.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d0b91da..dfa6a46 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -434,11 +434,15 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	int bar;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	const struct pci_epc_features *epc_features;
+	size_t test_reg_size;
 
 	epc_features = epf_test->epc_features;
-
-	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
-				   test_reg_bar);
+	if (epc_features->bar_fixed_size[test_reg_bar])
+		test_reg_size = bar_size[test_reg_bar];
+	else
+		test_reg_size = sizeof(struct pci_epf_test_reg);
+
+	base = pci_epf_alloc_space(epf, test_reg_size, test_reg_bar);
 	if (!base) {
 		dev_err(dev, "Failed to allocated register space\n");
 		return -ENOMEM;
-- 
2.7.4

