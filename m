Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320653EDE6E
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574238; cv=none; b=Xr/7gkb8oP26XQ9i6fgFFf0pOqR6fXVC8KFKYuHY9UvY/FiXg20huN+8gKN3o9fww5R/jIiKmd2DBvKegKXdosJULDax9I0dP3t5YUiZEPDHre2S/LlVei/mUtqg8N5KzxSU1inRDdOn3N2zf4bjKY4R+fGK7qcNSjHYnJhttZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574238; c=relaxed/simple;
	bh=QQ+BuMhlGjap9G/8niHShlE1MGJ4y7C/XEXcy/s8Xx0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PJ5YIOu+LQxabBALUiTphHkayxc7KcEa93gIWVt0poG8+dyH5q9JKe1yRMeTAbaE1jw7UtKCu8tAjnjpja4ath4afJqhDswMjl2P0AcUOJDAsobKOuEeFY48VU6h784lPx4Xh4sXNgsWNPQ51bHI2pBluQt+9MudZ5ztQ+abZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ITBMgZIN; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ITBMgZIN"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbedf6e8a42so4200071a12.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574235; x=1788179035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUcMgUMCUzyieEAsi81dwAASFx0SSottK9MrWICMjZA=;
        b=ITBMgZINcRwx84/FmmHQdROwkYLlsscnX1CNp1aBIlGnak81seFaCCe5dxgHAPZgK4
         lhisEEieq0xiP8VtRl6bKj78ydPvdq8pSoAIzGcvHBCLscu1kuMjP0i0UajyYYPeKZiJ
         n/eTF9Ug8BRw2M90ZNOtOrbsvTiucoXBRgkiKzLUcSgGwFZqpxok+6t+mjVBuhZPcI30
         YIdVWVAYC5uwiTLmmyJtMGo2zUtouDyX8e2qRiloNQQwIWEsP5YXWht9inMbe1eBvimU
         xxnS9BO5NW6feISxJZIhxeCvnBvcIfIBJqoSTbx95QNMGVHO1yOA37P7snRFl+Kl55Nz
         bhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574235; x=1788179035;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUcMgUMCUzyieEAsi81dwAASFx0SSottK9MrWICMjZA=;
        b=kW0A4rTvNxy69zganzTn1J1oT31VGeL9nd9yS++FLKC3hplq0FotmjOp2eJ0S9NuZE
         LnkYza4oy/YqN2iKyG12VROLB1lUlLyvdP7VoXQGA9UQLjKTpX1K0EJagobd5PHxrXIA
         9JQj5bNVbrsP36fOD3EzxPiYnsabQRYPrQzycj6vctNPjxcoFbjqjrlXZWTZN7lStDm4
         hlzr7FQA/jmaNH4i+88xkanY0mni6aG3CbzNHCg2YNeoLTpdGZUdJtQz50KhnSjFNlYV
         GR93x4kMhHam9lJ4NWk7TKr4SfudzHfeubm4ICP6irxw8F5kOIz+JjsfNFw7QZ+RnWsf
         Y4hA==
X-Forwarded-Encrypted: i=1; AHgh+RpR3ig+TY+BFxBXVf4uVEZwQYN6zUF13+YKnM35sFrN0p9WqAIDmHrb7clegXMIkn1BiGS2PuYGyoI=@vger.kernel.org
X-Gm-Message-State: AFuF++mjCZIecQlhLnkJU4N1iKev1RgqZXuP6lWluOc5R0H5ZFPy8DOZ
	yRDC0fKD35eR7qJn/T56ZP3p+2Cj+1yCp7tY2MPRZ3S3howbBwy9KAa8gB7uO5+GlDVHhxkY82g
	x9A==
X-Received: from pfbfr20.prod.google.com ([2002:a05:6a00:8114:b0:845:b9e9:fcd1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a110:b0:3c3:bbe6:95c9
 with SMTP id adf61e73a8af0-3cd301795c8mr46911339637.16.1787574235313; Mon, 24
 Aug 2026 05:23:55 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-1-praan@google.com>
Subject: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series forms the second half of the subsystem-wide ATS robustness
updates. The first part (focusing on the core subsystem, Intel, and ARM
SMMUv3) has already been merged upstream [1]. This half addresses the
AMD IOMMU driver and standardizes the PCI ATS API.

In v2, the series has been significantly restructured based on feedback
on v1. 

[v3]
 - Collected Reviewed-by tags from Vasant.
 - Added a comment explaining why devices without DMA translation support
   are not ignored (to preserve interrupt remapping) per Vasant's feedback.
 - Renamed iommu_disable_device_dma() to iommu_disable_device() to accurately
   reflect that it disables both DMA and interrupt remapping.

[v2]
 - https://lore.kernel.org/all/20260814015647.3370124-1-praan@google.com/
 - Patch 1 Refctors the probe path, isolating capabilities into 
   iommu_init_device_caps().
 - Patch 2 renames iommu_ignore_device() to iommu_disable_device_dma().
   Following Jason's suggestion, it invalidates the hardware DTE by
   clearing the Valid bit (lower 128 bits) followed by the upper
   128 bits.  
 - Patch 3 splits the probe error paths to ensure that devices with
   config failures (like PD_MODE_NONE or ATS mismatches) can preserve
   their rlookup_table entries, successfully keeping IRQ remapping 
   functional for bypassed devices.
 - Patch 4 implements the "Fail Hard" pattern for ATS in the AMD driver,
   failing the probe and throwing a WARN_ON() upon ATS configuration or
   enablement failures.
 - Patch 5 enforces the checking of pci_ats_supported() prior to calling
   pci_prepare_ats() across the entire kernel PCI subsystem.

[v1]
 - https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/

Thanks,
Praan

[1] https://lore.kernel.org/all/20260615235037.259909-1-praan@google.com/

Pranjal Shrivastava (5):
  iommu/amd: Refactor device probe and capability initialization
  iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
  iommu/amd: Split probe error paths to preserve IRQ remapping
  iommu/amd: Fail probe on ATS configuration failure
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

 drivers/iommu/amd/iommu.c | 199 +++++++++++++++++++++++---------------
 drivers/pci/ats.c         |   6 +-
 2 files changed, 126 insertions(+), 79 deletions(-)

-- 
2.55.0.766.g2966f0265a-goog

