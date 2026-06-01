Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CF63AD53B
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321344; cv=none; b=ujCcLjwnPW7g8bNiIn5sfMWCw+bpOAUdvzb32pmGFvNrP6oQDWaXjKa4WbGtK1y4Z19CcL5kljMrGPaBacJaYhGy2BoOUwQEoDLfeuAipslkczaR5hlnTvbXo0VHsyKIsUdbW8xTkcBexvF1gzkp6aw+XWSpNU3BnYw0gDSjGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321344; c=relaxed/simple;
	bh=auMnztirMjgLsVdaqQpnSuNWy8GRXz3WqB05wPcZf6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0oTaT8wJsN7gTx9JdxOm0bKAuj4Ch5DTZ05ONZToVvpVEU/YGUL3jHWLh6rg1N3hPO5h2BTwF63W0hNXPAT0Fp6G5vrjaqLT2sysmJkl1EvDIKo90R1hymvv2mpLvK604HPVzdUfT/U0OjickRtglCuPU0qDS8VhG2wPQIjQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQmGk23B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQmGk23B"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so2664600a91.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321341; x=1780926141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6BZcslBAGGRXzQms4jp3f5RHV26tlAI7OzQzhdeIE=;
        b=hQmGk23BcpWUBPxfvnZy7P2eoVl05awEdLzS9CvorwM7aMoBOHBfg3GKYBjTrtJmjX
         cg2f8nVo12qfQHvCKNAoAxz1EMZbAHjewsHf7cXLpqIWfqkc+YzGtkplHiB9PEjpwq/0
         Mh4HxfbCIale0w2ADxwUWa4xtzyH11ELrVxOI6ZuyPleKnV9iSumH6OKwGud9E+rQ0/9
         W9mnkVC65UR65bqKW7EjyyJM5BAZW6Gw3RSUE/ZRIvNhY+YUYWTQGn7rZVin/XP1+EAw
         Q+725GT3e7Jfs8CY0akY+h4Li4sD4wKBfxCEwr9N8Jcsyna3K7iqQHI6K8LqOGZn3/8x
         dTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321341; x=1780926141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6BZcslBAGGRXzQms4jp3f5RHV26tlAI7OzQzhdeIE=;
        b=qELG4mCgq/ZmCM+/KicZoc9Y/0tto+aCDUTlR7R2wuGse5bD9g61O+Sx7H5zSCL88o
         o23lT3YbsY7cE2ymu+IqoQ9hnKLi5aFUPtgUrZ0y5XUW+R/V7Jbt5OuZV1Xz6TdpVlvi
         7E5SW6Om1n0YTWhX/IltGQxEONBLHqWE34TDOY4YBAHblYsNlUh4oyFgmfq0vaxMo1sq
         fIjnrx4fIcz1x3JN2FgwP2t3l38ZQftoEgw806zCltyWatdE9a66KnrJ0KtqrsR4S+lK
         Yotb1nRNGkg79XaUY8t9nDpd95XFp7Tt80Xi63Exm7AbnlUMoGbPIi3I0Pzi2wO9fSE4
         zOmA==
X-Forwarded-Encrypted: i=1; AFNElJ+rJwoU8/iAdy8AxRShHj4uyYB7r5C9oc/Hv+9FOhl2dPJO4jiBgXnep4j9eAgIB31VFHuRiL2w/iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoV5WZwqySqdwFBRNpRtdf98aniDcgaJdUZEUofwADOzF4Jmxj
	dkAlxFA3kLSaS6jcrJzcsCWoA5yub2X3A9aWgsCyoLLOqkuo9zUb6tiGWjTAquo0uHHck7EwFtu
	3Ww==
X-Received: from pgbgc5.prod.google.com ([2002:a05:6a02:4b85:b0:c85:80d8:9229])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8213:b0:3b3:f46:1f0a
 with SMTP id adf61e73a8af0-3b427f5bd3cmr12362565637.42.1780321340582; Mon, 01
 Jun 2026 06:42:20 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:03 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-6-praan@google.com>
Subject: [PATCH 5/6] iommu/amd: Fail probe on ATS configuration failure
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
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4ef6024c5a4e..783f53cb8599 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -566,10 +566,17 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
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
@@ -2514,8 +2521,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
 
 	return iommu_dev;
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

