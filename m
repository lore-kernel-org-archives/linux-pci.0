Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972E44C51D
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653560; cv=none; b=pijYDgl8UtSFM2y0W44ecli62Bs6Z0SNwSNDmODHSQTxrcDtwbnV1htVETg/DOr5M2bpVtfd7+9qB6iiEuJOciGg5G/msET921GF63SbU17kSARC404zyE3Pz7W1bJV+67qSlTG3kyIaYS1CLMJ3uA8UkejJajhi4UBTdMbBLCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653560; c=relaxed/simple;
	bh=jQDR8KGpNrZKYirlT9iJ9d3fD/6KEDU/BJKEq+KDluo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPnxcLAqAU1PMspBwaJNUUuaDb4qLKRavDdBbgoJCZFJ7A6/zm1OPGBBZ89siWKMqy3aeXhrC3K/Tx4kS/eQZQiJi4SYQP0jLihnF387RGe1XiwGImq7rXJ3Im5BbdLHOEbl4PTPat3OeKgEbgGl5LlVUbvTnjq1J0jOlucO5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEigouDZ; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEigouDZ"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc79892d934so2759385a12.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653557; x=1791258357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfOHrQoUb0vGCPal7wCh2ahQm0IriRIShcuFqEMo6IM=;
        b=uEigouDZKcckLOeCjfhxaIQwzBP+vgbmSu/UxWlE5LcgvKOYouud4Ic8c+nI5ANdFX
         09okdrrMF51liqWM9U/9/pLvEUV8SkCtiTDdo1OP9ipkJvjsL0fVYwPG+W7yUTv7TSUw
         cRJB3BpIjUbqSu1i+q0aHavYvlKgIc3BPGdDZHAsXl8udwoKE8kkxlUgjialRhEpwO2A
         PQe5nt9WhMNJ6xVHMV4CgOOErxrt7v3a4df2vqJlGiixhEtSUqeLWgGZQKGrr24UeRQr
         pmHR+Rb2WoIZZ9VNGTvnrKCKfxB9TW8yWuypwj+JUIv74brfRK2aoBn5UpxsvE7UI2xP
         wNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653557; x=1791258357;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfOHrQoUb0vGCPal7wCh2ahQm0IriRIShcuFqEMo6IM=;
        b=skvBerQ78EuAZjzzUcmA5rvav5clPEn/VbHLlNlnAZBbEM8p6+fzD06cYXcMpON3aX
         lO53XSugUoSlLKqz/7OYkbvVVhN8u2oqJv95evYyRkvoyGy2ZzsTsJMEayUH4RlEHBFs
         xfM0ygwNAj7Qu4uMgJj8N1nQ3+jfL8S3S877tX0+sK57seBbKR5yOea90iW8OzvWI7UV
         gmcq4T6hG+EEScip9dlYUXLXsyworW4JPh6osHEUWPtjiqbAYcvdl44R+8BxMQWrUL2q
         VOGo7FYGFQQRD9gWhNOe64OtlXmJJ8IwYcXPxrJq6MnFkRP48/mRO9/PtcW5EoYHIQ85
         uRGA==
X-Forwarded-Encrypted: i=1; AKwUvBxNdnZAu9wsosoUxHl9hkY4aCkptal8Qnes2iRxCuJq7eq0Ye83SClJcBQBjU1aFZbMgCBfFRXqeZk=@vger.kernel.org
X-Gm-Message-State: AFuF++lgQtofk44OV09qQWto1j8xAiK1J7kaf3qCHHfghJelDudBbNpA
	p6djHGx6O/fEBKsEzJhobBunVKGEIgrPq8rFeAPRkLTyKhOAi6Us04CRrNJKBC2+bLVZm5no0fA
	M/w==
