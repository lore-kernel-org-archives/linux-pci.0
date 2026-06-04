Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB03A59BA
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597289; cv=none; b=l/eu7djjNnkalPe50kqrzNA8JMGW1BmR396qiCKcAW2r822ZjIegI/YlrF+SQBcB67fmdO9EJs2ezS7mzStYnkmW5e3ixc/V7/hPrpDwoP2AdBrWUHdmFEXo7jc98TKnGgbcyZFQagTskNvCP0S0UVrHq0NVB90UgQK2Va9CUFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597289; c=relaxed/simple;
	bh=VqiZ8kNwgyZT1T7foVFsSLZBWEZ/w4HCqD6vFQ2562k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ofY8mf+MiTXxiOw+NlWItjGOSxIlRytpnVKrSMfdnACPdx4AflnA9mkvxEQzSriRGE/EwM2+kVP4PgfvlVLnLfpJW3TXkEQuureDfaZ6pvu3bPnMuSEV/nfEqLuOSaYTKtjHB4wJFGJ+ybjidDqEFe4XsIWFw0xh/RDpyhB44Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXJ4KI7R; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXJ4KI7R"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1845bddfso12922915ad.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597285; x=1781202085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niiDq+FrdndFbib0XcxUBpiQEuQyYsWQAOjlvRNMMQM=;
        b=mXJ4KI7RCcB4+8NXPhstsC2CTTTn4EwW//jFLyE1PHXFXIDvdFYoStNm3CkMREzHxd
         hduPX0pN0r3k9LIqO4GJKzZKI1e/E9QI07vy9/NPe9DadBrWlr9YDXUKtzO/02lcutKy
         OErmYQA2pYNPRQZNDRKT0RCf/RyiXGEyv2hVXHL1O4buj6CjQMeM+wVQgkwtARrOruhw
         pP58s7zTwNToNrpF9jL6v44OjTYmG48m3EU5ta544OSvXZW9zbxgY0Ccf58rDnUY8ska
         yjRhSlEr+o4oacnmUDtKJQTfSPX1w3lIfEzHb0A87ZZAmLm3j/cMXQUmN6Ba3ALaab8e
         fQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597285; x=1781202085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niiDq+FrdndFbib0XcxUBpiQEuQyYsWQAOjlvRNMMQM=;
        b=NnaL5PpNO9GVrCUve0kKHVc4fX8bxxbh2AHEUSCBn6iar3Qt8YSvtZFa4LZbBioukS
         h7iB8NCUgO6zMoyb2uJlLMcdjE07RJYZoCu4h8NPrfo1QbSAhWrpvqVi6Z6VXFfxfJYX
         MRgVudcI5p7HjEG6GQeCETmBUlR83gvYnmqyFfrf4G3l1+P96iXmpY9scYpaDphw7Guk
         4rDAyanwhDmR4CXkR5poDHFQoX2TTy/CfdFz3Zrokrhc99IAYMpjt+w6bsKV6TsLkAyI
         9SuwSAL4hZC1oXtxJB0uAGqaDDza9o6ILMpzWp8/jue31zUvWJSqVsW0PW2rMBCDqNHJ
         zhDA==
X-Forwarded-Encrypted: i=1; AFNElJ9yceB8JF5SrSpanGMf3PR+roouO3H/Jvh2RGf8MoFiKX8a4JIai8zX+UMFlh3f8e5a1Q6oVLBC0pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueOBV58mbpTN3rBCYYLDksnt/oKenl7M63+Y8QRvbQLih2jub
	Vzx1VGlQD9ci8yVs/PPluyieiOhrXfq7uA/BudWY2hanme7dZqpYtUOjtTo1h7oy/xZ4u4uxa+m
	ydA==
X-Received: from plbjz14.prod.google.com ([2002:a17:903:430e:b0:2ae:41d1:278d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74d:b0:2b4:5aff:de60
 with SMTP id d9443c01a7336-2c163fa48efmr102370015ad.22.1780597284995; Thu, 04
 Jun 2026 11:21:24 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:14 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-3-praan@google.com>
Subject: [PATCH v8 2/4] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

While every PCI Function that implements ATS has an independent ATS
Extended Capability structure with a Read/Write Smallest Translation
Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
driver to configure the STU on the Physical Function (PF) before any
any Virtual Functions (VFs) are created.

Currently, pci_prepare_ats() bails out early for VFs, assuming that the
PF has already been correctly prepared. However, this creates a potential
mismatch if a VF is subsequently prepared with a different page shift.

Update pci_prepare_ats() to validate that the requested page shift (ps)
matches the STU already configured in the associated PF. This ensures
early detection of incompatible configurations and maintains the kernel's
policy of consistent STU sizing across all functions associated with a
given SMMU.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 679a3c3c1d54..9cb23780093d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -73,8 +73,12 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	if (dev->is_virtfn)
+	if (dev->is_virtfn) {
+		if (pci_physfn(dev)->ats_stu != ps)
+			return -EINVAL;
+
 		return 0;
+	}
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-- 
2.54.0.1032.g2f8565e1d1-goog

