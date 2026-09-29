Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D74334C5
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653552; cv=none; b=FNy5bS2DqprpRo76fYOTwNFSqSZKOa+nqtYmmZxq3WeTYNZuPsxkeg/FhRCNaGaPJ5+GT1K+XU4sURORbaK6xvRjcmeR3bdJv+V9/SRQhLHakO4UnRyZB3C8v9WpJVadI5x5LGJcEr+lNbazH7iYZF/KMZTFTHiv4sJReeEE1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653552; c=relaxed/simple;
	bh=Gb31fIvFOmJDnn3TQarQeSRrzRTD9iLRZv0TB/VL/Y0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYcAkz8+/DGZz/XA4nSva1/KroXnECBUcz7qZmT81fQopW+9tcVz1vBiBkjEGX2hnNL2FxJXmuDq22OELroDE1DXXhHHt7x/y1jibIIEmePc8/sr3o1380ilx/edsYJrGcg1q0eylIVc+mHAL5Yn3slgeSPHkO8GwwLVF/BsjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjpyNKUK; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjpyNKUK"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so4254412a12.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 20:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653549; x=1791258349; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1UoDLaUSVrQDcp8js+xQqVPvK9lSKlk7fepU02SFQA=;
        b=ZjpyNKUKDIdCerewyEa6HsmdJ5BuQfH0wzspT7vyf1NgyX0HWCeXrVNGN8gG5eJEGA
         O8GkCxnGpGHUaMkgFV1MAXqSc/4Lb8RLTyz2xf5vqGzmqoSVveUWHYjMb4C6PRZ9pMQ7
         +QVI4J6hvsfONGXqACaCT3rjeWLORdqvEKB+o/Oga/y0PGF70Ut1hDgmDC/7clOMwMhd
         NgUBkaUWJpsYyys86t1GUrUrrifpTBgyO1pdeyUfVB/ojVJad8xyJj+1A7eTU2TZtWxr
         wdlSYbibVOI+jN8if7w/sMVQlvDc10esaObJCMJtg5AlPmPGFPZHvf1YAxB5prOFU0pJ
         WJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653549; x=1791258349;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1UoDLaUSVrQDcp8js+xQqVPvK9lSKlk7fepU02SFQA=;
        b=DJLJY5msjcw2sF2oRua5dY3sG5gmQrcqiWyHi3ieLytNv9WMQA41CNneioEAot4Y4Y
         jD7VSbmiaFuZ9r1+WQ5IEttt4QbtMQlsxktZBNofy++Veel9GiQQYwZiVarUB2v7k/tZ
         jo56nEnepl4o5uz4wykGjL571rvuI5oq980gLV9zKVtBgbofdiUcp4Ls7ZfokELY4x8s
         R+mot8l2UYoftiIFY+5vtzbvy0rFpy74x+QliQ/Pr4shMdCk3yk/86BVU+3gnDjMWslF
         t98KsJN7DJyGE5LCCa3wLZK/uJbKUbklBXQ5QJqwTgRrwlZgQR07k6BR1XI6fWACcd+y
         9/nA==
X-Forwarded-Encrypted: i=1; AKwUvBy9EF/hjwL5bjzwN69Fesw+CDnVaYbbFfmNARJX9HbuD1KJLKY24Go61/rbg3eANVcEKm24kKZn5xw=@vger.kernel.org
X-Gm-Message-State: AFuF++lPBworfNOl8o6j4q1p71gH3uJ/olFUQJkFDXvANog05lQiDA5U
	enAa/hMLIbJiCLQK1TabQda90tU8pf5PkBFHccV9guGjZUuV2JZbC5ze0vwFK2NQR4OFm71wV5b
	xhw==
X-Received: from pgww22.prod.google.com ([2002:a05:6a02:2c96:b0:cc7:ade4:5f77])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c90a:b0:3dd:85a9:55a9
 with SMTP id adf61e73a8af0-3de26db3254mr10142499637.34.1790653549063; Mon, 28
 Sep 2026 20:45:49 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:06 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-13-praan@google.com>
Subject: [PATCH v11 12/16] iommu/tegra241-cmdqv: Add a helper to quiesce VCMDQs
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

The tegra241-cmdqv driver supports vCMDQs which need to be quiesced using
the STOP_FLAG. The current driver implementation only uses VINTF0 for
vCMDQs owned by the kernel which need to be stopped. Add a helper that
sets the CMDQ_PROD_STOP_FLAG on these vCMDQs.

Consolidate this logic by renaming the implementation hook to
quiesce_and_drain_queues and ensuring that the tegra241-cmdqv driver
gates all active local virtual queues before starting the drain loop.
Additionally, clear the STOP_FLAG in tegra241_vcmdq_hw_init() as a part
of tegra241_cmdqv_hw_reset().

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 77 ++++++++++++++++++-
 3 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7f89e2306942..89a4e756ff17 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1077,8 +1077,8 @@ static int __maybe_unused arm_smmu_drain_cmdqs(struct arm_smmu_device *smmu)
 	ret = arm_smmu_drain_queue(smmu, &smmu->cmdq.q, true);
 
 	/* Drain all implementation-specific queues */
