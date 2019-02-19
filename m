Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A444CC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EE32075A
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANiDQy+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfBSGDw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:03:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34505 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfBSGDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 01:03:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so9596304pgd.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Feb 2019 22:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GyjR1K+SCkiQJRz7sqZ/Dyo0n3Et48Yb+zUiZSu0/dQ=;
        b=ANiDQy+khlnfvD/w1RKC5rOs+Q2wteA0b4ldJqmxAFgowdd/bphom+Cz+tWc2FUAwj
         SM4t1zeZL5sK4TCY/qDKjyYxPd7Q80aTk75sjo2bkeY1B85g++OUiwYFv3GJIUK0JF76
         Tw3fsaITrSP94oFVYgbXhaQ6U5S2UK1r/AUvRZMGn5ufrEPta1NcMnob6upo6i6pr4ud
         5t4Ro4s12GPpjTwDYbg8sPHi/wLggL6Mrn5FXTsar3TEBznzfuN95ngIMWb7VQx8GzYe
         ylLi/kYUXkSYupzA1OUzArx3jOR6YDcwxlU1H0TFykPwYmnicAOqN3lwoKdzoK0EznLx
         /fKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GyjR1K+SCkiQJRz7sqZ/Dyo0n3Et48Yb+zUiZSu0/dQ=;
        b=IiiqDUWZyJqWuNprJcfKduC6DGlQflrYGdP9ZoI8NqSXQhy654tczOnCJ2ru+W0rhl
         w7TTCHbHKu/+Ua0Tb8c0FJHDmxLSivgMD2iEvu8y7u8w0F9twOjbT26tTMh4hM/OqaHZ
         d6JfurO77YiVLU+0iKV8QIrvNNee5vTO5LCd+2NAdbajiBATO3O/8FxAsMJvPZMwZGjO
         BWjRlinCW3nnTzC359ZbivENCdVxZZpwg4lr5kc+x29jHkR4I2Qk5lTiFSLlH5DYBtLr
         JqirGHy6aKOXXrBLBMTUhCufWuJvZx/6+Ypj/keQahTV9NkmAJeCsclxovPNfXtuZBSJ
         Tnyg==
X-Gm-Message-State: AHQUAuZ87y54b1paVdp3Xj6BF1QDMdQ6fmWJsDznyQOWQz/33eVIDW8u
        aTuWuYaC490SgGOwEhouRxo25g==
X-Google-Smtp-Source: AHgI3IYqMUM8xyL6zRq4Npy/+3U9kfU+r5bItEm8svJ14Et8uSwLZAjgbmTYQRjz92/hdmcS8lc7cg==
X-Received: by 2002:a63:6506:: with SMTP id z6mr22343021pgb.334.1550556231327;
        Mon, 18 Feb 2019 22:03:51 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 86sm31914838pfk.157.2019.02.18.22.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:03:50 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 1/7] clk: gcc-qcs404: Add PCIe resets
Date:   Mon, 18 Feb 2019 22:04:01 -0800
Message-Id: <20190219060407.15263-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190219060407.15263-1-bjorn.andersson@linaro.org>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enabling PCIe requires several of the PCIe related resets from GCC, so
add them all.

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gcc-qcs404.c               | 7 +++++++
 include/dt-bindings/clock/qcom,gcc-qcs404.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 64da032bb9ed..5aed43923239 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2675,6 +2675,13 @@ static const struct qcom_reset_map gcc_qcs404_resets[] = {
 	[GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
 	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
 	[GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
+	[GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = { 0x3e040, 6},
+	[GCC_PCIE_0_AHB_ARES] = { 0x3e040, 5 },
+	[GCC_PCIE_0_AXI_SLAVE_ARES] = { 0x3e040, 4 },
+	[GCC_PCIE_0_AXI_MASTER_ARES] = { 0x3e040, 3 },
+	[GCC_PCIE_0_CORE_STICKY_ARES] = { 0x3e040, 2 },
+	[GCC_PCIE_0_SLEEP_ARES] = { 0x3e040, 1 },
+	[GCC_PCIE_0_PIPE_ARES] = { 0x3e040, 0 },
 	[GCC_EMAC_BCR] = { 0x4e000 },
 };
 
diff --git a/include/dt-bindings/clock/qcom,gcc-qcs404.h b/include/dt-bindings/clock/qcom,gcc-qcs404.h
index 6ceb55ed72c6..00ab0d77b38a 100644
--- a/include/dt-bindings/clock/qcom,gcc-qcs404.h
+++ b/include/dt-bindings/clock/qcom,gcc-qcs404.h
@@ -161,5 +161,12 @@
 #define GCC_PCIE_0_LINK_DOWN_BCR			11
 #define GCC_PCIEPHY_0_PHY_BCR				12
 #define GCC_EMAC_BCR					13
+#define GCC_PCIE_0_AXI_MASTER_STICKY_ARES		14
+#define GCC_PCIE_0_AHB_ARES				15
+#define GCC_PCIE_0_AXI_SLAVE_ARES			16
+#define GCC_PCIE_0_AXI_MASTER_ARES			17
+#define GCC_PCIE_0_CORE_STICKY_ARES			18
+#define GCC_PCIE_0_SLEEP_ARES				19
+#define GCC_PCIE_0_PIPE_ARES				20
 
 #endif
-- 
2.18.0

