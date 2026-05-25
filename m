Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF538655A
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734644; cv=none; b=jiXq76dIwOpoRuhvUoWzLjljrHzQbxMDsz5vaOlGyz1kVg0reHYp/70At5uJr07//eEvMc4yVf0cLASWL1c/Sht8bXI4HknKvvWpUHy/q/AlPwcTvj5999WKLwOTHDjTBP9tTMFk6u5p+HYTJDuDgSYJi02VfXaPDg7QU0ETuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734644; c=relaxed/simple;
	bh=cfRHgvxt8vecrezTNhpJ2ROe+FrkIO0BXhKCSXsf5wY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTlWWolQwmaEieTWcbTws8BOQJNrG8PhP2HHh24A0TCLB3LRfLieRuUBOCvefDIaFzW5z+AFt8AV1lXFX0nw85KKZC+ip/uIINgfLsEi/HJm18nl08MTSkgwAreEskyVTZQYzm72FxOUnbQzn/JI7xy+yU+kW1s9GVQ83FbftLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TB9bffAi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TB9bffAi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso31742625ad.3
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734642; x=1780339442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejVfo6aDK2IjkhbswQYdZPzC7RHqvBJONF1IKeVRso4=;
        b=TB9bffAiWuSzavkhDat4YW6i8GnaJJMeHiRa/GpFS5WrAoD4G0ef02Z5Ele5sHUhMA
         tlPYxuZupgk3NdG418OGp3/d2VFfoC/mwiDJRsjiWGp80SVeaDBLwnfyXEksf9TIxicp
         OGfVjX3DtY6lRVhsGhdNQHyIUOJEc11pSsANGZO4vFWLwLSECcOuKliPlQi+kzID0yGM
         a1vLfQP0ZhkZDMuv3DtNkb622sgF9WlwMJ4pzp23ybkhYiG2dBIu3KYSBVWGeMkJfSAX
         efAMmc7Sc0s35fkckJfOwbwrz5DUdafbU9yjFMhrN81AoDvHBHtJNFjYPTpf9G6bVFLW
         UrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734642; x=1780339442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejVfo6aDK2IjkhbswQYdZPzC7RHqvBJONF1IKeVRso4=;
        b=INe+R/psL6/SiPe8BOaZIrNIUkBId6/kDND2zJv54QD+YoA7g97FVSIRHJ2GZVsOvO
         fbGclPF9pft7OhaRq1PPZyAv3D5LtT9sAtslpc9uGBKc2eOAzz+aiqdMUfUGkrCNs7CQ
         XvLV7jcJH+sl+w1kEWZ9UXqv7pOXku7y66w3Q2cEVu86LZZJwiBCJiiaJFDrUvTPXFDX
         2mVUSSrGIX27HZrwGqvp6GLdCvxXRjQrjZYbSaZekqg6fFMqPnLH17GKYdCw/S7seppr
         kz6ryS+MvQ0uQWsAyxDMy/ZkOOTfdPJDmEqm5VppiA1xC1eWZVL34MRQv5sPdSX/nJod
         dqBA==
X-Forwarded-Encrypted: i=1; AFNElJ9zjHOTK4GBsUbCdmYFe/8K9AC2m3X4ppyANgDAWTd+EGsZx6a1Ohio6i4txUrQLoOxa6C2VA4xB2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypjpyg/RyzbrwlGBxo19C/MyZCPfPr/Y+o0JZNEozsPFPYJvQ0
	/jFQRC1S166HqMVAIQX0TaorW/CJNg72PPTBxLKAbi/H6UBBTIiJdBFm96Ba2r/W4hX1vtycwUd
	aQA==
X-Received: from plbke6.prod.google.com ([2002:a17:903:3406:b0:2ba:2935:3b4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78e:b0:2bc:8359:66f
 with SMTP id d9443c01a7336-2beb06db375mr172687615ad.35.1779734642223; Mon, 25
 May 2026 11:44:02 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:47 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-6-praan@google.com>
Subject: [PATCH v4 5/5] iommu/amd: Fail probe on ATS configuration failure
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

Update the AMD IOMMU driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update pdev_enable_cap_ats() to WARN_ON() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 84cad43dc188..1dddb08e7b22 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -570,10 +570,16 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
 	if (amd_iommu_iotlb_sup &&
 	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
 		ret = pci_enable_ats(pdev, PAGE_SHIFT);
-		if (!ret) {
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-		}
+		/*
+		 * pci_enable_ats() should not fail here because earlier checks
+		 * have already verified support and configuration.
+		 */
+		if (WARN_ON(ret))
+			return ret;
+
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		ret = 0;
 	}
 
 	return ret;
@@ -2502,8 +2508,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	else
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
 
-	if (dev_is_pci(dev))
-		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (pci_ats_supported(pdev)) {
+			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
+			if (ret) {
+				iommu_dev = ERR_PTR(ret);
+				goto out_err;
+			}
+		}
+	}
 
 out_err:
 	return iommu_dev;
-- 
2.54.0.746.g67dd491aae-goog

