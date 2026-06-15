Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77A211A14
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567443; cv=none; b=Cn0DXUAE3VdCUhhMsNgFj/wuAqsMspC/e23ImYx0oyGWjrUiPp30vvo3EZ2up/EwilBsaHZoKXEQaBaGUqhZUVuZ30wwCy/fZdD32msuaHj4w1k+g8ZG7J4IBvkcooObbLgg+OkRYbEr2OEKN0XIzGHHPRScY0mIdFOQPPj7Ozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567443; c=relaxed/simple;
	bh=WuCn2cJfDSgYz+cJrW1trzK7HnYtT19Zs6r3BzaEXnQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hnh1PCdgFJffykK0LvremTfLo1g1UBXvm3EgPdhiCRW45TTjS1B5W5I+id8AzUsP6Zx3Zw7ThwVZIliT67mVmFcjzjD6hAEIQnx8iBeWoUpEWvxILfNjVn+d5lkoPDyheg4z7505JhdLy7A+BXrs7CEv5Tcchw0Znq2byvX//QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyBanHOf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyBanHOf"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2c305d0so2001540a12.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567441; x=1782172241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uHfT/UJmDenMUKvw1T9KTuk5xrvkQ5tAtaAx1tB7W48=;
        b=nyBanHOfpxs0Sp1nOokNmwkrE1Mb4INiajY3ugR/HYJa0TTROqwv+F8xPe/BitPHdY
         JIJ1runBHpHRZwpF8FTKgkOpKZk9uzBfe93HnwkLaUcqxngIeYfg3VL+IbiCSN5FzrlE
         Asg68MHtSf2xz5JwstRNmUY9Oy4SRr2nwG82RuXAk9/vrIWsI5TxkTs1iHiwmfAiSFjN
         5zqHTOqctrDEPZ8VLewjqV/bpLvcL4ZfZ5VxRC5w0W1KGfBfWiN6Z4htVm8oos7lLz3A
         I/18xqFkuYtUdNIp1FSk1C1HrFoWpocP22ugUseO0BoYLUL1VJzGlqutG2hQKKQW0Cx0
         zB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567441; x=1782172241;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uHfT/UJmDenMUKvw1T9KTuk5xrvkQ5tAtaAx1tB7W48=;
        b=ApXCQdhaexAib6P+1UzrWGBgs1CoHHSzF4BXmgA8R/ru1ZP8WkWRbrX/Sm44oMxM0o
         Ds9e2Po0CpzzNcq1sPv4GmbAo7vv2kSSB4boZlhwvirVbjlRnHymaC3C8QIjSowX8//3
         qvhz73tJxBmsF9Bwj0LzL380igFyYVKgqBlT6BhHzhpbM68ZXp4N4BIwjMyQ9oreZLVY
         uhez9XITafrLdwbXIoyvNkj4ncZnY2OXKO61DvAmrlj/amJSLzbCEc6YU16YP+iHr9l4
         EJjLRgxi1qFhHErVL36n+GE+jD9i/Ts/hCt47NRhwsgeswmSxrWN7TPDKQKt/yMksQuN
         4OHA==
X-Forwarded-Encrypted: i=1; AFNElJ/pDVog4YdApT/DEsRnVJ+LJafpc2h8aAjcRlDTcGdT5Y3x8+IK4tfZZCos4JeUcTcStDjXCuiMzDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfo78aSVcGBdZQR9n7VziR6yvrhmp+dhSwtIv1rZQ4rOHHswP1
	/Ge3ctQsPnkZCfu13AiZbu1W3i3LcxCpyrsU3F1yRppMvXRXlPNxfNqpzrl0vdcwwdhd0PaGHEG
	sXQ==
X-Received: from pgve17.prod.google.com ([2002:a65:6491:0:b0:c09:15e9:db4e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:3b2:8677:813e
 with SMTP id adf61e73a8af0-3b7e4dee927mr1145277637.42.1781567440978; Mon, 15
 Jun 2026 16:50:40 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:50:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615235037.259909-1-praan@google.com>
Subject: [PATCH v9 0/4] iommu: Standardize ATS robustness and state tracking
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

[v9]
 - Collected R-b tags from Bjorn, Jason, Nicolin & Sami
 - Folded in the dev_err into the WARN for arm-smmu-v3

[v8]
 - https://lore.kernel.org/all/20260604182116.3179005-1-praan@google.com/
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  9 +++++++--
 drivers/iommu/intel/iommu.c                 | 15 ++++++++++++---
 drivers/pci/ats.c                           | 13 ++++++++++---
 3 files changed, 29 insertions(+), 8 deletions(-)


base-commit: 6666bde33b83cb4fc9b1f7ba6a3471479f76ce72
-- 
2.54.0.1136.gdb2ca164c4-goog

