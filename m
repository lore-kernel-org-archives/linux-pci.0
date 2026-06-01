Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EFC306D26
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321330; cv=none; b=qJufLLDX8kh2csYz5L69tgNo7NEF5kALn7QNXq3EafehIH9Yls5BIje2egyzMXCAfiH7xi3s7kA2NISqC7z3yHjVwdQWlQRocu+ixP0NQmWUgz5j6oyQ2izhBc821K12FNnvBidBvin+/lbpmxq/RA9iePbur6yCbTvsErLOfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321330; c=relaxed/simple;
	bh=dy6ZJdEwqGXi1D7BxWGTU7NpCU8NjUAJeGH49rbOLEw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pFuMGFE9Snq+SVjt/dXg4AIt+bnhwxoHfJR0+NJ3HpH/bE4U7vGn6qITYYJbs3fwhmLwCMzG2xc34d5UFJZ5JRUBUKbRuEoeh9WAFG2s/Pd4akX7TbvIRLCwQsz/cSP5f4eZjWslcwuTw9Oyxb7kZgzl0pR/4SvXQThEve3y/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUOsLszT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUOsLszT"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso1273221a91.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 06:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321328; x=1780926128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rR61/+xb/oc53nV+wAUc+P1RLRo45eSY8sAO+f4MVRQ=;
        b=PUOsLszTQt9a6+wVab1Te+BiTeajwKciW7iVq0hvqjltO0NHwCPFabXw+EoCWLsFVi
         Ey+W+OszV5CvS0EMXthVe0/1ZUM+wq4lBt5sRFrV+b80XE3WYw6oBhy15hApFGtxEz/z
         swmmSEqJyfDbvUKwAVSOq4TS2u6fnu3OTuTGM8mQk+SiNWot3BlkybiRk3iGXapzN/Q9
         HNve1tEfmAmwRvRpgZvC3JJRuyEMvXHj32yK+woznOnedepGPkKaaVWXp+sQDuRdW2gH
         z2kOv0AbSEzMomTVO9L5Gc61Py821Rzgi2+hUM4YZnWLPRKp0DFbBN1JapJ+fFRxVbIL
         qjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321328; x=1780926128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rR61/+xb/oc53nV+wAUc+P1RLRo45eSY8sAO+f4MVRQ=;
        b=tFV0KexHqAZWkDkCxS3fGSepi3bY9PVPkQnX5f4bHROl+ZFbE6Sp7vSinJSjuHK3Kl
         yGZ6rILurGL723LdGvVvtQsMlixKkc3VTwF3jJIQGLpTB23zX1yyDVwTS6PbZE7xDKqM
         eIdfoCoxOqTuUPB5asECrdrEZFqWk/eM+x3vqK6EPnexAYWTOlJ/MA/SXH/5WxQv9drX
         vCCtfAcoy9hfo1wqoHoxQcjout8j/XgMvt7XiLBEO41T3JBZizhpiLlhOj7hgxkle+Vg
         WsEIu0OHLf/9q5rpftC/2su7fNZvj8Mw0cwhieDFXGaDdyt0Em83aBRWpD7mvD+cufyM
         suJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8p/S4Hq9VQcxu5+qWUXEdFwDCZyvBJqSqjoo44PkudryRscAIAsVyMxw2uAl2kdGOgvwQtk959ahU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDA/7DzcO4HncP0a1PdglUA38yNyjLomT0l4ji7GOon/fNCL7
	FA5QYy0I/VFTXTbU7lMBW976Y5b1zJ79jPSO9i9FNuSqcNgzn9yUNNhfTquttGK5shqQbv3XXoj
	owA==
X-Received: from pjbiq7.prod.google.com ([2002:a17:90a:fb47:b0:36b:dc35:1b43])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2cc:b0:36a:7da3:266b
 with SMTP id 98e67ed59e1d1-36c68473b45mr10733749a91.21.1780321328092; Mon, 01
 Jun 2026 06:42:08 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:41:58 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-1-praan@google.com>
Subject: [PATCH 0/6] iommu/amd: Refactors for ATS updates
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses some issues identified by Sashiko in the AMD IOMMU
driver during the review of the subsystem-wide ATS update work [1].

Patches 1-2 address the  pre-existing bugs in iommu_ignore_device()
regarding the order of alias clearing and cleaning up the DTEs. 

Patches 3-4 refine the probe error paths. As noted[2] by Ankit & Sashiko,
unconditionally calling iommu_ignore_device() on probe failure breaks
IRQ remapping for devices in PD_MODE_NONE. We now split the error paths
in probe_device to preserve interrupt mapping for non-fatal failures
while ensuring that dangling device pointers are cleared to prevent 
potential UAFs.

Finally, patch 5 implements the Fail Hard pattern being standardized
for ATS, ensuring configuration errors are caught during probe_device and
ATS enablement failures are reported with a WARN_ON().

Patch 6 is carried forward as is from the original ATS work [3] to
maintain bisectibility.

[1] https://lore.kernel.org/all/20260529111208.387412-1-praan@google.com/
[2] https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
[3] https://lore.kernel.org/all/20260529111208.387412-4-praan@google.com/

Thanks,
Praan

Pranjal Shrivastava (6):
  iommu/amd: Clear aliases before setting the rlookup_table to NULL
  iommu/amd: Clear DTE with update_dte256 in iommu_ignore_device()
  iommu/amd: Split probe error paths to preserve IRQ remapping
  iommu/amd: Fix Use-After-Free in non-fatal probe error path
  iommu/amd: Fail probe on ATS configuration failure
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

 drivers/iommu/amd/iommu.c | 61 ++++++++++++++++++++++++++++++++-------
 drivers/pci/ats.c         |  6 ++--
 2 files changed, 55 insertions(+), 12 deletions(-)

base-commit: 283d245468a2b61c41aa8b582f25ed5615d1c304
-- 
2.54.0.823.g6e5bcc1fc9-goog

