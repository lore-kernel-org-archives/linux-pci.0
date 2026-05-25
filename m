Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2937B02A
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734642; cv=none; b=Y4tW3gKLnZIIPQOD7KYhQupQ+jWNEurD8RRc7gZpXQfiUPJ70krwcSr/iE7auDHeqKICuPSBmH1ZwWnq+jULrZtnDwh4KaRVNImFMr0wraopDeKdiK9bq6MnxtzvpGYZqsfcJEISLU5iNyDxmK9e8Rl1W9zc8I+BcxH6LI+UBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734642; c=relaxed/simple;
	bh=TRq4A6KO1VvQ7IbUE+TwHmgzXSdtsRpTby/bdfBdlU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yfkf11TXdCk8j4s3HzpmFreW6EIFVo5jHh/VPHzfBqAvPWumFuUOYbgn8PokPpKBVhHT5Tr89vI6FZPwfswDUuMmYr5Nl6OlOJBbR3So8JgCtuu/xjqvSyNC96ve1+hU+ewcp9f3ZO6iTLXbx9Vy/nnTVwOdp/l0+arLja/juqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jsaprtku; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jsaprtku"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso5659327b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734640; x=1780339440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrjCHBiuBsjUFngiV4EYGqc8MUFFnHs0ozhKw+gXIDU=;
        b=JsaprtkugXxfgVQskp0i/hKRR0V9U/CvndKCTg6Mau/zx9ro731wLA1MHu8QPPjjBR
         U18ieYDLYLoKoXw0BOAWbGGu4Q8YqIYvDU4D0/HLYFq0oOUHarGd9jEjKIgzdh1dIyXv
         UrP5iY9vB9z9SMmGTeLP3DdbLKGXhEXlBdWMHREPoLch0+a/QW5UWoHWSLbDBaWzbj42
         5OyQDeUDUN4EOr3UxE0BHCNLktpykqAEgmetdLHxfo06xsLz0XVRG4ym3HozPQWduUyH
         msu6ts/pA/WM34kihVNsSG0BTvqKbsIWorWQW3P7J2jEbQ+qKag4VcDqU/7PSLM6i0g6
         xRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734640; x=1780339440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrjCHBiuBsjUFngiV4EYGqc8MUFFnHs0ozhKw+gXIDU=;
        b=RYxWd0bX3pe6raCvY3oTJPX8WL4nD/zco3XD8tFU/adv6yHx5ckCqxngg4nlrMFG8s
         Fxr6ZJw3JRGZHzBucIEcDNyxojPhS16hkE6pYh1my0KE2n73dX1UVTUH8HbFcoNZSVUz
         SWn6AQjdtW+Nh/aqp8uWe/rVqZaZjsAyd+bngPD8EvFW+hRykp15/nUn6/NnRNEBHlnh
         YiLTbn8vu9L6A02eEz49uZElnMlbihxYMpCrhop6sUy2eQx/KCWH1+d9u60GyjwIH7YB
         8HG2zM0oMi4iQpSh+KmrtmT/iZK5TDO/ucYVhOA+MizZDunpeZx/Tx042iMGdsF33Oke
         WQRg==
X-Forwarded-Encrypted: i=1; AFNElJ/FFzwHX/B194OPGnza5BFf1eUIDjOCeEMcC2HlwNyaFQdHxvEAFey3V9g1kToBPtzTtFI1FChFwA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoZ8haXHqRXbK2vPk50ec8cWEkVo4NWX1ksFORyJoSfVrCnGj
	VCNuQ+ytA4cEJhyep06K1dPgS8mwuH0jqPNJJpxZko6DrWA6NZhT6G7CP2+VzH9uj1viF4vs7dl
	35A==
X-Received: from pfbb5.prod.google.com ([2002:a05:6a00:ac85:b0:835:3df8:d72])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:421a:b0:838:af72:fb44
 with SMTP id d2e1a72fcca58-8415f0f16ddmr15589020b3a.2.1779734640045; Mon, 25
 May 2026 11:44:00 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:46 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-5-praan@google.com>
Subject: [PATCH v4 4/5] iommu/vt-d: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
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

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..22308e4911e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -873,8 +873,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
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
@@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
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
2.54.0.746.g67dd491aae-goog

