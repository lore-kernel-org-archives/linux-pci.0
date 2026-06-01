Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A45374E46
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324614; cv=none; b=obYBANg+1IIdS+Z+acLQQ+2ZVwcM3mjKVaK2Sez6cIaNom9e6PDPEOpc/2QKiB0Fby2iz+BG/5RPjiyag3bX9Rikufdw6p9/Z8LIMmRnnl/6XJVFQM1IWs5SDhQzuk05ztHBkhYEmjVgNMOcifAsBSG9RLRHfs1ssfdBGwQJyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324614; c=relaxed/simple;
	bh=ZY1CHI2qLE7gvcNu09TeXmB6q3EuV2tMfE05QxQiulQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IABWHiZdjZ25Bd4S+vhvjqSj2d5IzX0HN58+ERV0U7t0Mb6jrnniHp/2znt7kYNdUy91M5FiMGpJrkQc4jSVryy+u2xIQmgmIxURKyURQb5jV+AY6hKjcYAnUscEYlA8YpTDDNFoEUk+y4+jYzxP1zbm41YkAxW6nsjHQDZFH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3lcZCDl; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3lcZCDl"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso1325226a91.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324613; x=1780929413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1VlFw02VkFXjGZD0LXM1rfEtalYzEU51knuxCZNQpI=;
        b=Y3lcZCDl1kDBStCHLH0UqlGSbpkNQUnS3rQrug9CN6eEE8nHQM1XNzajFokwXhaoPr
         cOkDxPSTcbzmAlf+xA+3jao8A/coSRnQdV+hL7pHG7CdEJpkpklq4iOWYvLqKqXFD8KV
         ovDf/bRBUSAxDOzSvjLqnR89wZjNDjsbynb7skFYi591ymsRKtGP7lIfuhtY3YzOOXBG
         UILNPdcGQ4lJuj40Bbr9GTdrcvrTCkAIctuL3oy8dG+NnUV5a1PRsay0goSTxnWZ32jP
         KUIFfR+4SnC5+I5jVGR+HJCWwG5hku/9plBR4JtLya804bEI/UorurMAyMrQ9h7pkF08
         oQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324613; x=1780929413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1VlFw02VkFXjGZD0LXM1rfEtalYzEU51knuxCZNQpI=;
        b=NNbMoChWYAkeIwIiXTe9wOSAPI+RhWq30VxNr7oFeLyB1QJiX4MZrLfsFYpPm9Jk0p
         h7JiQFJ01ZwdKZhxdtcPEILF+AjeF67GqNlAubNduXCEEQiHdv6Fh5ZOtBucqzAptRmo
         mPTWfDoa7/pVRpwPrwTQ5rD1vPzvv7kYLbKxa26UXX70ly9EADpGRQhcY3okpt7NrEHj
         tUvQ2Ss6JGKMQANzOMhEeyQ7kCaxdnpYNjnR9tyAyhcBwTn1hVPNO8pwfmI1JoHFxxjl
         2krCMpuANcl59p0bj/PxokW+VqSVF/xTubE9qC5LrpEZfyKHVKyzamp4pHd9mOBRs7Ra
         v6pg==
X-Forwarded-Encrypted: i=1; AFNElJ92/kobp+9VgSRPmGJZ4i8cqkld8B8mHMtaw4jtBGL1aAKslE5txYlht+JwwPcNiUDfy9m0PpGBkoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpo9z4clP1AJZOMfhUPaXzkMevUXulGKMLM+nvZxbAr4j8Ax5h
	hkd0AjgpkAVpEfyLiif27GE4sIRG76kYKY3YgbxaFwEw9OwUrVkLTuMVA4cU5bpzHhfogqIXvli
	RAA==
X-Received: from pjnj13.prod.google.com ([2002:a17:90a:840d:b0:368:eea2:5650])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c84:b0:36b:9faf:8396
 with SMTP id 98e67ed59e1d1-36c4ff6b3cdmr10066002a91.11.1780324612870; Mon, 01
 Jun 2026 07:36:52 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:42 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-4-praan@google.com>
Subject: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Clear the iommu->priv to NULL while returning an error from probe_device.

Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error handling")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..54c7f1ae3a84 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4206,6 +4206,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 err_free_master:
+	dev_iommu_priv_set(dev, NULL);
 	kfree(master);
 	return ERR_PTR(ret);
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

