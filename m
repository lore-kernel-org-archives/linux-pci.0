Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F9FC10F00
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDFC2173C
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0X699T4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfBSGD7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:03:59 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34320 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfBSGD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 01:03:58 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so2435066pfn.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Feb 2019 22:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MjqQ5MrTPtrU3W9FXHLXJjcm6p+zqVXIeiNOEeU3DKk=;
        b=X0X699T4gNEhNz3HKmJRhtW6+rU1mseGBxQL03WubcdtE02y8HpEcXTP4yHdbQMZMN
         6xIAwYwibZjjpUC3LJnBPZHZhnjJt5EyWLWuJLExVs4OzAOOiO6gGY24yAwV1L/nNMf7
         gS2Oqe5G23351mGjA/tUuFNnxntVVXSFZCYtXoHJzq8X/JkXrzThflMkNxz0FS5L5Jwd
         KVtiDH7w0fay0d0i1Pf1ATfAkLREFmELGUbmNnBf9FubBmXY2y9oXUGkIIxW2IgUC/3L
         Q6AqJeY6FSKW7gw+8RLR5Hxj+bzRsSkuKERGW80vlZZ1AoPVbuhO6Ydls6hvUcQbHbZW
         j8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MjqQ5MrTPtrU3W9FXHLXJjcm6p+zqVXIeiNOEeU3DKk=;
        b=DfMdILSSg7cylimH3hpxuWScJnnpjlShWj+98jE8Tn0qY8ySWUHnN3X/5L0MvnPLLh
         lTHyCzGJz3gsps5XqJ0AkFlkXG9ZOOHElt2mTkdgBbVdvH3gOkeFecCqviUapFHhmbgo
         vmn9Q2R/+IX0cgSsfKkdvvUmEOBBs1zkz5osJAczybK0Z9cfftEJ+va9CnkulWsi8SS/
         Yje9X8PqrKSecukVm2/N//4zY41jDNPhXhVK2h0XakX/rHOeNrNWVG8cTFcZ0vb9H+lb
         kDuMCQI3ij9kMVPSjDs4B4veU5XynUdkbG0Kj6qxTr4gHMof9XCE1C9WAuRp4fPfl9Cn
         gEfQ==
X-Gm-Message-State: AHQUAuZfXK85DtWVoZlEhO2g6HL3/73zv93gbDr+FWXhtRNay7PmiP6Y
        gjKm6DOD5fSyRKGaO6h8aKf71g==
X-Google-Smtp-Source: AHgI3Ia3oqcVHx0V2r5skicVPy5wv1cfeHDHW5oevwtVZwQoxxip9bpxyWuCFcZjd7Mmw2wbhBHt3A==
X-Received: by 2002:a63:d709:: with SMTP id d9mr22034705pgg.157.1550556237979;
        Mon, 18 Feb 2019 22:03:57 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 86sm31914838pfk.157.2019.02.18.22.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:03:57 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 5/7] dt-bindings: PCI: qcom: Add QCS404 to the binding
Date:   Mon, 18 Feb 2019 22:04:05 -0800
Message-Id: <20190219060407.15263-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190219060407.15263-1-bjorn.andersson@linaro.org>
References: <20190219060407.15263-1-bjorn.andersson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Qualcomm QCS404 platform contains a PCIe controller, add this to the
Qualcomm PCI binding document. The controller is the same version as the
one used in IPQ4019, but the PHY part is described separately, hence the
difference in clocks and resets.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.txt     | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 1fd703bd73e0..ada80b01bf0c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -10,6 +10,7 @@
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
 			- "qcom,pcie-ipq4019" for ipq4019
 			- "qcom,pcie-ipq8074" for ipq8074
+			- "qcom,pcie-qcs404" for qcs404
 
 - reg:
 	Usage: required
@@ -116,6 +117,15 @@
 			- "ahb"		AHB clock
 			- "aux"		Auxiliary clock
 
+- clock-names:
+	Usage: required for qcs404
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "iface"	AHB clock
+			- "aux"		Auxiliary clock
+			- "master_bus"	AXI Master clock
+			- "slave_bus"	AXI Slave clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -167,6 +177,17 @@
 			- "ahb"			AHB Reset
 			- "axi_m_sticky"	AXI Master Sticky reset
 
+- reset-names:
+	Usage: required for qcs404
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "axi_m"		AXI Master reset
+			- "axi_s"		AXI Slave reset
+			- "axi_m_sticky"	AXI Master Sticky reset
+			- "pipe_sticky"		PIPE sticky reset
+			- "pwr"			PWR reset
+			- "ahb"			AHB reset
+
 - power-domains:
 	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
@@ -195,12 +216,12 @@
 	Definition: A phandle to the PCIe endpoint power supply
 
 - phys:
-	Usage: required for apq8084
+	Usage: required for apq8084 and qcs404
 	Value type: <phandle>
 	Definition: List of phandle(s) as listed in phy-names property
 
 - phy-names:
-	Usage: required for apq8084
+	Usage: required for apq8084 and qcs404
 	Value type: <stringlist>
 	Definition: Should contain "pciephy"
 
-- 
2.18.0

