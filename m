Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D035E1A0
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999850; cv=none; b=qBaO9jaAVpvCSr6tKac+fJFBOIP+9bkwUS2qmBgfNZbC5B+tauQTOHsRl/+2aKciVfij7nmIj6jnWYyVFxvTWURFQdmjvG/h3BKgvI586t6pzboZrDLvzkcNPpSbepwTHn+walt1tmaMU8NEa33C6GoYNYspGkSBmthsvVFUUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999850; c=relaxed/simple;
	bh=ylHhsRCHAqSMh1pS6GMlC808waOAu3ILm6CtLVqC5hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AhCtxQs0T7Yyqmf9dE+oKms7XJhnSUuOWIQbXcJ9ovAK5szcQ0Fdczl0NXvD34OQUEDjLcpNuI8HeDgxcfcyb2psHKMt9wIfAFfXmpx66Y7Z5Xz/fxOTS2qRmYpgUQgAI4ZQ2OSyBHK3JDJ8nhp/Bgpr34kRx0sb/fddrcbAJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmLE3FNf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmLE3FNf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2babbeff9e4so146141925ad.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999848; x=1780604648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7UJLNVkpdPww3mteKfmSVmHt+OJdAAQ7hsDxELrWtY=;
        b=tmLE3FNfR90yjcBQHC+yvKwkbgPdmJCNWlL0dymh+Hr2QCf1obCTMSzAKmtRCK+Dx9
         FPCIXWg8iJTzu+gM2VXNQ7MzsNvlDTYTJH5+wQdEEazEpU8EMGlK/y7+G5ZJ8/qX8ig/
         y1BkaL5VU9esPPViojFEsLh4pnQ2YqDFbV3t6Pd6GAjPlIckYOjSckrgOW1jrZcsfd3e
         yeMs57bTZzG7uI9jWtWqH3JmqdK9Q8dFHmNDDA2KIiKUwcVRRGGrPHhYAA5GgIfR4pAd
         wKyURDAbxI1PtpSvDFts3sKSkFR50HUABr1FSPig8+ZAnvYZ2iQ9H9Q5i/ZwhlNUX8/E
         3EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999848; x=1780604648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7UJLNVkpdPww3mteKfmSVmHt+OJdAAQ7hsDxELrWtY=;
        b=IjNQkP8XhRuBO/WT/OJfxvMv9Zke1ScxuzITcDmmNK7LTXC2okV1TuNpasLu4cLDmv
         dBHtNHI53mg2ac9j0R9WK26jvON3VFvqsZYAXTvZmpftF1w0XiHPOAzFrgTri8FYtASc
         kFtatzb6+sd1rJJQp8wXD2YjImu4o/ArHTFEhw8MejPyfq+Pc+fHU1y4Ovm1ceha1gY+
         cD+0gt/wvGZnaf5LZAf3QnGZ3Z91+smgukOcHmuTxk8jm68hWEtLWv5g2NL1+bu5gtZ8
         or4NMzSWBNyYBsnRaPY1406k77AiB7Jvxw+spLnYX6zQUkEdAWwE1TxoSWl0qAvLYMIg
         S3RA==
X-Forwarded-Encrypted: i=1; AFNElJ+YdwWadu9Hl3iyTg10Wkn3K+HRRizuoDVxI5xQj374Bp0URhjlw4sSz4qCFtLUstfF3SfWzfhS4FE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/ckMzfS6giC10vF1snCWIi6Ih9iKnvcxuK7twraJSwZq9nic
	mwIErtOntTyJM4nbOIctnVAWrMHKHREve/i3Ju7Lt0Eod9IYBIVeSPPbIs527sCb1Lsiyxics9a
	l3g==
X-Received: from pllh12.prod.google.com ([2002:a17:902:748c:b0:2bf:8c:2de])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa3:b0:2bc:8e7d:3dce
 with SMTP id d9443c01a7336-2bf1ffee251mr1653365ad.27.1779999847992; Thu, 28
 May 2026 13:24:07 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:52 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-7-praan@google.com>
Subject: [PATCH v5 6/7] iommu/vt-d: Fail probe on ATS configuration failure
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

Update the Intel VT-d driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ed6d3a0203f5..f13da16717fe 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
 	if (!pci_ats_page_aligned(pdev))
 		return;
 
-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
+	/*
+	 * pci_enable_ats() should not fail here because earlier checks
+	 * have already verified support and configuration.
+	 */
+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
+		return;
+
+	info->ats_enabled = 1;
 }
 
 static void iommu_disable_pci_ats(struct device_domain_info *info)
@@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 	if (pdev && pci_ats_supported(pdev)) {
-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret)
+			goto free;
+
 		ret = device_rbtree_insert(iommu, info);
 		if (ret)
 			goto free;
-- 
2.54.0.823.g6e5bcc1fc9-goog

