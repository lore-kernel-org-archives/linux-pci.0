Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C0357D14
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597284; cv=none; b=Eyd57u6iCkJFgmeSz/MoRTbhz2WRrriXzsrZFuuSJnGEtyTRW4JTm11/e0sPrrEzNXdyADWtMI4PjP6TC77y9CNY9inpUpRHy5A5qF0VCUOsOikNoytIzfsOnVWGrvNat6XL4dal7+qTUik9wD2A5AeifNWuhlHipmms4gRiRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597284; c=relaxed/simple;
	bh=o+wk7iXC6VauNnExxfg0TzcqhGJk19ik5VMdWoMy+Io=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fjYU4bg8unZd9UrOZeEKcLYHO0OPfkQzipAdI5OXjICcHdq2o35B+QC+M6TRXFblVyVgr46xWHGO/XOLmCMZlTAiLNeZ0vuatmUHsgGzG5/lJA1ZTfTkmyzmU/Fc9GrFg8vgwxTO18L21nULiED2rpJbv6Bv2lrWpwsrDRrgDjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvTk+BMk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvTk+BMk"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so791973a91.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597281; x=1781202081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WNm7tdHA24ucfyXJdikAS1wgOMt/Xm5IGhATPcb6sag=;
        b=EvTk+BMkKImtgblqMXTyvkE+M6a9idYR0XQ+1unJ7IFUGm5cFWTKqQ25jxcmr68gwu
         UCnC4LufvjKnVWflqjvY5YzyYL9hNcKrSk52OW8CXHrDajNjNcqnikP8PLSxw3Jc481E
         v4SY/Ez11DJ4hoWXN2GJ8ahJg4i9Ycu5HSlZACEqyp0vBJGw2EbCEW1ifGfCPf+NM5DR
         jPrWcFzcE1Ii+Og+x06jwsENfFy2/Qs22wSZF0P1plgKi2mIsWBN5kJw/RQA0KXMphso
         sPLRBvkXaxFUJj29KKOEN8+yprjJuSzmMD9wNI1dXqTntKcsBc6DkPjNzTmMwwktXkx8
         71uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597281; x=1781202081;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNm7tdHA24ucfyXJdikAS1wgOMt/Xm5IGhATPcb6sag=;
        b=Ftuo/mcXSpaTWABU/mSkZl8KQ42c+lrH5+y2S3FB+YqPHbtW7kpFwatRD6q94Pq49k
         KkWf2d7dVMNWM+dNvyJ1qffVhVWipJVBKhmx3rMNIvgde1AVBrBxg4LKxyNN4NhGqI2q
         2xEwH/dtifIhLZi2HDaYr4rgZbYqHk6ZoIAaWxDY9CwhRCRcAgOkj4VV9hYVxri4ooqH
         FM5eIRf3zfR8hN3HkT7KWqQLggLzEynV0hRh7RJ78xM45phMnUF/YtmyJyiDEgU7NAma
         VgabxoEXncRcDX2kwYz+hzHlK5tbY5HtQY8P/xYFwiINo16IODCVBWPKD0Ad486MBU+Z
         1GiA==
X-Forwarded-Encrypted: i=1; AFNElJ/VbzIRmTzNJhuEHOwiSMaIW84pvusvPcoBtAlyGSWAHv1EWo3qbD6BOUtnYCU2UQ1PQ9mUqJNIm5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoElcLAvVoFcD8cQ1mgJVZj+uXNwC4V0U8u+FChT46LSNu4Rj
	tEhFFSt74vgvZ++FTKKa8v/FnzGZGSQ6KakcuboYgep3HIIyRWQMcMSJJqYX+/veG3kKLzweNOI
	eCA==
X-Received: from pjbiq7.prod.google.com ([2002:a17:90a:fb47:b0:36b:dc35:1b43])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:588b:b0:36d:bc21:4ae1
 with SMTP id 98e67ed59e1d1-370f133294emr115252a91.27.1780597280556; Thu, 04
 Jun 2026 11:21:20 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:12 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-1-praan@google.com>
Subject: [PATCH v8 0/4] iommu: Standardize ATS robustness and state tracking
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
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

Following the discussion with the community, the driver-specific series
have been posted separately:

 - Intel IOMMU fixes reported by Sashiko [2]
 - Refactors for AMD IOMMU [3]

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/
[2] https://lore.kernel.org/all/20260531170254.60493-1-praan@google.com/
[3] https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/

[v8]
 - Collected R-b tags from Kevin & Lu
 - Dropped the SMMU dev_iommu_priv_set(dev, NULL) patch.

[v7]
 - https://lore.kernel.org/all/20260601143644.2358771-1-praan@google.com/
 - Moved patch PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
    to the AMD series [3] to maintain bisectibility
 - Added a UAF fix for arm-smmu-v3 to set iommu->priv = NULL

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

Pranjal Shrivastava (4):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
  iommu/vt-d: Fail probe on ATS configuration failure

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  7 ++++++-
 drivers/iommu/intel/iommu.c                 | 15 ++++++++++++---
 drivers/pci/ats.c                           | 13 ++++++++++---
 3 files changed, 28 insertions(+), 7 deletions(-)


base-commit: 542627e4a4aad76ccdf66436d7a8ea0d29069796
-- 
2.54.0.1032.g2f8565e1d1-goog

