Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDCB2FD7C3
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999839; cv=none; b=YSS81oZYxOPKbVcJQJguXffWCFeKwWBQWsKCpCRB+mXKoDAztzoixpmdWgqzQSajqO40Oaw3AqQsqwfLeHRhRbPT1RYfm6V00DjtCVch+akEtrpbl5L5mi9opWzng466HR6R2g2uLqmHCkeh6SK14jCNlRjdYBeUnTsKp+tEHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999839; c=relaxed/simple;
	bh=hGvy0pHCr8Z9RUIfCnC1sEgi08Pcgdjw5Rm3oBc3hMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gzx2VGBHPdDm8/f8FCMTueS/AI1xH0V8G6t9bJsZ5DRnDKK3ob9skBQqyEMBuYs8lZGa3ywFa60nwCYw2QF3zoscN9PMKGH8aQP1hjnk8UeyLT9ULhOKgxL9sQYsFUCtgUnCF2oHu/1bDgmPGmqQmBDZ3GaAWe6/NXCBdz7SuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9TZUrGc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9TZUrGc"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso10341584a12.2
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999836; x=1780604636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OCRry7rxw58KzBu/2DpFLzdj5hBkFn2md8kzREbSj6E=;
        b=n9TZUrGcIztBIQcxLEemUdmc98PbHySdZI+UdmOMQle2KHKiI3vQu7Sf48p35MwKJP
         Ofb+JhUgkcIpvqyJu/ga3ofzM4NR5JEga/LAQhSMq+3pCzKzUGwYrKnM/BAAD5BVMtFY
         VYmkrc8hqwVrPHe88+343y60xdMP7ELugstktN8U+VDBYvvSFtaTRWdMw9IQ6LeTpkrK
         XrVcF0RJd/Y5D0Rp11V1GbZDT5YTs22j3sAN73weEFjbuV8pGTLl80z71CnCDcn7aIWH
         4mK9tXJMl/QqB50pPLF47Hrx7oSu8bad41+8uW0Gzt8ips/mol9mVFnAImnhsZZkncnK
         83kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999836; x=1780604636;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCRry7rxw58KzBu/2DpFLzdj5hBkFn2md8kzREbSj6E=;
        b=AD1Kpv1hyUXwY9kQiBh//0eOk/SPaDSRct+X5nw7dI1pO+tWZ/MqA8IN1krEEiPRE+
         Yxud6mqosT4WsCtmyisv5cx9o0Ay809xRSlF8qdJddM/wX78KICvs6VqZpCPXOFF/zjy
         fn3s/Ep1u0yTTC+Gqr6vzN5wh6HpZUhMtds3A5JVYcYlzWKpugZt2BdSYnbo6lDRlde3
         kfD3H/oHistMp1qgeXDvysw5bRxxfu3IqnBOnAQiBMj0glYJtTqVLhH8378BRgZVQPEF
         XxizPgDQ6yeP73TRqk7Bsim7cQd1JfqWzaGHNXF1sy6cBHKRpN1w7XFcZ+oUJY825W+i
         GV1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8lTK+lCJNjkvCoShJx5r/uLwa9OOR8ny1P1PIEYCwjYhIlkV4fC77HiGZx+A+Dq+qjK+lTiNZgLj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqwNwiIfWfiN4p5irroTaFE4OPBr0vZ2ZRjsszUje3SxmyT0x
	iaYnI0TyvyWh+72Q5pzF7vp/24jijtzGjK/7SHcndvpB7HGy0P5aNacz8kwEa8EGobjcrVJ2l9V
	VNQ==
X-Received: from pgbo29.prod.google.com ([2002:a63:5a1d:0:b0:c82:2e5b:8f33])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1a:b0:3b2:924f:70af
 with SMTP id adf61e73a8af0-3b40e648375mr280209637.45.1779999835891; Thu, 28
 May 2026 13:23:55 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-1-praan@google.com>
Subject: [PATCH v5 0/7] iommu: Standardize ATS robustness and state tracking
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
To facilitate this, pci_prepare_ats() has been decoupled from the internal
support check. Furthermore, the device probe should fail if pci_prepare_ats()
fails. Since these early gates preclude software configuration errors,
any remaining failure during pci_enable_ats() is treated as a kernel bug

This series standardizes this pattern across ARM SMMUv3, Intel VT-d, &
AMD IOMMU drivers, while also hardening the latter two against pre-existing
issues found by Sashiko in their probe error paths identified during review.

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

[v5]
 - Decoupled pci_ats_supported() from pci_prepare_ats() in the PCI core.
 - Rebased SMMUv3 support on top of Nicolin's "Always-On ATS" series.
 - Fixed pre-existing RB-tree corruption in VT-d probe (Baolu/Sashiko).
 - Addressed the pre-existing UAF in AMD IOMMU probe suggested by Sashiko
 - Collected R-b tags from Nicolin.

[v4]
 - https://lore.kernel.org/all/20260525184347.4059549-1-praan@google.com/
 - Standardized the pattern across Intel VT-d and AMD IOMMU drivers.
 - Replaced the SMMUv3 ats_prepared gate with a fatal probe-fail logic.
 - Utilized WARN() macros for runtime enablement failures in all drivers.
 - Collected R-b tags from Jason and Sami.

[v3] https://lore.kernel.org/all/20260519135323.1558777-1-praan@google.com/
[v2] https://lore.kernel.org/all/20260504163842.2692314-1-praan@google.com/


Pranjal Shrivastava (7):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  PCI/ATS: Decouple pci_ats_supported() from pci_prepare_ats()
  iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
  iommu/vt-d: Fix RB-tree corruption and Use-After-Free in probe
  iommu/vt-d: Fail probe on ATS configuration failure
  iommu/amd: Fail probe on ATS configuration failure

 drivers/iommu/amd/iommu.c                   | 30 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++--
 drivers/iommu/intel/iommu.c                 | 22 ++++++++++++---
 drivers/pci/ats.c                           | 21 ++++++++++-----
 4 files changed, 64 insertions(+), 19 deletions(-)

-- 
2.54.0.823.g6e5bcc1fc9-goog

