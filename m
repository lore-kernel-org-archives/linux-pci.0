Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB5416CE8
	for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2026 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676416; cv=none; b=gj2Thp2Ncn1SNDX/mw7puegnwMkFFIF+Xci16qga0VpVi8xSpQqZlHH0lkBne8eaERdlrRygJhrXV7cDTWVQCY6yaUjXNx0bEhmtdm3DgT4/6a3f1xHcpS2RyGkXRkCHlJ0Z95Wk+Q/IKyONOhf/3VMridws6dLlGbmVBfn8s80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676416; c=relaxed/simple;
	bh=6nR3Juh9NDxntaUq247tAwVpN47pOLeSUP+bEF88yFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=easy4gt5iFs3CFO702pyj9DQcQk5n51+uDqpqatWMkT6EppuEadcLSLGgEvX1RLqn/9zQCq9UCokycP7IbGGhjiaN+4oXaGPUW6WJfs+Qyb3WVFznwf1jfW1X/k2tJKihLBLWzXPxujNVP+uudVtaE+0E6DngVJvCgfpFegRJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbeZTzfB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbeZTzfB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2911f93cso102495ad.1
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2026 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780676415; x=1781281215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLyfkCJtSXXJACwZ2rxgqL5LKRr/9vEGg7rw7W2SG6k=;
        b=PbeZTzfBfJr0RNYZ2WMS+lsAsmAtpUSBQEJIA6X0h/wuqdvh6N03XtxRYR5iLWE5qR
         U+Ie54mwfE5M7MFwcwP/Arn5oTdDYKCqP9uOsU6xuacd1CATqXfEcz411Edbr0iRXcB3
         BlxBvxmjxHvrTSRCgWZ47p31ljQ9OLVvwRwY1shV56PfFuHMbmLW34LUNczalEJhk7JZ
         mhppzM3s6ksq390SONzCIpVOcCOnsDn1lgv4OT7v1UOdB9eC8qec0p76D5JXzYvr4Fwf
         qZmdxX6P4sFrTlwvCe7aleFAcQt5suVHLnA5I8WPCVZ8fp64qlfD+MkRLOBU60benQz6
         eB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676415; x=1781281215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLyfkCJtSXXJACwZ2rxgqL5LKRr/9vEGg7rw7W2SG6k=;
        b=XwvQQjyWng6Pxco8CvW4j6pvbUC0maMWYKEWmXWHf86Zn2b/OZSkXK6FlbJVkub7q6
         dtquThvd1IYEpwaQFqZbO/deUi2UvsYnpyJjj5oftD8jsYwKmp1p8sfjvczgeSa4kkaf
         h7RT2w39OZxmrIX2Avcp+J5YQSK2MbDR3OpYN+NfkJkP1pEbZtnC33S13fDdHU39/b4Y
         ax2Fm17K7XcMlEthfAWYBH2vqbhxOJVzBKMsJRcaXuqi1hrizsH5iZKG1C/m0Bhi5e44
         GIA2smclM5yK4gvfrCniJSkH8zOmPSGbbW/zbgKh3KxeIUMjDaMekgZnn7jhkNOEYEPp
         LYVw==
X-Forwarded-Encrypted: i=1; AFNElJ/ATTdcV50SA0l/MZ8M1fPE09BuZz8YiaoELVGyT0J/lc0OiPHkvdizy9BI8i0fL2peBH7evH21nZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0VNgJh8WlonYgzZIJ7Is6/fZkWrRG0bEkhJuezfmvrO+I2F6
	zU3ZMYdpTGlB2j+XUf7Cahp8+e8b17PQL1KhM42Vbx9N7NUIqfFw0OWsJB2ubMmE9A==
X-Gm-Gg: Acq92OHaSXBwrJaKPxvqEVNLE2yNqkGaT5hBO9TwBNEAXe6cdPAQSB00vtl0r6tMAAL
	42keGMzY6dp/rybfwJH9lvwHjhIaVu8qVFRIjW/nlJ1P967RAEkxkwoC+YYAACL+xI8dg4FZm84
	db+X/6qYOYYgfEVKC5nXRdfDRsmJMZ3Zylil5tlDEcK0GhJ1OHmKGblXpIiXF1GElisjCoKjfUz
	R3YNJQr5C609hfww2wYvx+V5Zi78Hn7opKDP81ulirPB/Cm/6UjtEQO5behpqiDOvolbR8LOGvb
	0q+LGI4WUXKGtAOZyaUG8oCsP5rdZkcII5rsVVm1ROVhYV1QiY0GUgU2tIgdFh4uZEuamEnUs+K
	nn5lzo6dFxqHCxpHZ5IwecNzRTy6F2SXTxIGQ6DmnEsEUtd7fQG22meN2LPJXkt20zPiA/81Ts+
	f9ehsliB+VHzs5gEvIXwNxyqJWFhfvaYhe1T5S6RRMTlzLsVAu368BHapCc/7D/FCyTL0qj59/E
	MRHQ/V3kuQFq7VdgVH6K2YXeXzQCn4TeelgQytZ
X-Received: by 2002:a17:903:fa5:b0:2c1:ee6e:4e4d with SMTP id d9443c01a7336-2c1ee6e520bmr1529335ad.30.1780676414213;
        Fri, 05 Jun 2026 09:20:14 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827f1sm8989696a91.3.2026.06.05.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:20:13 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:20:09 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 4/4] iommu/vt-d: Fail probe on ATS configuration
 failure
Message-ID: <aiL3Mztpm7UjEqvz@google.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-5-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-5-praan@google.com>

On Thu, Jun 04, 2026 at 06:21:16PM +0000, Pranjal Shrivastava wrote:
>Update the Intel VT-d driver to handle ATS configuration and enablement
>more strictly. Specifically, update the device probe to fail if
>pci_prepare_ats() returns an error. This ensures that any ATS-capable
>master reaching the attach phase is guaranteed to have a valid config.
>
>Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
>fails. Since earlier checks in the probe phase preclude config-related
>failures, any failure during hardware enablement is considered a kernel
>bug.
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/intel/iommu.c | 15 ++++++++++++---
> 1 file changed, 12 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>index 849d06dfe1ae..f39451323553 100644
>--- a/drivers/iommu/intel/iommu.c
>+++ b/drivers/iommu/intel/iommu.c
>@@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
> 	if (!pci_ats_page_aligned(pdev))
> 		return;
>
>-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
>-		info->ats_enabled = 1;
>+	/*
>+	 * pci_enable_ats() should not fail here because earlier checks
>+	 * have already verified support and configuration.
>+	 */
>+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
>+		return;
>+
>+	info->ats_enabled = 1;
> }
>
> static void iommu_disable_pci_ats(struct device_domain_info *info)
>@@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>
> 	dev_iommu_priv_set(dev, info);
> 	if (pdev && pci_ats_supported(pdev)) {
>-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
>+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
>+		if (ret)
>+			goto free;
>+
> 		ret = device_rbtree_insert(iommu, info);
> 		if (ret)
> 			goto free;
>-- 
>2.54.0.1032.g2f8565e1d1-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
