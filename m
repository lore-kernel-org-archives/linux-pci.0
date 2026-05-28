Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59427254B1F
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000083; cv=none; b=kwUK1QD4jnxZ8EDrRr00w0efhFHdSHPApqyZWpd/kYLzWyL7HsxDL9Lt+PgeRk0GZZUQSsXwDEhXV8XNrF/JEilyoJLQD0Flg1ISjZr1VGFBBoSxWXsrP13Z+2EkqM6zCSafstBfuGSYdZkc3Qv8ijGr3lhDZqx5aZLk2q4PJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000083; c=relaxed/simple;
	bh=zcMMUMnHH7CIUa+4+Lg1jZfdooYB9e7ATSCdzCpDQM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoEKQy498tGWA+tI2oZPiC9sdCwFDkhBAfNIo/bXPC8RiuY4WAf4CU6nPKoYSlqBLRMfWS9DY5yLw+1GjH4AaDcJfCRLz6LLDswGKwckeh1rq39MzsZJZGEQjE3iWfdnfdQ9sVt3FF+a4HqUjRt7LELpgbJHEz1eJWa66d0l64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/fmqgKL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/fmqgKL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so305ad.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780000082; x=1780604882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5q3gOIhDAVqYSRxkfcmclYVTj3UlMX250M/GhPgP2Y=;
        b=c/fmqgKLJPzHgJ/eH+zOz+IsIoqFbtZg1FUNiRrhN0lKcFnXx3rXteweBwBfnh1MQl
         ZpAFyK2acWTGAv7zYraewGkYMgLxBTc4P6R5oMwQFbEUCpX7BbyaT4m7OBNazu2xTVCN
         qKnt5b5+np2GLRg0Lss7V64b3kLgLdhibnXkBzgQA0dAwNBJ+HiU8H56MhzIF6W9Qhr7
         qlcFViyn6nBBb2YtJWw9lAYqzxb7QFC7+BRg7tWT56DLlJbYXYD9+8p7EfwYJ+anPfJV
         12cXXfErpgfSok6cY4bKcnXgEeFvG9BGO0uTCJtj0R8HEa7+OAndftplE52R7X5cLRNG
         RJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000082; x=1780604882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5q3gOIhDAVqYSRxkfcmclYVTj3UlMX250M/GhPgP2Y=;
        b=Da8Vr43v4GS8D2ZpWLRJhgRjxdyL2geTNcTHmqghYQAX2xv/8xfuY50gGLa4BTvDP6
         nJsBYG0R0iBIoOZGzSnvodEJuqc1U3yUVhz7SBhpqbxxnq1iAf23+C2EHMoF3T6OXjoB
         MliBevjAAzQcfFgYzWrzseFaGz09W+xaE7KBfX6RpEtKGG6V5O/3L3iXa/rLem0Eq0kb
         lyy0yZ+jlmPqgx7fAVSVAV9HAj17gdfdRxHjrKJ4obfFLCWIQVVctPMwzsh1nlhl/EPq
         el66pKM+tudBdOrn9D/8C7X6WaFnBQJxS/pLrdmbFdKlnE2I+cg/3NY/93wpKYhdJyXw
         AGtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8C8e7GX0s+0dHcNq1kd8AuuFttvK1CC/I03gz383oChYoDPoHvVAx3g+n/sgswJhQ5qvVGJrjrRu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDIVRkPPwWrPe5Wk9bNeyCR5NfLJ+VT4Irm1ab8CdJFZEyQMP
	oDwqim22taNV4ic3K1EIjiUdd8Wf0Z6mpQgpwiDWaJDuPdYEE2AVf7rsEmHtefW9kA==
X-Gm-Gg: Acq92OG/K5KUuv8GADFjiwkBjOmtSr4//o775dzS14RrRGOlh4IqogUNM/QFgNwk2ka
	zhenC7BdxpsCy90ghgCcMsxeBZ1i6yFAFPl7ow/F5EnbzhGBeuQqsT59KTX6R0Esbr8jcGUPJba
	T53ZjlvGQYEMbnuW7CXO8Oxb+odQtZ6J9JKZAdxrKNi8op3jp4+dD0X1s5e4WNiya/zPnJezNL0
	qHGRezPzW4XjQRHWxKVcbOX+LWoUfQXJgCBhCf4x9T9vvTNTO2I69sVdCtdOLYWcGnZZoB8kD/O
	OqysG7eGlu/Kj1bJWI5AIE2qYQwrUjY+rujJevsJksoFQlEL0PJNF5gSZxd5Qjnbj7nX0p7Dlh+
	jYL4T4kEUI7/bznheUIAIgYQqJ3Bq43QGoBtpNEmWDBb49bb/XQaqnlWekUNt20oP/KTYXlmjLt
	ghJ+RONEB5C+3kgOclrxiXvFMD8+PXhgTlADZyPFe6r0XssfwXu1ehdoMftqrZzKAHyiGdRah7j
	rdmHUw=
X-Received: by 2002:a17:903:1a67:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bf2046519bmr36625ad.25.1780000081220;
        Thu, 28 May 2026 13:28:01 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8572cdd391sm167499a12.0.2026.05.28.13.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:28:00 -0700 (PDT)
Date: Thu, 28 May 2026 20:27:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/5] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <ahilSL7sGb1pnq5I@google.com>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-3-praan@google.com>
 <ahSnLeKchpPbz1m9@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahSnLeKchpPbz1m9@Asurada-Nvidia>

On Mon, May 25, 2026 at 12:46:53PM -0700, Nicolin Chen wrote:
> On Mon, May 25, 2026 at 06:43:44PM +0000, Pranjal Shrivastava wrote:
> > While every PCI Function that implements ATS has an independent ATS
> > Extended Capability structure with a Read/Write Smallest Translation
> > Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> > driver to configure the STU on the Physical Function (PF) before any
> > any Virtual Functions (VFs) are created.
> > 
> > Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> > PF has already been correctly prepared. However, this creates a potential
> > mismatch if a VF is subsequently prepared with a different page shift.
> > 
> > Update pci_prepare_ats() to validate that the requested page shift (ps)
> > matches the STU already configured in the associated PF. This ensures
> > early detection of incompatible configurations and maintains the kernel's
> > policy of consistent STU sizing across all functions associated with a
> > given SMMU.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Nit:
> 
> > @@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
> >  	if (ps < PCI_ATS_MIN_STU)
> >  		return -EINVAL;
> >  
> > -	if (dev->is_virtfn)
> > +	if (dev->is_virtfn) {
> > +		struct pci_dev *pdev = pci_physfn(dev);
> > +
> > +		if (pdev->ats_stu != ps)
> > +			return -EINVAL;
> >  		return 0;
> > +	}
> 
> pdev doesn't seem useful. Dropping it reads better to me:
> 		if (pci_physfn(dev)->ats_stu != ps)
> 			return -EINVAL;

Ahh, I missed this nit in the v5 I just posted. I'll surely address this
in the next revision.

Thanks,
Praan
