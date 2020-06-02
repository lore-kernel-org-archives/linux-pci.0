Return-Path: <SRS0=KYvh=7P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7BAC433DF
	for <linux-pci@archiver.kernel.org>; Tue,  2 Jun 2020 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C024120835
	for <linux-pci@archiver.kernel.org>; Tue,  2 Jun 2020 11:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrhDAFlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgFBLyx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBLyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 07:54:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85AC061A0E;
        Tue,  2 Jun 2020 04:54:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so2634367wmh.2;
        Tue, 02 Jun 2020 04:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIcmPOVlQLoKdIP9dCKqwaemztdzBXHNcMiHg1REgA4=;
        b=rrhDAFlwRPU2Hsv2t+7LvyG/zgJmK6lK9gOB+dHLw5rq9qVS466XSatL6Tb9i9EZTo
         wHLRmXaQgsGrwlPf8/6CDpUHFKjnYdGzMmvdQGuMaMqHXOTVY7iMFsaXOPmyCk93JPTB
         j5FcNqKUVah++Xw3+SmnWjaKl22I30IIUUAcfDWDx3u3qbB5jlFVf+H6TJAzftFFN0LE
         ru4fNnw5GNbXEofHf3pOKAT/u+9vnCMlml6NhuhEU5IYhU4JLhUIelfnHjQQWNp5yvAC
         u7S1t6nhhoILxPa3kCSB5VqEGMzRJ+PHnU4vELxfitvwrPGNu3QU2WDNdSueEiA8IIoJ
         zUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIcmPOVlQLoKdIP9dCKqwaemztdzBXHNcMiHg1REgA4=;
        b=DTFFiNI6+oitusK7dL0KMuhjOWQfHFNuESSGxpdwJAT/BgwzNQFhSPr/m7+TVwhKmD
         aEHwRfnK6XkJ8ZAf24B2apJ8+J+fdfGkfWCsUXUXbP4YPTFPK6CSHegP6F/xq29Icmoa
         kbbFrVcTbI8nz8jv1kIUzRQw+VXrlHEZEWFxBFtOR78DmUmeudh/6fuI2B34du83OxyG
         ReS4TxbHa8giSJT/BgpvAR0gmN/0Fsqp3OhnXzrx8wOBwhFXZzIUnsdO7jt+AHNu8T+j
         Egr2smgZkVBCngdJ1ceiSXCm8+MOfKB9Zafepm6eLWjpIXrOPAgsvuN0busKySGV0Ide
         zTdQ==
X-Gm-Message-State: AOAM5300Z83UzwwkujHhIxCOEy1QAIEtutnNpVq9DoTQ78ykkH3TXxr0
        XcAt7dyia4FDnL49zEAjcEg=
X-Google-Smtp-Source: ABdhPJzY2wnE8+8cukerL3Mxa1QbxixDeB9Tr3wcjXgPg4xTwNkPmFRgx5XwFjsvWf0VVkNQDjO19w==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr3784197wma.87.1591098890897;
        Tue, 02 Jun 2020 04:54:50 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host9-254-dynamic.3-87-r.retail.telecomitalia.it. [87.3.254.9])
        by smtp.googlemail.com with ESMTPSA id b18sm3273777wrn.88.2020.06.02.04.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 04:54:50 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/11] dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
Date:   Tue,  2 Jun 2020 13:53:51 +0200
Message-Id: <20200602115353.20143-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602115353.20143-1-ansuelsmth@gmail.com>
References: <20200602115353.20143-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document qcom,pcie-ipq8064-v2 needed to use different phy_tx0_term_offset.
In ipq8064 phy_tx0_term_offset is 7. In ipq8064 v2 other SoC it's set to 0
by default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index 6efcef040741..02bc81bb8b2d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -5,6 +5,7 @@
 	Value type: <stringlist>
 	Definition: Value should contain
 			- "qcom,pcie-ipq8064" for ipq8064
+			- "qcom,pcie-ipq8064-v2" for ipq8064 rev 2 or ipq8065
 			- "qcom,pcie-apq8064" for apq8064
 			- "qcom,pcie-apq8084" for apq8084
 			- "qcom,pcie-msm8996" for msm8996 or apq8096
-- 
2.25.1

