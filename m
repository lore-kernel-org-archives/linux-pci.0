Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D206C43219
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8B20891
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfDYQQF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:16:05 -0400
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:50842 "EHLO
        atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbfDYQQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2019 12:16:04 -0400
Received: from atl4mhob06.registeredsite.com (atl4mhob06.registeredsite.com [209.17.115.44])
        by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x3PGAnwB012804
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:10:49 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail01pod6.registeredsite.com [10.30.71.209])
        by atl4mhob06.registeredsite.com (8.14.4/8.14.4) with ESMTP id x3PGAlxf013746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:10:47 -0400
Received: (qmail 32247 invoked by uid 0); 25 Apr 2019 16:10:47 -0000
X-TCPREMOTEIP: 12.206.222.2
X-Authenticated-UID: amikhak@wirelessfabric.com
Received: from unknown (HELO nuc7.sifive.com) (amikhak@wirelessfabric.com@12.206.222.2)
  by 0 with ESMTPA; 25 Apr 2019 16:10:46 -0000
From:   Alan Mikhak <amikhak@wirelessfabric.com>
To:     kishon@ti.com
Cc:     linux-pci@vger.kernel.org, Alan Mikhak <amikhak@wirelessfabric.com>
Subject: [PATCH] Avoid leak on 64bit register or reserved BAR
Date:   Thu, 25 Apr 2019 09:10:29 -0700
Message-Id: <1556208629-1887-1-git-send-email-amikhak@wirelessfabric.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <amikhak@wirelessfabric.com>

Always check 64bit flag before skipping BARs
in pci_epf_test_alloc_space(). Otherwise will call
pci_epf_alloc_space() on bind for odd loop index
when BAR is 64bit but leaks on subsequent unbind
by not calling pci_epf_free_space().

Signed-off-by: Alan Mikhak <amikhak@wirelessfabric.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d0b91da..781f8af 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -431,7 +431,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	struct device *dev = &epf->dev;
 	struct pci_epf_bar *epf_bar;
 	void *base;
-	int bar;
+	int bar, add;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	const struct pci_epc_features *epc_features;
 
@@ -440,13 +440,15 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 	base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
 				   test_reg_bar);
 	if (!base) {
-		dev_err(dev, "Failed to allocated register space\n");
+		dev_err(dev, "Failed to allocate register space\n");
 		return -ENOMEM;
 	}
 	epf_test->reg[test_reg_bar] = base;
 
-	for (bar = BAR_0; bar <= BAR_5; bar++) {
+	for (bar = BAR_0; bar <= BAR_5; bar += add) {
 		epf_bar = &epf->bar[bar];
+		add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
+
 		if (bar == test_reg_bar)
 			continue;
 
@@ -458,8 +460,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
 			dev_err(dev, "Failed to allocate space for BAR%d\n",
 				bar);
 		epf_test->reg[bar] = base;
-		if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
-			bar++;
 	}
 
 	return 0;
-- 
2.7.4

