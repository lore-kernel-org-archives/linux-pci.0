Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B262DC321
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493321; cv=none; b=rPO/OtzAE/CXlxiE0tgr9Lx+0N88iZoPTC2KjYRxzHy98omPKoEf5m3Cty1D0P9DWXu/TLl6fah9scdiUxpfIRwZP1bNUZK6MRl/8yUPNqv3wL309G2wPHsImE/EoIrjU6ZqjflHJ+r1NiwUv01icQDIsduR1S8X+s+6pEEh8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493321; c=relaxed/simple;
	bh=9BWuaZqYbE2xZQJ56+qGW6ufhtqU4X4Evjgd7IH1HgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqHh6uiqwgOu9QvDQSvpLvKU3DSe0Lc5myUPCrPG6sNrKhKu7G0jTJAhU8k8xxM30ALcptlKQQ8dlkd9XH8e8Qq0n0j7BK93agw7Vb+OSbB0XRP8rxD0mhSi4r6zCItfSn1aNG44RZR6j3ZOt7wFuvhwFFfI7tlJE9wIaZ0Ht/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mODDCWFn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mODDCWFn"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5175d339e8bso486461cf.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780493319; x=1781098119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wV8eYWbv/I03NtOIpbrdNUBR1gCQqSNReaPud8ZUHs4=;
        b=mODDCWFnSVie6N7/JnQJh0bNh8N6tJb/r6Hig9QaAQY98uFGQtcDLeY2OCzWx8AR/t
         IxxQmdix6VEfXvzErJiBarEi61ExsMNSuZaJl1Gzb6V/0/FRaOu23z+xReH8r1QFpuHH
         WJ1Y61K5ckP0EyqaY78mDvxjVWWgPChgB0yV8kSYMGJgZMSGyTAkk1oFXuUgxiGyqoG2
         GAYwocKlVKNFfrGCg54PWfdIKzyuCcnT4JwQtojkCSpv8I/G/xpqYYi9ci0Kc+mY2udF
         2JLW4ZLlpSUgfq/lKdsV6E4VdM5FzyuWuklm3ijaBuMo1KN2Qcav+e/1v1vowT/v3yvW
         aPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493319; x=1781098119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV8eYWbv/I03NtOIpbrdNUBR1gCQqSNReaPud8ZUHs4=;
        b=bowzmXhp7zrb874q2m+stp7Px6LHIno14WDz1MflUs6XqwDZoTKMrNupZimWZHVIy8
         Rn6ETP5WZim0R0jfSN0qjxwpLpYrbTkNQyYS+UjfOemxa5JWL747cdGIY52ZkIBD1NI1
         3WsUnXx5YWk1t5mBE7GD3dFBQ2QkPEDh9D9CtbbwygYOkN1wfv5iIncLUg5zmWZmneYs
         S2XVp6SvLl+UMKHhStJwnw09ITG6gZ2Q4w5yj3DaD8lahJcF3Z4Sr3vVz43Esc0RVnqQ
         n7oDvFfshHMrzJXohxhfJvEaHAG+KEeUaMWVpWf7q4uS/yVr+WjAXZP7axhcKN0d3kwh
         FGng==
X-Forwarded-Encrypted: i=1; AFNElJ/es2CV/bUMCgdqLVj08/Q+f6vf1wkMaAF/TxTQYzYIlfmdf6eP/ComkM7djODf/zTObdgYWiN7EvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymuCkU6FZRuZEuwUVXPkeDMDwpffpHKjcmnJHJpbx5C3jnUi7v
	OZENGF08L4XTyKvjI4F/9hf+Lg1gomp3x+ZU0qys6CvmasmlJqq67sUtw/q3gUzQMA==
X-Gm-Gg: Acq92OEEikbElDl9ve2sjsC5ahTEnuSRNNsZ69KYTcf6W5jbFzfVWdY56IvVlAxiVrS
	yhqUGwYcgIGra08WddDcs/Vw6U2DxAfkyDreSwt/f614BwXeMuA5HVCQog3bnu9Io9J6O2ksro4
	8aEFBTKDKjTTheE91Uxb7XZ3Ly8uOuY9xW8lCLiliO2gFC5KK78x7IZnlcZeATzBXpkfGKda4mH
	M9zGjZbYYg+7K9Q3S2VGIokCODDrReAuMh09CUusFa+UkX3iaJvz609+t4ToBWiDR3K3CkOGq6r
	4V8lwzJGW0XfDuBXXb9zHjB70pB5lD/UGBx/Uo4A4iM5sTG7DgJV9EPuddWEo/wiuraE3nd4XZN
	HeNePYIf10jpUZD3Rh2kqFiPCAQrmHsZYhAXVqD9e10uh+p+a1gZTHHgEtux112nmIq35Q/iJG6
	R5qqHN5XtsTqUPOC+dqMOjFrumE9WZ0ERqPyX9QMkhAcwLB4ZmbRdxDH34m002spO7wH6Lqm8=
X-Received: by 2002:ac8:6897:0:b0:516:d25f:f038 with SMTP id d75a77b69052e-5177b9a4747mr6943111cf.10.1780493317250;
        Wed, 03 Jun 2026 06:28:37 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb915csm20063146d6.14.2026.06.03.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:28:36 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:28:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Message-ID: <aiAr_YZqVwijXyQ5@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-4-praan@google.com>
 <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>

On Wed, Jun 03, 2026 at 07:31:38AM +0000, Tian, Kevin wrote:
> > From: Pranjal Shrivastava <praan@google.com>
> > Sent: Monday, June 1, 2026 10:37 PM
> > 
> > Clear the iommu->priv to NULL while returning an error from probe_device.
> > 
> > Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error
> > handling")
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> probably add a note that UAF is theoretical at this point.
> 
> iommu_init_device() calls dev_iommu_free() right after @probe_device()
> fails...

Ack. This is just to prevent a UAF against future refactors. I saw the
intel & amd iommu drivers doing it and felt this is missing from smmuv3

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks,
Praan
