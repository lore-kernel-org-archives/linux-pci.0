Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5A49EC64
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050424; cv=none; b=FZE1Q2/A5PmRbctI8GuFp1QkJfiKTgCaZ4Rzcj6Sh5Wt2biyzA4q1V5i9pKsQgb+ERwDUEyONVF8NXU0QmFxIzsMn/UMXJzMLk37ZNHOvNxl4rg96peyXId0jLq3z/mXhUSyEtKaka8gX0Z/HdafPxS4pR1/Jl+wo1oU0RYGJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050424; c=relaxed/simple;
	bh=Uf1Mg8lC343lrJXvoIgHa/B0FLZkPDMfcU2FIL1W/tU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYOswQ/gNkP36OMx1A9+bWcPoLxWBb1TdbtvvSdJ7WsyEG+rh2ubd9O2l/fuNpeLX1kajbrbilIzDjke+6T8CYRi8rZehC/Cl8TmAgZQnhjRopj/FxHC7D199nAsUh3MV75OeQTARTBrI57rYl4yVHAVKnHqkmmonBTvpojXE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSTWOUE9; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSTWOUE9"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3b126c9fso73658955ad.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050420; x=1789655220; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VsODB2LlW2OUQJwkogRDDD6IthNc90JrH7J5IUx28AQ=;
        b=eSTWOUE9FGatUskMo+/4U9RiWsprBbNBPyEZsI9iygxHZixe5LncK/zPgclCeJYBhD
         YlZBeJ2NVmv9jgqz8fmle2gvUjMjehUCSjwTEz+F+UX980Dnbayn5ztqhJSc0bcXJaNP
         HEBbahlGTySFinFWe8zlzQ6wDf/OrkrzVy6zv1xTYn/WKj6+ln7qq0IG1JDwLzi4Ze3W
         iiJRxLPIf0IqTmHtRAjZdRNv8kvi2I36V0GlmMXQohNvfeAh40O+S2HlSDVpmS0UDiwV
         1M/DPbuVmmPCrPa4OR79oitRlvaUR19LleRzSiMmnrrQ5Rt23jDq5SLl3Agr3TtRHlu2
         HVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050420; x=1789655220;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VsODB2LlW2OUQJwkogRDDD6IthNc90JrH7J5IUx28AQ=;
        b=TB4MAEHLn1qAIkspXIOPhuShrZwjX1juki6g5z8MwwJUEFn4qEDOkz+znEqgI4Ucp6
         Pwrm/KgquUKjR1WzeKU5lHeccLPIX4mgaAW763o2aSCBjUxF7K6cahMnE3dFcD+S6yQ6
         lI9yFhaFcisnawDYFZQ0lw/0R1Q5XJmqSG5icdXe72PGvWjZkbJQwLZnUc7/Wx8tVUSD
         /sSSIAprFStvZ3jqu09Fy48hkmr19K2YPmMDUNGFupkesJouXD3GSJkPkDl5++3D1tMj
         tTzIZk2przcMK/lHnPDzGzmqhZwrUVYGV5gQ+JzIv1bzACe0q0WxLjPZp1DemP/EQ1Y3
         OUUA==
X-Forwarded-Encrypted: i=1; AKwUvByegLd1nhpiKUjUsZy6T2ARZrAcup36rc1B7xnoDvy3SStrclZrvLifgrLjPznCOX5ZmoOUGyeTq/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++m31h5UcexUdPfvxtIic9yZdtZtlrvWykjUoqJM/l0sVT6HLmIA
	gsT+SF5dRzdjCOGGf8Gf2CMpTuSdYGc4Oym60ytnlWvE/JEplO7gC4kUmZX3StiHYUcUbKnaopu
	DqQ==
