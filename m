Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32510382F2F
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608086; cv=none; b=rk1F0EbLeGjl6Sg2Grro9X4bKtb1pUdOYdwAOJkYt7rCvpbzXVBA3P18EqxoWXNOMez9t4k/8QKJ47Ib+QKr7HS60CSVT6ZstzMqjaMaJ34SxzK/0xHVMpSK2W96s/89mKinGCNyk8vbTRjgPyQx+sO8SvZ5EmxFB1Y45fP8TKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608086; c=relaxed/simple;
	bh=1AB/9p6Nv9TlqGlJhz19Hzzvkd1Gcyyk/aG7q9mZ3wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufck76/fYg/c7Xn6IAK9oTaihHMmlsysr2nMxez+ExU9fuHw/AOQZ1cdiPpNm9nsJCEjOhsd8n9+2V/sqOUKpEekHs/m6VexyFRbkvAE7MrIwjb8iRc243jGC/rcewywgqdn7IEhrhZXaN+Ja8jG5D35O51QS0o3gNUePadYRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHQ16fjJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHQ16fjJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso48625ad.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787608084; x=1788212884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1AB/9p6Nv9TlqGlJhz19Hzzvkd1Gcyyk/aG7q9mZ3wk=;
        b=RHQ16fjJ0wkat9/3Yd1Zs0GdACk8rvS4NPO3cJJcRO5LjJFe4JpYawfvFgxSvluNM5
         6Rg2kwTbl5NFdWcbC24psIb6vz+PvU+w6Vkqhj8XqzWAg8YmlaqaWEkiTQ6HNozaMnlo
         4hwF9vu0KUZVRElSwya+6O5ckp5i+mxBsxkaivGsZPl2O5nSOn0qP4qMtrKNMoY2sz8p
         gidRwfmzDlWrlPcH2Wv5TaUs7JshTh7EDNIEKQx5k1bEDaqgSsKknITLUCR876c6+6A0
         EX5gflBwp7suKTMwJLtpZSHoOmnN+tV6loIX+8O4xWKt4+ymAzpq6acbrmsbcFnF1bLu
         itKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787608084; x=1788212884;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AB/9p6Nv9TlqGlJhz19Hzzvkd1Gcyyk/aG7q9mZ3wk=;
        b=Ya6ZX77dDYHU2nq5uUgk5ZFMuIq43pAXGl2jHx+/2aKMwN7rYOcbHBSo5HFXR/tAz1
         ZHwqnu6qIRjbHKxs10Loypn8iLaFQLOnYr7/VH+NS9PUML6+OSbGpKZunQZLNjQuHhCo
         l61icY+QRd7DJ/gvdjIE5EpLGSjREwAHZ6awqLcYPL7dM1n9u9sPh6luuvfYK7aNxu/y
         /GLlvTnm4PKhSPZmGDcZij0jv0XdB+IdU32v9HOH//JdO4zlGQEyrq7zOpE6IVFT+qc6
         iL48lwH+W2UHiD5Kp1WfWyyVfTsUZ8DwvPYRiyW7KI7Eu1pDmf1HwEVmzXrvjAF2As+I
         cVew==
X-Forwarded-Encrypted: i=1; AHgh+Rr8u7ZJgH1U7SSTW4y+f9nEtC93rs/QSfjN2Scm3vc5XrlYtT2VIw/zNOOHPDMqFEdQ73X/oBti0OU=@vger.kernel.org
X-Gm-Message-State: AFuF++npUshQdAbSI+oWNVTRDykIMGoVeMzbaoYYpCJyx8TdscTNK1nC
	y/A+HoWCFrcmzpNxhfVwr98Zkhv0vNEeMtmM3k+tN0lzZAUEJgTR3mv/d3riLrgICQ==
X-Gm-Gg: AR+sD13ybFgr7IWR8a9bwiQJXpno628ammfJOHFLu9fD9tatc5RLtP6FQwjerpxa3oz
	hmWEBeJE+ERRKALnbdcI2Bv48i/4hAZBWG7J9NFMa6gtQUkgQrrlr20qQOnZKyTnrMB41yRrSO2
	Ib/YSwRX0k4ZVn/Bslg9QNy/ADr++CgihNHoO7DjENAph2zqN+J01SCRpAExEwzS1EfkvOZ1LPn
	tGeYrfcD3bSLfsT/pmKhubG3/c+xlgPGiH2hxSuHogUietc5L3fvmJTq1bqkD7E4nkl29/3Llph
	qDHyIb4hPhQJOJ23wqFBL5V4o6kmhy10eM36wO+a2y8a9gLpFWWz9fTjPM3Zl3d3StpNh4EtX2N
	JzUQJhnLjHS8+JWI4qvxzgej91ZIY7LQZIJJ4Mi1QYZ3aJqDi1z2Oj+u4CEqY6M8A0jlfmXgzoU
	I5x9g1tCplvSrOtVYsJ0/RemgkS/Xx8NZaqpsAQnOPeGOqs2lDTnq6vwyn6nz3OHwXDP/jn3i/F
	UpCEqkh279YbIgDaY598P9zhzUraqF8baTwCHgdK15LjfEnHACrNhIf27s=
X-Received: by 2002:a17:903:98b:b0:2ce:b436:272a with SMTP id d9443c01a7336-2d6e07f16demr2108015ad.3.1787608083516;
        Mon, 24 Aug 2026 14:48:03 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b64c48sm1054146a91.8.2026.08.24.14.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:48:02 -0700 (PDT)
Date: Mon, 24 Aug 2026 21:47:59 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <aoy8BdBFMVNPEi9K@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260824122347.1588592-3-praan@google.com>

On Mon, Aug 24, 2026 at 12:23:44PM +0000, Pranjal Shrivastava wrote:
>The iommu_ignore_device() function currently uses memset() to manually
>clear the primary Device Table Entry (DTE), which risks torn writes as
>the hardware reads DTEs as atomic 256-bit qwords. Furthermore, clearing
>the primary devid in the lookup table before calling setup_aliases()
>causes rlookup_amd_iommu() to fail for aliases. This prevents clearing
>the DTEs for DMA aliases.
>
>Fix this by replacing the manual memset with a dedicated helper that
>invalidates the DTE by clearing the lower 128 bits (having the Valid bit)
>first, followed by the upper 128 bits. The cleared state is then
>explicitly cloned to all aliases before the lookup tables are nullified.
>
>Rename the function to iommu_disable_device() more accurately
>reflects its intent, as we still support IRQ remapping for these devices)
>
>Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
>Reported-by: sashiko-bot@kernel.org
>Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
>Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/iommu/amd/iommu.c | 53 ++++++++++++++++++++++++++-------------
> 1 file changed, 36 insertions(+), 17 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