X-Received: from pgdg6.prod.google.com ([2002:a05:6a02:51c6:b0:cc7:ae70:fd9f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:439f:b0:3dd:5831:ef5c
 with SMTP id adf61e73a8af0-3de26c5dbe1mr10012436637.17.1790653556991; Mon, 28
 Sep 2026 20:45:56 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:09 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-16-praan@google.com>
Subject: [PATCH v11 15/16] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
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

Invoke the pm_runtime helpers at all places before accessing the hw.
The idea is to invoke runtime_pm helpers at common points which are used
by exposed ops or interrupt handlers. TLB and CFG invalidations are
elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG.

In the threaded interrupt handlers (EVTQ/PRIQ), arm_smmu_rpm_get_if_active()
is used to avoid sleeping and deadlocking against synchronize_irq() during
suspend. Because device links guarantee client devices remain suspended
and cannot issue DMA until the SMMU has fully transitioned to RPM_ACTIVE,
no client-generated events can be received or dropped during transient
states like RPM_RESUMING.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  20 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 163 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 3 files changed, 175 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 25982bdbcbd9..7150b9c497a4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -15,17 +15,28 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	struct iommu_hw_info_arm_smmuv3 *info;
 	u32 __iomem *base_idr;
 	unsigned int i;
+	int ret;
+
+	ret = arm_smmu_rpm_get(master->smmu);
+	if (ret < 0)
+		return ERR_PTR(-EIO);
 
 	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
 	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
-		if (!impl_ops || !impl_ops->hw_info)
-			return ERR_PTR(-EOPNOTSUPP);
-		return impl_ops->hw_info(master->smmu, length, type);
+		void *ret_ptr = ERR_PTR(-EOPNOTSUPP);
+
+		if (impl_ops && impl_ops->hw_info)
+			ret_ptr = impl_ops->hw_info(master->smmu, length, type);
+
+		arm_smmu_rpm_put(master->smmu);
+		return ret_ptr;
 	}
 
 	info = kzalloc_obj(*info);
-	if (!info)
+	if (!info) {
+		arm_smmu_rpm_put(master->smmu);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	base_idr = master->smmu->base + ARM_SMMU_IDR0;
 	for (i = 0; i <= 5; i++)
@@ -39,6 +50,7 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	*length = sizeof(*info);
 	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
 
+	arm_smmu_rpm_put(master->smmu);
 	return info;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a1b5ce6ff1c..89ffa8346478 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -121,7 +121,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
 /* Runtime PM helpers */
-__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -137,7 +137,7 @@ __maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-__maybe_unused static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
+static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
 {
 	if (!pm_runtime_enabled(smmu->dev))
 		return true;
@@ -145,7 +145,7 @@ __maybe_unused static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *sm
 	return pm_runtime_get_if_active(smmu->dev) > 0;
 }
 
-__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -1186,6 +1186,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 				   struct iommu_page_response *resp)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	u8 resume_resp;
 
 	if (WARN_ON(!master->stall_enabled))
@@ -1204,6 +1205,23 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 		break;
 	}
 
