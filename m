Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14AEC4321A
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287DD20651
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfDYQPQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:16 -0400
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:34444 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729023AbfDYQPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Apr 2019 12:15:15 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Apr 2019 12:15:15 EDT
Received: from atl4mhob10.registeredsite.com (atl4mhob10.registeredsite.com [209.17.115.48])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x3PGCKMA008493
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:12:20 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail01pod6.registeredsite.com [10.30.71.209])
        by atl4mhob10.registeredsite.com (8.14.4/8.14.4) with ESMTP id x3PGCHTn017328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2019 12:12:17 -0400
Received: (qmail 12669 invoked by uid 0); 25 Apr 2019 16:12:17 -0000
X-TCPREMOTEIP: 12.206.222.2
X-Authenticated-UID: amikhak@wirelessfabric.com
Received: from unknown (HELO nuc7.sifive.com) (amikhak@wirelessfabric.com@12.206.222.2)
  by 0 with ESMTPA; 25 Apr 2019 16:12:17 -0000
From:   Alan Mikhak <amikhak@wirelessfabric.com>
To:     kishon@ti.com
Cc:     linux-pci@vger.kernel.org, Alan Mikhak <amikhak@wirelessfabric.com>
Subject: [PATCH] Set endpoint controller pointer to null
Date:   Thu, 25 Apr 2019 09:12:04 -0700
Message-Id: <1556208724-2086-1-git-send-email-amikhak@wirelessfabric.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <amikhak@wirelessfabric.com>

Set endpoint controller pointer to null in pci_epc_remove_epf()
to avoid -EBUSY on subsequent call to pci_epc_add_epf().

Also check for null endpoint function pointer.

Signed-off-by: Alan Mikhak <amikhak@wirelessfabric.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e4712a0..2091508 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -519,11 +519,12 @@ void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
 {
 	unsigned long flags;
 
-	if (!epc || IS_ERR(epc))
+	if (!epc || IS_ERR(epc) || !epf)
 		return;
 
 	spin_lock_irqsave(&epc->lock, flags);
 	list_del(&epf->list);
+	epf->epc = NULL;
 	spin_unlock_irqrestore(&epc->lock, flags);
 }
 EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
-- 
2.7.4

