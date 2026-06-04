Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F7388E72
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597290; cv=none; b=PJTYjlMvcQoqtD8CB7j/fO6gNdnYRCSiQwEJTNW5g/NQQZErCjXpRZOhzelws6t0P5WezHoPZVSbknFZJZ/kR9j85RDALVg+kfFK/oRweO03fKeMelCOiFnvN4TM4/Yes8mvSthnx8RQ1dNatO1w7mfeGrq4J5s6VIq9ZChIsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597290; c=relaxed/simple;
	bh=ZsPtTr9xybmFV3D70USnSwdOFmyW86rzFy9C9TDJ8kI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Znw133PfnYBgKIBuhRrQshNjtkDjx0DOxDGam/ilUHmKCi3emHygGxA9E1qZJOC70PsVC9CmpCR6lSGSQR/HDoOpfWGQp+eDVD26SeMBnpbQ/PHWjN/nGRefu6zjIPwYKnXdqp2cpl++QEp8Toh/LAujC2zGRIiF/cr0z0U+17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6oPidh4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6oPidh4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b7c55406bso788929a91.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597287; x=1781202087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnO4GCpu3n+4CrPeKm18ejA4A5n6TmnDYVIYtLJbRE=;
        b=t6oPidh4h4g2rgXFMQdtCxS7OEwArQzaIFuMUPcWJzMq/z0pSabvkqtrZVBapQ0wrL
         hkI20TRuCkt95uRBfRW6wpQTljUakxCGDg+hSnW2y8imaRpUFmtH4p9OVQXvuh8fHiYD
         9pSeK9hrXr7+UfZ99Yy1h41HUtCNESmqeFcsPw1E+De4lxMAqIcAx+nc5JJeYnpIDxsh
         cEXejTu9JDAN9dNJL6u0xcdyCYOfvGZHtQOk2PfKl4VGrMJ4q/VMCP+9BfFH9Wd+zHAv
         JJcMCrIBTwOsGlkw5H+N4O43RUOnA0iCoGOPqMgscNI1xrdqzYl6ZmkhbZnUC9/d6CjD
         cdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597287; x=1781202087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnO4GCpu3n+4CrPeKm18ejA4A5n6TmnDYVIYtLJbRE=;
        b=VOH0beO5Gbmw5PZ2Wh7rBcavg4tNIHn2Jn9dh6eA5sYb39PL7FCHjfmmuTIUjncnFG
         fSt903iBUACdM+1lGigecgIhnoGIHGMkfvzS2U/ldd6ZgGnHE0EGmjuKBvTQgTViZ+uy
         3BUeNDhBjnpFyBKfTj+UQ0NLfa7Ygw/pVcAkiGfd7b0aXFkU3HTvUR/7+sACoTNykElG
         B8gUo4OU6BgGX/8BZDKcrtupw7O2cdrUV/F0YmzJDDqUkHBIqb2DobzfRtUP/nTgUlMc
         Si/5yvhAwO5EFln4Zy3T86sWRpyn/sOAJdkq5jEgeuOiWjlNtEj4jkFYHlpTlc//P2qE
         sIFA==
X-Forwarded-Encrypted: i=1; AFNElJ88KNARE1iZxvg22TDRjV6Np1THIePUL2MWW5gKK5txRAmx2afCNprw2o3LRF2s/jWg2ElDxbdv758=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYr6C9hxuIm8ihTTho5ojKffat/dhn1IBZasrYw+sEbVJY6W+5
	sb1ZOF0lVJKlS4TVnXD9NQFoGGovhCYDULNDZlx/0Q+6UiJnUU63sbXvtslvfDC53auuFzGN4tU
	RvA==
X-Received: from pjbbv3.prod.google.com ([2002:a17:90a:f183:b0:366:3a03:b66d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2706:b0:36b:ad81:c134
 with SMTP id 98e67ed59e1d1-370ee928d34mr155578a91.10.1780597287064; Thu, 04
 Jun 2026 11:21:27 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:15 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-4-praan@google.com>
Subject: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
WARN_ON(). Since probe-time checks now preclude configuration errors
any failure during hardware enablement is considered a kernel bug.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..0494c68daa19 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
+
+	 /*
+	  * Since pci_prepare_ats() has already verified the HW capability
+	  * and programmed the STE, pci_enable_ats() should not fail here.
+	  */
+	if (WARN_ON(pci_enable_ats(pdev, stu)))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-- 
2.54.0.1032.g2f8565e1d1-goog

