Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D85404BCB
	for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676289; cv=none; b=fnCJcEqOJkkYbGj/mcY2le3dzFOWJdvcB6G7LgQw6JA9mHAdEGChYC9i0JtTRoX0RByDnIfJRcOb/x3X2W0c/gKYxFVY9LCAslRZNUHVr6bEGWdHAqjlCS1AbEQgrY/C+gcmrMo4zW7cFCucsmIXvu5k1Ql9bNGc9aYY2eeFCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676289; c=relaxed/simple;
	bh=XRGI76MigkpSmoBHVTbHez1J+BmuHbL3tcuBjvVJSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvEzeu93A0JMyTP3qwwiOdhR2XM728siT8yv9RVUM4WXx0c3yDkaWH9kUGsWxYaxEWGYrCsuVYrkpXMYmxYyr+Bg+FqzmIvoGE31YjUoKASGPiMG0GaYlr2hnCrIBKp0eCjttVW7ZSt0c04KGnhOSe5IMLOvsvaptKY0bOafeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HW4tGWhD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HW4tGWhD"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b1a48855so142115ad.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2026 09:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780676287; x=1781281087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kt2tlKaxHAEAtMQ5U0c1x3clX9wtZ7zN2hv6EXts24=;
        b=HW4tGWhDcz6lLciajGPKQEGtOdxi48G4TGG+kYcEeXAEDxQy55+9nOoYyv/1nkUqGq
         W13WGOqpsSa6fEri3l3XHz6KP4RH+CWBv2C3lUFqoOLiKkPzkcB21ZdhEINsPMKFJo3R
         PVS2W7mRARbCf1rDZDfGDWlGTfdYSQAOLQFyq+A5pPXJloewYk05EXYMFSFSQGj0dHqK
         zlLB8s2Dtse4q57FQX2IKZUENwUH39ZqT1YMrp7WUTU6Sd4gmCdryjz1vToCl6w+aKcY
         gcoxlvkz1bNv9zNOOgIaWAG/GKg6ZWy9MNITAtJ18D69XNwV8sSWR89Po6Qybosc9imV
         JtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676287; x=1781281087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Kt2tlKaxHAEAtMQ5U0c1x3clX9wtZ7zN2hv6EXts24=;
        b=LgDWuAi/ajjf0oOTphVHSsc88AmY+SZT68oWlw2THMYqCd0ifol1KxnnBuJzLm2C/V
         9SmVxkJTUTAM3OghbOIIYDssR5CTRdz4sscPhGjTc4IVUy5I+QTThMbS54zUATaIXtU8
         D9x2VngcVi05o2gzDUxssNqDdbauOZuoWaNzhhqWOAKT9T0tSzG8B3MMNmHi3aiP8CnD
         bGmpSNHMU+RU/au1nwWOTr26VEBSaFxqR9fUHhzPJDNNxrOkpPll0o4Xn9IO67IXvXIu
         3Evi0duGzFSHE/Xn/ZrkT1UWnxD2/HecbEEtcb6DRuS4o4enOpx6yjutqIhfO+RqKldu
         D4xg==
X-Forwarded-Encrypted: i=1; AFNElJ+lZnM7Kxs8FhPU+pHD0O+AoWvIidd5t26RhDsl6j/T+gb7IcYb1TCHuSDtlDaZJ9/5713NDv63pfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwr/Z5AZEneA3MQ3JgTchnETGFMCXVzn8TplarQdHPEnKAp14n
	+ORnrErjJe2wUH1bmt4JTc4a5z/X6m6fo90Dvd9Apxz4gNeTlKsLtHHXAheAOpB48A==
X-Gm-Gg: Acq92OHg7MHL2NOTyyOXYXoB4S0bbym8V+/hv4/HTu93w0esD6iQ5LBEzWucn43T3oO
	p0mOjyCW8ZIlrAivxNuA1FzGrCAyROy+ApAIQvJ45/p2RmOV1B1HmIen4WjkqhF+pI5A2AG8Zl8
	92CXqzpB2UeTCFlZTDR2l0ECCl/4SfASrtQXwFlViOaB8ZQyq1rIJ+v2yvM7Q+AqK308oKv//kn
	RO2LpZDU68R4yLXa3dB12NbGwL0E2JyNUlOAEn/EyNUuFUf6mr5kZtAo82AOd05q5p+kwMNNV4g
	+7kO4CZuIkTZ+UiL/Ha+GOi9bN45A/T6gGoh0e7XbNMovo+NQBjae0hiRl8hV7WDG9sl2g9+4mn
	xjtKZuri+WgogdI6X8SHvR6YRV3oFw9QnfvI8JFdVH8mnJrqWUeFVYhUTCqyj40pplLFCidrEVw
	B5m5m9kc2OIYQjK1xS0/jbRwDPiVkJkJvr5eZYRBJWn5L2NdgDaLA3PApJHIui1wD4krdudaGxL
	VRJa2OwB12o1IsXDjFA/YBpr36U1w==
X-Received: by 2002:a17:903:2349:b0:2bd:a61:8536 with SMTP id d9443c01a7336-2c1eb74103fmr1371525ad.6.1780676286817;
        Fri, 05 Jun 2026 09:18:06 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm97716405ad.26.2026.06.05.09.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:18:06 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:18:02 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <aiL2spW1i0cwqh-Y@google.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-4-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-4-praan@google.com>

On Thu, Jun 04, 2026 at 06:21:15PM +0000, Pranjal Shrivastava wrote:
>Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
>WARN_ON(). Since probe-time checks now preclude configuration errors
>any failure during hardware enablement is considered a kernel bug.
>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>index a10affb483a4..0494c68daa19 100644
>--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>@@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> 	 */
> 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
>-	if (pci_enable_ats(pdev, stu))
>+
>+	 /*
>+	  * Since pci_prepare_ats() has already verified the HW capability
>+	  * and programmed the STE, pci_enable_ats() should not fail here.
>+	  */
>+	if (WARN_ON(pci_enable_ats(pdev, stu)))
> 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> }
>
>-- 
>2.54.0.1032.g2f8565e1d1-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
