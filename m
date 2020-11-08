Return-Path: <SRS0=7zso=EO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E5AC388F9
	for <linux-pci@archiver.kernel.org>; Sun,  8 Nov 2020 19:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51227221FF
	for <linux-pci@archiver.kernel.org>; Sun,  8 Nov 2020 19:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgKHTL7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 8 Nov 2020 14:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHTL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2020 14:11:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483CBC0613CF;
        Sun,  8 Nov 2020 11:11:59 -0800 (PST)
Received: from dslb-084-059-242-201.084.059.pools.vodafone-ip.de ([84.59.242.201] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1kbq6P-0006hf-US; Sun, 08 Nov 2020 20:11:50 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] PCI: altera-msi: Remove irq handler and data in one go
Date:   Sun,  8 Nov 2020 20:11:40 +0100
Message-Id: <20201108191140.23227-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the two separate calls for removing the irq handler and data with a
single irq_set_chained_handler_and_data() call.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/pci/controller/pcie-altera-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index e1636f7714ca..42691dd8ebef 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -204,8 +204,7 @@ static int altera_msi_remove(struct platform_device *pdev)
 	struct altera_msi *msi = platform_get_drvdata(pdev);
 
 	msi_writel(msi, 0, MSI_INTMASK);
-	irq_set_chained_handler(msi->irq, NULL);
-	irq_set_handler_data(msi->irq, NULL);
+	irq_set_chained_handler_and_data(msi->irq, NULL, NULL);
 
 	altera_free_domains(msi);
 
-- 
2.20.1

