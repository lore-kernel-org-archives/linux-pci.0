Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40263233E8
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202564; cv=none; b=ERgYMAXE50K/ZxgIiEICk4XjqzYJddhiEI/aekq99ejZu7u6tuBpqDmDA1s6060JZu2CQFwlFollU9CBPWQ+Gdf30U0gJW4abVL8c6iXHs0S/FeR74Iw3TPoldU/DJHTrxLkSBHHmrLhtgrpwsYmX0GV/3H1CvasQA+C78ArooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202564; c=relaxed/simple;
	bh=UTruZ0htNrfrig+4Zj/f+VTgHemhS2OQ5ihVLvJ2sCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZJMNth5DkRzCJve4YcwkUlpXW5uu1aBzq7OatEEaByTP86IIes040hUNy/U9zy4D+XHpfWGziTdJPXeXwF2lK1BCK79DdxPrpxpiC2zfD5WfmHX/4QZPYNigdFrO7SiNw9gTXJUC4+rY+3fuz45d+Pl3GKPbKcKOl8tW1rZSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CjxSXxhn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjxSXxhn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1175ad.0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779202562; x=1779807362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UobWovSHeOsX5hqrU728+VOS+TFZATYzmVbruY5nx+A=;
        b=CjxSXxhnx0Bxqv6hcF0ZHW5nMR2a30+A7dODt1sZZ6Hw1H4j/xmdgpDde7ct2evHHK
         z6+xQZH0ZBBbcBkP/wIARe/tsB0+rRWeTXJPgB1x5zX2meKdsNeb35I06tnpRHhUpIZJ
         OYyCqsKltkoCild865GYng1ejSBTPVMHMapDEz3aiRU6LD2VOuva0rDCMO/XnZQMce77
         61KxeYOLfosrH+Vd/W9PagtHsCK7cVJhJCgX8+GnLshfQl/3ILOapQefbowlqbOr2BBk
         SOTav74bVTE0+7dM7RuvLlJ/T5wCg9z4jjZqcTREkWRVmqcVAsfQjGRlqwUeYhhLdOKl
         T48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202562; x=1779807362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UobWovSHeOsX5hqrU728+VOS+TFZATYzmVbruY5nx+A=;
        b=k5+ZMK52HCd18fQjrbDtMFZ/qX9Y0M2BccxflY9lKcI9FVFnfUipCEpryBl8dbDTSk
         w+KmOYwmdksz2gtynt+rhDwwl2Y0l8V32/Pufzcp+Tt7npORF1gwn086iqviYQxgh3K+
         gwS8QHxThLKLtsg7VZfPVnZ1Sj8NGWQB83FLNic8D/hWaDNhZ9Y1uICfqW4jSKbxkjZk
         Qf9hlVnpbLFYrKtMYeZQCKbjgggqmDBG6VvXo1y5xVRLoDeUTWX7tr6Ag322vaNkvD2H
         bhCB5ae7DLdPvyLzUik5Pljnn3xQhhTUtsj2w/uNwrKYRXzhjrpwffMsIrv6U8aMFExy
         YnRw==
X-Forwarded-Encrypted: i=1; AFNElJ9UE0tYQ0HdsIOmZR/NKIoM3fJ109k50ijaL6FThS4tEzLhfqSpUAZnjLHleMBNcdxFJmnj1AKXvuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gR83d6KHyBW5DEBKkUKNLpV1B8YBRba2FmWXQw7qs0LzxHqD
	/eD7xreA94hD0g2oBGFi46U8humys6RTUFoG4jMAVtZZQ5idjzBmtqQnecm5SKJ6hQ==
X-Gm-Gg: Acq92OH8T+VcLh/1ZRm0wv3h6dk8g83nCL4DZTX2KxVgb1GpVzY35c4CkmRVMX5f839
	TyQalHR6WY3zlypl1/CNXzRUcpQvUtuR6RquyOTksTRvpdhfs5kqKeW0U+zloIBqbl9rfqz9LFa
	KHU/6l6MEc1PWFB7i2ONzV4QN5Mse7ZUxvQnFI2EX0BywcRcnPFP9N2c0oyBy43U5ezlP+nZarD
	TTb/mmmblJ8Ya76Ip4K3s59LDJWhVQcPzrXG6P70WUFrjxLH2yj9aiPQhef67k8qkpAvTni2p1K
	Eo2NM0NPXaCmPSxUqKDwfRRbGxtNEdqsYsaCrx4T3+xuHggU4ls/QzhtDSEtbfPwk5skGLtthu8
	iAU07rEKQMSisDOl0U7OheqPtnvSoDk/sfmg9KyVVfsPws6BOyfqSMTMrHdYZ9kPeWyQwFMBjty
	n8LpNx+4tGZCBpDRyE+MEf2GbcqTn4062pRjxn5r52QDJLwPqNVf4w0F6R1fFnL81mdfqITFRCa
	EZCXeE=
X-Received: by 2002:a17:903:2a8b:b0:2bd:6dad:3dfa with SMTP id d9443c01a7336-2bdb04114e3mr6771465ad.24.1779202561421;
        Tue, 19 May 2026 07:56:01 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe47c8sm190356995ad.51.2026.05.19.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:56:00 -0700 (PDT)
Date: Tue, 19 May 2026 14:55:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <agx5-jFkU2skyEos@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519144430.GI7702@ziepe.ca>

On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >  	if (dev_is_pci(dev)) {
> >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> >  
> > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> > +			master->ats_prepared = true;
> >  	}
> 
> This should fail not keep going, it is a kernel bug if
> pci_prepare_ats() fails.

Are you suggesting it's a kernel bug if the STU doesn't match?
IIUC, it can fail because of the following cases (including the PF STU):

	if (!pci_ats_supported(dev))
		return -EINVAL;

	if (WARN_ON(dev->ats_enabled))
		return -EBUSY;

	if (ps < PCI_ATS_MIN_STU)
		return -EINVAL;

	if (dev->is_virtfn) {
		struct pci_dev *pdev = pci_physfn(dev);

		if (pdev->ats_stu != ps)
			return -EINVAL;
		return 0;
	}

If ats isn't supported or if there's a STU mismatch, shuoldn't we just
ensure that we don't try enabling ATS for that device? 

Returning an error here would fail the device probe.. which seems like a
big hammer for devices that can't reliably use ATS.. I see Intel and AMD
IOMMU drivers don't check the retval for this pci_prepare_ats but check
it for pci_enable_ats.

We have a special case in SMMUv3 where we pre-allocate stuff in prepare
but actually enable ATS in attach_commit, which IMO neeeds to be gated 
based on client device's ATS capabilities?

Praan
