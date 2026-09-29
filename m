Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9562841A91C
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653546; cv=none; b=l4V4YLiKGHRiu5wTqiaOYcMRu9ZqMEo5kehXrLAYqBQY/exBpEkfbdRzRl9DpnBOpR++FxpJmZ49PJrMd2IScxnh58FY8IdIS2gD0RANTbZmAYgKoyMYJFLqRmYeAb2XD6lZMs1qVaUsR6UhfevCW+ieQkJd8sZZaSZIogiSWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653546; c=relaxed/simple;
	bh=uZ6gY/m1/uNPwW0ngnSZ50aeviMaNpqsykMbkfZBHTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgqlTWBlUrPJvayCAhGj1TawGKemcYkLKfxerA4vm2n4hjtNx5s6OP0A6F9kjMgIbpZ8ZZRYAOS/zvXQhTEu+qxaVorHoIUilIWwrEAuGv/jtGphXhTCbNf2+aFWiUG+IMMablRS4MDNNK/Hax3REqGEhVwI+GWK99JnunApmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKTY0TjD; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKTY0TjD"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc51591102fso2532088a12.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653544; x=1791258344; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pamITFUcwnp5TeeHCBPmUcU036kd5Sty9zaNaR/GKjI=;
        b=rKTY0TjDeAi2v4qGy0uAf8o2QUh2x9zmVMS3EPwf4JUh+4ypn1Z9VFjaQeWevhuymm
         2R4LJszNoR7ZT1cjSx7CHB5m1we2SkT2bM2vWd2MuaMrW2vKsXySfrwUpud2a56Uba+a
         PPReRHER15pgI0wxCBJD2Qucek8TSwq+rSvHEt/XQQfOVTy2MfxaZ0RuRhr6yDLVdAlF
         GY7IG5Zx+Vt+lyAoRG9mfaVv4qU9P3UqdI41fmYNdoNU+/+ckF5ec5l1QjWZf2JTvahh
         /YRfFXZJeDXSuKaHislIVrP5bpS8WGRlmYrznhXfW9mryQ63y4FdzzqLlwMaTtIbDcF7
         u7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653544; x=1791258344;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pamITFUcwnp5TeeHCBPmUcU036kd5Sty9zaNaR/GKjI=;
        b=t5L0eHSza3Fpybjy2k484qFi0uknizDI8oujcS/gTWj+KP9iOqcil6tuG5SZCkPELg
         AeQa5xSwwFMyD6agqRy8Q6PFUGlrzjg+5SlHpw0s3Xjmp16bGEmivO6z6ww7vER/TcgH
         STDxrzbrSn5tSTUOEq5ESLwdvkRhVZxfq3Oi9tlDx6SFfm5+ZsCPzzQRFPVEf8HFIvgV
         WvvCOhfje0n69cYUWDvbIIFQs8k1J1ZF2LgnoSzJb2JUXJHKk8wJXf9WuAUbqMkX0xFx
         jyt8WFB6Ol/+UFTImq1ub2QD5spVRTnEfWhNhVBylzRid9mJV43KO+9ph342emmyQURO
         3mRQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4AgVOw1Eqre78bEDbK847pll7gboSDxcnv9Ri8GDUB+tez4AEv9xUyb3dflWR+9u7sKhh8enwkxE=@vger.kernel.org
X-Gm-Message-State: AFuF++mWymhXDHTaHIrHEcjOiBmAsofNSvwlJUo4BF3FVzkPrjY0KMyx
	IUz5z2ehE+oQvi3y2MwZ+pA9NQVdZ6iqcp3EduIRLPVzpkZrVHuNFrS57rFL5qXNL18gAWueI3b
	LoQ==
X-Received: from pfbdl3.prod.google.com ([2002:a05:6a00:4903:b0:884:2224:5f7d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244f:b0:3de:6873:84d1
 with SMTP id adf61e73a8af0-3de6873856fmr3745913637.74.1790653543715; Mon, 28
 Sep 2026 20:45:43 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:04 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-11-praan@google.com>
Subject: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out arm_smmu_handle_gerror()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The GERROR register's state might be lost when the SMMU is powered down
during runtime suspend, requiring the suspend sequence to handle any
pending errors before the hardware state is lost.

Refactor the gerror handling logic into a helper function. Subsequent
patches will invoke it from the runtime suspend callback after disabling
the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
before the hardware state is lost.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7347d3ecdae8..a123810fac57 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2406,10 +2406,10 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+/* Lockless; must ensure that there are no concurrent callers */
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2452,6 +2452,13 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+
+	return arm_smmu_handle_gerror(smmu);
+}
+
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