-	if (smmu->impl_ops && smmu->impl_ops->drain_queues) {
-		err = smmu->impl_ops->drain_queues(smmu);
+	if (smmu->impl_ops && smmu->impl_ops->quiesce_and_drain_queues) {
+		err = smmu->impl_ops->quiesce_and_drain_queues(smmu);
 		if (err)
 			ret = err;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 794b258550dd..0a841441cc44 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -896,7 +896,7 @@ struct arm_smmu_impl_ops {
 	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
 	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
 			  const struct iommu_user_data *user_data);
-	int (*drain_queues)(struct arm_smmu_device *smmu);
+	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index c7989fcd2c62..61847f2802a3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -447,6 +447,54 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
 	return &vcmdq->cmdq;
 }
 
+static void tegra241_cmdqv_quiesce_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
+	u16 lidx;
+
+	if (!READ_ONCE(vintf->enabled))
+		return;
+
+	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
+		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
+
+		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
+			continue;
+
+		atomic_or(CMDQ_PROD_STOP_FLAG, &vcmdq->cmdq.q.llq.atomic.prod);
+	}
+}
+
+static void tegra241_vcmdq_wait_quiescent(struct arm_smmu_device *smmu,
+					 struct tegra241_vcmdq *vcmdq)
+{
+	u32 target = READ_ONCE(vcmdq->cmdq.q.llq.prod) & CMDQ_PROD_IDX_MASK;
+	int timeout = ARM_SMMU_POLL_TIMEOUT_US;
+
+	/* Wait for the last committed owner to reach the hardware */
+	while (atomic_read(&vcmdq->cmdq.owner_prod) != target && timeout) {
+		udelay(1);
+		timeout--;
+	}
+
+	if (!timeout)
+		dev_err(smmu->dev, "vintf0 lvcmdq%u owner wait timeout\n",
+			vcmdq->lidx);
+
+	/* Wait for queue lock to be released */
+	timeout = ARM_SMMU_POLL_TIMEOUT_US;
+	while (atomic_read(&vcmdq->cmdq.lock) != 0 && timeout) {
+		udelay(1);
+		timeout--;
+	}
+
+	if (!timeout)
+		dev_err(smmu->dev, "vintf0 lvcmdq%u lock wait timeout\n",
+			vcmdq->lidx);
+}
+
 static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -467,6 +515,21 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return 0;
 
+	/*
+	 * Gate all vCMDQs by setting the STOP_FLAG in a separate,
+	 * initial loop to ensure no new commands can be submitted
+	 * to any secondary queue while we are waiting to drain them.
+	 *
+	 * Client devices are suspended at this point due to devlinks,
+	 * ensuring no concurrent command submissions race with this
+	 * drain sequence.
+	 */
+	tegra241_cmdqv_quiesce_vintf0_lvcmdqs(smmu);
+
+	/* Ensure all CPUs observe the STOP_FLAG before draining */
+	smp_mb();
+
+	/* Now that all queues are safely gated, drain them sequentially. */
 	for (lidx = 0; lidx < cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 		int rc;
@@ -474,6 +537,9 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 		if (!vcmdq || !READ_ONCE(vcmdq->enabled))
 			continue;
 
+		/* Wait for the last committed owner to reach the hardware */
+		tegra241_vcmdq_wait_quiescent(smmu, vcmdq);
+
 		rc = arm_smmu_drain_queue(smmu, &vcmdq->cmdq.q, true);
 		if (rc) {
 			/*
@@ -489,7 +555,7 @@ static int tegra241_cmdqv_drain_vintf0_lvcmdqs(struct arm_smmu_device *smmu)
 		}
 
 		/* Avoid consuming stale commands on resume */
-		vcmdq->cmdq.q.llq.cons = vcmdq->cmdq.q.llq.prod;
+		vcmdq->cmdq.q.llq.cons = vcmdq->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK;
 	}
 
 	return ret;
@@ -566,7 +632,6 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
-
 	/*
 	 * HW Registers reset to 0 when power-cycled. Restore them from their
 	 * SW copies to prevent executing stale/ghost commands after resume.
@@ -574,7 +639,8 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	 * to the Guests since the relevant frameworks (IOMMUFD / VFIO) hold
 	 * active PM references preventing suspend while VMs are active.
 	 */
-	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.prod & CMDQ_PROD_IDX_MASK,
+		       REG_VCMDQ_PAGE0(vcmdq, PROD));
 	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
 
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
@@ -587,6 +653,9 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 		return ret;
 	}
 
+	/* Clear the CMDQ_PROD_STOP_FLAG */
+	atomic_andnot(CMDQ_PROD_STOP_FLAG, &vcmdq->cmdq.q.llq.atomic.prod);
+
 	dev_dbg(vcmdq->cmdqv->dev, "%sinited\n", h);
 	return 0;
 }
@@ -963,7 +1032,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	.device_reset = tegra241_cmdqv_hw_reset,
 	.device_disable = tegra241_cmdqv_hw_disable,
 	.device_remove = tegra241_cmdqv_remove,
-	.drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
+	.quiesce_and_drain_queues = tegra241_cmdqv_drain_vintf0_lvcmdqs,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
 	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

