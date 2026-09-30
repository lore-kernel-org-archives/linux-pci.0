Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA17D3FE34D
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799480; cv=none; b=O80EhkCStROGy2OrrAFQ0cUaJ0jxt+Sexh/jZ1SX+PYKm1kimPZJ6KiivzZrA5meTYyvNnTOIIq+z7noCzrCu7MPxovXCOzpUpyqQGuDBsNwLcQo3Wfse+MDkYGR6V3oPNXn89jyKLVhEaOezIi3guBZ5eDGPEKxdedrPNZFHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799480; c=relaxed/simple;
	bh=LuC1yxQciN15Y1owFlOie4N8M13gYNtvgRSiulcTHP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad7LkDIaAv+Yi4I0NIgk/Ak7WLXcy6nGjkNeDhy+oacb+8UDq1BAZObSV66jC1rH6LoBndbKJ+he1SZiudV1EGamC8QfUYOMNeaKVpUEFrDLsPLMOKYuRPCHerO9Yk44ftp720qMKj7COrWHZdXeXGcSuzFZGipat4HjKSZMKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ws6nEI3J; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ws6nEI3J"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e2e4ef20beso19435ad.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790799478; x=1791404278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PHcKhVSnEwqoc+1KLjRnxGF2Mva/GHzPrgk/jJQDp10=;
        b=Ws6nEI3JCsjGlo4y6KgSOCeEEBofqcAeldSO+mRisZ2dORiVTy1Yeu4jThIjdnE2Qz
         wguwnvfg5efw9EJH6nqGsTG5/tl9ohkPDDdxq0f8N3mgWDdPCHr4SFHbJphOWD42oQ0K
         gxccxo+fKA7TwgHzaLf5ccCEGf7o0uNfUHgCWxPxeCVP0ncgbUVZF9JYfaudgsiQwFFQ
         3dDQqdnE6MTu3CZ7Aq8kYYD/emr1IaFFD0mGcBiiXoQ1zA+/zQ1I1EeyHDVA32Z6hU2g
         Nrm4ASjtwaNBKvMduGqzztlAiz0Q/OcbJm0kAcUCqjwYevYpO0II5E9qcJlNVJ5C9zKc
         XmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790799478; x=1791404278;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHcKhVSnEwqoc+1KLjRnxGF2Mva/GHzPrgk/jJQDp10=;
        b=XpaRKqFqpzDHK9gWALgwaxe4u7+CYX7lVv0by1suAscAv8mhHqBaHCc4ibqUZbscha
         GrXdIt7+a7IlEEYGXmwyrSuYItuQIqaX8GItYCrJm/SxLTEXwnoPTGCjbwcXWPgDF1S6
         83FzLQpOnR/2Xnk6li1C4Bbs39m/M88tAOHvBtewV8DofKd+sTNACZNHJbBrchGWF1Fn
         BSMDX9d5Jgk/HlbtDuv+pXeW5Z2cOZoUfUcew/PWZUjwX12DBLE2kMyHciOK3cTLdCv3
         7MzrHyS3kRgH4C3QmUjaNNKIqVCPFRf9nzjJUI/MMpM9zLMux2MmtDq9e5ODgIma4Vsx
         0hOw==
X-Forwarded-Encrypted: i=1; AKwUvBweUZnoMpuFA7WwTIo1h2T29vz2BLl5+zpDEvEjgPlpMyh5yKWaGRl4QvmeLk1QH3QVJCBNWfQch/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFQ7q9LqeJ+lzb64V0Idw+Lbh66RAq49IL9xNG19JDv/381uWN
	lCN6g3HNXDz1V/LuW3u4XSzggDdhqDTiEEGfan+IFeHHRl+x7DtB/RAJW4JTLXZBoA==
X-Gm-Gg: AYBFou33n3zdB4RghmklqxzKvlBvGvaikn/vE9RWA6LbqmPoSBR+wlurrlZv8WIunN9
	0ebf32qwLoUZeF1lRxL+myhh0fOP/wQrt5nCT6MnM9R6dnXaj2+oDHwuPN6dhroZ9IuaibI7/nD
	mTEJ2dBq6O8L/cemFpjkAr2jkGuLol3V0TPZhvqxU2rv9k+3OjigN6Dc4z/igZUCh49L3k9bzpm
	8CRGmocwkt7speeJ5mDdfrenuZqVRpRf1gq2r5NcQnXP6CmAUlOF6wGvkZKeDAom6yFYCNMVqto
	9Pmr37AuYLpPdYmD0z3M/7RmBqioh+z2TyRvyy4PqfQvmbyCqMK9rrPjxdu6YicGK8zE3bJVmsK
	kUTpg36zuNoxnBkeR8WozZkqHC7/yqe4onttGOpHFbG0vElvzU72BZEqNz9Ks1AIiDQqRhGyAP1
	gwq2l14E6mNYX/t0CwFR2A2XHDXpHegjt6GPhuySSsaomqwi2OoGASSlrLtpruo14CmwbdZeZrP
	8fz5yse4Ksug0ZxYNVb1LTE6T2ucI1vBvke80Gap3h1ysKM
X-Received: by 2002:a17:903:1a03:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2e301ae27ecmr1354315ad.1.1790799477609;
        Wed, 30 Sep 2026 13:17:57 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300af8560sm2018515ad.46.2026.09.30.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:17:57 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:17:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 03/16] iommu/arm-smmu-v3: Add arm_smmu_drain_queue()
 helper
Message-ID: <ar1ubp2nHdRIXNEn@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-4-praan@google.com>
 <ar1T1ecOPXb6JSPc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar1T1ecOPXb6JSPc@nvidia.com>

On Wed, Sep 30, 2026 at 11:24:21AM -0700, Nicolin Chen wrote:
> On Tue, Sep 29, 2026 at 03:44:57AM +0000, Pranjal Shrivastava wrote:
> > +/**
> > + * arm_smmu_drain_queue - Drain an SMMU queue
> > + * @smmu: the SMMU device
> > + * @q: the queue to drain
> > + * @until_empty: target selection
> > + *
> > + * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
> > + *
> > + *   cons0                cons                                prod
> > + *     |                   |                                   |
> > + *  ---+###################+=====================+=============+--->
> > + *                         |<--------- undrained==0? --------->|
> 
> Jason gave some remarks against this API:
> https://lore.kernel.org/linux-iommu/179018862538.3334538.17643821143626392419.b4-review@b4/
> 

I see!

> So, my PRI series would drop this patch. I suspect that it still
> has some value for the RPM/CMDQ case, compared to a busy-waiting
> alternative. Yet, it probably should be simplified for CMDQ case
> only.
> 
> In RPM case, the "prod" would be fixed/stable right? IOW, there
> should be no new commands added to the cmdq, so it only needs to
> wait for cons == prod?
> 

Yes, that's correct. By the time we drain, the STOP_FLAG is set and
we've waited for owner_prod to reach the target & cmdq->lock to drop..
so PROD is stable and only the HW moves CONS (same for the lvcmdqs).

I'll simplify this to just serve the CMDQ in v12, maybe just a sleeping
readl_relaxed_poll_timeout() on CONS until it matches PROD..? 
I'll think try to see if I could repurpose this too.

Thanks,
Praan
