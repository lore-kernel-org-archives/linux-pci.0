Return-Path: <SRS0=HtbM=ZC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AC5C43331
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 03:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB29215EA
	for <linux-pci@archiver.kernel.org>; Sun, 10 Nov 2019 03:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355835;
	bh=o/TOvQIheBmK4/IOoKUhlIn3DScWwrc2sRd+jGer1Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aMwMW6ZPFEME8wRHFxGOjV7B5mwDi8exGateAYLjWHBhH/+AWgLewYfLM5iSZCjzD
	 w0yH4zp07+WZvrk7RmgkXbPYFdFo/D13DX1yt/AUhaTs6hFldYEj8Gz3FnV5vy/UTo
	 5QXYDi3tpS8hEpkirrXrk4UZXIdGswvAkiPx0G6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfKJDRN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfKJCkY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12FF21924;
        Sun, 10 Nov 2019 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353623;
        bh=o/TOvQIheBmK4/IOoKUhlIn3DScWwrc2sRd+jGer1Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NyltAoaciBfm5ddlZwsGAxCOEh8U8735I6GlCmx4d+8DSKJtHPqTR8doth6yzdO4s
         zS/9eFgoH7jk570QZyHvB+np+Q4m+OjFYTpVdtHohnnHyfnbcTOPLt/mSVHTyA8qRR
         qt05YafNZSNAmX9fxwtILOZlHGv3bOidE9O8zGVA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 008/191] PCI: mediatek: Fix unchecked return value
Date:   Sat,  9 Nov 2019 21:37:10 -0500
Message-Id: <20191110024013.29782-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit 17a0a1e5f6c4bd6df17834312ff577c1373d87b8 ]

Check return value of devm_pci_remap_iospace().

Addresses-Coverity-ID: 1471965 ("Unchecked return value")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index c5ff6ca65eab2..0d100f56cb884 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1120,7 +1120,9 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
 	if (err < 0)
 		return err;
 
-	devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
+	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.20.1

