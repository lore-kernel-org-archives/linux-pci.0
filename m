Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4A393DFB
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654370; cv=none; b=UnWbs+FzPGYBCD8lJM59fW4CTUGPMH9RGdAZGrHEWPBTOxGVQmr7sqGnWJpwEvG8RdBf8cNqdvsxxblxR+cYCEwulWt4vggYfWUwTgy4c64IhjVawn6Vi96lBhp4knEtnJM0abxQ6JzU6iw05pVIBhh0tPyL2I5upQp2FWOgbsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654370; c=relaxed/simple;
	bh=UPQA1z6+4XvOvRe3oYbBw3Hq/r/87REpuY65l1PTnWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrttHkqa1ZqDVz7NantKIWNF6PmBqNOLXyecuYLwW0PKXp4QJbC2t9r0fcpUa1c1MlDL/TFKONEmSAOqjR+XyNHJOoCMh6NQExaiZJe3PMRpFQ78zZWlQq/GIbehLWDFiKA4rybcqP/BtbCwZZ/5Kjt+dcm+ecNO4lmldVsD0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLR8F7X4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLR8F7X4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ccdf36f63dso102415ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787654368; x=1788259168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fQimmvEugRdggoTJdTzrA2wAibwk9qnzvD9RGapkzMQ=;
        b=OLR8F7X4ZGEwf4OAf8nOxdKf/LHcFvjYRShkg0r33UNfifIrBDw2LKtKJW0HUYJ3na
         iDugtKH5eBaHOm94/I432+jPM7Y4T9xdIU52lcHgbNdpi1c9oIzDHFCOphj1sOuvCkNI
         +95zuw2tDpfVRKmAoBt72Kc2cyb9cwxlsgkdAGWXzCNCmZbUz1XJpYlUxl+u3/OANMmU
         Rzb3P94qXWhK10gm7WCrytgTVoapYOs5Ow+luatVZJcHtU4oCdoSQTCGwKtMZtV4U/vM
         S+vExqX3EgAKW1NrfpEPA9jfOsxAhtqNfd0sGUfM+ayWW4kfocT9nA/gISxQ4Orkgl+1
         9aNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654368; x=1788259168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQimmvEugRdggoTJdTzrA2wAibwk9qnzvD9RGapkzMQ=;
        b=rV/RKHNfiGo6KRhVZ+arJrfrDDl1BEfDeun+jkusWDHVhsmIuRDhwEK5Z3ep3qqSCA
         bbjk/+UNL/mPTbXN7aFMPtP7yGX5s401uT6hfSkf90/xGPAzwwcB/DXbVvp+DlhkpVg8
         zQvbfS+wCPIEPyC0oIfY+u1hblyFkRg6rCstqJ0yRO3ENkBjJnz+MIh/tQWsnAbawo47
         +4Y3HILX0AeyLvV4XLGDJUHSChEqCtEADLcOOeT5w+hzMCiewzuhRGN9iE3eRMT4bZ+C
         Oo+5tN2iVla3wI+QP+ASOW/7zxhZW+5Ub1oZ0VAecbzJWDoDRdgN3pwYbq/cMVnoRkO8
         DAqg==
X-Forwarded-Encrypted: i=1; AHgh+RoQXMfdBWVrS/iGZkTfTD/Ida5k9CKFYOtgZlZosJ9uy3Re6cmfbBrvz7XlLEM4LmG7wf4l7CZYkxk=@vger.kernel.org
X-Gm-Message-State: AFuF++mib1Dq/xa6kwzzWipTIN3+W2V5bgyzagNMxyic60gzxy/5KSMR
	u8uByVMJKm/hzn3Fw8awW08FUDi2Mwt3KUGvMiQma7l2HIHH3Ws0fOG8at884qqLJA==
X-Gm-Gg: AR+sD13rnpy8frVCDMRI/LB4ZTbeoBKbfwOokrokaT8OAp86Y1F6YitH+3saqEwTyf1
	DUQsxEX1Yf9pvUcTH9xEn5EQ0+U4S2qDsta97WxNrhVKrrXzlNUm6tJyz73oGEK5Z/cfkpWqRPr
	5hJ9BvglFvw8hQT1a+1rxARk/5gUktvJyBT6/4l4wd2ajts5Y6rYKS3NBitIs4f5JnBmPenmoQu
	awO3qV9BsbInBJnubvFl236ftj5EEDmWVcTQlqjHn5jjQvgMwMaqFIxu+XuBqW8oJ86DywVPTQh
	OYgQihnbSUrc6CW6b7Agi+0ScQq43No7shCRlENSA1tDq8kVbAkDTZhxGtKJTPTiAHUxZaOAh+K
	hjNsyBbNDVne6EYOfHLm0BVFIA4mesrtUKjDN/Bj5iOWHJ6L6S5L0UMkDOWNW0gTrg7bwBmbdNF
	b04Uu5LWNVOuogFFjUrmrAeP9dpk6obWRc1uc9L3TIMqdO4fXsDj1nQPPUxgMYMyH+BaQNw3qVa
	BCdTiJyVI1jHEefZlNqcYvW/w==
X-Received: by 2002:a17:903:2b0b:b0:2d3:153d:acae with SMTP id d9443c01a7336-2d6e036b7bdmr6964335ad.0.1787654367869;
        Tue, 25 Aug 2026 03:39:27 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645c06e02sm3307145a91.17.2026.08.25.03.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:39:27 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:39:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
Message-ID: <ao1w2dzzsSHOzvhT@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <178759520115.3131778.12333086025639368747.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178759520115.3131778.12333086025639368747.b4-review@b4>

On Mon, Aug 24, 2026 at 03:13:21PM -0300, Jason Gunthorpe wrote:
> > [ ... 41 lines skipped ... ]
> > Pranjal Shrivastava (5):
> >   iommu/amd: Refactor device probe and capability initialization
> >   iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
> >   iommu/amd: Split probe error paths to preserve IRQ remapping
> >   iommu/amd: Fail probe on ATS configuration failure
> >   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> > 
> >  drivers/iommu/amd/iommu.c | 199 +++++++++++++++++++++++---------------
> >  drivers/pci/ats.c         |   6 +-
> >  2 files changed, 126 insertions(+), 79 deletions(-)
> 
> FWIW something about this series is mangled, the first patch was
> changed before it made it to lore. Maybe whitespace damage..
> 

I see. I generally use checkpatch with --fix-inplace before sending and
it seems like it tried fixing something. I'd drop that arg now on.

Thanks,
Praan