+	/*
+	 * The SMMU is guaranteed to be active via device_link if any master is
+	 * active. Furthermore, on suspend we set GBPA to abort, flushing any
+	 * pending stalled transactions.
+	 *
+	 * Receiving a page fault while suspended or suspending implies a stale
+	 * event when the master has already powered down. A lockless pre-check
+	 * on STOP_FLAG avoids taking the PM lock if already suspended. If active,
+	 * arm_smmu_rpm_get_if_active() atomically acquires a PM reference under
+	 * power.lock, avoiding races against concurrent suspend and rejecting
+	 * responses during transient states like RPM_SUSPENDING.
+	 */
+	if (!arm_smmu_is_active(smmu) || !arm_smmu_rpm_get_if_active(smmu)) {
+		dev_err(smmu->dev, "Ignoring page fault while suspended / suspending\n");
+		return;
+	}
+
 	arm_smmu_cmdq_issue_cmd(master->smmu,
 				arm_smmu_make_cmd_resume(master->streams[0].id,
 							 resp->grpid,
@@ -1214,6 +1232,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 * terminated... at some point in the future. PRI_RESP is fire and
 	 * forget.
 	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 /* Invalidation array manipulation functions */
@@ -1739,7 +1758,6 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			smmu, &cmds,
 			arm_smmu_make_cmd_cfgi_cd(master->streams[i].id, ssid,
 						  leaf));
-
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
@@ -2050,9 +2068,9 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 {
 	struct arm_smmu_ste_writer *ste_writer =
 		container_of(writer, struct arm_smmu_ste_writer, writer);
+	struct arm_smmu_device *smmu = writer->master->smmu;
 
-	arm_smmu_cmdq_issue_cmd_with_sync(
-		writer->master->smmu,
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu,
 		arm_smmu_make_cmd_cfgi_ste(ste_writer->sid, true));
 }
 
@@ -2460,6 +2478,40 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	/*
+	 * Use a non-sleeping get to avoid a circular dependency deadlock
+	 * with arm_smmu_runtime_suspend().
+	 *
+	 * When using a combined_irq, the suspend thread waits for pending
+	 * threaded handlers to complete. If the IRQ thread blocks waiting
+	 * for the PM core, it creates a deadlock:
+	 *
+	 *  [Suspend Thread]                  | [IRQ Thread]
+	 *  pm_runtime_suspend()              |
+	 *    state = RPM_SUSPENDING;         |
+	 *                                    | IRQ fires
+	 *                                    | arm_smmu_rpm_get()
+	 *                                    |   sleeps (waiting for suspend)
+	 *  arm_smmu_runtime_suspend()        |
+	 *    ...                             |
+	 *    synchronize_irq()               |
+	 *      sleeps (waiting for IRQ)      |
+	 *
+	 *           <==== DEADLOCK ====>
+	 *
+	 * A non-sleeping get allows the thread to instantly drop the event
+	 * if the device is suspending, safely bypassing the synchronize_irq()
+	 * deadlock.
+	 *
+	 * Devlinks guarantee client devices cannot resume or issue DMA until
+	 * the SMMU has fully transitioned to RPM_ACTIVE, ensuring no valid
+	 * events can be generated during transient states like RPM_RESUMING.
+	 */
+	if (!arm_smmu_rpm_get_if_active(smmu)) {
+		dev_warn_ratelimited(smmu->dev, "client device is suspended, dropping event\n");
+		return IRQ_HANDLED;
+	}
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2480,6 +2532,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2518,6 +2571,18 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	/*
+	 * Use non-sleeping get to avoid deadlock. Devlinks prevent page
+	 * requests from arriving during transient states like RPM_RESUMING.
+	 * (see the detailed comment in arm_smmu_evtq_thread)
+	 * Page requests require active client masters, which are held in
+	 * runtime suspend until the SMMU is fully RPM_ACTIVE.
+	 */
+	if (!arm_smmu_rpm_get_if_active(smmu)) {
+		dev_warn_ratelimited(smmu->dev, "client device is suspended, dropping page request\n");
+		return IRQ_HANDLED;
+	}
+
 	do {
 		while (!queue_remove_raw(q, evt))
 			arm_smmu_handle_ppr(smmu, evt);
@@ -2528,6 +2593,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2582,8 +2648,40 @@ static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
+	irqreturn_t ret;
 
-	return arm_smmu_handle_gerror(smmu);
+	/*
+	 * Global Errors are only processed if the SMMU is active.
+	 *
+	 * When the STOP_FLAG is set, the SMMU is disabled (CR0.SMMUEN = 0)
+	 * Any errors captured during the quiesce/drain phase (suspend)
+	 * will be handled by the explicit arm_smmu_handle_gerror() call at
+	 * the end of the arm_smmu_runtime_suspend() callback before power
+	 * down.
+	 *
+	 * During resume (RPM_RESUMING), the only operations that could
+	 * trigger a gerror are the CMDQ invalidation commands which are
+	 * only issued after the STOP_FLAG has already been cleared.
+	 *
+	 * Thus, no legitimate gerrors can ever occur while STOP_FLAG is
+	 * set. Any interrupt received while !arm_smmu_is_active() is
+	 * strictly spurious. Hence, returning IRQ_NONE correctly signals
+	 * an unhandled IRQ without missing any valid hardware errors.
+	 *
+	 * A lockless check is favoured here over a dynamic PM core check
+	 * since the runtime_pm_get_if_active would return false during
+	 * transient states like RPM_RESUMING & ignore level-triggered
+	 * interrupts.
+	 */
+	if (!arm_smmu_is_active(smmu)) {
+		dev_err(smmu->dev,
+			"Ignoring gerror interrupt because the SMMU is suspended\n");
+		return IRQ_NONE;
+	}
+
+	ret = arm_smmu_handle_gerror(smmu);
+
+	return ret;
 }
 
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
@@ -2666,6 +2764,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	struct arm_smmu_cmd cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
+	/* Shouldn't hit the WARN if there's no devlink inconsistency */
+	if (WARN_ON_ONCE(!arm_smmu_is_active(master->smmu)))
+		return 0;
+
 	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
 	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++)
