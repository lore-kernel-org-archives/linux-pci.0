Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5409B41F35A
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653544; cv=none; b=DRhn9b0B0KoDsLIVmPt/RZPb53u4RGNo/9bdYKRn4zlCvEalMS61kq8m/oj/eCByRNUrfzppZAfn958SO07ptxR99bwsj06ZtPanJLnoV63C97327OsTuFSOZ6vfRUXFVwCvre3PDmDo2o6vY4bWBzNQ+adx7yZuOrRX4gw7yPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653544; c=relaxed/simple;
	bh=rAWcJCCi9A6gOKRWLlYQUftC1yte/SSOlRW13UF9bXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=boxdEvYzecF9ohfB5BVLIUePWyXWqJOsEchG1vEYK9X49yQfkYMtqR+xZIYPpD0t2r+jK426uj3PiOjMm1Tk1Dul26AfOTaKIL0pshTnsYcNjbc4vh2OY44FLSkJjTe4dlDV6cLXVdgWUAm+ZIejTx6ZBS7Dyfa/koXH0Ng5kWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3xOJAiY; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3xOJAiY"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso5561279a12.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653541; x=1791258341; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWQbzPnJHI/UQ6xRoFaSMFgVnf7una/rhjMJI3MVJUs=;
        b=c3xOJAiYJn/H0KP2MbTzcwR/RMumzuNPOvcaY/FB93FIUN/wkwX7+ZQiS0HmCTRnog
         oVOTEn6bdub4oenhg+T4SAhVVfRs7mxE6hSEKj5St4CQpp12ejyXccnBVy/CTBhU80D3
         AKrj2vtgYLtnhSVyamqSooPALVCzrpLUe7MeuLdqAd+fDAZSUJhjxeISOHILpzowc/1f
         sPu9s6CO1w1dSOKIyAB9LEdCEXdE13DHMxq2chPXrDe9QzMTsA5Q3HBSN4CndVhKWGMU
         NQ7+ZJFU9d87RsHnS6Mwos8Sm+h6L408C7ONZSDIjui3RZJjXKV/TCnhCiLdevEkwahY
         b9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653541; x=1791258341;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWQbzPnJHI/UQ6xRoFaSMFgVnf7una/rhjMJI3MVJUs=;
        b=ygXP1HIKoKM7dhjPGb5UUafc/WNK4WTbCMjm+aCthsMgyGKJRcl5LXsAbcuYJOcuoz
         3btdtb41TyAe5p8V2VLJsSN4aDu+qApkskKxjId3MNrgCFiYdiQufD4wwzYFSxxOOlgF
         DPevpBUbnhWEWc/hwaDOc0Znqeu0FumD8QIwWrvyM7oT82I2wEQVbM3fyNrkTo6TXddw
         NzH4ZID9txY9avmg0NmdGZnePzd0rI6vroL/DBqNbtHKwXY9K/CiJCSE9JXCO8nqVtEF
         U++2vJgI9MdCGWc0RU+Tv+RpKClof2AZYzUR8BeY64v6zYeDx88BhuYh8A964zUFiaDc
         MT+Q==
X-Forwarded-Encrypted: i=1; AKwUvBx09DVbkbhB0ofa+3BWNDXSOr2RZtvu5qagQDEW3DJYysJ1I+uKSznGX4a5Cj3iW8IzP1cCP/22d5A=@vger.kernel.org
X-Gm-Message-State: AFuF++kpnMfRQCWHdTOginAZd+a6ZhZm7bbS5Ej0W4056+Q0C/mUQmQM
	uzAeUtPGOhg0zjWPTKdMmsyNztpRzzotBLcREQxl1imNQVKNJq5booJ3iKtJcIuno599ZHJJqdm
	/2A==
X-Received: from pgc13.prod.google.com ([2002:a05:6a02:2f8d:b0:cc7:4d12:8a9a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4324:b0:3d1:e510:9052
 with SMTP id adf61e73a8af0-3de0e6f3973mr13463950637.7.1790653541112; Mon, 28
 Sep 2026 20:45:41 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:03 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-10-praan@google.com>
Subject: [PATCH v11 09/16] iommu/arm-smmu-v3: Restore MSI config on resume
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

The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
address, data and memory attributes lose their state when the SMMU is
powered down.

Introduce arm_smmu_resume_msis() to zero the *_IRQ_CFG0 registers (which
reset to unknown values) and restore the cached MSI messages across the
device's MSI domain via msi_device_domain_restore_msi_msgs().

In addition, clear ARM_SMMU_FEAT_MSI if MSI setup fails and the driver
falls back to wired IRQs, preventing spurious MSI resume attempts.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dc2fc02b5163..7347d3ecdae8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4779,6 +4779,19 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void __maybe_unused arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	/* Clear the MSI address regs as they reset to unknown value */
+	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
+	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
+
+	/* No-op if no MSI device domain was instantiated (e.g. wired IRQs) */
+	msi_device_domain_restore_msi_msgs(smmu->dev, MSI_DEFAULT_DOMAIN);
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

