Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB623BD224
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672612; cv=none; b=DgCE2gFutOUmIU4/qanmlDy0/ebuZsSLRpiVxYdl6VBypxL+P+DskMveYltxOffaChc+JpRK3Jt4TE2LpmfvVOM8E3RJRxefON417/ZQLVhhYcWSgW/3RhBnqetQzZw0XvPHbzA5xSEBskihNXZ7eBgVCrp3atDJvGyz68ckNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672612; c=relaxed/simple;
	bh=NCd+j7nYxNHdzjcZFSHtTXKm1kUiQw8psOs+qwO+fZQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wgho3IfVy7lQEzvajxPQmYQmZeKY8mUpzhxBuGYqKqmxS49gMtOw+a2VxZyNfda53x88UQKk2/eQ2bN42X+vo5D2Uj+PxxGnRXX/UBoChVRZcCvimo1N8uVRTRbYMwevLrEhnquj4fTmf7FNPv8/elgp5H68WRCaleMQ9vycZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s205sK3N; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s205sK3N"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedf6e8a42so550637a12.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 18:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672611; x=1787277411; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OUkFjlhYb4V9G0SD2iUKbc3ig8CtlYc6GojhAFo6lwA=;
        b=s205sK3NX7/kVENySj7ID+5WZH/fBeTJ4e+PusmyYjP6zkOR89HadYuPDDPhh1U7of
         szlFfHBTHLkX3QqsJ3D/9nzj0N8NKs3ldV9Wiu1QuQyw5t2AdBiAwzB95y7jT7vYLJm0
         DRKW1P+hUo7m1z/tuzroDwli+/AHI7WFVBlduEW/HQyEDGtG5bK9j37aUusW86fbHMYQ
         K/6kcZWKQPSEQjtHHLbrSoiEGZZHBKmzM5lt9fyY5wePYfcDaHG/meBqXO8qJuN4QbzH
         k3u1/FMJDnBd2Fgaan8uJtx0n94ad2XCq2FwWhbMVhiCoEJQeJg5Sz4QBdCWv6pfsfWq
         TPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672611; x=1787277411;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUkFjlhYb4V9G0SD2iUKbc3ig8CtlYc6GojhAFo6lwA=;
        b=IVUuB2wUTgHqkiFrx0a9lKhAisG5MzI0gfXDO4sWOW497/Ial6ZHQvd5QRtYx/6jTW
         b8aBDEHEfw+7jSs3lNmFIrlbtjQt3fj4Prw7yucDG/aVAvYaWIIgekXJ800+MIA7rlsi
         7yiMYd0jx4M7/iUPuQxew3sg6OUFkR6vTlqidzaqRjwwM5fd4OTbRF355jIkx6cjZ8HM
         /Pg++r+l+MStyL6GRCZ3ePcIjO/rD2rJZk0MoSrn7tZ9ynXdBiTi4pVdO1Yx+8Mriy6B
         1ahqH0jGmQjbMpRY2ISVJKmxKUc3zmXlKp74MN0jCxbytL1Mlq1JbgwKe4y/ZhR87G2j
         WlQA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7lz3VjtyP4FbL6tewwRVskCbrsxlEl1X35GAn19t3preBGoHOzItFBehHH4sro6i9uoCf7FSJ6f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MO0ndR0wjutEZzWMfLTgTmFIVtJrL6aBhxWe/myPZo7Xmg4G
	Xo2PX+1ophNGBY4xZ3laPCprhYW21obO+j9f/X4r0M153g/HwiB8nUkMwvitFraxcmzlQouN4DQ
	ZWA==
X-Received: from dybia9.prod.google.com ([2002:a05:7301:309:b0:314:f66b:be54])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a86:b0:3c3:875d:705e
 with SMTP id adf61e73a8af0-3cc71d7a018mr2488543637.19.1786672610589; Thu, 13
 Aug 2026 18:56:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-1-praan@google.com>
Subject: [PATCH v2 0/5] iommu/amd: Refactors for ATS robustness
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

[v2]

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

 drivers/iommu/amd/iommu.c | 196 +++++++++++++++++++++++---------------
 drivers/pci/ats.c         |   6 +-
 2 files changed, 122 insertions(+), 80 deletions(-)

-- 
2.55.0.691.gc56d675ccc-goog

