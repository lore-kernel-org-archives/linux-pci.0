Return-Path: <SRS0=tMyV=2J=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE51C43603
	for <linux-pci@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03F2467B
	for <linux-pci@archiver.kernel.org>; Thu, 19 Dec 2019 16:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZ1mQvkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLSQbY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:31:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37025 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLSQbY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 11:31:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so6640423wru.4
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2019 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
        b=DZ1mQvkj39du9c3uvhuc1sVcu9Y0A998X/z1CY268T8u5anFgELkbUT49r7j/FRZcz
         +7ksycnZd2+fQJ6zh90kx8v00yqv95+dvo7vFBGyHIpOdKxZ0pBKHP1Ib58Ky7Fth78Z
         VeRsmVP2kmHmNbga3t9PtcFS9+McrPng62snTWftNTaRLMsUnkTCDDJavYidq4WFXSbY
         4AcOnnyLgLkT3p79PmvIDRKzHsoP0jh32/SQlZwafUWUhVdz4WPCLo+VzqantlSmz8QH
         1+1hoBcCfokGxka6d4wDM3UGxmSx/Ms/zaBIQammeFbf2MG87txqfxqlxOs1Ib7Kb6F6
         gRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Rlh4fuYqJBRp2jOU8B0MlV1M4d0Kd3bn04JlNplJUI=;
        b=DIAM/6TfhHfkRKVqRFuG8Mk6femDv0ZCEdLdTp4ZxkQqH6UUoOC1hwcWWwUx55Evfu
         xGrh0LjRHs0LnSNfndLwzxE+N8Q+vi1YiveT8pbVsaVjMLXxiEKBgSue/0xg6ngVc3Ws
         ItdNIerUo2OK4NZ55P0bbugb9cGVsLBh2LDQZdmQs59j5wrri/XG991FO60x0MNLwGio
         8DDBND7/CBtKROq+fo2TFFBiuQkOmw4AFCgHyuf6ACeehpr6MCILvoMMx7rz8IL4xAeI
         9+yK12zAvGGvxuvnevGtJidsk23RaFel/zjZyum6QPHy/X8O+/DxcwRz/fmb2/ZQFosF
         Tk/g==
X-Gm-Message-State: APjAAAVIwlLByw3MAHN/cHyu/5F+CrJLY8wB7sr2SYovtObugKGolHck
        g1SwxcjRz4Rwkptn7P4AkYLE8Nob6BQ=
X-Google-Smtp-Source: APXvYqyam1fWJispp04KzWY3PPXWRuIZpC4LpasQ5BFUWvh/VFFpRwbOR/7kgGSzp2MXQTFfM2Wo2Q==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr9990514wrp.71.1576773081514;
        Thu, 19 Dec 2019 08:31:21 -0800 (PST)
Received: from localhost.localdomain (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
        by smtp.gmail.com with ESMTPSA id u22sm7092068wru.30.2019.12.19.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 08:31:20 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        eric.auger@redhat.com, jonathan.cameron@huawei.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 02/13] dt-bindings: document PASID property for IOMMU masters
Date:   Thu, 19 Dec 2019 17:30:22 +0100
Message-Id: <20191219163033.2608177-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Arm systems, some platform devices behind an SMMU may support the PASID
feature, which offers multiple address space. Let the firmware tell us
when a device supports PASID.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b4624defc..3c36334e4f94 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,12 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- pasid-num-bits: Some masters support multiple address spaces for DMA, by
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
2.24.1

