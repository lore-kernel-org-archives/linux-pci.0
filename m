Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974473D413A
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053149; cv=none; b=Z/Xzq/Nsgbt4vo9wQBHeSEJg2iWyMi1S0CH4FqlxvS8UuYmd0h4pc7pyQUUGYca0rrcucp9cvVpB0sEkjfQVjohEwjoBCaD8nH5FwW8NbNXMscbkuMldZqoXAlJ5lXrMpTxsF/yipkwkjdyaBytqoAwKfePWcGRH9rRNEKwdDnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053149; c=relaxed/simple;
	bh=rCPBs6VpzFnSeGV1IQONO9sqLS2eG7RrmNxYtsUNeyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSyo+PCIfzo14duqzadhkiIjfAYbPUylSenjJndw4cZCsWxBAeZWUpJbWHKvDwmN7I5LwoClUNZBUfjJB8RbAE5dzGGwWSeUA9LFhXpgj72fdJLZiPB6wdDq0C3cUW8ue1XX3OjpVUl6vsLdo4eZIIH1DGyw7wJwPmaa+aeVtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umgvyL2V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umgvyL2V"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd5b20aaa6so147143595ad.2
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053146; x=1780657946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=umgvyL2VbhBdv1uUIOXd32DGF3eP4OIddNLAHBFykL6GEkr03rsORqDX1jbu8jj8w4
         hvaBhMRaeNi/INMkNmG98rTDMBN369HLb72LrWX/jdd+pQWWHUI3OtWvVagFqLVRf0CT
         CH2MVZKTw7GHYwqWc6dRgntSgOmHdsfB+BX3TAeagkwqQ65gcrXtAUZK701gEx3YfONb
         KWcCTe5rn8gF8fxyiy86P+5jf8JummTX3KXMdZ5bZSUaYkWXdsL9P3xWFNbJYIQz9egB
         +oeHiekzmTEj2flF0Vmxz14bZ/LuUoiRBfmDoa21Bo9YVLeFILAD7Wv1O2ypFA60fRwq
         +VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053146; x=1780657946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=N54bvupggGPJ8PfF4camEQsLsZ2zfw/9xJu3C02ETjQPUqgGPe0d6OWyx8t1P0jExL
         XudBpk2Yfshg77lqXjo6Jpv7bB16Jj7MzjqdnjeiVaTw6EJMmf9B/abOy2PwisyRYP27
         nmVPb54R0gGQPlpX/9d+/D+G3+oPfjrBtlm4IwWHig6/8wLK9jKkuT9lvXJ/IcSZW+MH
         bGsRBK3JoF2T8Doi/I7JnYV5RtgjdBo37HCa2JrWuumP2M642egNMv7iXgJpVtTHc16Z
         q7z517q0Ox/L0gpuOdMKLIol6BlkS2hD3+91yvin9TmJdD5XA/5q3CcPd3AkCGO+JIbp
         mt2w==
X-Forwarded-Encrypted: i=1; AFNElJ9xQS7NrOJuFeMgIsMZEDKLheOBlIfxKJBmpvJOLDauKv3EN1/aVsiRVCyP3c1VfoN684k97Qvagyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoIXJRCEhUmkDHKD/5CryhyV7CZNNuFTDZf6JTsxrOTJ3Eu6b
	YRktC9ni7qFIx7DKPyZ+I8kyhHzo7eG3HjlsF1tfOhVri+qQEaUXGczkv6KmsFXbgLPX6s8lMNw
	uYg==
X-Received: from plav20.prod.google.com ([2002:a17:902:f0d4:b0:2bf:1a98:5111])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f551:b0:2be:3850:297e
 with SMTP id d9443c01a7336-2bf2098933bmr34166025ad.31.1780053145610; Fri, 29
 May 2026 04:12:25 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:08 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-7-praan@google.com>
Subject: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
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

