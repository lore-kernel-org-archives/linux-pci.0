Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53783A16B2
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038232; cv=none; b=jaXiIgjJ5enWjDfEzStFsaFvalEYZDjjvZwA5kI4Adhmw9FP/U4OIuEjSKnyFshE70ysRyGdnuHyc3/s58IhNufJr4UqKqyVUKg0AAawrUGuxckTlqIJx2Hnx7w9w8MRecMfomH+Qrf/dMh7LE7nvot13LhQdjytiOUDrnHIswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038232; c=relaxed/simple;
	bh=K37FJrlJLgQ48xNBlfd/0e/D+IfYMnIA6C3+yZ6AfF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDcTCB4lW4BPoT4dwz8GCfWpoOEPDwUMJniIKm89tzLK0LqLOv4dOcfpLs/eY6YVsFzkc+mGPhrpeTuBrnKI03kOoRbihFbY2RINgsefp7WRUs4dDodaGoE5JVmM6zOgu5LfqdeFqGR4M/RvdbeQwglar20cq2eBqst1GW2ad6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0SuzoBi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0SuzoBi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2911f93cso745ad.1
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780038231; x=1780643031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wayzXiIvXZ+65LI5CwNwB4BPx1PsmW3NvKiQ0xrMIcM=;
        b=B0SuzoBidHBRoedq5Ea9WnVE3wiNzFrgEHFv/RnCPiWpEmy95aqkiq30AdSBgAdQZk
         skPKoCLtPEGx5GP/IISCQH2xmaFGUDUKA67kcbXExc33LFCF5jREAaibVpSCnFNYWDRR
         SRla9QfrQEnxgQSyBaZmGOG2/RylCnG+Jdsq3Fap5ypU76CxdbnjjbG6zvj3tZksZQgJ
         k8oQfasq1O5+BnCmE0job3hOpAJDkWHhG7IGrVr/Ibub4TYE4Recw/6mms7Z13AZzU5s
         hqwhfUQXiCNUubpsEaT3zyrWjo13K4ciEA7vqUb9HQyMHKfge/NlWRAlk4lCXs99qgDh
         oRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038231; x=1780643031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wayzXiIvXZ+65LI5CwNwB4BPx1PsmW3NvKiQ0xrMIcM=;
        b=bBTA6FQIKDyJ50YAMbTzhKc6K3auI2tJFdlabjU8Iist2/3QeWL6GeZMrmOPLjkbKo
         7KkteHlW4/jZ8L26SlK8csx7p6nhuK3CDyXCrPE0g35/yYwi+BYe6RBK1jKSK5CI5twD
         HtqfSg4YNCeQ1x+VG3naqIpYiGxePQeaSMcBrgzi6bixGWnVFcyYEE4l2oWrAjWp4nXG
         g42wNd8P51Uf8/3lKSbE/MgDEiOWIvnSy+FDj61QNaPYRUviA6nW4tnoX11X5mJC3VJK
         ln89+UH45uWLakLV4M1f+uBBIDqL2tm0C200TnXCyAGWGkuPZvxsq6R20pEaQalH0vr1
         mqgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IA+OkNzhp3dI+4r+9tTTexYIA+TTuNNEsH76lToL35zJA2Iq+jse3h1ASZa1AVvudJBWmhHdK2l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2pw5b36k5Ie7AOGhVSoT2dC7pWLmOfFO7XLxHPRl4h4WFiQM
	8cUTL9KY7OGID2rt/mCH0b4kHBA5ZBa/PH8byvw9pP/MbFlAqsaJUDuB2RexgChVtQ==
