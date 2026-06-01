Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC037B000
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324610; cv=none; b=oiTRHVcbnP/OdMyPX1vlsT5ER6YlzA6NSeNNc54HpcOkyIMj3q97cedJPP7uG2cShW47k4ufWner8UT6SXD2Tk/OTejHqGKjbAwAEamMqa2KgYzs31DkW/WK2iKnYP5akl12z7QiZKbf3PBBxnxv1brF2wgsZW/ye2nFPq9EDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324610; c=relaxed/simple;
	bh=+aUZFujOJt1HzKW2d/02qPS6+H/Sp7A9/BMfcdW8tvE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RhAxfVxglqOVeJWIbJGIkAav4J5ryTzTcvA981EOqshIXC3GtSryzlAeKXcLnGsPFKTDhpLqrjKBHqk/1h00RJ4IWqws4/fE9WwHJ+aBiId+wNUSOD682/mofcIZNHCbzhmQdZx0n7jbYCYVFTQ06EoaVl7ERRPHLbygZOlSALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+BDTqRm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+BDTqRm"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b7c55406bso3378879a91.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324607; x=1780929407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mq680t4Gx83PdTUYD69e7f2qCRhIL2CvllXumPUWfXM=;
        b=Y+BDTqRmuiaRZh3yi220AIz9o12OFiGyhf8OxjTWn9QYMjAHoURULUkbCxOwIh46qm
         AK/z8Fo8WyXB8uQoQf0nDRyrTCbJJ6K7iDiVuObBpWO6yGwu6HW9FqSqIQg93g2QcKnU
         WK2Lrnb03Bh7s/V0gCVOJvK6yDx1MMTX/SKubTKaS8/ys5/8wzD2dxFu0JH8G4IZaOxK
         3W9Yh0nfzynYbZcT+1YPPYlQw9KB+r3ax3h88wvvovua6mOOzCqtzUxB/1oNpbUQLkts
         YKfqZN+/Bgl1fLYR44wdHmcIfWHH9lSjCwT/WYoy+33ue2++aIdZMzZ5Frd6WOW42L8d
         8Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324607; x=1780929407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mq680t4Gx83PdTUYD69e7f2qCRhIL2CvllXumPUWfXM=;
        b=CXqgmu/BcuwriZ+4StGogEaM41w4bw5THLxhv1eSGDJ5XYNdy2TiqLyNoDnIGBBvU6
         vm4/KiOfRm5cQVIM+3vo6TURv4D+o622634gucNpzbx4Pdvjm7oNE8qYS5+Sw+ZUSNjN
         eF4/h06YDjSF1mE+uJHFVo0aL0Y5T7rvM62HoegUGUcd4vGhKMZb6zB5RgpPxtJBv60h
         EGS98bCPb9tyZFbmlcpUTn7vKTk01h6j0ebhj2gcoJKRRJbwxQO9E4exihqflJPl0H5w
         OSSYKyKQ3nYKs8lPT5FiOQfTmldufwDxNUnJJUwMmcmEs/fYiGQ7CpqtS8s4kjtVncPa
         0pPA==
X-Forwarded-Encrypted: i=1; AFNElJ84RNQYo0Q1cEmLr3PThsPRTOxbNB3gLihjPIZ/+Cw1xeczTAQVs6MvQJjZg8SzDduVxBl0Rf+Ww0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsFM4Kv8rm4xn+cHHxJ/V/5kH9i4GkfnweQXDN0QjIBV6+zN2
	uEzSt7Pfhi/m3L1DN67qoTOGkbx3eS3wlbpjsHHqqXgHiAV+5c0HJoFTuNbi29MU2wonbaDHdbl
	pAw==
X-Received: from pjsg9.prod.google.com ([2002:a17:90a:7149:b0:36b:b005:e76b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:564c:b0:366:10f1:3d91
 with SMTP id 98e67ed59e1d1-36c4fef3035mr11248821a91.1.1780324606616; Mon, 01
 Jun 2026 07:36:46 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-1-praan@google.com>
Subject: [PATCH v7 0/5] iommu: Standardize ATS robustness and state tracking
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

Additionally, while fixing probe paths for Intel, I also spotted a
minor fix for arm-smmu-v3 (patch 3).

Following the discussion with the community, the driver-specific series
have been posted separately:

 - Intel IOMMU fixes reported by Sashiko [2]
 - Refactors for AMD IOMMU [3]

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/
[2] https://lore.kernel.org/all/20260531170254.60493-1-praan@google.com/
[3] https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/

[v7]
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

Pranjal Shrivastava (5):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  iommu/arm-smmu-v3: Fix a UAF in the probe_device error path
  iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
  iommu/vt-d: Fail probe on ATS configuration failure

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  8 +++++++-
 drivers/iommu/intel/iommu.c                 | 15 ++++++++++++---
 drivers/pci/ats.c                           | 13 ++++++++++---
 3 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog

