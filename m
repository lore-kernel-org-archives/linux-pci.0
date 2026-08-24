Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531E36895D
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574242; cv=none; b=DP7oFaHGGU5+TA6Oa4zpheHiVvklFhp3/5dUirk7fk5aGGUopCqdYf0l3ycDm5Fv8be4JaGKCpsAgNz6lVOT0211KOQFUHKiCOH+C7CA0tZH9dy/c6Mqua7R6sRMH5N1HWmiHfmBU0B46BznwtodUIgwPnEehVUFUkfhlJnXBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574242; c=relaxed/simple;
	bh=0FrHW9VyarVTWexh+cRfUDfEcUegknMlo0+I6quTFkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxs0/xbRNgA0PiUtW/+wBfpv0rAXs086GZDOrbx5J/CkS8tTBQFLWaz/0cnGJBRXVOwm6l1K9QIxHgtGpHQCressmDqlsffcxst8j6+IcspIU85JLWTdYxzWsqWqWDPBeH1BvddR0ZeqJ/ivpeEVOwqDQrG+rUQMCjJEzRUSB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlX00zJK; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlX00zJK"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb835525b10so4586878a12.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574240; x=1788179040; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfYNwAoiWTPLSXTU/nHcpeXRO8BpM/FKM+cbWnkCGPk=;
        b=mlX00zJKvdtoLZc1UVTFWjrvh45OFfn0Kv3OkuxZrkJx0DqCs8JO90dg+Al/AaUCyd
         quO9cFvttzDpu+E4SdPK7/dFUxY90TMVmMITU9TJ+aKtZtV6AduV2s6VNJZJmonVziBT
         M0Bs8huU04MMTnXuuS8DNj7bSK+SCQRR58aAuB8U384FOH2pO9ErLABUju6oTH1npqF0
         dAAY5ieJCagjxhQj8XoklBY1p4TJkksST+rUmTIH+YaOBohyYsO/TbNCxUaRNEXCSU40
         mUBjolFlai+kVFEy8bpvkhzOUqdN10FY2L6OXCHEW3lsM6gRV5QFPbnAUfh1U3NXCn+v
         jiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574240; x=1788179040;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yfYNwAoiWTPLSXTU/nHcpeXRO8BpM/FKM+cbWnkCGPk=;
        b=GpcNBg5+IxmgPuWjKZW4EXVx4tRow/9mVpLfUjn71nnGkejGPMHr4Q84lBOvX/FH9H
         wQF/Qul3WrqTo5fhyiNHwUPavSZxOD4zBEp9TPOLkArQfIehna1BtDVu7gyoEJQe9v8F
         QYVjpT1f2+SXAnvRMAiXzXmmVHHBLLWck3aTlsIVlraVERZvebBlgWhLs2QYUO4TCWzK
         0SWl4qbmYZb9JXm2QpDtm21MKGwLUnVdVUP8QjofY/G4n+AlRP85qSVzjWCYSu+R1cEW
         J4GmB55eH9WyAY04bMXqu00oJ9EOeyXQww4nCZMwq++NEr/c5G77+YQXECiiPbX+M/On
         XHOA==
X-Forwarded-Encrypted: i=1; AHgh+RoFSO8xKhGBG9PcBD0zO5/Zk9qSc1B+hTS1LH+Ia5Q7d09JVw6ewZQx/rO8JkVpsE5xHBX2esiBq4w=@vger.kernel.org
X-Gm-Message-State: AFuF++nNDBdrWrZMp4G/Qem4DpGhYoKdnV6cKiiPCwRjbPzKkcJen3xG
	xAZdAAt1iWo8yWVlqhzwXFBtp29Z6G8ATXjKdgF9TaL/A2aChNZlcF//paSxOed1vZ7+bK9jpvg
	etQ==
X-Received: from pfdc3.prod.google.com ([2002:aa7:8c03:0:b0:84c:2e88:693d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:300c:b0:848:4859:a45
 with SMTP id d2e1a72fcca58-8520b96630dmr33366040b3a.2.1787574237585; Mon, 24
 Aug 2026 05:23:57 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:43 +0000
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824122347.1588592-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-2-praan@google.com>
Subject: [PATCH v3 1/5] iommu/amd: Refactor device probe and capability initialization
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Restructure the device probe path to improve readability and prepare for
cleaner error handling. Refactor check_device() into iommu_lookup_device
to explicitly validate and return the amd_iommu ptr & devid. Refactor
iommu_init_device() to return the allocated dev_data. Consolidate all
PCI cap inits (MSI domains, PASID, ATS) into a new helper:
iommu_init_device_caps().

Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4c31294fabc5..e1f9fbb63837 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
  * This function checks if the driver got a valid device from the caller to
  * avoid dereferencing invalid pointers.
  */
-static bool check_device(struct device *dev)
+static bool iommu_lookup_device(struct device *dev,
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
@@ -2477,49 +2464,75 @@ static void detach_device(struct device *dev)
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
 	int ret;
+	u16 devid;
 
-	if (!check_device(dev))
-		return ERR_PTR(-ENODEV);
-
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
-
-	/* Not registered yet? */
-	if (!iommu->iommu.ops)
+	if (!iommu_lookup_device(dev, &iommu, &devid))
 		return ERR_PTR(-ENODEV);
 
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
 
-	ret = iommu_init_device(iommu, dev);
-	if (ret) {
+	dev_data = iommu_init_device(iommu, dev, devid);
+	if (IS_ERR(dev_data)) {
+		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(iommu, dev);
 		goto out_err;
 	}
 
-	amd_iommu_set_pci_msi_domain(dev, iommu);
+	iommu_init_device_caps(dev_data, dev, iommu);
 	iommu_dev = &iommu->iommu;
-
+
 	/*
-	 * If IOMMU and device supports PASID then it will contain max
-	 * supported PASIDs, else it will be zero.
+	 * When DMA translation is unavailable return error so the iommu core
+	 * won't attempt domain attach for this device. But interrupt-remap
+	 * is still supported. Hence do not ignore the device.
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
@@ -2527,16 +2540,6 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
2.55.0.766.g2966f0265a-goog

