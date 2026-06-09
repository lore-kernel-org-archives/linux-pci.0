Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139623F4835
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002573; cv=none; b=XDti2irLXOUlmlqyyDo0x+Iq0/VSmSA4DQSAPoffuX4yFEr3K6qhzW6oQ27yv1gTFGL9QU13OpuWD8kRUmcsVKN04zYldSMJkjTOAdgroLahgy4qwrXFV17lwaTK4bCT1juqrkTG9LMZRGGwdrpBcTYrjaL+q4MsFv0N3a42lFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002573; c=relaxed/simple;
	bh=pVQ8NOIWiqEzwBktd16L0HeYTmPDW7Os+iLDh6FPSSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn53xKvNivUn2/ie/f+IB+69GlvOtGRB8JzGSKEc6MGt2npwxAqR6/PN7jQo7mceZruN74zV0hbDYRczLjHKbXGCd8/46M5XOMh90WMzp/+7i5nMhzkgknlpbE4EmnDuOMubhHO4oXUwftNcAB8vJp5hzb4kktBohtu1IzplWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQ6vg1Gz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQ6vg1Gz"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b1a48855so496485ad.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781002571; x=1781607371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdMxQIDs+l/KSPJFUNCwvqWbxtsN9baWYoGyb/P1vPg=;
        b=cQ6vg1GzVVdc3mcOeEPOPzVSfX4jZ6CZM2ya9wYX7qPg7kxQ8qK7EdAXDCJ3n4R/GX
         U7s7heGkFJJYDqOSpMP21+e6EAyucI7J3rDOTfjKdP84Z+cV+YV349HRsViR1FFMM3yf
         ZIKEci//OejBFAv/bUoHxaTOtJ8BJK+xnNS5anXuKRIZ1e0zK2jDPwEI+UNQDmPYT32J
         gNBZ5s69GRxpY3gsN9W1o5jPQa5U52cBnYkp0fYMsgohcexwn+NQGC6nQBLD+cBmiFYR
         Ua+NIsITyAaYAf7RbNzTRnuubzadI6Savqv7SAhSBpNuIYuPXdZBHDv1KiG/vvVEvnzF
         w59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781002571; x=1781607371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdMxQIDs+l/KSPJFUNCwvqWbxtsN9baWYoGyb/P1vPg=;
        b=Iff0eyY+lL1xO+ikS7A9gYWWv6hvGltUwyOi6waLomajtAjVNyWU6ai9q9O+EOPLpN
         h3Z7C+RWO4p6jzMiO4i7OayvYJ5o7+Pe1FJY+eYQ2+I46mrnBnal4CBykbyV+aODaWGr
         +QNKuleeO7FxdE+p7J7M4fEQ4oYx1q0bxxllIDencEQajNDu3ZkH4+G3y9u1rZq7d/eP
         KFk6llHJgB/GTtkZPBZMO+W9LTW3j3Wixksi4IdbN0xWKkf1ob0Zo4JtN2UYllYV/JP0
         78zpqPdZwiDRVBoqJzpLyyv71ZTjLuVUQ3Vi4Szw6h5ZMbKSHeUg4Ee0HfZ9OOE3JCiB
         9KzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8o831mIYjLZkBMsN79hB4TKKc0HPOvZBUPpvp1QOkR5+gCJeOk+gE76HqwOcY4+BYbUX5vEfXkVE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcoiJPYhpQnvSahd/2yB6fyKzL+bm+o3mp6PGUdgZ/N+MyJFF
	kumpizgBV3Mprq0k2yJA3CXePpxCMEzC/9WyxLH8uscJU3IdVDApYaz2WmD0n+69/Q==
X-Gm-Gg: Acq92OFoE3Hp5f5APhwzZ6EcN3zH/ORzB/bp773qm+ZW8EraLykOrRz/HF+lJRmHlHe
	1XGUYkbLU6youYDN3umxc72i9rkSQc8hChVbuMoBfvu2YcipEbUaWjK2p7FSBqEE1T+zj/IBYhl
	uyW2u7jgg84TVd2IpU+KVVKdH2tHUdOgLKBSpJxQUdttx/RVeP+ikBVrNYM3pqwawCyuG5et/YQ
	vzke4+7c7fYEM3Q1qeillYQMUOlhVcVqUSrVAOZcudsUVpx6X7GgwhAULgjvTiQDc1hv2w25xKQ
	DR53ToN9uzqTf3Lo6m3xO0v7cCTbw8ji2zlx81jrgRoROypv1Zht3wyGMdGcvjILGSmY+QEZG0L
	vtfe/2rjAcLobrKRd5atAzM6W003svuWDiY6cQuHI8rzEj9tqMTJoa4lCz6Z57ee24oLy+9vWgG
	D0RhcPYTmBPOW/+jLFWZjqKK087DJ4opOP04QZqYm5Y6B5YPZxcfPlsSoYmOest7K1RYQ6RFM=
