Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DD8C282C2
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8BC218CD
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpbQIBf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfAYXpq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:45:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39303 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbfAYXpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 18:45:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so5442918pfc.6
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 15:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MjqQ5MrTPtrU3W9FXHLXJjcm6p+zqVXIeiNOEeU3DKk=;
        b=OpbQIBf+sKp2Yl9qz6fBsNPEkwei3rSJyrfuD4iv0/6FiwumRzlvQhq6atULgyCjiS
         lGc5MifQbFQq86Kj8F2fBvrvmhnf3W0aM5NX8CChI8RxMT9nquuyOl3Mdj45ll7CfYAJ
         mz1yQMlVjXiDQYeTP2nB8T4sE5JFNZDUejYKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MjqQ5MrTPtrU3W9FXHLXJjcm6p+zqVXIeiNOEeU3DKk=;
        b=AYFe3LWGN/1Fq+ZWxu8L2a5MqoHN+0k+DMv17Qp+1T29xoELK+cMLGebz6R+IiUF4I
         NCD6l41NOGl5ELUAoGTEL44pHP5dgYFGu0O+Kt8InuWyuRM4HnuKqVFUsh/UUNsBausE
         IYOpqNntI9WvzC3ppKkqYZ/MEx2nItSF4GqcoBizkgM6F1spMIQL2WkCyf79/vWSFIhG
         C+D7J+QjWt2c4NDZ/m7peZMed1gxf5VA3zLxnwRmN//C08P0UjAk2fLjUXKMlHFC9/I8
         CbgPV2Oj/wo8hLAumueppNBEB5+yFe9ZomH2X3EjeY/ITiKX/hlk5JYdNwkZ6+qQNyRO
         WVHg==
X-Gm-Message-State: AJcUukcYEyRZ3emzcT6orw96Xfe2cjvbAOLlLFuD1egG1ixIi5Gv+iVM
        4TOAzqXsOkJyWFokyPjChf7NOQ==
X-Google-Smtp-Source: ALg8bN7JRQY7jH9tnzfZIU9dcCQL19eJAUl0gLoulQyzdUiM2E+49u5YFdIgDcM6oJxfzqjNO3q25g==
X-Received: by 2002:a62:76cc:: with SMTP id r195mr12889733pfc.38.1548459943719;
        Fri, 25 Jan 2019 15:45:43 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm32950302pfi.74.2019.01.25.15.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:45:42 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 5/7] dt-bindings: PCI: qcom: Add QCS404 to the binding
Date:   Fri, 25 Jan 2019 15:45:07 -0800
Message-Id: <20190125234509.26419-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190125234509.26419-1-bjorn.andersson@linaro.org>
References: <20190125234509.26419-1-bjorn.andersson@linaro.org>
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