X-Received: from pgbd26-n2.prod.google.com ([2002:a05:6a02:64da:20b0:cbe:efab:fa5a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4310:b0:3d3:adbf:777c
 with SMTP id adf61e73a8af0-3da3a0b7121mr62384226637.24.1789050420087; Thu, 10
 Sep 2026 07:27:00 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:26:52 +0000
In-Reply-To: <20260910142655.3281464-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910142655.3281464-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910142655.3281464-2-praan@google.com>
Subject: [PATCH v4 1/4] iommu/amd: Refactor device probe and capability initialization
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Restructure the device probe path to improve readability and prepare for
cleaner error handling. Refactor check_device() into lookup_device to
explicitly validate and return the amd_iommu ptr & devid. Refactor
iommu_init_device() to return the allocated dev_data. Consolidate all
PCI cap inits (MSI domains, PASID, ATS) into a new helper:
iommu_init_device_caps().

Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4dc306a4b5c6..5e144a60c397 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
  * This function checks if the driver got a valid device from the caller to
  * avoid dereferencing invalid pointers.
  */
-static bool check_device(struct device *dev)
+static bool lookup_device(struct device *dev,
+				struct amd_iommu **iommu_out, u16 *devid_out)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu;
@@ -690,7 +691,7 @@ static bool check_device(struct device *dev)
 	devid = PCI_SBDF_TO_DEVID(sbdf);
 
 	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
+	if (!iommu || !iommu->iommu.ops)
 		return false;
 
 	/* Out of our scope? */
@@ -698,47 +699,33 @@ static bool check_device(struct device *dev)
 	if (devid > pci_seg->last_bdf)
 		return false;
 
+	*iommu_out = iommu;
+	*devid_out = devid;
 	return true;
 }
 
-static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
+static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
+						struct device *dev, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
-	int devid, sbdf;
-
-	if (dev_iommu_priv_get(dev))
-		return 0;
 
-	sbdf = get_device_sbdf_id(dev);
-	if (sbdf < 0)
-		return sbdf;
-
-	devid = PCI_SBDF_TO_DEVID(sbdf);
 	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dev_data->dev = dev;
 
 	/*
-	 * The dev_iommu_priv_set() needes to be called before setup_aliases.
+	 * The dev_iommu_priv_set() needs to be called before setup_aliases.
 	 * Otherwise, subsequent call to dev_iommu_priv_get() will fail.
 	 */
 	dev_iommu_priv_set(dev, dev_data);
 	setup_aliases(iommu, dev);
 
-	/*
-	 * By default we use passthrough mode for IOMMUv2 capable device.
-	 * But if amd_iommu=force_isolation is set (e.g. to debug DMA to
-	 * invalid address), we ignore the capability for the device so
-	 * it'll be forced to go into translation mode.
-	 */
-	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
-	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
-		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
-	}
+	/* Wait for DTE updates to go through */
+	iommu_completion_wait(iommu);
 
-	return 0;
+	return dev_data;
 }
 
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
@@ -2487,49 +2474,73 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
+static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
+				   struct device *dev,
+				   struct amd_iommu *iommu)
+{
+	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
+	else
+		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
+
+	amd_iommu_set_pci_msi_domain(dev, iommu);
+
+	if (!dev_is_pci(dev))
+		return;
+
+	/*
+	 * By default we use passthrough mode for IOMMUv2 capable device.
+	 * But if amd_iommu=force_isolation is set (e.g. to debug DMA to
+	 * invalid address), we ignore the capability for the device so
+	 * it'll be forced to go into translation mode.
+	 */
+	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
+	    amd_iommu_gt_ppr_supported()) {
+		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
+	}
+
+	/*
+	 * If IOMMU and device supports PASID then it will contain max
+	 * supported PASIDs, else it will be zero.
+	 */
+	if (amd_iommu_pasid_supported() &&
+	    pdev_pasid_supported(dev_data)) {
+		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
+					     pci_max_pasids(to_pci_dev(dev)));
+	}
+
+	pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+}
+
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
 	struct iommu_dev_data *dev_data;
-	int ret;
-
-	if (!check_device(dev))
-		return ERR_PTR(-ENODEV);
-
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
+	u16 devid;
 
-	/* Not registered yet? */
-	if (!iommu->iommu.ops)
+	if (!lookup_device(dev, &iommu, &devid))
 		return ERR_PTR(-ENODEV);
 
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
-	ret = iommu_init_device(iommu, dev);
-	if (ret) {
+	dev_data = iommu_init_device(iommu, dev, devid);
+	if (IS_ERR(dev_data)) {
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
-		iommu_dev = ERR_PTR(ret);
+		iommu_dev = ERR_CAST(dev_data);
 		iommu_ignore_device(iommu, dev);
 		goto out_err;
 	}
 
-	amd_iommu_set_pci_msi_domain(dev, iommu);
+	iommu_init_device_caps(dev_data, dev, iommu);
 	iommu_dev = &iommu->iommu;
 
 	/*
-	 * If IOMMU and device supports PASID then it will contain max
-	 * supported PASIDs, else it will be zero.
+	 * When DMA translation is unavailable return error so the iommu core
+	 * won't attempt domain attach for this device, while preserving its
+	 * rlookup entry for interrupt remapping.
 	 */
-	dev_data = dev_iommu_priv_get(dev);
-	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
-	    pdev_pasid_supported(dev_data)) {
-		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
-					     pci_max_pasids(to_pci_dev(dev)));
-	}
-
 	if (amd_iommu_pgtable == PD_MODE_NONE) {
 		pr_warn_once("%s: DMA translation not supported by iommu.\n",
 			     __func__);
@@ -2537,16 +2548,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
-	iommu_completion_wait(iommu);
-
-	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
-		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
-	else
-		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
-
-	if (dev_is_pci(dev))
-		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
-
 out_err:
 	return iommu_dev;
 }
-- 
2.55.0.1003.g10538fe699-goog

