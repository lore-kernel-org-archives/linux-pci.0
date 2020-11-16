Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC5AC6369E
	for <linux-pci@archiver.kernel.org>; Mon, 16 Nov 2020 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A0D20715
	for <linux-pci@archiver.kernel.org>; Mon, 16 Nov 2020 16:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1BPqWzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgKPQgb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732184AbgKPQga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 11:36:30 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963CCC0613CF;
        Mon, 16 Nov 2020 08:36:30 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m6so2190217wrg.7;
        Mon, 16 Nov 2020 08:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A+FE3R5hcwBY+z65SnAL9G4GLC9xYY2THDCEYGJfiOk=;
        b=J1BPqWzpxluha/Pzix6Tivk6KVAv2wIWkDVgTeSGvnKGOjIK3xHxOa2efF9EVxS6ci
         8s5rTD3Gc65zy5etH8nriLeeDEg4aIHTGiE57MLKhr2l0O3gtG3TMCS3gDBac525nUCU
         R5UymHm096bLiFhIVfGDLDxZ1Q0kaKnCZQo7CORpzfItWldfKr0wqrjagdu57IcRO7d9
         s4QZz+VZ/2CRSbU1JRs5N2QsYiEDcJuxmgjfsYARlNTbALgR1+wjq420fIC5gJlB+bnc
         GoAUdSUJN/m/A67O2Q4nNNtq5y/1kznLVQ0xNhbkOJRhdPN26GaP1DUxtqA4rrgfpFjy
         YH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A+FE3R5hcwBY+z65SnAL9G4GLC9xYY2THDCEYGJfiOk=;
        b=L4/XszQeWd6u0MUvNmUB/RP6F5wXkhSZbV72eLuaayHNM2Ns3Vu/rUIKBz+3aPK012
         etpUH+WNofbQCvuHECzNAvqhZc5ziuYHIGd1fivGgwMoZUSo4td5n2EVo+fEtsTMvRhj
         pFyMbJQxf9gfDpIaWvxa0Vbwwy55Mt2vAl15ZlTGp69SPvewl1gJdoswg8snmN9hT4YP
         AeCeQH4yKgUUI3inH+GnkHW0Tu6KQTBjBjh1mBi0MPNX75W/uEW7m6ssSZAi9aQQcmpq
         0kQRDBWw1IYaN52e0lf3OssV++xQEg0SFhK6+XaQ3YfLwsUprBx43iK7R68u8Jq8zBA+
         5P/g==
X-Gm-Message-State: AOAM531pDG2NT9s2yGQzK4edekLNwrAGH0rHDWpeNK/b4nkZt2TiS3rN
        Hi2jcSxL/I3hMnh49CGN00E=
X-Google-Smtp-Source: ABdhPJyQOz4ID7iAss60cqSo99HMjyg8KY37EymsVFnt2YOdJq7ZDNPakBD9WB6RpRPOkuB4GSz0kA==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr19367408wrq.33.1605544589403;
        Mon, 16 Nov 2020 08:36:29 -0800 (PST)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id h15sm23361628wrw.15.2020.11.16.08.36.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 08:36:28 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] PCI: dwc/meson: Use PTR_ERR_OR_ZERO
Date:   Mon, 16 Nov 2020 16:34:18 +0000
Message-Id: <20201116163418.10529-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
doing 'return 0'.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 1913dc2c8fa0..f4261f5aceb1 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -115,10 +115,8 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
 		return PTR_ERR(pci->dbi_base);
 
 	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
-	if (IS_ERR(mp->cfg_base))
-		return PTR_ERR(mp->cfg_base);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(mp->cfg_base);
 }
 
 static int meson_pcie_power_on(struct meson_pcie *mp)
@@ -208,10 +206,8 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 		return PTR_ERR(res->general_clk);
 
 	res->clk = meson_pcie_probe_clock(dev, "pclk", 0);
-	if (IS_ERR(res->clk))
-		return PTR_ERR(res->clk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(res->clk);
 }
 
 static inline u32 meson_cfg_readl(struct meson_pcie *mp, u32 reg)
-- 
2.11.0

