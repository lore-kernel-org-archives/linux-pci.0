Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A33806D1
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734640; cv=none; b=CX51dw4NTPVZnulEyYUfji2tPBZvJsXwg2oU0Jo9e8bbylbWX30SmYhR11Ar532CQlL6/uXzpHEetj24rhAh9yZ4vSKRj/xM1xaUPZSea34qJg47Lib7yvyCbsp90Rcg744VDiwOIhMOkLl6MvC7Or+r93kGzktdMg8lVwqYv+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734640; c=relaxed/simple;
	bh=XIlrVbW7vqzi6M4eCXLdH8IyV5V+kP8/9nkGd3RD0Pk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7u6m0KUxtdz13PZeDBv/Ro0Pukath+/TtICiLsNqbWTgTFeK1DdxRh0d/HT36vYZ+EnN17CHhP5KPQHFz+xQ2Gd20p36Vm1nQLwYG9ALbz6hDGiJI00d3PemmChdQ5c9C1npvKjyqTlPPyUJjbdVm8dqtm8Zeup3ULskNPe6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTrxHHBc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTrxHHBc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso107302485ad.2
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734638; x=1780339438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PIC2nM3CJ35DU4tF0EpN+9rHstJqWdUiMemSJfIgpOg=;
        b=nTrxHHBc2FQ5YMUTArBPT4oW25eNQY/wpo94g20MG7aMmd/2iKhnP7JLuJDfivs2C7
         RVnizAG2AfDWbeVhZyD39o9x1RzEnNyqWUxGsj+yi0NmO/YHx2tfqqnhWXuQB/gcpqDl
         3Prpz0aEcu2DJEjraT9A6phIR5xXClO7di+ez1ahZzbe6mjgTKFzMoKyoomJ8OPWsgZP
         ST1+ObZy4U5EOXHu+0iEr6kcsXRoZhbDAunFPKJXK4Y5gWGGufF3Px9yr3ymfvow82XN
         gKeNmqF2usa4FdIZiIS2OQ9s9l2c1GRlaDHKXGoN4QX2GAHtI3n//C+tLT1XdGDRHvan
         FFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734638; x=1780339438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIC2nM3CJ35DU4tF0EpN+9rHstJqWdUiMemSJfIgpOg=;
        b=DP1MrUgBxzS5SE6wapdsZWXyv64HeQAco1XWI284oQtcd65Hgp4LWjUtbb3BMT/nPy
         bzqG9w0TtoZHy/UL40DpPZ0SvUcSrSfj0z8EHY+JJ8rdhJmr8Fki//vhp24LU+edlK5a
         uc0TKarxB39vXNUmCKDG0lj3JkkAuMKa/uuTX/BPrRntxeBG4DaKvr/NZ+RV6oFY6v4y
         8mXZVyraPBdigKHNccp0yQLVbOss+hKjDnBb5EzEuQ/liALPNLAydTrFPydqB0jiH+Ie
         TJo87Av5K1BUzWe36PXG1jENcv4Uxzjaipxmgu5VUKffJnXdYootkYJSjolRFtdJVh0C
         QJMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vtnRE6w6m6DUuYgT7mxcCf9B1KGIorscA8bAXXMMw6aPdtX3aVhCOKvUh5eJdqE7+zFyXTHuRstI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeYD5QnFRVX+DRxIwQ7gd89bFDGfPPf1BxNx4wxl6MY5w/S/K
	KHL8yjfb21rUtqBCCiFTWoxhrYiB55xQTxOeAmY05DbO+4nGJpxlCX5D0hn2lQTBgxPh0RlyoU7
	n4g==
X-Received: from pgbbq20.prod.google.com ([2002:a05:6a02:454:b0:c82:7805:9e52])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4389:b0:3a8:2af3:ce8b
 with SMTP id adf61e73a8af0-3b328c93ef7mr16114960637.14.1779734637814; Mon, 25
 May 2026 11:43:57 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:45 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-4-praan@google.com>
Subject: [PATCH v4 3/5] iommu/arm-smmu-v3: Fix ATS state tracking
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

