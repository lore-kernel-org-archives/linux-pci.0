Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B14362149
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567453; cv=none; b=ST7lvSjyB4bRqx+Y/3l9QrkPMV7EKp7U6dkF5uER9aF0KGVDBIf97Kp5IY9dzmv4Z3wq7jWAGJn5bkLUo5+lPT1PyEtnTjWScUMLS4inlYenfYlIo/BISumtW5ey2r/oREWIZubbGUpipeEGcMK/UkcA9wdQ5J3Qh6v1uctreEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567453; c=relaxed/simple;
	bh=uVBZNtimwbIIguHcLkZBeq/x7MZXc57E82UKcm28GYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uXXaK0tU1Y0tyL5kp72Xyrcj5dE7U4is+BQFvTHA9HK7b+zSjuXvPCObSzsE1TpT3ilA0Unx3MUyfdSI7dBAw7VBBmVCU1E3w5pU2PmNGEk4nbOP1gHTL/8SsmWf9CFCkDykie4sIL4PMHUBA6g6HAOhnTEjJLEtkpZ7AL1LL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gJ64sjJi; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJ64sjJi"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2f19558so2054214a12.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567450; x=1782172250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbp1vR0f2bRMycBRqikb36Jvottf1nd9z8DiwoyXr0k=;
        b=gJ64sjJilup7+bt+i/MbmqXjFSDGzt+UxXQFf/d4fPFcWBd+236l6CM1VqXEgngIYI
         9YE9w+bfx/1jSqPXn1NpyL0YMfHq4Srj1CnsNhC548P/vXoJC7UGcvU9Ssv9Num8QZRx
         agvibevBTsepWvUon87N5zySXW6wFkaSL1VPVZjl7fO5W9ulgMNx600KhPSp21un8Rr6
         6bGKXMgBmmfTSstv5+T2DS500s+7+N+X7Z0x2jvPsh3Mj4kKKzd58hi+2PXHma6wqfzm
         C2kbo086oKJtCrNpANJy6fn7GE3CZZkiHE13XawncO9p/z7TS34tyCTH8zso9RCi90KN
         TedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567450; x=1782172250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbp1vR0f2bRMycBRqikb36Jvottf1nd9z8DiwoyXr0k=;
        b=ic50a001v4RfAc/yJA9NX1MjQlnboLTfYajDJoC3dVRQkBhOfyYi1qgsY/i6hs3apx
         5sujab28EH8YPNXO+kvnf3BbV5buKvljNWYKhSk7TkHzBdnLXzp8pHTLFvg/9IS7z+qq
         yC9dlIG8v+wnPQLskSQ8OL1oQT1zbWfPVXTbPksJ9Eh9mQXI981ttZxxskqWg/HJhUci
         0dpyaqU4IaP5NB/EtGyI91ZQmcDAcGeL54q/QwM2Xws7gqnujaJgVaFhQgF63nD5xjm+
         9VsLHqic6cLya10732ZhYcXSVSIL3WDfmZcT+/ruZ+jX9ZO+VCudg1ZKccjCim4tGu9b
         XwuA==
X-Forwarded-Encrypted: i=1; AFNElJ9uNlWHc94TJjt6Z7FRqg2p7wCg3atO9MgRZg+2mjYI/olXF2PYcYwocRGuZvpX+08ip/tfYIezBoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyytSyUiPPbhAESWBCQQoakUHDcyClwRRmKJIs8ZIG8vyPC6/y
	onKJroDYwZJzCdrywY1CDqV6Y8fzCUvYkf+h4yxdRnFiZoM0AqAkegQ9eANv9ZnF0MO0SV9D2kr
	LhQ==
X-Received: from pgac17.prod.google.com ([2002:a05:6a02:2951:b0:c85:7ee2:5d43])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:408a:b0:3b4:7163:a7ed
 with SMTP id adf61e73a8af0-3b7e4d5cd24mr1255984637.30.1781567450060; Mon, 15
 Jun 2026 16:50:50 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:50:37 +0000
In-Reply-To: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615235037.259909-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615235037.259909-5-praan@google.com>
Subject: [PATCH v9 4/4] iommu/vt-d: Fail probe on ATS configuration failure
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
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
2.54.0.1136.gdb2ca164c4-goog

