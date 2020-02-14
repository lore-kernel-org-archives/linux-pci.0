Return-Path: <SRS0=x16U=4C=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A0CC2BA83
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D682086A
	for <linux-pci@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695374;
	bh=EH0AaaBxidM6w52kyxw8SmOZ2SPi6FAU5ED1YOkX3CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MxN1ASw0Ib6mHrXMSSYfVX/tHimOrHagsIaGsbzbSmfRm24cq4Aip4xMxDCGHPZ9o
	 pvjcxuH4PbB9RElUeGv3IqLgsE6StxmULQoo7N6kDrjFamhzTx7G5RN+aMwrEEB4Kq
	 yOjCOyRPZNiVkekxJQFSI+6yMwtmQVO5cyzshBzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgBNPtc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbgBNPtc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC609217F4;
        Fri, 14 Feb 2020 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695371;
        bh=EH0AaaBxidM6w52kyxw8SmOZ2SPi6FAU5ED1YOkX3CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xT3U7hlF8bRC0E5nM/2LiJ1VcEu4lk+OgFs0VaVjn116fykb84BI3/r3c+PMC0c1Z
         WDjFK6qMzoFAu9cbXBDKKU0nfahX6fzRmXpNiiSy0MZnTxjV/javZbfJzKBnJeT914
         cHGKEhTiVZwDlv3R9uvETbhT6fEKBNkvKMVBuWYs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Sewart <jamessewart@arista.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 028/542] PCI: Fix pci_add_dma_alias() bitmask size
Date:   Fri, 14 Feb 2020 10:40:20 -0500
Message-Id: <20200214154854.6746-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: James Sewart <jamessewart@arista.com>

[ Upstream commit f8bf2aeb651b3460a4b36fd7ba1ba1d31777d35c ]

The number of possible devfns is 256, but pci_add_dma_alias() allocated a
bitmap of size 255.  Fix this off-by-one error.

This fixes commits 338c3149a221 ("PCI: Add support for multiple DMA
aliases") and c6635792737b ("PCI: Allocate dma_alias_mask with
bitmap_zalloc()"), but I doubt it was possible to see a problem because
it takes 4 64-bit longs (or 8 32-bit longs) to hold 255 bits, and
bitmap_zalloc() doesn't save the 255-bit size anywhere.

[bhelgaas: commit log, move #define to drivers/pci/pci.h, include loop
limit fix from Qian Cai:
https://lore.kernel.org/r/20191218170004.5297-1-cai@lca.pw]
Signed-off-by: James Sewart <jamessewart@arista.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c    | 2 +-
 drivers/pci/pci.h    | 3 +++
 drivers/pci/search.c | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e87196cc1a7fb..7b5fa2eabe095 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6017,7 +6017,7 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
+		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
 		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a0a53bd05a0b8..6394e7746fb54 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,9 @@
 
 #include <linux/pci.h>
 
+/* Number of possible devfns: 0.0 to 1f.7 inclusive */
+#define MAX_NR_DEVFNS 256
+
 #define PCI_FIND_CAP_TTL	48
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade14002fd8a..e4dbdef5aef05 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -41,9 +41,9 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	 * DMA, iterate over that too.
 	 */
 	if (unlikely(pdev->dma_alias_mask)) {
-		u8 devfn;
+		unsigned int devfn;
 
-		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
 				 data);
 			if (ret)
-- 
2.20.1

