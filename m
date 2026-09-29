Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E7427FB6
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653549; cv=none; b=AAPiNWtYCXL0SABe8Fq59hB72MXfigYs9Eo7NebvmB+8hOjrySBi/ol8yfdpPwoL/agiCLqcBrNx0uwz6JZ8ticbS/2/FTfv0HBhwIVOmj1at4fO7BTdgL8z0WsSmf02yzQavbWue8RfUeEwxuxso0Izss3jXjDzeT4XzQ6UXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653549; c=relaxed/simple;
	bh=emN7DAxtSRLF415z6jBFS1BVT82Ombe4VPgOdgIfbVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UeJiNaaH59tH7sXyNgiP9j4AGyq4lcaMXWmWlQ4jsXrAlaIZG6DrlmNtQyUVg2NIc8gwBQja8kbf1wHXY3HyB2qh2iu6q5C+vGEig50ZjL7vZWgSuAL7OQGDARbJGM/FAlzJNKzOrkl7LLh9WNGNypDmAQZ+za5ZwZZOG5Ause8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOCwsQxq; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOCwsQxq"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc79b966c51so1193258a12.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653547; x=1791258347; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJUc8W66LdXd5niQlho6vVTddWB/e8RRGn6UCJy7ACg=;
        b=GOCwsQxqdyIXirXzgGoj+9nuGcbeM9taIC6m5ob5HMGb2y2JzwP9cXG2zgUkKhwzLU
         eiCIxAh2AfftNZMmLvnFDiuDeq6J5jjUTQB7vDhjWW864Aif8u9lz0vqKJGkmhNpr1VA
         tClcnt/6kUQPpaCcBewiH9s6Qx5GwsTl/qHpmXmeTES6V/4W/dIfoIFmVTzmObROtPUe
         /54IyXjDefYxufYT2maPgcf4XaWuUdITm0HjmSzwJrSJ4lN6D2KYPJBLKSWknN0ilMen
         bPcvea/UzuSvDqQ6yVuJQksePP7iAoDcUTfgtujK/zA0igVZjSwFGkO7nthr9gWaaI8c
         TdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653547; x=1791258347;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJUc8W66LdXd5niQlho6vVTddWB/e8RRGn6UCJy7ACg=;
        b=rWBbWXW1R3fEuSLUXb2gA4Y8a7TkDIuiMJQcziPtEuG0Pvt6tFr2cnMJONDxq+UXHq
         Jt1VLac7AJLmplc0MeKl2yci97s2oqLUy6TMOoSnt5cPf/a12j//MLKiqXlg4XY7bd3X
         o853uqWH9IBUw8o/5OfTX8gSErEyjBDmJkWxEa8izVRuBEDE6raB1tFv/5qeeI+NzsWU
         aWRQYhWw/2SzIn/aPoewwLtObPMDYh3ImCQ2TM1staKehA5JCWRReNkyW3CblvYl8t/W
         uNu/3UpVvNPfbdG8rN8hoq0AvHNCqdVrui/XGmBl9B1djuVF1d42lIlSB6+C/iaabgCQ
         o4MA==
X-Forwarded-Encrypted: i=1; AKwUvBxwCYs9z/SKtrBVwNvU8xd2orPZ4gag0NIw5RMj4bcDgD9cSd0sjJK/IgjDM79xCJWmxQjXNE9x6bM=@vger.kernel.org
X-Gm-Message-State: AFuF++noWnqxXUS/V2/biIgLiaX2U6h7YufeM70955EFCoUU70aLc4Xa
	KIXlCIMoZKIY7/JV+NZKCjbPa/pxtmSerPwEdRs2E9lrI8y/tBi93jKa3AEU47kiUT6CKOV8E10
	PRA==
X-Received: from pgdf1.prod.google.com ([2002:a05:6a02:5141:b0:cc7:56f1:71ad])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f06:b0:3d3:ae40:51e5
 with SMTP id adf61e73a8af0-3de0e750b0dmr13391618637.25.1790653546468; Mon, 28
 Sep 2026 20:45:46 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:05 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-12-praan@google.com>
Subject: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate
 CMDQ submissions
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

Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
queue's producer index to safely gate command submissions during device
suspension.

The flag embeds the suspend state directly into the existing global state
The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
which acts as a Point of Commitment, ensuring that no indices are
reserved or committed once the SMMU begins suspending.

This prevents a situation of "abandoned batches" where indices are
incremented but commands are never written, which would otherwise
lead to timeout during the drain poll.

Update queue_inc_prod_n() to preserve this flag during index
calculations, ensuring that any in-flight commands that successfully
passed the point of commitment can proceed to completion while the
flag remains set.

Suggested-by: Daniel Mentz <danielmentz@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a123810fac57..7f89e2306942 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
 	u32 prod = Q_POS(q, q->prod) + n;
-	return Q_OVF(q->prod) | Q_POS(q, prod);
+
+	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
@@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	do {
 		u64 old;
 
+		/*
+		 * If the SMMU is suspended/suspending, any new CMDs are elided.
+		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
+		 * our new indices yet, we can safely bail. Once the indices are
+		 * committed, we MUST write valid commands to those slots to
+		 * avoid indefinite polling in the drain function.
+		 */
+		if (Q_STOP(llq.prod)) {
+			local_irq_restore(flags);
+			return 0;
+		}
+
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
+
+			/* Avoid waiting for space if the SMMU is suspending */
+			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
+				return 0;
+
 			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
 
+		/*
+		 * If we exited the polling loop because the queue finally
+		 * has space, but the STOP_FLAG was set during the poll,
+		 * we must abort immediately. If we proceed, we will
+		 * commit new commands beyond the Point of Commitment while
+		 * the SMMU is suspending.
+		 */
+		if (Q_STOP(llq.prod)) {
+			local_irq_restore(flags);
+			return 0;
+		}
+
 		head.cons = llq.cons;
 		head.prod = queue_inc_prod_n(&llq, n + sync) |
 					     CMDQ_PROD_OWNED_FLAG;
@@ -779,7 +809,8 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		/* b. Stop gathering work by clearing the owned flag */
 		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
 						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		/* Strip all metadata flags */
+		prod &= CMDQ_PROD_IDX_MASK;
 
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index deefb17e31eb..794b258550dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
 #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
+#define CMDQ_PROD_STOP_FLAG		(1U << 30)
+#define Q_STOP(p)			((p) & CMDQ_PROD_STOP_FLAG)
+
+/* Mask out software-only metadata flags to get the pure queue index/wrap bits */
+#define CMDQ_PROD_IDX_MASK		~(CMDQ_PROD_STOP_FLAG | CMDQ_PROD_OWNED_FLAG)
 
 struct arm_smmu_cmd {
 	u64 data[CMDQ_ENT_DWORDS];
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

