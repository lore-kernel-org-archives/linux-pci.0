Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58506443C24
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653562; cv=none; b=kgq0rF4ZwAbArl8WRSzUp2VvVA0F5KNToomfhm4MyvYvz0QhBvxyQHd+pow4RDkhJF7rZRIHdjbvSqZBci5y3oCOw2PsLyvRmJjeZYqoxsNEOyZJ6PK61TvssaoM/t8j5wOpNssEHaUmXqjzXK3gkm3t65G4J23Tk2I4OYqJKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653562; c=relaxed/simple;
	bh=xKzOlxV1mbMqlPwZGhd+MrehSrrNxk9EFSUjk86veO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PJ72gZUC6u5w4pjWr9cUGOlNDys6pL0g9jyyBg/+i8Lunsnh1e+uHwV3dG95OMrhVpsOB5KOFUQ/DmuxUkMgRNta4ngIU15QU2oufxkYVk0rgsd1Vcbpcv4UTxQbI8T6VdkMG0DzzWNO4+MXU0HYm5RsQg2sqACFAMs4e3wDi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqLlyPRp; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqLlyPRp"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e2c785aa62so4708895ad.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653554; x=1791258354; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIxR9gKP4j1PYg6iofZ/XK63ShN3XaQLf38quAwtMeA=;
        b=VqLlyPRpGnwf6VC5R/F2b7dnT5NJ53CXvuwEStE0M1Wqrud5cj3zkwTDz9CfL68jmC
         WylxYpe+pR0Vwk6ViXUhwQM5Xhd/PESiEmVB/D4IPbVDCL4o9RVxipgQnRmzBdoHa49O
         qN7OW7Qbw9DMXpXD1BCKMwQmX2VL82lxd/84t6ho/iHwAoFyx/MsNmxlHstGtYBWfTdi
         xUDHrhL2R31HQauWQzdBmsMp7hDUYxmCpWNQVLH0hJk13YylxHBg3enkk6xWHWB406ib
         vHebC/d5nRsd/hZ9Q+Ul3kq7KXL1A58Tx7BLMERcVv4nrUUR9WFpL/ov8uUcsbUZ24F+
         pymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653554; x=1791258354;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jIxR9gKP4j1PYg6iofZ/XK63ShN3XaQLf38quAwtMeA=;
        b=LkyzdjESKfn58v4LLHnWclFUSoZ0/XrKMDcHWsjEWcQ7acho3k0CvYvrQCX4oyINTj
         2whIDPMdsTiralEoy/G41BTqVi1UK5Ky54Sln30gIHXdi5fP4hQZydA5Ofpw6anirtdQ
         C2WL9Q8yhU5itmiW3roV0OMQLP2J96OOkmER/eON0Tu4BIGWEA7M7yl3RCjS7rY933oj
         7FfQAMFk1IsPAzZBv8inNxPvYTmFK5kXO7lADAQ9Jpz3PJcSWreL05fCL7qd+SZFTRLx
         fmEr2qttchkkec5E46Z3CBl5uJNxFxKnpkJGECi0Jn10NwztlzAvzAkOhNJNksj3lwO6
         eIhA==
X-Forwarded-Encrypted: i=1; AKwUvByTokYapS3Tux9/to3Dvwg9R/EXmhJGD04/rt2iIMol/XmELGd/Bqj93dYSlSbB1+g3dISHL/yzjx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5MkkbOQeNC7QfurMi/mDO0z9UxanhOVyA6jSEyUMrsmGaIyzk
	W2mUQW1j7G+eNLaTKfeYJwyCsC5+KZh2UeISkpqdECQgzskH6y8jJirN7q3ac0gLUcgNMCzV3cC
	SgQ==
X-Received: from pgce10.prod.google.com ([2002:a05:6a02:1ca:b0:cc7:9b89:2a8d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c1:b0:39e:6c68:c77b
 with SMTP id 98e67ed59e1d1-3a098e078b8mr13128801a91.49.1790653554263; Mon, 28
 Sep 2026 20:45:54 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:08 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-15-praan@google.com>
Subject: [PATCH v11 14/16] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
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
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable PM runtime for SMMUs having a power-domain during smmu probe.
Add a devlink between the clients and SMMU device. The absence of a
power domain effectively disables runtime power management.

Additionally, handle runtime PM teardown in arm_smmu_disable_action()
and skip MMIO accesses during teardown and shutdown if the SMMU is
already runtime suspended, as translation is already disabled and the
hardware is in a low-power state.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 49 +++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e127e3be3a6b..2a1b5ce6ff1c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4511,8 +4511,28 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (ret)
 		goto err_disable_pasid;
 
+	/*
+	 * If linking fails on an RPM-enabled SMMU, abort probe to prevent
+	 * DMA transactions while the SMMU is autosuspended. Otherwise, warn
+	 * and continue since the SMMU is always powered.
+	 */
+	if (!device_link_add(dev, smmu->dev,
+			     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
+		if (pm_runtime_enabled(smmu->dev)) {
+			dev_err(smmu->dev, "failed to add devlink to %s\n",
+				dev_name(dev));
+			ret = -ENOMEM;
+			goto err_free_cd_tables;
+		}
+
+		dev_warn(smmu->dev, "failed to add devlink to %s\n", dev_name(dev));
+	}
+
 	return &smmu->iommu;
 
+err_free_cd_tables:
+	if (arm_smmu_cdtab_allocated(&master->cd_table))
+		arm_smmu_free_cd_tables(master);
 err_disable_pasid:
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
@@ -5097,9 +5117,17 @@ static void arm_smmu_disable_action(void *data)
 {
 	struct arm_smmu_device *smmu = data;
 
-	if (smmu->impl_ops && smmu->impl_ops->device_disable)
-		smmu->impl_ops->device_disable(smmu);
-	arm_smmu_device_disable(smmu);
+	/* If the SMMU is already suspended, nothing to do */
+	if (!pm_runtime_suspended(smmu->dev)) {
+		if (smmu->impl_ops && smmu->impl_ops->device_disable)
+			smmu->impl_ops->device_disable(smmu);
+		arm_smmu_device_disable(smmu);
+	}
+
+	if (pm_runtime_enabled(smmu->dev)) {
+		pm_runtime_dont_use_autosuspend(smmu->dev);
+		pm_runtime_disable(smmu->dev);
+	}
 }
 
 static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
@@ -5912,6 +5940,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Safe to enable RPM here as client devices cannot be probed
+	 * before this probe function successfully returns.
+	 */
+	if (dev->pm_domain) {
+		pm_runtime_set_active(dev);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
+		pm_runtime_enable(dev);
+	}
+
 	return 0;
 }
 
@@ -5927,6 +5966,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	/* If the SMMU is already suspended, nothing to do */
+	if (pm_runtime_suspended(&pdev->dev))
+		return;
+
 	arm_smmu_device_disable(smmu);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

