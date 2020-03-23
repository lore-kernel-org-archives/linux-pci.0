Return-Path: <SRS0=7zJh=5I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5A1C4332B
	for <linux-pci@archiver.kernel.org>; Mon, 23 Mar 2020 09:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D65C2072D
	for <linux-pci@archiver.kernel.org>; Mon, 23 Mar 2020 09:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgCWJpw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:45:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:5938 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgCWJpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 05:45:52 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Mar 2020 18:45:51 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A21DB60057;
        Mon, 23 Mar 2020 18:45:51 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 23 Mar 2020 18:45:51 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 564BB1A12AD;
        Mon, 23 Mar 2020 18:45:51 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] PCI: endpoint: functions/pci-epf-test: Avoid DMA release when DMA is unsupported
Date:   Mon, 23 Mar 2020 18:45:47 +0900
Message-Id: <1584956747-9273-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When unbinding pci_epf_test, pci_epf_test_clean_dma_chan() is called in
pci_epf_test_unbind() even though epf_test->dma_supported is false.
As a result, dma_release_channel() will occur null pointer access because
dma_chan isn't set.

This avoids calling dma_release_channel() if epf_test->dma_supported
is false.

Fixes: a1d105d4ab8e ("PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 3b4cf7e..8b4f136 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -609,7 +609,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	int bar;
 
 	cancel_delayed_work(&epf_test->cmd_handler);
-	pci_epf_test_clean_dma_chan(epf_test);
+	if (epf_test->dma_supported)
+		pci_epf_test_clean_dma_chan(epf_test);
 	pci_epc_stop(epc);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
-- 
2.7.4

