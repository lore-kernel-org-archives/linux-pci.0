Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7735E1A3
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999852; cv=none; b=UEdI1MhowLbOtMzSkoW60SgC4hQCwg28zSqFYodReMIHuRVHprw7xYP87M5UrIAVSnZU3QzZtpr6V+9zKihJOVJ1ZI49qiZpl8tcj6k2wd030ZPXW8gafix0kFimmk4sm0VJtItZKk/HuijaQFDkTOax50tmcdb1VpXbtPPZFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999852; c=relaxed/simple;
	bh=rCPBs6VpzFnSeGV1IQONO9sqLS2eG7RrmNxYtsUNeyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9KaQ2mwoFeyIVu52OqNvoH4v1cRxocIQzkF9YBNxuy3PZS8WYzHBRNaslRLrG5/LJqnWYoX2gaLtC1E64YaG55KNC94Uwd2EJyqXTx3xp+Gn0ZCu+SShPwSbHaDuYdjHw4iT9aGvizRkSEm1Tugc+ffarS6gTU8GHQtGopAE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHWlUVgn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHWlUVgn"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so366380a91.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999850; x=1780604650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=mHWlUVgnf+i6tgAJL5mZDPBOwkgpBVSahNHXwBM7D5WLWK9/gZEmPiHt4nV2+S3cSR
         WM2826vfIgQpNCITrjF+4IPF8G+lbSeJnqCsyyG5m+UQEMRoY9s2xog5Vw2gWhizxqNP
         hgl+Qw0+D0T6D2eRfDyrC7tPfwUiWH7cvr5fa08ORpC+q6kS6rgL4bkcxZcEqyVNcV1U
         EbGWZuDWGnylPqBULLuCOIJsv+iIxjlj/8THlmfxvhf7IP23CH5vu38EmN3H7Gvi5IlX
         eg36xh+7azQkKWCfROcvF8bZ2NvzvTtDfuabDdKTO6fdvO5yaXnEZqH0mEHxBwyaY5az
         DMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999850; x=1780604650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=F3aDZVrNEYv9j8UCLmk129DZam1rvcYBBSJ0Wh47aFqfF5vcioM+i6I6JDRuscea4D
         mowj2J7oNo1FTwhP3ZW9EPk2RnmCC4v8SXQXzGyilZnsm1/ClawqQg0MHNzgIDe7w+I2
         7Li/UJtaXt4dnDMs45/Pi7w67bztj2/VGqrccV4tt/mNR+1Ex0eIScly+mE53ImizeCb
         YUUOeEfHBaHfRGsDFFg3G45q3GMICXGmdvQrT1FIAcgaOGXs5jbKm0U4ZfiXIm2k4NQl
         IuhsgkGpXte7vGAoNe7Egb7vupQsvillthN1MZobb5ng+8N1p9nqHoXNIeoteeBeR9Tr
         C5bg==
X-Forwarded-Encrypted: i=1; AFNElJ8q8S9EmbbdToEgozEGNIueUqQ82rZXU9NBjTKT7BSibjGfJVztTm3Lo9mmS3BZ3DUugpDbld1A8YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVuhECGZ/LvU3mP0/5qBjCN0RkN8mNAM9lHedQCU4QhJZx/Qx
	pFtQqoyHt6xRqcMgDe8flKrl2sGDaw2o2gzx9F+b0DN0bMyTU/BzjVIjvGF5GhRrzP77Rx1NC80
	3UA==
X-Received: from pjbbb14.prod.google.com ([2002:a17:90b:8e:b0:36b:bdb2:1426])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:586b:b0:36b:abe2:bc82
 with SMTP id 98e67ed59e1d1-36bbcc16bb4mr121972a91.1.1779999850016; Thu, 28
 May 2026 13:24:10 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:53 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-8-praan@google.com>
Subject: [PATCH v5 7/7] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the AMD IOMMU driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update pdev_enable_cap_ats() to WARN_ON() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Fix a pre-existing Use-After-Free risk by ensuring iommu_ignore_device()
is called on all probe failures after iommu_init_device().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 84cad43dc188..b74c4504bee3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -570,10 +570,16 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
 	if (amd_iommu_iotlb_sup &&
 	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
 		ret = pci_enable_ats(pdev, PAGE_SHIFT);
-		if (!ret) {
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-		}
+		/*
+		 * pci_enable_ats() should not fail here because earlier checks
+		 * have already verified support and configuration.
+		 */
+		if (WARN_ON(ret))
+			return ret;
+
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		ret = 0;
 	}
 
 	return ret;
@@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	else
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
 
-	if (dev_is_pci(dev))
-		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (pci_ats_supported(pdev)) {
+			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
+			if (ret) {
+				iommu_dev = ERR_PTR(ret);
+				goto out_err;
+			}
+		}
+	}
 
 out_err:
+	if (IS_ERR(iommu_dev))
+		iommu_ignore_device(iommu, dev);
+
 	return iommu_dev;
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

