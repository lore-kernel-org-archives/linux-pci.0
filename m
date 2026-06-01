Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCE3AD530
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321339; cv=none; b=mhFIMBvqm0V1Cq20RWw28pLi9D6VDDtOpuebCeKhO+KGMpcUjhmlfXqkTvpQVLubIqrjoFXTZImQQptmJIuN72c4NfmjYuS3lnKCewVyvDAYgEM1kWJN+xMZBSR1nvW0nfn/uwgZApdBQJv61IxY+36Ei5gK7xeL58zZ/9/5nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321339; c=relaxed/simple;
	bh=Ju72LWXz/B8md71qQh8t/Jq+vqDu3BYR+Mvmt3R6GnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qqoEzaqPViSactHL5sK2EmoNAy8APJAKa1J0BHIW+KI/G9dmM+mujAJcqVbob5YBZRNgU3s2aIinet8GBre00VscTHuCpFvHgARbnkbI4xy+9auVqW6jeGcERhHaDiH/rUiPuQKRcm0VzTIb85E0COtAFtDQe71SkWtVqQeB4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qr1nuu4m; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qr1nuu4m"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf0453031aso58531685ad.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321336; x=1780926136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXVaCkW8Gnzx6rEb7LWE+bpldCw6MgCsucYo9vO+yHM=;
        b=qr1nuu4mZGfdEV76P0h3WX/RspEPtguV1o5WG6a0sHoiGTPKfVhZPNIgfsXxd5R6eT
         zaZZp1yqeBDIzdf6pKHzSvRATfWXdaSUrcE8PwoHAq0lbdf9WFiYSgtTzwKSBYgSB8qT
         bQ8HLJ2xrN3DhGSzSiMwEVEpHlySZHEgdQYChUxvmBNLtmd1+5z11Q0pmlSyCLXSS4ch
         AIXSgfojUKEF2mfMjkU0eqi0uHCsrQ/rUsnkKysnVfcX5R40+92+pR57sClfmbWOT4vf
         z/zd2X2AXSrVsh1FF8Of+4QrOMf7wPOBugF5UwYF42ocuPrUsS1ybSAC7i7QcPTohxAD
         DeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321336; x=1780926136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXVaCkW8Gnzx6rEb7LWE+bpldCw6MgCsucYo9vO+yHM=;
        b=mB4U9giJKVvm/JalYJCm+7jHf2jel2sxHkBjQrymoJD5vkC3Ejhp33KkVxNQs48SrV
         roU2dxJ5WJTLHBkBQ9VtsrAQXyrDbl8xUlZX6NXDGJ3l0qo7mGNfg443TbrykbF0iPjd
         W75Kzj6z0mf4DFeItgzCWYfwvMev/o8+0a2jP2v6uSx3/Cm24tCO7svZz8UsrucPgg9b
         1lxph9BoxDlHlL7plqid8DtFffG66YqnstWRoRb/pvRaqIfg50Q8JO7YBAq0WuEGoH9+
         oh0uC8xCX1xZ/ugz4QEhKA/zIDeoLWQNJOpL4f+l1BhcsN1MDT1yqCTOnhzpv8pVJk43
         fp2w==
X-Forwarded-Encrypted: i=1; AFNElJ8JKVltZXbogK/szB3r/cE0N82kGpTHvjiQuoyt9ZOhjqDXc6uzTdcMxayRYW+iwIrASxYApJ+QbrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykODXHYKbyt1U/ADFCXUtSi5VhtiqAU/WH6nIrZh6y2DtDezuM
	yUHCfYFUpmg14CarQlw32lBnTg6wqjmzSFjuKUliN608aBgq8op/4qzqIPDLdM9on3Wf3gYlXKa
	WLQ==
X-Received: from plrx24.prod.google.com ([2002:a17:902:b418:b0:2ba:f5a6:38db])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8d0:b0:2bd:c5f8:504f
 with SMTP id d9443c01a7336-2bf368d9ee5mr123694865ad.40.1780321335923; Mon, 01
 Jun 2026 06:42:15 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:01 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-4-praan@google.com>
Subject: [PATCH 3/6] iommu/amd: Split probe error paths to preserve IRQ remapping
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Split the amd_iommu_probe_device() error paths into err_deinit and
out_err. Proper init failures continue to call iommu_ignore_device()
while configuration failures (like PD_MODE_NONE or ATS mismatches) skip
it to preserve the rlookup_table entry required for IRQ remapping.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Ankit Soni <ankit.soni@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9b5861e241d7..c3b3750d4a22 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -737,6 +737,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid, sbdf;
 
@@ -2477,8 +2478,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (ret) {
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_ignore_device(iommu, dev);
-		goto out_err;
+		goto err_deinit;
 	}
 
 	amd_iommu_set_pci_msi_domain(dev, iommu);
@@ -2512,6 +2512,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
+	return iommu_dev;
+
+err_deinit:
+	iommu_ignore_device(iommu, dev);
 out_err:
 	return iommu_dev;
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

