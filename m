Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3D3BD22E
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597292; cv=none; b=sTr7D1kko6OqgDkN1RwrTUwNpHko9j0t4ly7a6bUG1YcoBc1iZsFKBT/HevfaOgaI6f+nuARXUlVFZWXLGyYDRUn6VlL+GVBt/kWwP9PztJZSSWIUGJofR+tApBv2SaYzwjwljLEKjP5dIJRqGf5AVAed4yVIN5P4H8SblDE5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597292; c=relaxed/simple;
	bh=w57WWqbuVg1C46CefALqiJ2Pvgfc2qJJo+gvJ+wT4u0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g76v3QZyA7qnD4fLQAWV5yoUAL2rj+xol6nLa/FTMUsE6gsKCkVf5bxsnmONeqe5Y//MQQGUfYj6HNOQEagQcI88jPvyapVVE19h7gYwB70I6a1NJSYWzkeINKA65esR3jTQd21SkkOr6gvdYhm/XA/P3vasyKx8BvmGEWn+txQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STL+5Ytu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STL+5Ytu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bc5e97950so1184292a91.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597289; x=1781202089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIiNR1cRpyTRt2RrDtP+DBDRqvojsy7fBnMse0sQxKI=;
        b=STL+5YtuXwXutOWeM/3D9ikrRMie68CjVids4tmFX8vCdCUhydgXDFfp/Wr7JwWAp6
         4czuikXCU8UPW/t9lK/XLQ4pTWmB2PpD3kWISo7bisqM1Nr2RUpXtXIcPdC6lnlIq6oa
         8z7bYQvuzC+fwQ/E6o3LP0XZDVTzpDRO4ZJYi5U5YgvyUOknORHnh8D8iPlNs5f7AL+W
         AV+hJ+hkeZlesmltjyDFq8JBJe/XHNF8Y7nHDy8tMs/OQXZSi8Yd/o9i2fakktv29Oo5
         Rgc2FSxRoBpb+3f8q0Jb+MtOU+37IEH194sW4hGFvdU0G/Bw2F/ov/5w0CZFifR+7ATE
         Y9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597289; x=1781202089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIiNR1cRpyTRt2RrDtP+DBDRqvojsy7fBnMse0sQxKI=;
        b=HvMHGFassvQVPO7r597p7NvTaRhKv3wKClNbMGxV7q+im3RTrjb5CphKAWY+ygFp3j
         kGZQz/6c9BzES22llHIjqrmVO2Fxh8tB8JZEiWEj9wP/rwvwUXXPnO3VEE3A43tYLJFd
         m0cOBPsEB2G1YrBMRFSCdXLHfvi2lyLwmqjkYwcdX3om5WgHh/yHOt96goW8r0aA+2cI
         8IeG+wydgcAfJlqaCvBb1wHq2Z7y7Jni7d6HGMBU3bIxZ8DyzATuP0oOAzmBPIHNnFl6
         e7iWX4hFZl5bnoc1vLFFp/hONexn+Ln5yUvnX3Y/42v/fEMJbr7ve6WsacXmxQtzeHAJ
         3kXg==
X-Forwarded-Encrypted: i=1; AFNElJ960NzGRpm5TeKpndOE5zFP2pvT5lE4YQcBzTPes7whSnI+yI7YfRN444VFIhSqJ1N6xo0pRTt/wF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQYb3M6Pj6K7p1x1mD+209lavtMtnchEyVjmvDA2uLIdHsTv4
	L/9e0V2i2TenzCU9dfkUirg1W/zBQxBtgoVgU614HRD2D1qpRbeVNU3AcOCHKNCELmM4Kagafdg
	aEg==
X-Received: from pjez16.prod.google.com ([2002:a17:90a:150:b0:36b:be09:e0f7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1ccd:b0:368:a297:bd38
 with SMTP id 98e67ed59e1d1-370eedfff8dmr139009a91.7.1780597289305; Thu, 04
 Jun 2026 11:21:29 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:16 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-5-praan@google.com>
Subject: [PATCH v8 4/4] iommu/vt-d: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the Intel VT-d driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..f39451323553 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
 	if (!pci_ats_page_aligned(pdev))
 		return;
 
-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
+	/*
+	 * pci_enable_ats() should not fail here because earlier checks
+	 * have already verified support and configuration.
+	 */
+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
+		return;
+
+	info->ats_enabled = 1;
 }
 
 static void iommu_disable_pci_ats(struct device_domain_info *info)
@@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 	if (pdev && pci_ats_supported(pdev)) {
-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret)
+			goto free;
+
 		ret = device_rbtree_insert(iommu, info);
 		if (ret)
 			goto free;
-- 
2.54.0.1032.g2f8565e1d1-goog

