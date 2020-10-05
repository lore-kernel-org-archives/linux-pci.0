Return-Path: <SRS0=jvhy=DM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCC0C4727D
	for <linux-pci@archiver.kernel.org>; Mon,  5 Oct 2020 09:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5E0206C3
	for <linux-pci@archiver.kernel.org>; Mon,  5 Oct 2020 09:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNvnqEPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgJEJNV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Oct 2020 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJEJNQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 05:13:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBB8C0613CE
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 02:13:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so6430155pfn.9
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 02:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ChHcHi6Ji1r+llty/7EuPk/EuojfII4VV6B3JIzI5g=;
        b=CNvnqEPPMbtVaXYCvQQhaTeMVv3JRNtbdIgi/4MgXbatDyRw2ZDvPLr29DFnsvB3hm
         IXhssH88sEFQpVJx48zvLesMpITHcKvia77DR4uLsVIsNyX66J1xUBxgbzXI3toqbZXY
         fNbNHkRywT32wKgXC42BlqdndUYRxiCfdpRBQPd6f4687L5xJhKmYuepUdZC8zGB4Q55
         dvPTvleUzvQYkX+YayzPMp9SAMz9cVtuQ0eoN95D2EYYAVwGzBodrpPZVwGpaEDBrfcR
         AX6acRZ52lnM7n4vydzcW9r6t7ioClv1ejrZtMgkHX+vDPHI2LX9ZVxwVfjyLyLw/kGa
         ZUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ChHcHi6Ji1r+llty/7EuPk/EuojfII4VV6B3JIzI5g=;
        b=fRncWMhmkYU0Xbhvfo1Jo/lhwLq0l6NVZq2K+dnRT3+nsCUiRItWtcZwCwu64S3TCq
         sJ8ZpcMYRog93edxwM0QGOlkma8pet6PQmBh5PXEuv0WWuPWpeoeBoueE6VJt7EjNUSE
         O/mwmqJTDL8+N1QOhvmFMSt4eSHdhyeQ2YlatFFGlkRuFk+KD1xFxlGrGxSiJ1ZVIt9s
         ZR5TbUS7ATB3fQzxl+ljBKFV2MDEBxwfKHgYsL6+fh4cO4wG4IdMcmodtf13r7jRYxvk
         LgKONBzhgSPS3ZoaGJFHQiSN0fWpXdkKAHR0HSiiWRkcYQUB9uJblMzV8dHD5WvqS4IL
         noaw==
X-Gm-Message-State: AOAM531/pf2nuqFAwgJa+7LJHFSPwnfcFUeqWwXhnIJzGb30yrjm4M49
        sgTpfqcrZqQTJ6FFLwOEBdRp
X-Google-Smtp-Source: ABdhPJz8eIYQ+efj+IwRpOBdP7HXfrTImiJKwXz8SBsYemn89gybHBlcYGiItIB8qjR3PliVId0hyQ==
X-Received: by 2002:aa7:9afc:0:b029:152:9d45:6723 with SMTP id y28-20020aa79afc0000b02901529d456723mr950729pfp.35.1601889195746;
        Mon, 05 Oct 2020 02:13:15 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id c7sm11255028pfj.84.2020.10.05.02.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:13:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/5] dt-bindings: pci: qcom: Document PCIe bindings for SM8250 SoC
Date:   Mon,  5 Oct 2020 14:42:34 +0530
Message-Id: <20201005091236.31770-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005091236.31770-1-manivannan.sadhasivam@linaro.org>
References: <20201005091236.31770-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the PCIe DT bindings for SM8250 SoC. The PCIe IP is similar to
the one used on SDM845, hence just add the compatible along with the
optional "atu" register region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 02bc81bb8b2d..3b55310390a0 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -13,6 +13,7 @@
 			- "qcom,pcie-ipq8074" for ipq8074
 			- "qcom,pcie-qcs404" for qcs404
 			- "qcom,pcie-sdm845" for sdm845
+			- "qcom,pcie-sm8250" for sm8250
 
 - reg:
 	Usage: required
@@ -27,6 +28,7 @@
 			- "dbi"	   DesignWare PCIe registers
 			- "elbi"   External local bus interface registers
 			- "config" PCIe configuration space
+			- "atu"    ATU address space (optional)
 
 - device_type:
 	Usage: required
@@ -131,7 +133,7 @@
 			- "slave_bus"	AXI Slave clock
 
 -clock-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "aux"		Auxiliary clock
@@ -206,7 +208,7 @@
 			- "ahb"			AHB reset
 
 - reset-names:
-	Usage: required for sdm845
+	Usage: required for sdm845 and sm8250
 	Value type: <stringlist>
 	Definition: Should contain the following entries
 			- "pci"			PCIe core reset
-- 
2.17.1

