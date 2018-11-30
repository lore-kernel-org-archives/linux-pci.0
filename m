Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14196C64EB4
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 22:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64EA20834
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 22:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64EA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLAKKM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:10:12 -0500
Received: from ale.deltatee.com ([207.54.116.67]:45318 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeLAKKM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Dec 2018 05:10:12 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gSrkh-00061c-Cb; Fri, 30 Nov 2018 15:59:16 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gSrkg-0000lU-IU; Fri, 30 Nov 2018 15:59:14 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 30 Nov 2018 15:59:11 -0700
Message-Id: <20181130225911.2900-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: akpm@linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, logang@deltatee.com, dan.j.williams@intel.com, bhelgaas@google.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] PCI/P2PDMA: Match interface changes to devm_memremap_pages()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch" in the
mm tree breaks p2pdma. The patch was written and reviewed before p2pdma
was merged so the necessary changes were not done to the call site in
that code.

Without this patch, all drivers will fail to register P2P resources
because devm_memremap_pages() will return -EINVAL due to the 'kill'
member of the pagemap structure not yet being set.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---

Ideally this patch should be squashed with the one mentioned above to
avoid a bisect regression point.

drivers/pci/p2pdma.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ae3c5b25dcc7..a2eb25271c96 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -82,10 +82,8 @@ static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
 	complete_all(&p2p->devmap_ref_done);
 }

-static void pci_p2pdma_percpu_kill(void *data)
+static void pci_p2pdma_percpu_kill(struct percpu_ref *ref)
 {
-	struct percpu_ref *ref = data;
-
 	/*
 	 * pci_p2pdma_add_resource() may be called multiple times
 	 * by a driver and may register the percpu_kill devm action multiple
@@ -198,6 +196,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
 	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
+	pgmap->kill = pci_p2pdma_percpu_kill;

 	addr = devm_memremap_pages(&pdev->dev, pgmap);
 	if (IS_ERR(addr)) {
@@ -211,11 +210,6 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	if (error)
 		goto pgmap_free;

-	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_percpu_kill,
-					  &pdev->p2pdma->devmap_ref);
-	if (error)
-		goto pgmap_free;
-
 	pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
 		 &pgmap->res);

--
2.19.0
