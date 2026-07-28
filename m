Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1113FB055
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273420; cv=none; b=M8PMMGNqqRjQ7EkD3zALFdCVSI0fhU5aHDHtLJ7KJM3U6FaqDkWT1xnO6K2XR+jLh5P3VnmmybDVINWT9x7fWRA6tyCRplbVG0SCTx7a6bE5W+nymK3byxGOgttzMa+URuWunbuQsu3bcAZld36K1BN/CWyXblXX2PNciN54dzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273420; c=relaxed/simple;
	bh=rYYKfO7fr8tCeIBgfW8VCHWFR3LOeVGgcB0gu3vWhJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrYuEYZB9mg/ODy/oi06g07uA+gqCQZnpYfha9ncdN8Lw0gY7qTwu0pV5v6BVa2Eu8XRP86afA2khrnvcvLtnNIeMrdtxX3pJsvArROwBhYbE0bDtDhWmqvuR4XxAa9orfPdkph25+uWoLgjXhRV4otdmmIdVZ5zXoFku9aq/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqxaPory; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqxaPory"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ccdf36f63dso43295ad.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785273418; x=1785878218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QYFlnlGtzGaTmpuO49iDLUfMpOme9Z4x8j8IG4rbPjY=;
        b=bqxaPorytheSUf/PkJlrbI8DGghgMaM8JQsHAF7c0WGI5D9BJRcj2OMZmZt8g3mbFu
         k+Ps8WKfUfBHCT7FbP2UVq1e+JvqeoFjKiTzYXJ6mP8KJoY9F/tzQ4s+gvRgNOdj30Jk
         ELf/zlJwhNJCdIYfqohLhVdPMzpkSllE82vjgzllfvpfgFL5xJ4oLvn1flO+59u7y3M3
         5R7XVu5rkOJFlbcg9/IS1uz64UqN/PUEZe0fVWz9sTIqZM59BKN49701z4Ka6Zc8jIdS
         duIbBWU/iqaOfr31VCdZ/jzqEZTtRPMd0hBmKB5PTFHGUFVD0pZe4vx/eCnJrnI9A6cT
         On2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273418; x=1785878218;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYFlnlGtzGaTmpuO49iDLUfMpOme9Z4x8j8IG4rbPjY=;
        b=cBv8hKbhF+NqHnMa6w2DYE/WX9vIkebf9NYammvJPwLAyQY3WKC2N3W9ePuJlgAEHU
         EvRJ6/6/xTUs08e+/FMitqXX7VxW537L7KjUBSMIwLwg2WyE/IGkGcRTXXNQEq2aKaC8
         BHUu/s5LS4EkdnMuWCq8cIyBq+NwiXY6lAaBvbXfoSsZak+x/05lhoC0sZy+EEkmj7zH
         VZXvqt7VaMVGivdkbTt/qddolHDKBSu/9gFmkqz08/JDTIVQSnfaONS5Z/Q2YkU9EFxh
         Ze436nplFwDnXNcQ0T9XHsQVcWHYXXELWxLAyjlrqbnC/sVmaDS5agtn4FFPxKDvmi1e
         NUJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCo9lRU94xX/SUIYN2ft/9R1wgapSYDP1bVA879dfGRKv+TSbJew9SXPucljfgtynAjcT6ZDZFQCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxgZNWFwSa+3OITKRxK8PW7BR43KQhAoZIy9/gn8gLS89gOct
	UZ2qxFpvQwgD0DniwJsC8MfvX2wPr5Pp9gzg/8JvzP57Itkq+dQQk5HlHlgj1tHYiQ==
X-Gm-Gg: AR+sD10UPfSTyd0hY5KmnhOwqyZJGS92S/DHPHkKMPTPSo6eSpzaZaRdiut10PWtsHg
	5v/HwHrVMfAgzGq0zu7fnktxbAfZSC9X1BTCW5wtQVn0+QoPRfubvLtU0W1YwUv3hu21I5Yl4Fq
	4zUcB7wS1NRTNagG3Ygmxd7LdmN0AOwGNsfS99RVPdmPkFibM/Od1GIU78veKQhRbaGUbYAwQ4q
	B2Ztey/1Dq4bomxmeiS+ulwBc+yEUKvj+WHnvQTsbhZQ9YPEUKt/H/RzyFpUVQNq6h30Jfj7dT+
	v/rEF59prEj9dIqn0YAp92zjcf9k8xmzvaGIdwJF9UanoIr4lCKNVmBIbo1xo+RnuCIF7OHmu/Z
	L2VklN/a6bHirqHEjpBRFL34NJm5uOx6EY6mHf/+mV3sqO/etnIhra2jvNBr4s+Bj64FEI+LeFs
	ze7u0vvsRRBReGvpB273IToz/xVJICIKxEjb6/bdohss4V8ISlpaVyV3dCmSGqF9UrTYDZXJV4M
	X0clxsEBA5Zi8gB1v/fAFk=
X-Received: by 2002:a17:903:1a03:b0:2c7:b1e7:501e with SMTP id d9443c01a7336-2cfde09f0damr13311135ad.3.1785273417527;
        Tue, 28 Jul 2026 14:16:57 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c2d5a4sm1779895ad.71.2026.07.28.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:16:56 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:16:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	bhelgaas@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <amkcQRVylEe_t-yP@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>

On Thu, May 28, 2026 at 12:59:31AM -0700, Nicolin Chen wrote:
> A poll-until-empty form does not converge on the shared EVTQ or PRIQ since
> other masters keep advancing PROD with unrelated traffic. A fixed snapshot
> bounds the wait even under sustained unrelated load, since the target does
> not move with subsequent enqueues.
>

[...]

