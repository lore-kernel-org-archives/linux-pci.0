Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA92C282C6
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1679218CD
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVTbFBab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfAYXpk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:45:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37706 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfAYXpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 18:45:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so5442933pfb.4
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 15:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uK46UagMeCc0KFc0YPlTS4qrXQgdBZIe1DAGlyy2xmU=;
        b=PVTbFBabosZnWR3uWaJ393YNkylOMbSzbfz/s9cUNbQA1Y8ukCW4d2F1gQLE4jcvNv
         2WUAyEHpzndT58Dj0N2VO53+/01NLWUDI5qIv5m6gCgI+j6WlWE34u2MRA2ObmXOSktG
         f/+TNVkiV8tvjD0r1e4q5ytVuwZGL1pPkFrsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uK46UagMeCc0KFc0YPlTS4qrXQgdBZIe1DAGlyy2xmU=;
        b=qgortcKBMBAhr5p03hGutYhTcOg22eUrSaScRxCtemsjr86qxr9rthlNIyDhGeYLKv
         E+J5W2PoRZq17Gq1IhT92CXKFyWsr52Bv1ykoVdvfxl0k4K2EDKAq+l3lqPNUNhBM1O1
         85S91bUaGqv4tp12rqFB4cVFr1WMBt2zGlbS3zWuuJhIQxSh121aikcKhReMrWmGqGdG
         2NGRv24lJIdfpEc7Qqb+vCxP03eQvd7m3EbQDT5nybVGcmjs96RjTb7kkw2Z+iSeZvno
         NViKTqHZZCZs3sg1qj9BeENiTbG6g/oIGpiAft76JUmYQz72HnKIeDzTOXZYqsyO/ngw
         PmRA==
X-Gm-Message-State: AJcUukflk6aBwg5KlSpP0viOYI6AWEn4HprYZFyUT3UYlUjHprm3tm7V
        8Js+kP1ks5DZ9iWJPK37CF/bFg==
X-Google-Smtp-Source: ALg8bN6NLxf/W1PVvaxvb8J7oZIGQDaQ2Ob/5IcVnLbRq2KlDG4Yk/3gnPYhUhN6yljAQZforK97Zw==
X-Received: by 2002:a63:ae01:: with SMTP id q1mr11541487pgf.402.1548459938750;
        Fri, 25 Jan 2019 15:45:38 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm32950302pfi.74.2019.01.25.15.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:45:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
Date:   Fri, 25 Jan 2019 15:45:04 -0800
Message-Id: <20190125234509.26419-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125234509.26419-1-bjorn.andersson@linaro.org>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
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

