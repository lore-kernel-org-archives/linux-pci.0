Return-Path: <SRS0=2i2g=4M=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC422C38BF2
	for <linux-pci@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B67120880
	for <linux-pci@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxiRGOVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBXSYt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:24:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38462 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgBXSYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so345368wmj.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/v4/yX+Rb+z7FmgKRxusFg6LNtZiO3DMXvnBgeOuHA=;
        b=zxiRGOVQbUYycQsFrjTLJX2IpngMLUiFnM9zOzjXR47e2SetqBWdJnpHlovEcuPFBv
         FexG3YDDT1ALrD/D+FKHkP2MIXaGBqx7A0sQaHVDRDNDQVr6jS2GdDb8Dv4EB4Ft15Rc
         X+Oex0fYMVCjcbrMtfUHVdIYJ1+hcTCMOOiPeqQ4R0z6xH0F4B7muTW0XjymSxneLuIP
         UjsAEBRJN0lKsKcUb0AF5d72SsOmuIZT45CPqq1FHWour+tr4KPFS8ATERhupHhS/6vO
         NnLNTmMYIpRJABwOkWxXIjD1Zqj0p9uyUCjjFEDFuUat5g+KAY0cf2+EDDRSjS2adgZy
         cP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/v4/yX+Rb+z7FmgKRxusFg6LNtZiO3DMXvnBgeOuHA=;
        b=kRROZ9anq25cGLdU405zJB/jT1JIXQZ0/vRBlXqwNdUxlgsbQBmFIasulDyEDM1ggM
         AQdGlJ8/+4FCaH85+/NL3n8r/ndzgRpPrhIEVSXj5HGA4JL9mYVPb0WNbarf4XInxKM5
         aTklqALk5hRNWM7P6jOgNjn9vEm393DHV9QsUrtYoDST/KSUCVe2T56xZxc61aQhDTcR
         H+QQ2WIbQ0+9WxktgDQoGvnJfFpK1qdpZcmjGXVo517c731wLCczO9duxslrMsFMDpUM
         uwwDb+OUklVkMlGSsT6wBAGXhRifPa9utnj7c9aWW5ZhmCKpJfECu6aPiFyFvKu5gpTt
         WZMQ==
X-Gm-Message-State: APjAAAXjvZuWWh3o2gUO4psHSeMtzXqCasGIjoNIpq8NcmuxvHdQJR6U
        2NX5HqVZAfjjRQtg2YPK9V2QQA==
X-Google-Smtp-Source: APXvYqxqoFKehhPoecAVUtglmpmoNhk6pIi6LUZIxLg0IgobfRPy8bO8YntSNF9Wq6iiPuinGYBuMA==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr309717wmm.79.1582568687070;
        Mon, 24 Feb 2020 10:24:47 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:46 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org
Subject: [PATCH v4 16/26] iommu/arm-smmu-v3: Add dev_to_master() helper
Date:   Mon, 24 Feb 2020 19:23:51 +0100
Message-Id: <20200224182401.353359-17-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We'll need to frequently find the SMMU master associated to a device
when implementing SVA. Move it to a separate function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 77a846440ba6..54bd6913d648 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -747,6 +747,15 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct arm_smmu_master *dev_to_master(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return NULL;
+	return fwspec->iommu_priv;
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -2940,15 +2949,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	unsigned long flags;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
+	struct arm_smmu_master *master = dev_to_master(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_master *master;
 
-	if (!fwspec)
+	if (!master)
 		return -ENOENT;
 
-	master = fwspec->iommu_priv;
 	smmu = master->smmu;
 
 	arm_smmu_detach_dev(master);
-- 
2.25.0