> 
> This is a prerequisite to apply bug fix calling iopf_queue_flush_dev().
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org # v6.16
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index cf41b3cf5985f..4794a15f351c4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -894,6 +894,33 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
>  					   cmds->num, true);
>  }
>  
> +/* Drain an SMMU EVTQ or PRIQ to a PROD snapshot taken on entry */
> +static int arm_smmu_drain_queue_for_iopf(struct arm_smmu_device *smmu,
> +					 struct arm_smmu_queue *q)
> +{
> +	struct arm_smmu_queue_poll qp;
> +	u32 prod, cons;
> +	int ret = 0;
> +
> +	/* Snapshot PROD; entries [old_cons, prod) are the cohort to drain */
> +	prod = readl_relaxed(q->prod_reg);
> +	queue_poll_init(smmu, &qp);
> +	qp.wfe = false; /* No SEV on EVTQ/PRIQ PROD advance */
> +	/* Read MMIO each iteration; llq->cons is the threaded handler's */
> +	do {
> +		cons = readl_relaxed(q->cons_reg);
> +		if (__queue_empty(&q->llq, cons, prod) ||
> +		    __queue_consumed(&q->llq, cons, prod))
> +			return 0;
> +		cond_resched();
> +	} while (!(ret = queue_poll(&qp)));
> +
> +	dev_warn_ratelimited(smmu->dev,
> +			     "queue drain timed out at prod=0x%x cons=0x%x\n",
> +			     prod, cons);
> +	return ret;
> +}
> +
>  static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
>  				   struct iommu_page_response *resp)
>  {

Hi Nicolin,

The following is a unified drain_queue helper, that also attempts to
address Sashiko's concerns. This applies on top of my runtime PM v9
series [1], please see if it works for you:

Subject: [PATCH] iommu/arm-smmu-v3: Add a unified arm_smmu_drain_queue()  helper

Introduce a unified arm_smmu_drain_queue() helper to replace queue
specific polling loops. The helper handles both snapshot-based cohort
draining (for IOPF) and full queue draining (required for Runtime PM).

The Runtime PM explicitly gates the CMDQ (via CMDQ_PROD_STOP_FLAG) prior
to draining, this allows a single, snapshot-based target to natively
handle all drain scenarios.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 68 +++++++++++++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 +-
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9106ffb75f7a..2deed6e3bf9b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1057,39 +1057,70 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+static bool queue_consumed(struct arm_smmu_ll_queue *q, u32 cons, u32 target)
+{
+	if (cons == target)
+		return true;
+	if (Q_WRP(q, cons) == Q_WRP(q, target))
+		return Q_IDX(q, cons) > Q_IDX(q, target);
+	return Q_IDX(q, cons) < Q_IDX(q, target);
+}
+
 /*
- * Currently, only used for CMDQ.
- * TODO: Update to handle PRIQ & EVTQ when PRI support is added
+ * Drains a queue until the consumer reaches the provided 'prod' snapshot.
+ * For CMDQ, the consumer is the SMMU hardware (polled via MMIO).
+ * For EVTQ/PRIQ, the consumer is the CPU IRQ thread (polled via software llq).
  */
-int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
-				    struct arm_smmu_queue *q)
+int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+			 struct arm_smmu_queue *q, u32 prod)
 {
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_ll_queue *llq = &q->llq;
-	int ret = 0;
+	/* Secondary CMDQs don't support WFE*/
+	bool is_cmdq = (q == &smmu->cmdq.q);
+	u32 cons;
 
 	queue_poll_init(smmu, &qp);
+	qp.wfe = is_cmdq;
+
+	do {
+		if (is_cmdq) {
+			cons = readl_relaxed(q->cons_reg);
+			WRITE_ONCE(q->llq.cons, cons);
+		} else {
+			cons = READ_ONCE(q->llq.cons);
+		}
+
+		if (queue_consumed(&q->llq, cons, prod))
+			return 0;
+
+		cond_resched();
+	} while (!queue_poll(&qp));
 
 	/*
-	 * The events are only generated when CMDQ becomes non-full.
-	 * Thus, wfe can't be used here, mark it false explicitly.
+	 * Check once more after timeout: cond_resched() could have delayed us
+	 * until after the timer expired while the consumer finished draining.
 	 */
-	qp.wfe = false;
-
-	do {
-		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
-		if (queue_empty(llq))
-			break;
+	if (is_cmdq) {
+		cons = readl_relaxed(q->cons_reg);
+		WRITE_ONCE(q->llq.cons, cons);
+	} else {
+		cons = READ_ONCE(q->llq.cons);
+	}
 
-		ret = queue_poll(&qp);
+	if (queue_consumed(&q->llq, cons, prod))
+		return 0;
 
-	} while (!ret);
+	dev_warn_ratelimited(smmu->dev,
+			     "queue drain timed out at prod=0x%x cons=0x%x\n",
+			     prod, cons);
 
-	return ret;
+	return -ETIMEDOUT;
 }
 
 static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 {
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	u32 target;
 	int ret;
 
 	/*
@@ -1097,7 +1128,8 @@ static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
 	 * from contexts (like suspend) where the caller has already
 	 * ensured that new command submissions are fully closed.
 	 */
-	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
+	target = atomic_read(&cmdq->q.llq.atomic.prod) & CMDQ_PROD_IDX_MASK;
+	ret = arm_smmu_drain_queue(smmu, &cmdq->q, target);
 
 	if (ret)
 		goto out;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 15b5d5fad627..eddf6f41b570 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1176,8 +1176,8 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
-int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
-				    struct arm_smmu_queue *q);
+int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+			 struct arm_smmu_queue *q, u32 prod);
 
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
-- 

[1] https://lore.kernel.org/all/20260728210928.1050849-1-praan@google.com/


Thanks,
Praan
