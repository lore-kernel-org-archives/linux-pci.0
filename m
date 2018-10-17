Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE131ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 16:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C767A214DD
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 16:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C767A214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJRABl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:01:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43164 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbeJRABl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 20:01:41 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gCoJu-0002Bv-VC; Wed, 17 Oct 2018 10:05:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gCoJt-0004fq-Rb; Wed, 17 Oct 2018 10:05:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Date:   Wed, 17 Oct 2018 10:05:10 -0600
Message-Id: <20181017160510.17926-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dan.carpenter@oracle.com, logang@deltatee.com, bhelgaas@google.com, hch@infradead.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] PCI/P2PDMA: Fix NULL check in pci_p2pmem_publish()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We should only assign 'p2pmem_published' if 'pdev->p2pdma' is not NULL.
The extra check on 'publish' makes no sense.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 drivers/pci/p2pdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index da66c7e31730..d710b5ef65a1 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -678,10 +678,8 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
  */
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
-	if (publish && !pdev->p2pdma)
-		return;
-
-	pdev->p2pdma->p2pmem_published = publish;
+	if (pdev->p2pdma)
+		pdev->p2pdma->p2pmem_published = publish;
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-- 
2.19.0