X-Gm-Gg: Acq92OH1By67kIAJJ9lrOzOMEWYrL/s/dU5tRamoB0/Zmn/8JUxg0CfX+et7lakIPIF
	v794Ymip0UBny/ODsWRV+XHHLHV6MH+MTyyVnbHn/mc51WzqPUBUAA67BDCeis+JcOdsXhOpyem
	PCgp/XvTsvOi+3l0p32Mq6Cg8iJAvuJHOFxeARZij2uyu/bI5rTryZqD9vgwJeSyRiNO/gJ/Nq8
	X/tcphqBQ7IoGU7QzKncy+BUKi8B3OmduXO/RoEENNh0Ous7LoSKuGLA1OetYijfQtpqt/6jN19
	8Sw5ymJuDcTZeavI5QzoCMdASWQpIq7Dyhh/3WXsD/N902t63l640YukCSc6KMN3oyP7eHrb+IW
	z4u6uzfmIBwH3UgeSOQHT2hC18F1vuYuod9wJ11FGxvHgWMMIrx4VvW7bMgzEn250Qfj5WrIAb3
	xno4lU0+R6RO/c4ZELzebe0N6sLTiK3K5WWgmUBQFAiqhypbGRMR4I4nYhn3x9mGZp+riHaqE0A
	Waiids=
X-Received: by 2002:a17:903:41c7:b0:2bf:1ae5:2c51 with SMTP id d9443c01a7336-2bf22e488b9mr1020105ad.1.1780038230320;
        Fri, 29 May 2026 00:03:50 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe12456esm592183a91.4.2026.05.29.00.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:03:49 -0700 (PDT)
Date: Fri, 29 May 2026 07:03:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Fail probe on ATS configuration
 failure
Message-ID: <ahk6TchfnjsGUzs9@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-7-praan@google.com>
 <3fa3d4c9-c083-4167-93fe-814f0ecfcb7f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa3d4c9-c083-4167-93fe-814f0ecfcb7f@linux.intel.com>

On Fri, May 29, 2026 at 02:39:26PM +0800, Baolu Lu wrote:
> On 5/29/26 04:23, Pranjal Shrivastava wrote:
> > Update the Intel VT-d driver to handle ATS configuration and enablement
> > more strictly. Specifically, update the device probe to fail if
> > pci_prepare_ats() returns an error. This ensures that any ATS-capable
> > master reaching the attach phase is guaranteed to have a valid config.
> > 
> > Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
> > fails. Since earlier checks in the probe phase preclude config-related
> > failures, any failure during hardware enablement is considered a kernel
> > bug.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index ed6d3a0203f5..f13da16717fe 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
> >   	if (!pci_ats_page_aligned(pdev))
> >   		return;
> > -	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> > -		info->ats_enabled = 1;
> > +	/*
> > +	 * pci_enable_ats() should not fail here because earlier checks
> > +	 * have already verified support and configuration.
> > +	 */
> > +	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
> > +		return;
> > +
> > +	info->ats_enabled = 1;
> >   }
> >   static void iommu_disable_pci_ats(struct device_domain_info *info)
> > @@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> >   	dev_iommu_priv_set(dev, info);
> >   	if (pdev && pci_ats_supported(pdev)) {
> > -		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > +		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > +		if (ret)
> > +			goto free;
> > +
> >   		ret = device_rbtree_insert(iommu, info);
> >   		if (ret)
> >   			goto free;
> 
> Sashiko made a valuable review comment, and I believe it applies here as
> well:
> 
> [Severity: High]
> Since ATS is an optional performance optimization, does failing the
> IOMMU probe when pci_prepare_ats() fails break backward compatibility?
> 
> This completely prevents devices with buggy ATS capabilities (or VF/PF
> STU mismatches) from attaching to the IOMMU.
> 
> Could this disable DMA translation entirely for hardware that would
> otherwise work correctly without ATS?

Ack. We explored the "not failing probe" strategy in v3, but following
discussion with Jason, we moved toward this "Fail Hard" policy [1]

The rationale is that we ONLY enable ATS IFF ats_is_supported().
If a function claims ATS support via pci_ats_supported() but then fails
in pci_prepare_ats() (e.g., due to an STU mismatch between PF and VF),
it indicates a bug or hardware inconsistency.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260519145947.GK7702@ziepe.ca/

