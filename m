Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0253D0935
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053136; cv=none; b=uyN+2DerqDAHq65H106AZCKZBVgBXxwKhYTC6B9D+MnmP45hyJ5L6wfrTddxE7kwcnreGBwggfWSdsqukpacU3fIm621S8TSGNaTg9fg37cTbFaXQosXp3XP1SmNoIe2ejWbQ7wCttFkfKh7FaSI4i1zFRD1RB1HgfzZUaH2zw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053136; c=relaxed/simple;
	bh=YPpTmg45GJK8y+rb5wGdt6oO/mzN5qPxq8bXqYfGSdM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UYXoW0ex5XlcUGnPI22Af9joxC8lTKR1YCIYZU7RnCGOCQXwQUCpKmhmuaRy+sm47r/IJa2m+bcAQsqD/wn2I3hYSCFX0AD6Vr8XvlQF9U6TmjmGhUk94AOFMhZ1UGF4Zlt6+FKDr2qfMRVZYDKQMtYdy0x0vXtgdVzSRkrm45o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5K18Efg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5K18Efg"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so7129210b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053132; x=1780657932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCxdVVEheuvS2AoHvSV+25X74uQUGsdU+w3bwjC0ns0=;
        b=S5K18EfgbTheJQrRiGODWXMt8cDojoyxZHjO/SBqmFS8kw7JdT5TNIB8zNOph82Dz/
         esw8TuorlaSYevjfuYco/GH3ne2dAVB8SyZ1UkmdCX5QVKCN1QLCG/vEvAmxPzBuuWTN
         nuDkr9BbS95ysMnCJB9HtVPD/vTi2B73x8Nzl5UIeZ7MmRnPz4dmp92kGA2Dlu7ojbKM
         lPmkXpSBc/tdqHaEL4+92tQT8dVsO80XX89mWDRAjDCmBW6P4xKVMQUJvSUBY3mjK8W3
         nihd5QQ4rXsemnNcDJIJWL4yWLWYRpNyUTdjShC8UmskOqrNBCBOfNSKfiV5QQjPdOox
         BzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053132; x=1780657932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCxdVVEheuvS2AoHvSV+25X74uQUGsdU+w3bwjC0ns0=;
        b=iTPqn/wVruHhNJXwePsLU+J/PfphqQMedpRMgRRgmpspQbDhGYiXXJmBIkvrNFY7fj
         5Y8UIgtXQd3EsLjLvckPT3Dqyzi7uDjgepdv5ZcO2VjVHHe4pK6lAzPgMbdkqj+idBen
         jntajbIEUTdFzQ7OlclqwQ3YS232hO7YZFUTZ3xCR/FZIVojSinO2aZyhlLKWOqJDls0
         04Pzretwx/PU18LFQuUyJva8mSEDsvBhRIYyGpcqppeknHdGj1gypVAmkF+Xt2f/Xhwp
         5Ekcxl3nD2dTTKfDhX0umCMgrJBMNX+UvuAwsRIkFxX/3j0WYLMEZXHMj3/2KEGf1lXP
         oiKg==
X-Forwarded-Encrypted: i=1; AFNElJ+b82aA77uCvCj9ZkoZAhNoRqo1p1rwlLEMYz8UE1JAw0eBtF5DYWxdJzhAbBk9ma507F6cK4OGaWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbi2SyBpHCPBgt1ZDB79TMsTbzSAa8y3ow2RfrAI8DyPN8B72p
	2JSz5WUGG0GuAzYQhkl6/ucLdaBPulKO8oL5EyELqlJmVfNQrEuVdgsSZs/8sVapgGFoAHvuUej
	DCA==
X-Received: from pfbgj6.prod.google.com ([2002:a05:6a00:8406:b0:841:c3cc:207d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3693:b0:837:8c8f:8f51
 with SMTP id d2e1a72fcca58-84212dc82c2mr2600820b3a.47.1780053131812; Fri, 29
 May 2026 04:12:11 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:02 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-1-praan@google.com>
Subject: [PATCH v6 0/6] iommu: Standardize ATS robustness and state tracking
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

The primary motivation for this series is an ATS state mismatch observed
under heavy load (via iova_stress). A failure in pci_enable_ats() leaves
IOMMU drivers like arm-smmu-v3 with inconsistent state leading to PCI core
warnings during device detach.

While David's recent work [1] addressed a discovery race for specific
quirked devices by moving them to the HEADER phase, gaps remained
regarding how Virtual Functions (VFs) inherit state from their Physical
Functions (PFs). Specifically, pci_ats_supported() did not account for
PF-level quirked status, and pci_prepare_ats() lacked STU validation for
VFs.

Based on discussion with Jason and Baolu in v3/v5, it was decided that the
IOMMU drivers should explicitly check pci_ats_supported() before calling
pci_prepare_ats(). To enforce this, pci_prepare_ats() now noisily checks
for support via WARN_ON(). Furthermore, the device probe should fail if
pci_prepare_ats() fails. Since these early gates preclude software
configuration errors, any remaining failure during pci_enable_ats() is
treated as a kernel bug.

This series standardizes this pattern across ARM SMMUv3, Intel VT-d, &
AMD IOMMU drivers.

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

[v6]
  - Reverted the decoupling of pci_ats_supported() from pci_prepare_ats().
  - Added a WARN_ON() to the internal support check in pci_prepare_ats().
  - Dropped the standalone Intel bugfixes (RB-tree and UAF) to be sent as a
   separate standalone series per maintainer request.
  - Kept the folded UAF fix in the AMD IOMMU patch to ensure the new error
   path is immediately safe.
  - Collected Reviewed-by tags from Lu Baolu for PCI core patches.

[v5]
  - https://lore.kernel.org/all/20260528202353.3422206-1-praan@google.com/
  - Decoupled pci_ats_supported() from pci_prepare_ats() in the PCI core.
  - Rebased SMMUv3 support on top of Nicolin Chen's "Always-On ATS" series.
  - Fixed pre-existing RB-tree corruption in VT-d probe (Baolu/Sashiko).
  - Addressed the pre-existing UAF in AMD IOMMU probe suggested by Sashiko.

[v4]
  - https://lore.kernel.org/all/20260525184347.4059549-1-praan@google.com/
  - Standardized the pattern across Intel VT-d and AMD IOMMU drivers.
  - Replaced the SMMUv3 ats_prepared gate with a fatal probe-fail logic.
  - Utilized WARN() macros for runtime enablement failures in all drivers.
  - Collected R-b tags from Jason and Sami.

Pranjal Shrivastava (6):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
  iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
  iommu/vt-d: Fail probe on ATS configuration failure
  iommu/amd: Fail probe on ATS configuration failure

 drivers/iommu/amd/iommu.c                   | 30 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++--
 drivers/iommu/intel/iommu.c                 | 15 ++++++++---
 drivers/pci/ats.c                           | 19 +++++++++----
 4 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog

