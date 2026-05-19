Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426837AA95
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217334; cv=none; b=Em3DTuZCPA3QtPI+v9BewJL/E2HRwP5060KdNfiAZrQ9SkS9gYov//PgTVPt9dVSZNTrsZbh1gndkjKNmfsUYqKeyj/V+MdOsJBGNetzMR4tjcwAS6G5c7jb22JLYLhfiVPNTHOi5nDuI3oChmQDPnm+HFBBCWQf4diVefY25GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217334; c=relaxed/simple;
	bh=HtyRYeO1F1mHvikYxkPLNdLupXC4fBREsTuVb8Of8Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf2SOvNKJImQpjFiXm0/WfVijGfhdymQQmxtTSh9vq+ab6pvIDyo6AIERYA6BUzPTWqDLo5s32go+TK82WBlUN9wPm11IDUE5RRWZeeCSLd+oXz3z6Cq2XsM3eYi9f5ti8XPNDFJ5ZRwyaOziknBsCbDxGNcxRN23KJvmNGKH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPZjRD9I; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPZjRD9I"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba180a022dso25ad.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779217331; x=1779822131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rA3l2l1qf0c3PJEWCBDErkIAF/hCSQNHn0RYU9kZx5g=;
        b=KPZjRD9IGwYH6verXrBXnw7plcYHlo3GeFq7KoGoY7mMGCEVpw8h6aKIkdQOxZ2749
         njDdy7Utw5uTOlll3JkdbmCeIQUYQttwjo14ozh0d0WdzWPonyNCTCgHolkA9ssObD5v
         qa9/RBtiuvFuabmwcLcpxTyBulBe1DtWhCOaaaV3PL7LJzAJGMJmC0BpTnVnOMJzsBjN
         qOXdbZeCVuC8pVkTai4PFyrB8NUTMAqmJjfv2IzZYs6Bwyc/lU8PL1+BM2L09gFZ5pB5
         Jl9N70rhf3eGrcsF8xulyl1HgZo5lzCqhLiH5JvB3C5TuC1JOUxn0v27n7frxEL8pHUa
         7qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217331; x=1779822131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rA3l2l1qf0c3PJEWCBDErkIAF/hCSQNHn0RYU9kZx5g=;
        b=PisdSRNgTLUJglfVNJNAp41ZR6gwcXnwPfcRs70I1J32NQfDWuIjXdfHZUWZoK+D9Q
         dWC87JAmVIeLBLTv688o9Y1+UVhuIuZal9H+LD1tFyWPHDZfc6FNnJAEAvDglSdz2aAH
         p46gwZ8Qcbhdieq2G1ByHk7CJVE0TTu2GBMuBt8cbs4T//w1PbazE3ISVyq1tfLcLgHw
         QGC39A3viJ6DW6vvdWAzPLC+oVpP/egQ7DOvI3H/uxYoN2gdJrMhL29FTM7JRT00jFT3
         L0h8/mnlHNE2BWI1gsRwFDcCRLV7lJY3B7HhXzLizyQSXzocxzBNER0+wdXmF3uaKUaM
         xzsg==
X-Forwarded-Encrypted: i=1; AFNElJ84Ou9iJzjRT5mepUAhFgD2l+vYQKhRgU07dzYj7Q05+dCjv0OlLH0tI2qiE59L8rFbcK4vssCEVpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5Eb2uwAZcGcadzxTqgzJWzBCXij/yjYLlxbTPxSMEykFFHe2
	x24uZM6QA2cbuueS3gY8v1qAIYv4lFSt31yCJGFPmwYO2ukiX/TUAOp9Uj3Fyk5Pfg==
X-Gm-Gg: Acq92OEx0qznBtyT5WiFRDU0wEouMqAzvEC6EW4WJL1VBs0fxBKBCFezoxDo7yftRbb
	JEQeuhZNhgwCXRap5qRRj6AMS9X2do7xx3fEvHelklDDGffy+YKBCMkDUcG9/R97bXTpja9TPF4
	7dZZyKibmdbPZLPZmIvGG3CS5QhU6XjEEb3m1sVO9tB8C2NJRsACco9xu2MYSqyhS48+uo/whyr
	nGtbD9yhjiSq9eN2dDBK97mSSm/QHZ/dNIK1cOrpV1H1RZtxPCDstq6lpYuC/8qc8OV/ED5IMJB
	PewbjLmd74DI5FXkvYvjzcgaJSXWmxT6ORW6EvRsgX83/KH9sVVmxaqh2IK0ut+Be5c5mhWbd1R
	ihUeHjjg2avrlCJzNY9MloCc9+aLI4v4bDCmci4kpfypCmuK2k82vIYHI/U+oQTUbcfMHGvx5dP
	i9XVaSEYSWAlVXpzjEamO0AZV8GfPbzvaVOrPOhN2t7OTFIhNn2ZSm5tNqwH1aVLQwoGPrzw==
X-Received: by 2002:a17:902:e788:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2bdb32c0349mr6198875ad.21.1779217330325;
        Tue, 19 May 2026 12:02:10 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664220sm17245650b3a.4.2026.05.19.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:02:09 -0700 (PDT)
Date: Tue, 19 May 2026 19:02:06 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 1/3] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Message-ID: <agyzpVjLtxgr-BFt@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-2-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-2-praan@google.com>

On Tue, May 19, 2026 at 01:53:20PM +0000, Pranjal Shrivastava wrote:
>Update pci_ats_supported() to additionally check the associated PF's
>status when called on a VF. This ensures that PF-level quirks and
>untrusted status are correctly propagated to VFs, providing a robust
>support check that aligns with the kernel's PF-centric ATS configuration
>model and is immune to the timing of VF-specific fixups.
>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/pci/ats.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>index ec6c8dbdc5e9..a5fa7745bce8 100644
>--- a/drivers/pci/ats.c
>+++ b/drivers/pci/ats.c
>@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
>  */
> bool pci_ats_supported(struct pci_dev *dev)
> {
>-	if (!dev->ats_cap)
>+	if (!dev->ats_cap || dev->untrusted)
> 		return false;
>
>-	return (dev->untrusted == 0);
>+	if (dev->is_virtfn)
>+		return pci_ats_supported(pci_physfn(dev));
>+
>+	return true;
> }
> EXPORT_SYMBOL_GPL(pci_ats_supported);
>
>-- 
>2.54.0.563.g4f69b47b94-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