@@ -2912,7 +3014,16 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 
 		if (cmds.num &&
 		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
+
+			/*
+			 * Concurrent suspend races are benign: the cmdq allocation cmpxchg
+			 * loop acts as the serialization point to safely drop the batch
+			 * without MMIO accesses. Concurrent resume is caught by the HW
+			 * reset cache invalidation, ensuring state consistency.
+			 */
 			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+
+			/* Drop this batch to ensure the next one's fresh */
 			cmds.num = 0;
 		}
 		cur = next;
@@ -5116,14 +5227,37 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 static void arm_smmu_disable_action(void *data)
 {
 	struct arm_smmu_device *smmu = data;
+	int ret;
 
 	/* If the SMMU is already suspended, nothing to do */
 	if (!pm_runtime_suspended(smmu->dev)) {
+		ret = arm_smmu_rpm_get(smmu);
+		if (ret < 0) {
+			dev_err(smmu->dev, "failed to resume device for disable: %d\n", ret);
+			goto disable_pm;
+		}
+
 		if (smmu->impl_ops && smmu->impl_ops->device_disable)
 			smmu->impl_ops->device_disable(smmu);
 		arm_smmu_device_disable(smmu);
+
+		/*
+		 * A PM ref was only acquired via arm_smmu_rpm_get() to
+		 * guarantee power for the MMIO register writes in
+		 * arm_smmu_device_disable().
+		 *
+		 * Drop the PM ref, we intentionally do NOT invoke a
+		 * synchronous put/suspend here since the HW was already
+		 * disabled above. Calling put_sync would invoke
+		 * arm_smmu_runtime_suspend(), redundantly attempting to
+		 * do the same. Any pending autosuspend timer is cleanly
+		 * cancelled by pm_runtime_disable() immediately below.
+		 * The core code ensures the power management here.
+		 */
+		arm_smmu_rpm_put(smmu);
 	}
 
+disable_pm:
 	if (pm_runtime_enabled(smmu->dev)) {
 		pm_runtime_dont_use_autosuspend(smmu->dev);
 		pm_runtime_disable(smmu->dev);
@@ -5965,12 +6099,27 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+	int ret;
 
 	/* If the SMMU is already suspended, nothing to do */
 	if (pm_runtime_suspended(&pdev->dev))
 		return;
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to resume device for shutdown: %d\n", ret);
+		return;
+	}
+
 	arm_smmu_device_disable(smmu);
+	/*
+	 * Drop the PM ref acquired for the MMIO disable write.
+	 * An asynchronous put is intentional here as the HW is already
+	 * disabled (CR0 disabled), and the system is in the middle of
+	 * reboot/poweroff. Initiating a synchronous runtime suspend here
+	 * would redundantly disable SMMU and delay system powerdown.
+	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d0a3d497915c..a018913d3bb8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1249,6 +1249,9 @@ static inline bool arm_smmu_is_active(struct arm_smmu_device *smmu)
 	return !Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
 }
 
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

