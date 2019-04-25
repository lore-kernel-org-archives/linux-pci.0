Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE27DC43218
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E0C20651
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfDYQQW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:16:22 -0400
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.118]:33418 "EHLO
        atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbfDYQQV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2019 12:16:21 -0400
Received: from atl4mhob22.registeredsite.com (atl4mhob22.registeredsite.com [209.17.115.116])
        by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x3PGBoKT006699
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:11:50 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail02pod6.registeredsite.com [10.30.71.210])
        by atl4mhob22.registeredsite.com (8.14.4/8.14.4) with ESMTP id x3PGBmRv065765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:11:48 -0400
Received: (qmail 13336 invoked by uid 0); 25 Apr 2019 16:11:48 -0000
X-TCPREMOTEIP: 12.206.222.2
X-Authenticated-UID: amikhak@wirelessfabric.com
Received: from unknown (HELO nuc7.sifive.com) (amikhak@wirelessfabric.com@12.206.222.2)
  by 0 with ESMTPA; 25 Apr 2019 16:11:48 -0000
From:   Alan Mikhak <amikhak@wirelessfabric.com>
To:     kishon@ti.com
Cc:     linux-pci@vger.kernel.org, Alan Mikhak <amikhak@wirelessfabric.com>
Subject: [PATCH] Clear BAR before freeing its space
Date:   Thu, 25 Apr 2019 09:11:35 -0700
Message-Id: <1556208695-2018-1-git-send-email-amikhak@wirelessfabric.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <amikhak@wirelessfabric.com>

Associated pci_epf_bar structure is needed in pci_epc_clear_bar() but
would be cleared in pci_epf_free_space(), if called first, and BAR
would not get cleared.

Signed-off-by: Alan Mikhak <amikhak@wirelessfabric.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d0b91da..edee375 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -381,8 +381,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 
 		if (epf_test->reg[bar]) {
-			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
+			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 		}
 	}
 }
-- 
2.7.4

