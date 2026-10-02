Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78354570F4
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975514; cv=none; b=q9PQsC2ocgjNnBjLTztYsX2y+qH0SOGSd4/O+naK5U9y2Mr00knV1eQM9BjUihP/zuPFK7lF3MCjpeT1NyGyGqCy5qTrsFsVRD3DSUzJge+biZNhBeE+d4OzjJmLupV2DfS+YA2dgj90Rqx7J/Kvo4tLB2teWVxNVCwipDixEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975514; c=relaxed/simple;
	bh=iOrHGz64z0wKTg4YNpqTI/tUIfNY75DEXU5oPmbSSps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=en34zs2cbJh0hmiaYllubiQ+mOAjfxfy9pEFNhi7YQbypH8sFbpdT2jv8KR5EzKybcIoFE7zcrErRW+hEuVRZUEJ44X0jCizLvmDK8lZX7Jx3RBwN9GcMhmloHuQ2KDfwyOZHlfh5mZwd+zE1IgMBcQcC9FzNJPoMk3qyfaVILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6G0Hr+g; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6G0Hr+g"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b445a84fso20525ad.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2026 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975507; x=1791580307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aTAI7MYZpbnU/agtQxfkMDXpGe2YnzBKn6e+VLjrcQs=;
        b=q6G0Hr+gsATNOiGjgjZRfqLksZ4xHC5t2jrdNJJO6ojpxul1Ku5ET1K5Kn5JUoCowC
         m1GCDYXHnEwwrBUNTvJFbKdq5IoFBzxfizrRHTS88ajTMR9IAoOvzJphsZJwRMMHdKcT
         9aMTlSHBWP4xP9IH4jXf/xrJcFsy5UjmNZ4m+mIIsv2ZbAfEUbQ8nRzFQlyY5pxzU27V
         jygdSNGVj9cXX6qSXOtsmcFfIwLq/TiM+JppfYy/7VOQZLsiW5WvbleJVRqpMXHGER+n
         ZRTJFkbqgzb75Cw3yRfRLpdaKRa8UkJ3UprjlMBoIqxo/QslMF4PI5cz/EQwAU4s1pBw
         +8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975507; x=1791580307;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTAI7MYZpbnU/agtQxfkMDXpGe2YnzBKn6e+VLjrcQs=;
        b=wx8vpyWayrCMoqKOoWGtlk3OroIQmK5zkqmp24AZEIRwlC++Ww1fZT/S7IWbgUb+8x
         h9dK7c+c4Z6Uqgb6cAd9RFscYnGhH4Z0G6tKjhUlBhmxVA2NCKwRez3IRmw66IIkpgFp
         hnTzcQPXPuBbToqKHr4scrM8o2MokIfUxo6B0z1BWk5Ka5sMi3iXfrZ2iTWgQUcQbYfB
         PayIMcWajYhtk69pf2Mx4cqI+lsZo5khRGA77D1cwrUl+nms4NAJruOeJ6T7PMTuu9KM
         1+Ph4BeLhsyTGcWrUuqjrREX0sobcBReqhHCUxbbi70VmbYjwLrSfb98Fl3xe+U+vT3I
         T6lg==
X-Forwarded-Encrypted: i=1; AKwUvBwg47rD4H5vVEQgeov+ncJ4pPxFwVcPvZ8E7yatupIMa8r1pDHrmWLTuTiOBiVC7osPdAH5hTMz79U=@vger.kernel.org
X-Gm-Message-State: AFq9FYISFFtEcTitTe+hmTyLIX7SQulM0pO91yyHap+0JccgKLfDukah
	QloZCZa2Gl8JFtEGcXMgsmlzaUGAGwVsaqPJfWeygVVloM9uFRuG0IPCaBlnzxPrOg==
