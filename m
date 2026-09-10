Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43BE4A3414
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050430; cv=none; b=b/01kgIpc4Z6YTStlw/ldnGhuM++m+Kgp4CNWgvBmWbWQqUyoev0RZB6aVtRzw/XGr1dI+q/nbB96dnDHI8W+hO+I1I5DVTHbPU5YNVR8pp1KSeE0Nkv4hpkIoDJZXjlnB6+5FEoS/uEYiyneOS1QAWG+RK3KuISIZVQLWtAaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050430; c=relaxed/simple;
	bh=YYZVAnbeYsjJUQMqHO19xE7fLWQGWh0V5fiC80emyOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M8lBzIpC3AjHIyWlWj++E0+GToWPgoaCMbz2klgxORdlZB1KyMk4FDqpd27dX9Yn9zEqQdEsNqXUTw58SrBHph4DTUzztelS8Hm18zT/viMQV02fWbuIDs1M/7IqadneZbfYjJN5ZpmFMuIR0oRK3/stuXRW4EOBHDOhVe6qAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lbqPrSp3; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lbqPrSp3"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so8976872a91.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050426; x=1789655226; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2x6uJrq0uW0oJaL9sX59+iCeuYUCoD1qgfJpjGmx3Y=;
        b=lbqPrSp3up+iMmA+ev5Y8bFdZHmpQzyLKI9a8m0PAQql3pNIuLCxFiTxp/CpmtlNBN
         +1jrUL6pwqrNf9zDKkbAeX28EcMgyLc63lT/8UxXEBcQGQTZGoCrqz2WOFNfuSgg9pkL
         uTm0L/yINbFIZwZpoBO/y9tn6bG/sqkwnnPsGqEA4FR+kt8faHlksElAKkpIySs37vLo
         gGFVTWCpHwwRIRmuaSi7S6Ljggbg6IqQfggWPj1h/AG32GyxE5w9xHXfn+RoKYI2ihPm
         i4UrDyOiOtakML8ngTId4ekTFkczM6YMXOJxab3JYJ3rkqzZjrYbdiU1B9DsRH3dH/IG
         SSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050426; x=1789655226;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2x6uJrq0uW0oJaL9sX59+iCeuYUCoD1qgfJpjGmx3Y=;
        b=Yk65sMiwGPUFrho3oEhUX1/nl37ywKNS8Wo/D02xgxJtSgHu7FjdjdlgNT3sRo+UPG
         Itp9V6ZwA1OvUY6PRBY24wOFT1ofj2r4vgVb8rjkO2KC9qcD6Ueo7Rljh4zyobZAB3qI
         H0xWMX4xTRM+QQRWB02hf7SSzKEDuaN5YqGl89UQiIc7lJjrpLRFwqwne1mF9lA5WE/J
         gPS6sEQd7oLR4fvcKGaTdj8xVI5EmnMeUN+Pn7iIYrmzYWoHRfXyDGXdw7tTHJcqhNO4
         1FbPODzZN4wqjxXiXtVTy5rjHYfdm7t8Mgg7uUdyVP4gVwF9Q0Ihz3/hQreVIlWUJ3J7
         zsWQ==
X-Forwarded-Encrypted: i=1; AKwUvBySU7v2dtDGas4+ZyV74AtXVf9PNGSe8A8BPaxnCZ0WEqdPI00H8JMVhTepbPwyFnxNTGWOCT8KKtU=@vger.kernel.org
X-Gm-Message-State: AFuF++lWfsIGJAej0u2fwxG1ibzEMW7ReqGpqTzDaXnch1TP34RyprIO
	RPPzrc0YrRP3Qn/VBBf58vsOPlq/H9Tj43UZl1dTupA+OuShX73Kw8/EYTIws4E+46EIFRX3++h
	4bQ==
X-Received: from pgmm13.prod.google.com ([2002:a05:6a02:550d:b0:cc4:a477:43cc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c05:b0:393:288:29e3
 with SMTP id 98e67ed59e1d1-39b26106c44mr63990436a91.10.1789050425503; Thu, 10
 Sep 2026 07:27:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:26:53 +0000
In-Reply-To: <20260910142655.3281464-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910142655.3281464-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910142655.3281464-3-praan@google.com>
Subject: [PATCH v4 2/4] iommu/amd: Remove iommu_ignore_device()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The iommu_ignore_device() helper was historically called on device
initialization failure to clear the primary Device Table Entry (DTE) via
memset() and nullify the rlookup_table entry.

However, clearing the DTE on probe failure is problematic:
1. During normal boot, DTEs start out unconfigured (blocking DMA), making
   clearing redundant.
2. During kdump boot, pre-existing translations should be kept running
   until deferred attach rather than abruptly clearing them, which risks
   breaking in-flight transfers.
3. Writing to the DTE table via memset without flushing the hardware DTE
   cache risks aliasing & torn writes.
4. Clearing the rlookup_table entry breaks interrupt remapping for
   devices that fail probe or operate in translation-less modes.

Remove iommu_ignore_device() entirely and simplify the error return
paths in amd_iommu_probe_device().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5e144a60c397..7f8b51c28a7e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -728,22 +728,6 @@ static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
 	return dev_data;
 }
 
-static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
-{
-	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	int devid, sbdf;
-
-	sbdf = get_device_sbdf_id(dev);
-	if (sbdf < 0)
-		return;
-
-	devid = PCI_SBDF_TO_DEVID(sbdf);
-	pci_seg->rlookup_table[devid] = NULL;
-	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
-
-	setup_aliases(iommu, dev);
-}
 
 
 /****************************************************************************
@@ -2528,9 +2512,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	dev_data = iommu_init_device(iommu, dev, devid);
 	if (IS_ERR(dev_data)) {
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
-		iommu_dev = ERR_CAST(dev_data);
-		iommu_ignore_device(iommu, dev);
-		goto out_err;
+		return ERR_CAST(dev_data);
 	}
 
 	iommu_init_device_caps(dev_data, dev, iommu);
@@ -2544,11 +2526,9 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (amd_iommu_pgtable == PD_MODE_NONE) {
 		pr_warn_once("%s: DMA translation not supported by iommu.\n",
 			     __func__);
-		iommu_dev = ERR_PTR(-ENODEV);
-		goto out_err;
+		return ERR_PTR(-ENODEV);
 	}
 
-out_err:
 	return iommu_dev;
 }
 
-- 
2.55.0.1003.g10538fe699-goog