X-Received: by 2002:a17:902:f708:b0:2c1:ee6e:be23 with SMTP id d9443c01a7336-2c1ee6ec5ebmr6732565ad.33.1781002570788;
        Tue, 09 Jun 2026 03:56:10 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f711e52b0sm19480623a91.15.2026.06.09.03.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:56:10 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:56:01 +0000
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
Subject: Re: [PATCH v6 07/12] PCI: Refactor matching logic for pci_dev_acs_ops
Message-ID: <aifxQalxwM_hic6F@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-8-dmatlack@google.com>
 <aiW_M7y0fFwLN84G@google.com>
 <aic46OtIKfLhdoKy@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aic46OtIKfLhdoKy@google.com>

On Mon, Jun 08, 2026 at 09:49:28PM +0000, David Matlack wrote:
> On 2026-06-07 07:01 PM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:05PM +0000, David Matlack wrote:
> > > Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> > > the loop and device matching into its own routine. This eliminates some
> > > duplicate code between pci_dev_specific_enable_acs() and
> > > pci_dev_specific_disable_acs_redir(), and will also be used in a
> > > subsequent commit to check if a device requires device-specific
> > > enable_acs() during a Live Update.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/quirks.c | 50 ++++++++++++++++++--------------------------
> > >  1 file changed, 20 insertions(+), 30 deletions(-)
> > > 
> > 
> > [...]
> > 
> > >  } pci_dev_acs_ops[] = {
> > >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > > +	    .match = pci_quirk_intel_pch_acs_match,
> > >  	    .enable_acs = pci_quirk_enable_intel_pch_acs,
> > >  	},
> > >  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > > +	    .match = pci_quirk_intel_spt_pch_acs_match,
> > >  	    .enable_acs = pci_quirk_enable_intel_spt_pch_acs,
> > >  	    .disable_acs_redir = pci_quirk_disable_intel_spt_pch_acs_redir,
> > >  	},
> > >  };
> > >  
> > > -int pci_dev_specific_enable_acs(struct pci_dev *dev)
> > > +static const struct pci_dev_acs_ops *pci_dev_acs_ops_get(struct pci_dev *dev)
> > >  {
> > >  	const struct pci_dev_acs_ops *p;
> > > -	int i, ret;
> > > +	int i;
> > >  
> > >  	for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
> > >  		p = &pci_dev_acs_ops[i];
> > > @@ -5481,33 +5475,29 @@ int pci_dev_specific_enable_acs(struct pci_dev *dev)
> > >  		     p->vendor == (u16)PCI_ANY_ID) &&
> > >  		    (p->device == dev->device ||
> > >  		     p->device == (u16)PCI_ANY_ID) &&
> > > -		    p->enable_acs) {
> > > -			ret = p->enable_acs(dev);
> > > -			if (ret >= 0)
> > > -				return ret;
> > > -		}
> > > +		    p->match(dev))
> > > +			return p;
> > 
> > Nit:
> > Should we check if (p->match != NULL) like we check for p->enable_acs &
> > p->disable_acs_redir(). 
> > 
> > Otherwise, it seems like we're mandating the existence of a match op in
> > the pci_dev_acs_ops here? Today, we just have two Intel entries in that
> > array, both of which need the match op. However, AFAICT, it shouldn't be
> > mandatory for future SoCs that might only need a simple vid + devid match
> 
> *shrug*
> 
> I would usually say those future SoCs should be the ones to make it
> optional if and when they need to.

Well.. that's fair I guess.

> 
> But making p->matc optional now isn't so bad:
> 
>         for (i = 0; i < ARRAY_SIZE(pci_dev_acs_ops); i++) {
>                 p = &pci_dev_acs_ops[i];
>                 if ((p->vendor == dev->vendor ||
>                      p->vendor == (u16)PCI_ANY_ID) &&
>                     (p->device == dev->device ||
> -                    p->device == (u16)PCI_ANY_ID) &&
> -                   p->enable_acs) {
> -                       ret = p->enable_acs(dev);
> -                       if (ret >= 0)
> -                               return ret;
> +                    p->device == (u16)PCI_ANY_ID)) {
> +                       if (!p->match || p->match(dev))
> +                               return p;
>                 }
>         }
> 
> I can include this in v7 if you would like.

I don't have a strong opinion here, this should be fine.
It's just that we have NULL checks for p->enable_acs and 
disable_acs_redir too. It'd be nice to keep the same pattern.

Thanks,
Praan