X-Gm-Gg: AYBFou2y+GbDI4I2d3gn/OKmxan6UGzkcHb3jfoaHWk/QnQotr/cGRNv3fQng46edyj
	NG1JmdTHvXLhafHpDh6zoXnbj4b8Gn9/ybItWMblgP12x2/Rk7GaSuPi810dsjTXIhvG64Yv9Ra
	8ow8iWX1KcjhyZ9/+Oa8dE96QiKa6sihX5ItH+QJI4Ri5dZuNobvUVVCaTNYStuJ+86LaZW7v4s
	1GaPoqLb6xcQmmedyj4HvqQs3ulNQGdPof8mqvGuw49saYF+ZXygm9Zb6AvpTf40nG3YNzAtmom
	jihS/sMGuiqlimA3DzsZKwa9kgGJqx3j/NafxdwbOV/UicYXR5df4BkyDjvf8vn/vpQHOj+YBq0
	lg93wQ57qgS25URSKSZaaQo6RfS1TFdKXKcm5jcOKD+7ERr58gdKLmCNUPHwxO9siJJAKQCqtB5
	0Fw8lodcStMnvhDH+/c2Sz+vhs4eaA4lLaCJmsQjPfJGR7+HF4+av7Owq340TUC9Nt3TGhoottB
	i1mysvtW4Mfm33n2mvcwrkRf190OL0BTQm/
X-Received: by 2002:a17:903:b8c:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2e53091f83bmr1274215ad.2.1790975506423;
        Fri, 02 Oct 2026 14:11:46 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e497230sm39218a91.11.2026.10.02.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:11:45 -0700 (PDT)
Date: Fri, 2 Oct 2026 21:11:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <asAeCz_rmpe5hbsh@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002164748.GD3481470@ziepe.ca>

On Fri, Oct 02, 2026 at 01:47:48PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 01, 2026 at 11:03:15AM -0700, Nicolin Chen wrote:
> 
> > > So we can't issue ATC_INVs during suspend (the EP is already down), nor
> > > during resume (the SMMU resumes *before* the EP is made active). The EP
> > > can't use its ATC while suspended, and if it loses power/resets on the
> > > way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> > > back with an empty ATC.. same assumption the PCI reset path makes today
> > > (pci_dev_reset_iommu_prepare()).
> > 
> > In that case, would the STOP flag be too late? It's only set in
> > the middle of the SMMU suspend. So, an ATC command (via doamin
> > invalidation) might be issued prior to the Point of Commitment,
> > which will be timed out due to the unresponding EP?
> 
> How can you ever fix that?

The unfortunate reality is that this gap exists in the kernel even
today.. upstream SMMUv3 has no RPM, so it's always on, while the EPs can
runtime suspend independently. So an ATC_INV can already be issued to
an EP that has suspended. I'd argue RPM improves this slightly, since
once the STOP flag is set everything is elided, so the window closes at
SMMU suspend instead of never.

> 
> How does power management really work, is it expected that the end
> device is already quieted by its driver?
> 

Yes, power management would topo-sort all dependencies and invoke
suspend callbacks accordingly, i.e. in our case the suspend callbacks of
all SMMU clients would be called before the SMMU's suspend callback.

> Could the first step in power management install a blocked STE? Then
> we don't have to worry about ATC desync and that automatically stops
> generating new ATC invalidations if we go and detact the domains too
> 

Partially.. at SMMU suspend we set GBPA to abort and clear SMMUEN, so
nothing gets through while the SMMU is off. But that's global and only
happens after all EPs are down, it doesn't stop ATC_INVs in the window
Nicolin pointed out.

One way to ensure the ATC state is relying on the PCIe spec to lose ATC
content during D0 entry from D3cold, or D3hot with No_Soft_Reset=0). 

Another way to enforce this, is to *somehow* ask the endpoint drivers
disable ATS during *their* suspend, i.e. in the EP's driver's suspend
they could call pci_disable_ats or a better suited helper from pci core
and the in the pm_resume / rpm_resume they could call it's equivalent 
pci_enable_ats, counterpart ensuring a clean ATS state. Or maybe the 
pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
suspend/resume?

I could mention this explicitly in some comments or dev_warn if any of
the masters have ATS state as ON during suspend?

LMK what you guys think of that?

> Maybe I'm wondering if power management should involve the core code
> so it detaches all the domains from the device, setups up blocking and
> then the iommu itself could power ofF?

I'm slightly against the blocking domain attach because it's a
reasonable ask for the client drivers to be able to dma_map / unmap when
they're suspended, given that most of the modern IOMMU state is
in-memory and the only HW state is some sort of TLB/ATC maintenance. We
can map/unmap when the IOMMU is off and just ensure a clean cache state.

Drivers often want to pre-map everything, power ON just to run their
workload, power off and then unmap. 

That said, I agree it would be nice to have the core code handle power
management, which can be one of the next steps. (it would be complicated
to see how or what each IOMMU might have to handle for power mangement
in a generic way). 

> Jason

Thanks,
Praan
