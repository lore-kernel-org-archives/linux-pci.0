Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B6BC43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD3B2173C
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m30cXDa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBSGEi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:04:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34308 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBSGDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 01:03:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so2434949pfn.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Feb 2019 22:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uK46UagMeCc0KFc0YPlTS4qrXQgdBZIe1DAGlyy2xmU=;
        b=m30cXDa7WLxP0HBpbmPJa+4LGEM7xP3MD8yY6K+aPEv/VAt/jySL8yXw1cVES4AL9n
         1Qtp7Mv+N8fncT4HpeVzBltrRpMgmQDZJNAUZ87NqhI9DyhwZeGcqFvJ4OiM1BGayqij
         31Q9lNUu7O8wuJjL8Va0rEtTmI3tDkYaocM0x6iLW0wMXRDcPnTWYDfOMDvBW+9fsJ/2
         mPZKhsRO5LbVq+jCfqDBvH9jtPYbj+M+lxTMo7Vzet/aqbPQtwPf7uH7RICAtBJlpYxr
         mEeiS8BhubnWMTE2FRA5c72ZFFIifSZ3d1BnvGlQxVQDVhykCNNb7Y/NTne1BpHl/6IP
         uajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uK46UagMeCc0KFc0YPlTS4qrXQgdBZIe1DAGlyy2xmU=;
        b=asVbrYkRl5hKRUY7jOJm0DI5dec/pYKdvIfv5/6fJGjCxRDG/Ff3M2dlYY7dy08yqT
         lClX6uTh5UovVu58Fn4gHt5SUMjFx0mURD5vIfcrSnnk62E5vL+c4MsyqTEc8+qWAuZC
         dl/uGm98WGN+PP20T1G+uSXyP716tCasZm99w/LvjazGt3WnnD4gwQy34r+A/9i3UQiG
         eeckHks7WsyaRz39jPeYrYe9CUbai9W0EtsbMrz382Y1l7GWpp9ouPhbhI4NNTW4Wqu+
         nX5qVEhxJqm2WzeYxPc3rDUz9LLl/aFoId/x3xOqTJ5GA4KDzFUo+5R+0mVJMdczgnPp
         tkPQ==
X-Gm-Message-State: AHQUAuZZ7YRBYrenBeuWqSYnmTrSP8quPJjWhWTlmRwgsB/2YWZ6Zvv5
        ton2T3fuWUmP2yBAE7SYR0pDmg==
X-Google-Smtp-Source: AHgI3Iayi3BjIl/C1hHkZeYEyfWTyhL+ar64aoujl3SBCnXsLg99fFeFwPxYwRnijb9UKj9E01C9+w==
X-Received: by 2002:a65:620a:: with SMTP id d10mr21793859pgv.75.1550556233009;
        Mon, 18 Feb 2019 22:03:53 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 86sm31914838pfk.157.2019.02.18.22.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:03:52 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
Date:   Mon, 18 Feb 2019 22:04:02 -0800
Message-Id: <20190219060407.15263-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190219060407.15263-1-bjorn.andersson@linaro.org>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Qualcomm PCIe2 PHY is a Synopsys based PCIe PHY found in a number of
Qualcomm platforms, add a binding to describe this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/phy/qcom-pcie2-phy.txt           | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
new file mode 100644
index 000000000000..7da02f9d78c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
@@ -0,0 +1,40 @@
+Qualcomm PCIe2 PHY controller
+=============================
+
+The Qualcomm PCIe2 PHY is a Synopsys based phy found in a number of Qualcomm
+platforms.
+
+Required properties:
+ - compatible: compatible list, should be:
+	       "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy"
+
+ - reg: offset and length of the PHY register set.
+ - #phy-cells: must be 0.
+
+ - clocks: a clock-specifier pair for the "pipe" clock
+
+ - vdda-vp-supply: phandle to low voltage regulator
+ - vdda-vph-supply: phandle to high voltage regulator
+
+ - resets: reset-specifier pairs for the "phy" and "pipe" resets
+ - reset-names: list of resets, should contain:
+		"phy" and "pipe"
+
+ - clock-output-names: name of the outgoing clock signal from the PHY PLL
+
+Example:
+ phy@7786000 {
+	compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
+	reg = <0x07786000 0xb8>;
+
+	clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+	resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
+	         <&gcc GCC_PCIE_0_PIPE_ARES>;
+	reset-names = "phy", "pipe";
+
+	vdda-vp-supply = <&vreg_l3_1p05>;
+	vdda-vph-supply = <&vreg_l5_1p8>;
+
+	clock-output-names = "pcie_0_pipe_clk";
+	#phy-cells = <0>;
+ };
-- 
2.18.0

