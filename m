Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410F3FDBEC
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003714; cv=none; b=h7OOGiCp50rIz457O5kZxvzN9oNgiAzmU3D1ku3VoPNgTqd5hcJ3Jk55xPMz1fKoLk0CoZE1xItzdMHMigAE4s9+ymaDSM/e4rAke6kbd9tGz1JpyIsA5MZDEyrDzguDcKHRq0Ras7aXOi2XPVoy2AmqI4o9dctgWEqjtiGz34w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003714; c=relaxed/simple;
	bh=9SIAMrTDRCwU0rg5iW6FUT/EumfO9apNRmvR4Mu0DIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMSYGXf8W3oenQgElTdx24iGtRQszFso+18PBhh5ll2RVgH2bgoYG5kyEDRb2PkPXeayyCAuCYLt+3cFHXue18IwLfr73VlRhJET8PEVjuTbl2++S2Mc8uWlcxr96ibo5gmMGR2lSO1AD+vyKMNhfrCyzYRfiZ1dOlnEUVOThms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m3YQ3ZYx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3YQ3ZYx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b1a48855so497955ad.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781003713; x=1781608513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIwRB/fzX43FvZDy8zd3F8cYltlmCTKmqxv8mTl/pb8=;
        b=m3YQ3ZYxLsZHy4JBU1Y2bdKns3I0KkUDQ/IwPPN4fyfR/j4+tT1IF1PEkO/KTNq9B9
         ZSuPJUgIiF0fIbEBVzh/w8tWjIzzsJM8IcxGjYADHjaWwjJdcLXGOKVuh6OyhgyyEJeS
         +YThBihMk7fzw8MqQUGlkYoSs2K1bJ0OdyVATxgUmNu9l8kGSScgbPHFuWTjf2f1wSUx
         EXKF2iOWWVsK6G6oPz0pIXvHXMBbjzka5hEW7ZVHbzrPNQU+/PqnpU4dl0+wiNYC4y+q
         mt37iKdhfSBUnp7aC0A2J3Bqx1SmW8QGfC3sCwzJOP7s7eKjc4vca5PdIZBmr5a44rLQ
         eVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003713; x=1781608513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIwRB/fzX43FvZDy8zd3F8cYltlmCTKmqxv8mTl/pb8=;
        b=QecBbgYg7EJc+URqRmG6JoKWzswkuO32c9PJIYN0hQQcsW5Vbn/+nJdDJhNmgyCOZa
         JNGz2D7p0XAGIQY6dNpd0j7jT8X4dwFTCzucH9PfgAqcTL1JU1jg4pBSpwSy3MSgHpJV
         4LSn7YEhtGKaThL/CwytLaYwIg3QdaPat3Xi5X1BZSXDc9eDlPP0vzqQsQAB8y7RJNSW
         edqDNEHNUOGDJFivbuqeNweR49S1+rM08UC5Fz04nBBUxrP+XsAapcQAvjsNQBWquXNU
         B39P9gQWV6FL/VyXfnrwA5S0MXrklb8vXG8zhLK/yVrIfLoDVmbmQLN0805y4elrrxG+
         MCsQ==
X-Forwarded-Encrypted: i=1; AFNElJ82oSnrmJyIrHdFdGKz8CmAsW2fq7yWHZtjJzbYBZjkxmSCyCGgM7uKl5yri+fnc46I4y8sP1la8Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfjm5RAPtyxoCL30H+dH34TTsfZDmyGGnvj7YZ+TIQXpUEPRw9
	PMT7fISpBhWZGz0tqDGFHPMxpEOnzRiMXzw9+twCm4k+bFUctqhAH78dM1RQjtMx8g==
X-Gm-Gg: Acq92OGFyF/nh/DZSnzNiJ6hNMPZAfUU8csuIOWtusOhb4Tt4C4OrUeOvQShC0/+BYC
	DzgtNLQnlXVIvahvcCXOTBO3L5jF2R0MLZCa5/Ght+jm1/Jksehyz1QhOSAAmuNX8tRV7+jKA+s
	ynE0VsachChT2NJsIXxXFvQDBMOg56L1Nrz4LK3YuCHa+S2GvUQIBDw/7CglcOzlde36PehmrTN
	ExdSmr8dOfDXBEocOfh2oxgbh/8x5vtql6AHpOf1tuNQtZNmoI6dkmptPHobcOPkwN1/npJEKqy
	XqbXAZBmJghPktZXNgHm/nNbGrlV9lsLrHh0vop1IfsGjnM428eD59wZO2vHnlGSSSgLhXVGZk6
	b8Nq1ohgjdA/rliLZ3c6eu1l7ydna2vWC8m/De9wQjQnUjcraqrfjH3naphSW0+fAB6eQF2egl/
	0ju8/PK6wQffwHvj839SyDIJ969krrO8aE8WlrtBfPd140v6FltiaKLOeAA1Puy/qklrTvdm8=
X-Received: by 2002:a17:902:ffce:b0:2c2:50c7:5894 with SMTP id d9443c01a7336-2c250c75a1dmr4219375ad.24.1781003712132;
        Tue, 09 Jun 2026 04:15:12 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d109dcdsm21430052a91.9.2026.06.09.04.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 04:15:11 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:15:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aif1tq8TvHuYwUC-@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-7-dmatlack@google.com>
 <aiSb85Ec6jW4xPaE@google.com>
 <aic1gdmisIT4sqEN@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aic1gdmisIT4sqEN@google.com>

