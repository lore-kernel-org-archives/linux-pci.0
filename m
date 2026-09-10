Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6154A2613
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050432; cv=none; b=Y2i9FddJLyfa5HALdG+N/RqVo3e+Do9hoXnwOFw0NjKp1xCMWwm7JUpNei4+8yPpWKRyzKnauxzYqNX8pIHqNv79NazjIv84JIREhop6Q0Vu5X3OJwn3PGkut60vzdzDDxucXMUFOYKSeU78ybHkMZnxTiWqgIiO/aTXzheWdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050432; c=relaxed/simple;
	bh=Nd/TSx61dnRJcb82K5r+IJlVNkV8VFS+45irSLvRyZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kg4hKWd3dtF1LDMBU5vVVnbs0CxYuARy3jV7DYZrG8kEoqXnWDqEY1ClWzTl7tZHSjAtdHfZy/anYrxNtzSbwkwLYr6mxeW5I6swzTC7GnWtT79a5+vGiEvTS9xcqjvsaAc5hum6iqdOX82d+GTLY9HNZx++yxtUUTvjqN023+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZZFUqhA; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZZFUqhA"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc2229450b4so7015197a12.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050428; x=1789655228; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e6bJocx/haeARB/34yTuoF3un4Dy/cyjeIVcxgejW4w=;
        b=lZZFUqhAgUZOfV/4DL5oNB1NS5BLVYyThhWMQbZKySkMQX7skwhg0bqT7BAafrrHKv
         CfoDcAMGlpbH4QPvE/bwnwN7SETujLU4OMTqvxUaObjgFcj/VDua/HMcSa7MW9XlznKP
         NeW2Ut3bw/y4GAheDjNacDsZGvhBmn263atSK1g1OdTbMg+nVynJyFGoWRvJE+XslcdF
         tjVpqmmkjIaYnVU6Mdu4OkWrwfqp+PDr4+JvbIliJTWYCm3hLFYheoJvy90g7tOEKTL9
         YsP1Gh5spbBqqdMJFXovqIUa1u/BCCL7WC9Nxtm0bmIh0eiMkyjo4SG/bYtuG7/JUsrg
         JOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050428; x=1789655228;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6bJocx/haeARB/34yTuoF3un4Dy/cyjeIVcxgejW4w=;
        b=F96eIAApel0C7ijEjwBN4NdUyf4dXG3yMkbw5FG38IecERfX0cOvvl40nIEHi3JQZS
         2hRlnlvPt9AC7BmbpmOT2xZdeAPOEDMbg70whrD45BoZteJAcd8jCJOicCRJ/HkmJFyI
         XgSxKonCYsaVdSuP8pnOdwM8S9klU2NAyojaATGG0PnlISVIgqUA9ss/WYSnzdYxuNCQ
         etqJEqriXyeMxCjXkoEhpARD16sfXXuZCcDbrh+gDlwOfYnBM6J/hUuZtDQq9qm3qzDO
         3yoIkaWG3tnGKA1vJXj4mpdvbWizW+Td+g4IID2M+vU2vd+zvQYv67nTOLWQqlEPcVOy
         AJ0w==
X-Forwarded-Encrypted: i=1; AKwUvBzi40nUVpRsuHTbSm9wRB3KI3NpTG3GZ6q2gf3K5JccQJKEsPt6PMTER+08F0oCqpRcfL8M30CiO8E=@vger.kernel.org
X-Gm-Message-State: AFuF++m6XD8rlLxe3siLBZ3eQXiiKq/z1IMS3le+RuKkQIEFw/VZhwSb
	vHB37DbKF83FDs/iUCkrEZDths7/PVBfG0ejC0Li4ikVEJ+gV4WN3MD8VaV1Z2RdnEEzwGKbcsR
	cSQ==
X-Received: from pgdo11-n1.prod.google.com ([2002:a05:6a02:620b:10b0:cc2:2366:6edd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6110:b0:3d1:39e9:b269
 with SMTP id adf61e73a8af0-3da39b5cfc5mr69071582637.4.1789050427790; Thu, 10
 Sep 2026 07:27:07 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:26:54 +0000
In-Reply-To: <20260910142655.3281464-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910142655.3281464-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910142655.3281464-4-praan@google.com>
Subject: [PATCH v4 3/4] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the driver to call pci_prepare_ats() after checking if
pci_ats_supported() and fail the probe_device if pci_prepare_ats()
returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
a failure in pci_enable_ats().

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7f8b51c28a7e..195097365413 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -573,10 +573,17 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
 	if (amd_iommu_iotlb_sup &&
 	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
 		ret = pci_enable_ats(pdev, PAGE_SHIFT);
-		if (!ret) {
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-		}
+
+		/*
+		 * pci_enable_ats() should not fail here because earlier
+		 * checks have already verified support & config.
+		 */
+		if (WARN_ON(ret))
+			return ret;
+
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		ret = 0;
 	}
 
 	return ret;
@@ -2458,10 +2465,12 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
-static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
-				   struct device *dev,
-				   struct amd_iommu *iommu)
+static int iommu_init_device_caps(struct iommu_dev_data *dev_data,
+				  struct device *dev,
+				  struct amd_iommu *iommu)
 {
+	int ret;
+
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
 	else
@@ -2470,7 +2479,7 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 	amd_iommu_set_pci_msi_domain(dev, iommu);
 
 	if (!dev_is_pci(dev))
-		return;
+		return 0;
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -2493,7 +2502,13 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 					     pci_max_pasids(to_pci_dev(dev)));
 	}
 
-	pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+	if (pci_ats_supported(to_pci_dev(dev))) {
+		ret = pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
@@ -2502,6 +2517,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	struct amd_iommu *iommu;
 	struct iommu_dev_data *dev_data;
 	u16 devid;
+	int ret;
 
 	if (!lookup_device(dev, &iommu, &devid))
 		return ERR_PTR(-ENODEV);
@@ -2515,7 +2531,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		return ERR_CAST(dev_data);
 	}
 
-	iommu_init_device_caps(dev_data, dev, iommu);
+	ret = iommu_init_device_caps(dev_data, dev, iommu);
+	if (ret)
+		return ERR_PTR(ret);
+
 	iommu_dev = &iommu->iommu;
 
 	/*
-- 
2.55.0.1003.g10538fe699-goog

