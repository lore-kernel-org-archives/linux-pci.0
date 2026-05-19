Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4E293B5F
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198815; cv=none; b=BYCcY/Uf9h7CExmLNZDdSu4KGNHPi83S4zZgdc5sTunLcdjFAw/roCxwNZ9mjrFanYakaty9HzmByunqbv0xm7jh6fAR+8eGmGPozHCYzp77rnV4dZZWZWc9QyNY6mWHUy68sNiXCOl0mA64OGo/hS4YBgjOlpcGrxd7Oiz8954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198815; c=relaxed/simple;
	bh=F77Y+VEw2xuBQKl2TrIZqfw7tzIvP+VoFwv7s/NVV0E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pMmeylOQ+2v8gmDNaoQqHUljsKR1HSQPRwUmOL2HUyO4XTlOjbDz4JF4C1F/TlqQR8NIFfXhLMM81OIMhjXvLfMCiLcCrfwVeikZWtpBT0f513MAyPrWNonIuUF2Nkehp797wJRUXzoV0NHjWbbNNoWeMO7BOsNxnuFiwOobeTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYS9LG5D; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYS9LG5D"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so3396769a91.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198813; x=1779803613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LseJJ503fMaFTO/RV87YZuQhoIlQze9D5qECxjs2xgM=;
        b=gYS9LG5DmaXkPPcsfMjUIQQmoScOJY6NRO/DSjQWny6bbFxaLZ8DUyqbwzaou4jTM7
         MllKR1E2FM29WoPi1BbP+pcFhLHuMgvo5Q9Prubaj3juOpEgDk/JWXylRXdnMn42/YfA
         4PB/ZowUAryhoQVUraQP0YwE+ZUI0DKtt8fjSHjPElHCfTBP7gI53iMu7sphyesmvZm8
         X4OYAhcaGwcb59djDf78Po2V+6ICE8KCWmZyCTTCONTwOFrNwnVYPAZ5sBiQ9ZrdrVka
         btc2iYCEect5dxlyFxMCltJfcl3QZ6mRWtj8SjhkSerkN+GdCpkgC4X9xytSoYbSd1V+
         tXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198813; x=1779803613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LseJJ503fMaFTO/RV87YZuQhoIlQze9D5qECxjs2xgM=;
        b=C2NnWIzn+LqNOvktMNXzF/9Cld9pp4i2EK9njvVBCe5qU1n8686XMho3aoEGm+Sd3N
         F36r7gy+StsOweYjH951cNu+/S904hLp180vOqQb87bfJs4wTbsZewHyF8aGMe2/jgGD
         jWoWjyiQr5V+KMYyAgdvNNrX1cPQCWt18lMjykhJhnJ4hoQrNhIeumXzwHe/p10oJPZU
         9hkWNaNlD/7w1M4xiCa+5XhYoTrRJfaQccwDHHrxkvfJ8FzesPks3qhgHnsXT8vzkUbC
         YrnRzBCgljF7dnDjXZNB6+ILq5lQgIjx7QZq52jYkGFuyH+5e4PC/nmRwX4dxjJOq1Ij
         0Wig==
X-Forwarded-Encrypted: i=1; AFNElJ+L/ut1/A16ypcz6okA9icpcvG2uVWoZeCPA5mHWvign0OHP6zBWCIcX84kbKNCd+bOYVuF2c0wcLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6whygzAVUqUgqWIiK9WrIUS7nYeC3vt4OBMqOy9PrX3nDxXlU
	KDiKysJYXL7s6iU241zyzXTwjbTmOjHLFQ6PFpSP3Miw1ngshYhssFjEMGEHhDeQnOjxcxh0FaB
	koA==
X-Received: from pjbfz8.prod.google.com ([2002:a17:90b:248:b0:367:e13b:f33])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33cd:b0:368:7536:b5b7
 with SMTP id 98e67ed59e1d1-36951b71e46mr19846027a91.16.1779198813302; Tue, 19
 May 2026 06:53:33 -0700 (PDT)
Date: Tue, 19 May 2026 13:53:19 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519135323.1558777-1-praan@google.com>
Subject: [PATCH v3 0/3] iommu/arm-smmu-v3: Fix ATS robustness and state tracking
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"


This series addresses a set of related ATS robustness issues in the PCI
core and the ARM SMMUv3 driver.

The primary motivation is a state mismatch observed under heavy load
where a failure in pci_enable_ats() leaves the SMMUv3 driver with
inconsistent internal counters (nr_ats_masters), leading to memory
leaks and PCI core warnings during device detach.

While David's recent work [1] addressed the discovery race for specific
quirked devices by moving them to the HEADER phase, gaps remained 
regarding how Virtual Functions (VFs) inherit state from their Physical
Functions (PFs). Specifically, pci_ats_supported() did not account for
PF-level quirked status, and pci_prepare_ats() lacked STU validation for 
VFs.

This series addresses these gaps and hardens the SMMUv3 driver:
 - Patch 1 makes pci_ats_supported() PF-aware, ensuring PF-level
   constraints correctly propagate to VFs.
 - Patch 2 adds STU validation to pci_prepare_ats() for VFs, ensuring
   consistent page shift configurations.
 - Patch 3 introduces an 'ats_prepared' gate in the SMMUv3 driver to
   ensure that configuration failures at probe result in a clean
   fallback to non-ATS mode, preventing domain state pollution.

Thanks,
Pranjal

[1] https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

v2: https://lore.kernel.org/all/20260504163842.2692314-1-praan@google.com/

Pranjal Shrivastava (3):
  PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
  PCI/ATS: Validate STU for VFs in pci_prepare_ats()
  iommu/arm-smmu-v3: Fix ATS state tracking via ats_prepared gate

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/pci/ats.c                           | 14 +++++++++++---
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