On Mon, Jun 08, 2026 at 09:34:57PM +0000, David Matlack wrote:
> On 2026-06-06 10:15 PM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:04PM +0000, David Matlack wrote:
> > > When a PCI device is preserved across a Live Update, all of its upstream
> > > bridges up to the root port must also be preserved. This enables the PCI
> > > core and any drivers bound to the bridges to manage bridges correctly
> > > across a Live Update.
> > > 
> > > Notably, this will be used in subsequent commits to ensure that
> > > preserved devices can continue performing memory transactions without a
> > > disruption or change in routing.
> > > 
> > > To preserve bridges, the PCI core tracks the number of downstream
> > > devices preserved under each bridge using a reference count in struct
> > > pci_dev_ser. This allows a bridge to remain preserved until all its
> > > downstream preserved devices are unpreserved or finish their
> > > participation in the Live Update.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/liveupdate.c    | 136 +++++++++++++++++++++++++++++++-----
> > >  include/linux/kho/abi/pci.h |   5 +-
> > >  2 files changed, 122 insertions(+), 19 deletions(-)
> > > 
> > 
> > [...]
> > 
> > > +
> > > +#define for_each_pci_dev_in_path(_d, _start, _end) \
> > > +	for ((_d) = (_start); (_d) != (_end); (_d) = (_d)->bus->self)
> > > +
> > > +static void __pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > > +					     struct pci_dev *start,
> > > +					     struct pci_dev *end)
> > > +{
> > > +	struct pci_dev *dev;
> > > +
> > > +	for_each_pci_dev_in_path(dev, start, end) {
> > > +		if (pci_liveupdate_unpreserve_device(ser, dev))
> > 
> > I might be reading this wrong but are we leaking some upstream devs if 
> > an intermediate node fails?
> > 
> > 			  EP0
> > 			/
> > Assume we have: RC -> B1 -> B2 
> > 				\
> > 				 EP1
> > 
> > and EP0 & EP1 were preserved successfully.
> > 
> > And then we try unpreserving EP1, we follow:
> > 
> > unpreserve EP1 -> unpreserve B2 failed due to a corruption.
> > 
> > This aborts the loop, skipping B1 and RC completely?
> > Their refcounts remain elevated, effectively leaking them as preserved 
> > state permanently? (i.e. if we unpreserve EP0 after this, B1 & RC will
> > still get preserved).
> 
> Yes, but that would only happen if there is some sort of kernel bug or
> silent data corruption. I guess we could proceed with trying to
> unpreserve the bridges upstream. But I opted to log a big warning and
> bail immediately.
> 
> pci_liveupdate_finish_path() has the same behavior BTW.

Fair point. I agree we are in a broken state if we hit this. 

I was originally thinking of a situation where we'd want to keep the
failure localized. For example: unpreserve EP1 fails -> user sees the
warning -> resets EP1 -> retries preserving it later. 

But given the recent discussion/decision that retrieve operations
will no longer be retried, I guess there isn't really a use-case for
retrying anything. It makes sense to just bail here.

> 
> > 
> > > +			return;
> > > +	}
> > > +}
> > > +
> > > +static void pci_liveupdate_unpreserve_path(struct pci_ser *ser,
> > > +					   struct pci_dev *start)
> > > +{
> > > +	__pci_liveupdate_unpreserve_path(ser, start, /*end=*/NULL);
> > > +}
> > > +
> > > +static int pci_liveupdate_preserve_path(struct pci_ser *ser,
> > > +					struct pci_dev *start)
> > > +{
> > > +	struct pci_dev *dev;
> > > +	int ret;
> > > +
> > > +	for_each_pci_dev_in_path(dev, start, NULL) {
> > > +		ret = pci_liveupdate_preserve_device(ser, dev);
> > > +		if (ret) {
> > > +			__pci_liveupdate_unpreserve_path(ser, start, dev);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * pci_liveupdate_preserve() - Preserve a PCI device across Live Update
> > >   * @dev: The PCI device to preserve.
> > > @@ -321,6 +403,9 @@ static int pci_liveupdate_preserve_device(struct pci_ser *ser, struct pci_dev *d
> > >   * pci_liveupdate_preserve() from their struct liveupdate_file_handler
> > >   * preserve() callback to ensure the outgoing struct pci_ser is already set up.
> > >   *
> > > + * pci_liveupdate_preserve() automatically preserves all bridges upstream of
> > > + * @dev.
> > > + *
> > >   * Returns: 0 on success, <0 on failure.
> > >   */
> > >  int pci_liveupdate_preserve(struct pci_dev *dev)
> > > @@ -336,7 +421,7 @@ int pci_liveupdate_preserve(struct pci_dev *dev)
> > >  	if (IS_ERR(ser))
> > >  		return PTR_ERR(ser);
> > >  
> > > -	return pci_liveupdate_preserve_device(ser, dev);
> > > +	return pci_liveupdate_preserve_path(ser, dev);
> > 
> > Minor nit: I might be too nitpicky here (and it's NOT a strong opinion)
> > but naming it pci_liveupdate_preserve_path_for_dev() reads better to me.
> 
> Noted :). I'll keep the current name for now since that is pretty long,
> but if anyone else votes for it I'm happy to be overridden.

Sounds good.

Thanks,
Praan
