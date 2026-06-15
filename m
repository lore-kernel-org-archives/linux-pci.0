Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E5369D50
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567546; cv=none; b=tLu+nbBumvbt+Mdngi/hCnub00pmP1bGggIeo5aA1uf0DAqB9kdkIfDqUZTrtpvuLdW4VOegnnqwSvppf23R51jKhE6zmhz+VN4g2RVq+WPsnmUmhPrjvT4CZoK5hCs4My/yToWlJBQFHemHYFkkLvRgoZBESt1iQku9Ugx4u9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567546; c=relaxed/simple;
	bh=SOt5i2BywBkXFWly41PQ3BQqKk6IVCQhp/5l3Wfdr+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCQiDCdx5j1pzY8Hogu5MBIeOGd8bh6khTwe823ztugkZwRb4EOOuS0UmIao0chBo/zJo9mNuGzpBMfMFutinITAye/xL5wlj8/6IHJ9bfRMo8cV2cx6nPwOxjiwx1T30iA25bxLB+tWkdbu+1i2JzhvxCCSDpugcTl3lXHEsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vt+7+KmS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vt+7+KmS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2d865383so13375ad.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567545; x=1782172345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbKI26CmQkmpXGjuaVtHQErivgQSDI5Xz1YBBq2PiBs=;
        b=Vt+7+KmSubreIwphlu65ysJvm38Ij84QD6Rr0bhcdYFqgbXgk1rDzJdBWusnHsLmhF
         kknVxv/wlxE+EPXhXaHy2G4xnTK3K8wvcKD+HwrnMIC/VHs8DE9r0V+eLl9gWpPIHWxF
         bqJM0H45Ifu23Wwtvd9mZ5FhLFL82wwWc5B2AC0sHEZvL2/4n3UykXuJUYJRGcEN8A1d
         cdkMRyB+A5KXjQSUEM+p7vBsxB4j5nCmEUJGH7jyaClHTR+pbmMkYDayUJc5EE6j4hJW
         HV6RGQORGq7XZLyllGSzy3by22X65yqzjJp2EbXfoCXZKfcSMZDBdKbU+VSuNiGL2e0l
         A5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567545; x=1782172345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbKI26CmQkmpXGjuaVtHQErivgQSDI5Xz1YBBq2PiBs=;
        b=orQbzg4mKL5el0Ogj3h3JJ/sVLA7WvqQc7cpNXG4jW7j6ywTETUKoJxtg3ZDxmGe9w
         NutvPpf9dKh4goIqAu+E+QvFzJOwNwgSQTMTQRNwEcJlQbD3wqVRgKVibgOfXQzJTugG
         EAYkKS8YsRDuY+WrUM4hent3neJo5XWgYaY8MVRoiuqcp30lnlOcVaQSMDZPAFsfH2EI
         YhhXwWKiTainbyn27NIkqjwjrjhz54Hh43f49zMyjsV8FVupuMeArrRaI538l7PbTXHO
         9E8RqQYNHWL1TBiUk7OBl7UKZsbA+iO4rE0y2VFV9ChTyfgNfY4peIt4daNJQH2oEyp+
         PWeA==
X-Forwarded-Encrypted: i=1; AFNElJ+BgvLeG7Anoa2/ddx/W4JhIy0m7nGjHvau1Jt11mXQvQpardDctor3b1Zo7FMwOnegYh6vSdsD3pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOO280FY/mz15Ng4ofKv5j2E1UsFgRTE6fEdEBGGZ3FQdNXy+m
	669qu8ujBo0FDIFpHxQ7ELdwtJbYeOfZ3TJlz3WKUAaO1H0sg5eDS7/piVRRu3krIg==
X-Gm-Gg: Acq92OGB3cijBkxSIvpp+x3GoRDHpCo0qYhmRRIhh74Ka4oDLnTzIbnCEVuvv6agkp0
	mQOiORwdGvOcySw8P0GhOQOmiIs3n0V3ORuzDJcYf0XCZaEW2mklFF3QDde1Mj7KG4Dm8dO4qzF
	xqm2P9KaI96F52seJAa2/b+3s8c2XYfPTyMzDTEbMbCJl3WxfX3KryxxluJES/NS69aCOquBF4t
	mZjM9+ZsSxhUxSZ9JNYr9OxZ29yjaZ803z5sxHt/epccxyaZIsLB5N4ue7fJfunlDm4avsroA+g
	tODEycgORme+XedKRv/SxSMCrr52nhpbWmYKDE8JL91mh7QijlRk4duSFu88Ssp8UJRzJ3eeU9C
	Quc9d4u3Rpr6aaEGlg93hEhpmHDv6033Xx0jlpKBwX1uqpgBPNFjzzqiVyKs2cAj/DhXV3a8oF8
	NjlJ9b0Dz8zZjrIljppA3PJnxz2yVQB3K98229Un16kka12nhc7mKHuU9GPHu+
X-Received: by 2002:a17:903:1a2e:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2c69c30a638mr593135ad.25.1781567544491;
        Mon, 15 Jun 2026 16:52:24 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm11601182b3a.32.2026.06.15.16.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:52:23 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:52:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <ajCQMhErQ8TdFDmY@google.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-4-praan@google.com>
 <20260612133638.GG1962447@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612133638.GG1962447@nvidia.com>

On Fri, Jun 12, 2026 at 10:36:38AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 06:21:15PM +0000, Pranjal Shrivastava wrote:
> > Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
> > WARN_ON(). Since probe-time checks now preclude configuration errors
> > any failure during hardware enablement is considered a kernel bug.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > +	 /*
> > +	  * Since pci_prepare_ats() has already verified the HW capability
> > +	  * and programmed the STE, pci_enable_ats() should not fail here.
> > +	  */
> > +	if (WARN_ON(pci_enable_ats(pdev, stu)))
> >  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> >  }
> 
> I would fold the dev_err string into the WARN though

Ack. Sent out a v9:

https://lore.kernel.org/all/20260615235037.259909-1-praan@google.com/

Thanks,
Praan
