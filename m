Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48E3403E8
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198817; cv=none; b=t54OJoNk8+OvLsMLcHb+mlO6qPEAk87PyAwB9QCHWOuPCvXpnPxQupGRhSxXLvo16U8w+16AoTBoHhBQLlCGfkvi4q/uvLfahZV64AHzrZ9q7OQogfVAPzneqhRKQ5ecjwXC7B+cS1fastln/Cf3wBKDZLp9YcLQkKggP0+sNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198817; c=relaxed/simple;
	bh=ftPuSF5fEorm3tcHSoDg4t5CQW9EzadJM051EBrSzZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c6FnuSIHsaev9jxOqZwqHTxoIcjqy5aAu97YFmC3Ve16YJ7HnVW+K4ziEKnAn+ZINapvu9YnTd6RpanDT+5Sxz0PVpdZXjJb3eVzVUEac7OAomiiEpQ4RvlTRbh2+h8YICvSCBnu9AbQDxOB0/WC7s2vw5kNdzNzVCgZLtcWHCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qm5Ea+Q4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qm5Ea+Q4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8024fc7032so2070351a12.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198816; x=1779803616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTRxUJzZLnF7O6lqa9s49yWKPCyCP5ATHRikunHLlWs=;
        b=Qm5Ea+Q4go+a8ZUm5XZygkJOdvpfdGpUCto1pKCruq6leMFlrt5kiqoT84KHgxYNRr
         otHyoq90kpf36X4TutVN19MwYXlgishd/UnviV16KQx0H0qPAcrcb5EZSz+/DzxLLDz2
         hJ/kIYu2mbhaVCC/828RHC/7lU1JYJZgezEX5qkJYoP15xZofANtzLsvqb4YcbAAqBDh
         sSDHia8OhlWJsJMDSZ8k04n9LCOOExHPy/x61nbBK3gIBKvO2OeFrH304PORDbAZK1iY
         3EU04lHQhWwIqH27L/glRomoZku6h4XUXdDQ8HM+8otWqDoFiDFDtosz6Ki02JPFCN7G
         AzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198816; x=1779803616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTRxUJzZLnF7O6lqa9s49yWKPCyCP5ATHRikunHLlWs=;
        b=Vvm4Yocmu8Jzl/TJse3RKCwPzrYsgWsRzo9wPoYA8CQErgyT2jR0YB/Ddu08BwZQ5r
         eaBOpu2nNL122/cFS33h3goYSpwWLxdZDVIoXyubWPOlWX4MRr2F5TW7M5YBaafCqFnm
         KDBtBbk4PB47Q81DCrSapy9tgnKo6nocsw+6Yupea1HQ8p/6xcGwtBOZ38RnYaO9pzoH
         IidVskdkrTL2kO6npRtf64L6otMGhyiOr87Sp2FoCtPHJz1rcubLFm8hlv0/gC8yBHJV
         rl4H1uLNd6XHdKSG5ejxoFgxozsKLn4TrM9ewnH/ZYLJpHWl1Ve8GTWDKFRRgmARWZFL
         4xmA==
X-Forwarded-Encrypted: i=1; AFNElJ894dpdWFcGKbgDsnzqNSWt2ZgnprTrt2UOfn16tgpNYa+62cp6hlEiI7kJz6wvLjPrij/owtY4lIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYCtwUS/zrWm1a/dZtaUQLWTv+aCxaiB98yBmWNRVTjD/x1mb
	Tg6BXcJFE7Guw5MCpLg28ajVoE6IEEHMCIoECgS7eStIWepqR8vs9jW8aU47Xt6Dz1W7GrRHU87
	8Ug==
X-Received: from pgv5.prod.google.com ([2002:a63:1545:0:b0:c82:7761:9941])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244d:b0:3b1:884a:c3d5
 with SMTP id adf61e73a8af0-3b22ebd8ce1mr20588569637.24.1779198815838; Tue, 19
 May 2026 06:53:35 -0700 (PDT)
Date: Tue, 19 May 2026 13:53:20 +0000
In-Reply-To: <20260519135323.1558777-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519135323.1558777-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519135323.1558777-2-praan@google.com>
Subject: [PATCH v3 1/3] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..a5fa7745bce8 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap)
+	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
-	return (dev->untrusted == 0);
+	if (dev->is_virtfn)
+		return pci_ats_supported(pci_physfn(dev));
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
-- 
2.54.0.563.g4f69b47b94-goog

