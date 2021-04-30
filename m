Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D0C43460
	for <linux-pci@archiver.kernel.org>; Fri, 30 Apr 2021 15:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A135D61462
	for <linux-pci@archiver.kernel.org>; Fri, 30 Apr 2021 15:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhD3Pza (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhD3Pza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:55:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA987C06174A;
        Fri, 30 Apr 2021 08:54:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j7so40280259pgi.3;
        Fri, 30 Apr 2021 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=li4P0f9ZpyoBcCwFHOffrUiZrzMCQxccd5xyukLyhMM=;
        b=SqkaWdQH5jHitR7HyrO7pdXH9wT30YUvJgeZ3KtlT0Rk9mQ1nBfPK3l8KrP/jt0UM/
         9pu/Md3XcahVkflpc28qMEg2GOjKik4gTtCpdcnFpsN8fYXdY0qy4V4W0lLwAzoe2mKd
         BUoEsZvX2br19/hOib3DciVU1MWrRMyzLh5gHCx9zrcjQyaCDvrBrUxAE8HKibp62/3Z
         HC3Aa8QolrmDo2Y63P403sn759PI2AMTAHvYJ3eAvOMIW98X9CxzTVU/j2QdT2X8FLCR
         tJLY5MDeJwaLiDtuKklxUZj0yUPEnOx7tFeAiwrCpW7Bjs601+mw9yWdy6DVnJ7BbCVM
         PVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=li4P0f9ZpyoBcCwFHOffrUiZrzMCQxccd5xyukLyhMM=;
        b=CrV/sdHEyDP3XjBq/aqCpABvqQLA50OkkTWe50cRMyGjJZCqAqUHNRWbq5VKMbvCSa
         yvl9dAcP2JEYws/OZvwUkxQFzrh4WD6qHrWKMJQ6mrJGY4ugnogrY9VsqdSGf58ClEBt
         6dl9vCKypJK2pf0oD0EIRSNfTsaDI4Q2LOuFCcDl3zuK7SkC09OJh2a72XyUALqV/RZK
         k4PKCtLKXDRlc2r4yvv4Huu4bwbmrjv2sWW95QtEaNSJL41UafbD+cCOmtIzzWE8T9E8
         +N6Gixq2ZOEizKyWh8UP+tf6UMw9hzGaDke5ySudzNgRBFrVuNFwjhB8qPVXSYXaqpdS
         /EpQ==
X-Gm-Message-State: AOAM531pnPqtP/PdWGcBvaWgviYeualKA2G452YEZf/rHDLD4PujcW2i
        LZ5PnY854K6OggzRE2Rra3o=
X-Google-Smtp-Source: ABdhPJzhLNopbYOVTFvjJ5/orBo4d8YD8kKpUXJgCiz0JBSJkrj7UyvGPl6TCdqlL9N1Lsj5R8b8Ig==
X-Received: by 2002:a65:620d:: with SMTP id d13mr5219720pgv.85.1619798081388;
        Fri, 30 Apr 2021 08:54:41 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.161])
        by smtp.googlemail.com with ESMTPSA id m11sm3360805pgs.4.2021.04.30.08.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:54:41 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2] PCI: mediatek: Check return value of clk_prepare_enable
Date:   Fri, 30 Apr 2021 21:24:29 +0530
Message-Id: <20210430155429.35034-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case when free_ck clock is not enabled during device resume
check the return value of clk_prepare_enable() and return the
error after printing it.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
Changes in v2:
	- Print the error before returning
	- Clarify commit log
 drivers/pci/controller/pcie-mediatek.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 23548b517..9bdae34cc 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1154,11 +1154,16 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
+	int ret;

 	if (list_empty(&pcie->ports))
 		return 0;

-	clk_prepare_enable(pcie->free_ck);
+	ret = clk_prepare_enable(pcie->free_ck);
+	if (ret) {
+		dev_err(dev, "Failed to enable free_ck clock\n");
+		return ret;
+	}

 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		mtk_pcie_enable_port(port);
--
2.31.1
