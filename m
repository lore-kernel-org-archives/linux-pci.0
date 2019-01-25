Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B17FC282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C94E218FF
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL34RnmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfAYXqZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:46:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34273 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbfAYXpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 18:45:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so5457403pfg.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 15:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2e/BKakkztsacyE7KxQ2hK9BiY92qJSpHRggObm9auk=;
        b=OL34RnmUgZYPoY29dJN7yZgJSkEArXSCb+vDLyAbrd46qHvaJAS5uV/Lj8RL9m8rNX
         50/HhX4pj9DGeihDWYAd/9zsfHojKg6CW0HpBgaML0YS1W8HZeLIxJE68kMHLQsFBkAU
         qY8oVrew9rIPAzlxyI7TdM3lcVjIje+PPdhg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2e/BKakkztsacyE7KxQ2hK9BiY92qJSpHRggObm9auk=;
        b=T7nU+Ks5ZWbHNs4j6WCoA535+tMmDv1Cej2XIHpy2K8mdaP6D+fqCKak5sxCgRmRaL
         lab7GXQH9A+p1DRwTUpAnizxsnMAl/AL4GmJ89qU6Efbdce/u3migAnCJKJLvu/W02Rn
         R5PLJUtZB8tf1nPlCn7hiR0tN7UMqrqNogeo/RHErr5dM36dyaL5zSko44iZJ/+uC3Bn
         71xJZE2yplsYHxTySzmk+9HlYrRjWtC/o89hQNlkvU9YObp2ko3D4lBUWhztdzm4XEmE
         j2BUXom5UvHx0497fna0XDUOniJc+W89X/us8cNW0KN11hCrBvVRTvvda1d8xx268kAP
         KjVA==
X-Gm-Message-State: AJcUukdpY/GUkuj+kvkD15BQV2UX8sgaUxOyy9IaXWlTRlBo+Qw95D6W
        AI+cLt84y5wauNrAzBh0goh4FA==
X-Google-Smtp-Source: ALg8bN5ARKvgsDe4qBqaV0PnGmINcuNTVzkJZgkV9AmjQ+rDDERlLjXtNwVacKU8DTkZcJSKoJtUfg==
X-Received: by 2002:a65:4646:: with SMTP id k6mr11512152pgr.153.1548459937042;
        Fri, 25 Jan 2019 15:45:37 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm32950302pfi.74.2019.01.25.15.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:45:36 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/7] clk: gcc-qcs404: Add PCIe resets
Date:   Fri, 25 Jan 2019 15:45:03 -0800
Message-Id: <20190125234509.26419-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125234509.26419-1-bjorn.andersson@linaro.org>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enabling PCIe requires several of the PCIe related resets from GCC, so
add them all.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Stephen, I suggest that we merge this patch through Andy's devicetree branch,
together with the DT patch in the end of this series.

 drivers/clk/qcom/gcc-qcs404.c               | 7 +++++++
 include/dt-bindings/clock/qcom,gcc-qcs404.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 64da032bb9ed..cfb8789ff706 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2675,6 +2675,13 @@ static const struct qcom_reset_map gcc_qcs404_resets[] = {
 	[GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
 	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
 	[GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
+	[GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = {0x3e040, 6},
+	[GCC_PCIE_0_AHB_ARES] = {0x3e040, 5},
+	[GCC_PCIE_0_AXI_SLAVE_ARES] = {0x3e040, 4},
+	[GCC_PCIE_0_AXI_MASTER_ARES] = {0x3e040, 3},
+	[GCC_PCIE_0_CORE_STICKY_ARES] = {0x3e040, 2},
+	[GCC_PCIE_0_SLEEP_ARES] = {0x3e040, 1},
+	[GCC_PCIE_0_PIPE_ARES] = {0x3e040, 0},
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