The SMMUv3 driver currently has a two-phase commit in its ATS enablement
flow. During arm_smmu_attach_prepare(), it predicts whether ATS will be
enabled using arm_smmu_ats_supported() and accordingly increments
nr_ats_masters and merges ATS invalidations into the domain's invs array.

However, the actual hardware enablement via pci_enable_ats() happens
later in arm_smmu_attach_commit(). If this call to pci_enable_ats fails,
the SMMU driver's ATS state tracking remains polluted, i.e., the driver
tracks ATS enabled on a master that is not actually using ATS. This leads
to an incorrect nr_ats_masters and triggers a warning in the PCI core
during detach:

[  127.925080] ------------[ cut here ]------------
[  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8, CPU#42: iova_stress/12240
[  127.949761] Modules linked in: vfat fat dummy bridge stp llc cdc_ncm cdc_eem cdc_ether usbnet mii xhci_pci xhci_hcd ehci_pci ehci_hcd
[  127.961760] CPU: 42 UID: 0 PID: 12240 Comm: iova_stress Not tainted 7.1.0-smp-DEV #4 PREEMPTLAZY
[  127.970619] Hardware name: <REDACTED>
[  127.977655] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[  127.984603] pc : pci_disable_ats+0x94/0xa8
[  127.988687] lr : arm_smmu_attach_prepare+0x104/0x310
...
[  128.068169] Call trace:
[  128.070603]  pci_disable_ats+0x94/0xa8 (P)
[  128.074688]  arm_smmu_attach_prepare+0x104/0x310
[  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0
[  128.083899]  arm_smmu_attach_dev_blocked+0x50/0x88
[  128.088677]  __iommu_attach_device+0x30/0x138
[  128.093026]  __iommu_group_set_domain_internal+0xdc/0x228
[  128.098412]  __iommu_take_dma_ownership+0x118/0x150
[  128.103278]  iommu_group_claim_dma_owner+0x48/0x80
[  128.108056]  vfio_container_attach_group+0xc8/0x1b0
[  128.112927]  vfio_group_fops_unl_ioctl+0x578/0x968
[  128.117706]  __arm64_sys_ioctl+0x90/0xe8

The issue was exposed under heavy load when running a VFIO-based DMA
map stress test (iova_stress).

Fix this by ensuring that all failable ATS configuration happens
early during device discovery. Update arm_smmu_probe_device() to call
pci_prepare_ats() only if ATS is supported and fail the probe if
pci_prepare_ats() returns an error, ensuring that any master that reaches
the attach phase is guaranteed to have a valid ATS configuration.

Additionally, update arm_smmu_enable_ats() to use the WARN() macro.
Since earlier checks now preclude configuration-related failures,
any failure during hardware enablement is a noisy kernel bug or fatal
hardware error that should be reported with a backtrace while
allowing the driver to continue in a balanced software state.

Fixes: 7497f4211f4f ("iommu/arm-smmu-v3: Make changing domains be hitless for ATS")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..1d96064d314b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3065,8 +3065,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
-		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
+
+	/*
+	 * Any failure at this point is a kernel bug. pci_ats_supported()
+	 * and pci_prepare_ats() have already verified the hardware capability
+	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
+	 */
+	WARN(pci_enable_ats(pdev, stu),
+	     "Failed to enable ATS (STU %zu)\n", stu);
 }
 
 static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
@@ -4264,9 +4270,16 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		master->stall_enabled = true;
 
 	if (dev_is_pci(dev)) {
-		unsigned int stu = __ffs(smmu->pgsize_bitmap);
+		struct pci_dev *pdev = to_pci_dev(dev);
 
-		pci_prepare_ats(to_pci_dev(dev), stu);
+		if (pci_ats_supported(pdev)) {
+			unsigned int stu = __ffs(smmu->pgsize_bitmap);
+			int ret;
+
+			ret = pci_prepare_ats(pdev, stu);
+			if (ret)
+				return ERR_PTR(ret);
+		}
 	}
 
 	return &smmu->iommu;
-- 
2.54.0.746.g67dd491aae-goog

