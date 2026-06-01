Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9121FE471
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324616; cv=none; b=Cyt7gKioJQcoeHZSWUOYcRMTeYBWL4xXfOZ60cGych0pxeHZ0h5VpQTDMW4E9mCKi42Db3zusWYu1pQIGHlgfBfBMv7AzYC/TrlkQBuUQTt296zA1nhOqkIfZC8YoZSmgUolCHSuCjTGqG8osviR4UtwfX/XsGON1chI04d5J6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324616; c=relaxed/simple;
	bh=j7uWcfmh8/AWow0GpSjwBM2W8CoLXjCsLXTc1fs8K4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8zdMIQ7i2I4fB99HfKzqpkpFb0WT1652cNzabJBvh290qdp4EH4UumhCGtAJDgjf/Bd00dbGPg3H9NFxjblpkJCNKtxlmFWL2hI51IR44t2ChrlQVnIZszhUidjd+6vItODRsu8v4Wq6Hgx0gfo+W54aQID1vq3WQsU0UTDAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtVpGAzc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtVpGAzc"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so1062048a91.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324615; x=1780929415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3NEMqkb9FMkJODx4KCoMPC9Bib26rrCy6qGt3/6ySA=;
        b=XtVpGAzcNJsSUUUhc8qrSZDgoYvPUX1PWfFiXTGTr6vp0TeWQGsisMt/217ki6OY4W
         NcsppRuqxRivNyXSlDFaW0cJVmS0b22aNN3pzAjMV1gR4upmeeyhd6V/bb61rRiC9Eas
         GYlfqpS1yVHS9cXvomfdnynPo5emslD1zRLnazAAStjUrvLAif2DR+ZL3Wt6fD5eg4Pp
         J4EzSv3O03rQUCcNhTIieHOfVjFO/2BeiRiDhi6aL07QTCVwG2RSTQw3yY1Dys7dO7E8
         FjOqkCVtbpMcm1f9WyntqwK+Ct7RS5DLu85VUjjFCriTTP6xHt8zuZClC52JLl4cQIXL
         aFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324615; x=1780929415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3NEMqkb9FMkJODx4KCoMPC9Bib26rrCy6qGt3/6ySA=;
        b=HztWovikjb7tvzV4T3dpe9hhjp7oR0DeFU1rnjyusdfgrhqh0OIbuJPqXfzY03gYtu
         n4UtA0adnVeWlUrXtrIGgmaEMF04/zBXaU5bEfYVmthTeQNv52CHkiKgu4z/Ld5JD6Ho
         gLUlal+42xQJ+9nWhFAcfalIduKvMH8sh6zvHFcdBAbvz/22uwNeFjv6/dMC07aiheJC
         5MboXGh+AHyxt/bQY1FowH4uw5FlnvGcmHmzXKaeNN2SDRNPxhxMwessAbZKpCZ2upM9
         Ljoi1/t2WhD7R8ysekpJU+DjBxM3tSd5UYVXDJ9NW2/rDVNEfgJH8U0XbFiN5+PFV/7Y
         Hi/g==
X-Forwarded-Encrypted: i=1; AFNElJ8vJI+oG8TYIp2VojqMqPmhWC6e1f3QmmNhYMCCm7dOriV5c3XEfhCqc+AMAa06ZPX4wpHEAZl3EYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ws3vKgc2SWm7vafg/kCWj162nVYmawwb2bQdUdpTrTRyA4da
	WwifA054fccS7DH5aMJGc3nASdctlGhcLfJSxBCmTXXW3Iv5b/qic+FA/afs2ZYAAvz0Fv2+Ugo
	QBg==
X-Received: from pjpo14.prod.google.com ([2002:a17:90a:9f8e:b0:36b:28fe:916f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:590d:b0:36b:b3f4:d574
 with SMTP id 98e67ed59e1d1-36c68482266mr10917424a91.25.1780324614861; Mon, 01
 Jun 2026 07:36:54 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:43 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-5-praan@google.com>
Subject: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
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

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54c7f1ae3a84..dfb2b0d2d2a5 100644
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
2.54.0.823.g6e5bcc1fc9-goog

