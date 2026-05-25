Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398636897F
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734632; cv=none; b=FtPjBEfcvGJmjkRm0eI294puHYUsAOABnkoz3N+xYC/M0E2HXVSsZT6kjKkXD8zvSRVv1GCH9xR3d6wILzDyc7gGQE9Hnrf3KbqtDFOf2qQR44pYiyrR8eBYtIzoWkf0thfn2pZ9lQJT6l/Z5oIoN4i0LCBzXYo1VnraYC3Tp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734632; c=relaxed/simple;
	bh=S3WwxYOwTFTGOXsA16goqVxlrACGQO7go6i+UDqPF0o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=byCF9U0V6vGeVoBr5yxatuAq7KSnhz7js+nz5vls31tZ8gsmj3UwNzLI2/wAoEXm2aGlIxgzKGng3Y8yM9Ah9rB/C39drF75TFl1Hu9VymSeJYso9X40Q3jCD5rnMHQ82mYtnbYtTB6+QIJhiVIs/DMAFFHlVVmPzEQ2LmIjVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nI9nOH6H; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nI9nOH6H"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc977e6aedso101578705ad.2
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734631; x=1780339431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hKucAVRhiN094mFuCmSJPl9Zvf4iz9kVDYBn+OIoEcY=;
        b=nI9nOH6Hb5w4Ev2GVjE+wmr32ovZMkiw17u+bnTW7mpTFkLgLvWG6kxzDVfsD20pQz
         e4OW5CJVTY3i3Hbwc/G8vs6xogiHuMHfWdp3cNLwzhDJfttjjvZl7o2a7zZzQmxZ894C
         RQkixTdB37ZZuibrIqwTEuVyoldHtdcUncfSxp9OfblwwYQ1ObOD0Eeg+HTOzt4IkR/D
         BClF2Lk26IYTTtbnRrIVBNeXKI6RaSdirrMoR4/J/+NkEFkZVvL2gZ8j2WhDxw1I2qaF
         W9xiljRgcjtvfnnfRkPBu8AqsXEwOL6RRBFXHeYzqp8wN9S7GYyQ68MQt7omydl3G/1+
         qdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734631; x=1780339431;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKucAVRhiN094mFuCmSJPl9Zvf4iz9kVDYBn+OIoEcY=;
        b=itTdZxpiKd57x9nJEueudpd+Kk/41s1hE9MvGfKmBGx6Sy5/a23zFoIcb2X8d/rNY0
         nRtGZkOBZA71ojz74a4KiydWdvmlX3EUuIkauR54aWU0BtzLRrZeJyA03RvWiAWedzMK
         woEq9g4gAmXuSvOR9/0Ah8i24SIop/Vba62AYnsHq/DLn2IFN4Co50V710smCfMlEUMy
         gBlUEbywmk5TM+5JmmQ5e6bE0OeABEo9kyoz2NYgph3i5iJ/iCV2vSxp2lbcusCDqmke
         vVy5bOCUP+pqCh3rGrV1IpBKfaIj7KKpkIUGDXNxNSW7fCuXiN+xv9KyTJl3UYHsLIMq
         ul1g==
X-Forwarded-Encrypted: i=1; AFNElJ+zVFzA8IJnfi5bEtcj60hBJ4gv8OJr66ozgoyi4dxpWCvZJUT6UseWaHwKFTNq6yzDzEwte3bAB1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYrf1xHzssnl4IEE8YgzlsYjJDlWWSb2ZdiP+jJabYwICgABe
	i+cjoSJesbzNRxUSg0uUTRShSY7owvwuIibkEaO8nayFLHAwgF7XRWQo/zeiuZlQL3UuojP6/AZ
	xMQ==
X-Received: from pllo21.prod.google.com ([2002:a17:902:7795:b0:2b7:882d:6a56])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d50c:b0:2bc:78ec:54cf
 with SMTP id d9443c01a7336-2beb035a83bmr182353345ad.9.1779734630658; Mon, 25
 May 2026 11:43:50 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-1-praan@google.com>
Subject: [PATCH v4 0/5] iommu: Standardize ATS robustness and state tracking
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

Based on discussion with Jason in v3 it was decided that IOMMU drivers 
should explicitly check pci_ats_supported before calling pci_prepare_ats
and the device probe should fail if pci_prepare_ats fails. Since these
early gates preclude software configuration errors, any remaining failure
during pci_enable_ats() is treated as a kernel bug & reported via WARN().

This series standardizes this pattern across ARM SMMUv3, Intel VT-d, &
AMD IOMMU drivers.

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

[v4]
 - Standardized the pattern across Intel VT-d and AMD IOMMU drivers.
 - Replaced the SMMUv3 ats_prepared gate with a fatal probe-fail logic.
 - Utilized WARN() macros for runtime enablement failures in all drivers.
 - Collected R-b tags from Jason and Sami.

[v3] https://lore.kernel.org/all/20260519135323.1558777-1-praan@google.com/
[v2] https://lore.kernel.org/all/20260504163842.2692314-1-praan@google.com/

Pranjal Shrivastava (5):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  iommu/arm-smmu-v3: Fix ATS state tracking
  iommu/vt-d: Fail probe on ATS configuration failure
  iommu/amd: Fail probe on ATS configuration failure

 drivers/iommu/amd/iommu.c                   | 27 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++++++++---
 drivers/iommu/intel/iommu.c                 | 15 +++++++++---
 drivers/pci/ats.c                           | 14 ++++++++---
 4 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog

