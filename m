Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FC17B418
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672621; cv=none; b=Kfu/hy2ywagY1axEKQfaPhZwHjisx/pl0YCqwILAYtN7FxNYssGSCicKWl+pC9oqNskG2Sduj0x2sffo0IY35oFiq1gU+/aZEWKvMy9B7Z6Qy5eY81cRr1V6NIDW5OQfjV+lRzkok1rR91uakuovGoXRt2vGkU9udXfavmbZCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672621; c=relaxed/simple;
	bh=TeLGlZlGueMnnuDpyMEND3hVfU0bdUekXlmjXYYylRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HI1EhMD11hzY3ISWBfYOHHAYABRijfScrw1VF7jax7TlnBlPUg3DoMaLsE7PO5qVladIaqwqFRLc2/jMNulnOggJzg1aGlaezG1CK35w60HGFZmpJEQkM0ZbJECi/yXsxlzw8ty0EteBuqV/JmAMOdSxbOcsAThj2Nz+QeAhvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgQAniE9; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgQAniE9"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso682503b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 18:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672619; x=1787277419; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxGWxHB9t694q53I+ISUkOTr7+vIRLM1u+PIWdopAvk=;
        b=wgQAniE9wlhLw5MeuVxa/gp13bBQ5VaOHrSjsj4xDOFC2d7jALWLJvtICWXr/SwfX7
         hYK3pxsZuZJnAZsZoLfcF/SRa2VFQm5UMJFg+PKLtCiZWkLeeFOB7WmJG4n9fvjpgDu0
         GnBLQuL6Ut8M/121JjPGqNuqJoc9KgZywzqbbmDo0qhqe1cDnYmFDYe445C1zyzvVJbU
         ZnWnrHhVIDhuGRbUgv3CZfTNBfD3U1N8GiEIp5eDIvnkrSK8r3n88W8aD4EMIQqrLyng
         bHi76vKqlSE3yR8bQq5CzyNCoVEvIBwSAuNQT/Z9Ap0j/F77ANlXsRE9+gc0p7HKUToy
         IzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672619; x=1787277419;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxGWxHB9t694q53I+ISUkOTr7+vIRLM1u+PIWdopAvk=;
        b=E0Ej21Fyq4XlDB0Z4otK1Fj2tZBNdEvfIuYD1ILgpi1b52tlpkFGuQ2f90gb+vdGFk
         4HHdylzeGjx38TivkzfrvMNivJPsghXnY0Ba1IAQlyMp8/LQjpn7J+b0ztJ4nxBw04mr
         5CdxeUMTJKMVce4SMZpt6/F8wDfmj881cjWitO5abR91CnlSQIKJDkDhiCjASc5OhHBL
         UVRKsiNeYXTxWBOXpgjH2se2Hiwkqka6OAzWtUbbjM1v1GpYohSmbqR1YMc6KMTa0jUa
         VYDAA/Luym891oRnY9YH8tfKppXMRAWJ8U+9yUesDDMlZv0GKJ1P0I3J5thMKLGCBPEI
         RGgw==
X-Forwarded-Encrypted: i=1; AHgh+RqdZXk5Z6EtSggM1Cm/j/YhR1n45ygC4oWynViyYDlSuTBrUnA/uzNd4j/sLbdb7lgwLIlrX8ke5HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnv8jX8H+InXqEL4rAogHH4GSn+VBajJyp/fjAUcMoDb71n4fz
	79wr1OTY+M7cO2p2qOy9NuyRv/uRLG0ddiapbiFWJGtk70w9ccWxcKPWjxJpIZPHzCMFziZTYRb
	06Q==
X-Received: from pfbfb42.prod.google.com ([2002:a05:6a00:2daa:b0:847:8962:8101])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21cf:b0:845:cf86:9469
 with SMTP id d2e1a72fcca58-84fde26cd95mr1986048b3a.29.1786672619169; Thu, 13
 Aug 2026 18:56:59 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:46 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-5-praan@google.com>
Subject: [PATCH v2 4/5] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the driver to call pci_prepare_ats() after checking if
pci_ats_supported() and fail the probe_device if pci_prepare_ats()
returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
a failure in pci_enable_ats().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 40 +++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 808011a700de..5ccc76bffb88 100644
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
@@ -2483,10 +2490,12 @@ static void detach_device(struct device *dev)
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
@@ -2495,7 +2504,7 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 	amd_iommu_set_pci_msi_domain(dev, iommu);
 
 	if (!dev_is_pci(dev))
-		return;
+		return 0;
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -2518,7 +2527,13 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
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
@@ -2543,7 +2558,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto err_deinit;
 	}
 
-	iommu_init_device_caps(dev_data, dev, iommu);
+	ret = iommu_init_device_caps(dev_data, dev, iommu);
+	if (ret) {
+		iommu_dev = ERR_PTR(ret);
+		goto out_err;
+	}
+
 	iommu_dev = &iommu->iommu;
 
 	if (amd_iommu_pgtable == PD_MODE_NONE) {
-- 
2.55.0.691.gc56d675ccc-goog

