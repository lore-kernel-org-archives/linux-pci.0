Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28EE47AF5D
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630853; cv=none; b=JbslaVvff0z3nhPtdBWtAOM0INCM6pcxZWt1du3cboqgVPm11DPMHZGyolyF5N9RNIsRoX6BTd7QNgOz2anGFcy90OGe9AbRGCQ4hzcPuScAi9qbg7psePFEL76i3yq/HKtjkx14fvcZhKis9tFrQh5XOG9orx/WNWPJe/VQiJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630853; c=relaxed/simple;
	bh=VtjaadP+F0YUxb65uRur5r6Bmp3C/5715zYvrg4FlHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRSQUCrekX49mO+jrCp0R2OpDWTB1j7PsWHvNkOne59rtrX0X5RqqQgQ20rMgNvUML8nkKKqwwBXqI4fZxF0bkm3VB9kct0jYhyB3NiMx0F20TCXbpSIilUQsDO/C1+c1kmWIymlsNQGJjLuJ72uo856avxveOCuBefuK6BooyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jIsKFfN1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jIsKFfN1"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-517a5cafc3dso52491811cf.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781630849; x=1782235649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbojEdCp9OpH0p8tfFcuNMVV5jC/64+CSjIGMdMdWB8=;
        b=jIsKFfN1K7t40T3Z1eYuR97Qnfs+SCeTuq9lnwCs1kzqD+2fNfVQJVjLC88sJ1Oidn
         RelY8h4rWxu3ipVELAkLDuTsF/hG3+ErzMLv9Je83yjVLgaiMrCfJ4OrqOsXSF97Y9d2
         lIDOSvroeYilx9POcj3elQqm6EIKWxAe7JpQWiHc8SKBZfQanyiUqw21vBrq2urXmG+Q
         uomDd0M1HSIjiA1yZgf+NbmZFb15Cz+wDHdm+y/YuML4iIWKpI/ZTMMJ7VacS2gw+7io
         5REGh0zAn75XqJybPBka6ZcUdZ9jzaQLNIx+Eu2Z1q7LYMK+aXjP7QmVwp1CT7seIOEY
         EvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630849; x=1782235649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbojEdCp9OpH0p8tfFcuNMVV5jC/64+CSjIGMdMdWB8=;
        b=NMiH7kcIaNtAItT19nijQgNwSVDOWnEQ0ZCxMjiWyQvYJMYzDul10AG9EBsfsBrAT4
         50xYOhWYS4XLzYCjdoGIwgpoL2nSsUNV0sG1K6NmSAipqCSr4YvayXtngGPYmfMz7iRO
         AdXEeJq/Nha4ImyBmbuyMtzlgJLcprVnmr5y3oad7wy7QeHJiaLeaMP5ZQBp4dxA+FQM
         L8KnATaHNoIG+P3XIkJUY5ja0P2yC3jgx1Ee23Cs50wVxSxeDZL5sVHfxAfXheQLSSSd
         48MB4WyDnGrUtuMnaxxnSjYC+AxSHuAdciLxbEicuMuWfhpbuFirEa7lcpqL5DC2GJQj
         errA==
X-Forwarded-Encrypted: i=1; AFNElJ/Kr0ZyMrqcHuXOdtR6tQJDCPeSWYy3SNq3HVAET4A3Z6woQLpQUlMbXvZP+GgGtMLfItkmTAbulu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72n+CXoCrOeyM23oTKajvhq+5FNVLwS6BbXErBoz6j2SkXqpu
	sU4GnomYAjDut6/PiLD5l3sjWiu2n2TPGTy769IPQxxv7W2Obq+LlfoM8rm6xkjGY50=
X-Gm-Gg: Acq92OEvLsD9Ql/EhNsLe1WCJRKs25UuReVxLran46oE5drml5c+C8JtFMED+49sPn6
	VuAvvfME+ksrxgBUeE/pNHCDtk0w3aAWTHUZjV7A/CA/LlhCSlUs7QKtvbF2DNklw6w1grrRquy
	9SHG5IwK8S2d7ZPqeyVEsjpKnhZsNqBqd7QdcOXGfttCeVJ1w49mDu1VXDmpCgxV4kXYhPMx22j
	OlN4RvF5f8snis8kklVJCxs923i4n7PO15LT08N7ItbVWDvSVL8a37XmhRaQbTL2gnczOrnVW/B
	BpHpqwE82CFmb4S6eTes+0KtnTnUriALoNFRm7yNHCpCGjktfVjm63md63p7VwMSrHuw1m/MPjZ
	J2JodG7z5DTIG0zxf+TUwUbB2kWbTOFpYHLaA0AAVXwq88hgvwLmghsVqd3cOVMeoBeCsxmhd34
	oHtllXuxVdaI54HpJI2R9COScrdVCt3km9mxd+EhAZaVDCyI8dFuNuumyI0fxLvjwq/H96k3ddk
	Z8uCA==
X-Received: by 2002:a05:622a:4897:b0:517:7d99:f32c with SMTP id d75a77b69052e-519a8e5e259mr6448551cf.32.1781630849518;
        Tue, 16 Jun 2026 10:27:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb83e8e6sm156638201cf.28.2026.06.16.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:27:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZXZQ-0000000GYyO-259c;
	Tue, 16 Jun 2026 14:27:28 -0300
Date: Tue, 16 Jun 2026 14:27:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Chengwen Feng <fengchengwen@huawei.com>, helgaas@kernel.org,
	wathsala.vithanage@arm.com, wei.huang2@amd.com, zhipingz@meta.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260616172728.GC3577091@ziepe.ca>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca>
 <20260616105754.784be22d@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616105754.784be22d@shazbot.org>

On Tue, Jun 16, 2026 at 10:57:54AM -0600, Alex Williamson wrote:

> IMO, this implementation in sysfs more so proves that vfio is the wrong
> place for the interface.  vfio has a use case to consume STs, but it
> doesn't produce them or own any of the mechanism by which they're
> generated.  

I would argue only a VFIO user can consume this information so putting
it in general sysfs is overkill.

> The weak point is whether this bin attribute, exposing an array of
> structures, fits within the socially acceptable norms of sysfs.  

I'm pretty sure this style of sysfs is not accepted and
counter-examples are things that are ancient or slipped through.

Jason
