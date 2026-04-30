Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5D2EF653
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 21:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583722; cv=none; b=MJubQ0eD5iRc3x4IOUOnbTrFAbkyMQ5Q3lPfgXlidWv4RCCgXR6eJT87FnyIRk0wRRVuYxCpq+qgaMQ50Sy29gaXBAfpYme6B1wU42ua+VEMAhZCfvoe9LgQVmad+nMnw8ZXiR+69CBApxhg1Q+rJeLysgmw4caVjsOwb5qJIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583722; c=relaxed/simple;
	bh=inZO7ZV0wRh5CqvM/ucg9lY2CTAYKdanpisWvC3TQ9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSZpfk9ZLFEa7/6UGC8jYSUKrSAjMw/qSEGSbdo7aqhIhXRzkf8Tl+LNXI7nsPt5Psry+iu2c13CkV6v2zS/QV/a7TzSjUhwUVW4/bilDqQG0urLRZE3gyjtdZwcjc0HV1NUmF+yBFAOYIwB7UPsHX6Cv0W9i0aPOcFW4Q4qucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxMLn1IQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxMLn1IQ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d95017a68so1134415a91.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 14:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583721; x=1778188521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=;
        b=UxMLn1IQuNma/45TLDGLHz7WiSXx7C7t5cQnqX8cRydSOs+re11gX2q69MKSOFV5ms
         yzthR0GcbnPt38XRXtjcPQI27tCEEsTLsHTm7/HsVItkFHFB6kNkkqfabx8KCKV2Yof3
         5QMTGStowS9Yb+/aUll4kFgcze81ZfZiNf9dKQCD7jnAOS88QKSGDVNpMGbf7nCvNZOv
         6PoA3uAi7zNQx/tuulBDn91lWPx0TiPRc8UdtO/DFhgWQSXZsSzqqEnXVtmjyuLaOWPS
         BhV8nuFuXAvRMRbu9h1BooBDLqEWX+aD2Vh3NaB5F6bGPg2Bu7khJEKb1bhGnB4LjGk1
         C2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583721; x=1778188521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=;
        b=tT4BpJ8UQTXGiCfZ01G4AacfPyi3WMUxI2U4FM23E6IG/w90Djs//v7xe6SOV+4/MO
         RonZZrue5fZCZ731DwvFDduUZGnvjPRoQrenA6FujyZJjcM92cVKEVxRbk9mB+hGs5GZ
         FKop1FcJdBXkp7CLjfXW/2SEB3Q/pYfvU2Ustvn7Kt49xki0QMz3lJH2eZuvsPvS8nkw
         y85iTPRGbtPCfq99luG9B+bWH+r4uDmdQ1gV/2kPWLjZ0brXFAbzeiW6llJcuaAwfA2T
         S40JnC1cxonCdxj7HC2NMU5tAgNStT0Q3QAxvfU/SdD5Q00tHig2h0VQQeMQ3C5aNccp
         jgOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wO62oJTOBGWS8c+cbBUxjZKgAcmP0T/UfvsJ255iQ966RNQvfaMvfTluv+mjzehfodzx7wm1lq5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjflep/1/xNudfDE6XvdhiJRV7v+3G9EppXBrwlSYP/saMIL5
	NIaaU3TNxCfUnRJZv4AN4KvkjHcyCavISSrMxOp5OAmoRnpxy5VzmPbVFxZI6f3yEg==
X-Gm-Gg: AeBDieuKotqBpw+zTmiGJfocIihJxW4uvUjYGR5PBEn8XN3uTi4OvUPS3oSyG7lXp2c
	aFZ8edyXd4zYtb2qEWGEuHfAOr0EXOiO+sSk4JtwBSBE+4lIEg9KmjQ9UH4IZ4bIuKH5S9DgEvo
	sEazwnNhMSd/zp54QVY0+sYx0hGdjAaqfrrjLYQ6FxzMf6dkycrQFWD5bnw2n6MwgBW3DFQlMWB
	G9/tVLB2ShICQ5XlmZWLjQiR1fMA2M27fV8yfsi1/Ou0BCa3GVpt8VYGPAmaBC9pO9SPVvwZTGP
	W6g0JirJ40rWszMgDUiURBE+nMHtLXVSGXtuNjrgEanEOR8RjdJRgQpCmZBEcztvQoHavPQoaK2
	p5d2Rlei16VL8+Pjf4krseZX1kyl0m+BuQiQ7HXLYxTEuKUxzgyJ7NrXFhx+u5N/dg1aWhiWeQL
	DCYr7wMpgaqVw5vhZmn/qbycrEt6MhnGOeMAetUS8I31ZkSl8ROvfoC2vfFkB/uVMFRZpnuuMeR
	6kbf1GCr4xitwpI
X-Received: by 2002:a17:90b:2790:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-364c309bc21mr4610958a91.16.1777583720228;
        Thu, 30 Apr 2026 14:15:20 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebd46484sm474408a91.0.2026.04.30.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:15:19 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:15:14 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afPGYp145FbrvURR@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDqs6oqWlhoVqMN@google.com>

On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:

> > +	for (i = 0; i < ser->max_nr_devices; i++) {
> > +		/*
> > +		 * Start searching at index ser->nr_devices. This should result
> > +		 * in a constant time search under expected conditions (devices
> > +		 * are not getting unpreserved).
> > +		 */
> > +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > +		struct pci_dev_ser *dev_ser = &ser->devices[index];
> 
> nit: Maybe we can move this logic in a separate function as down the road
> when we expand this to add VFs and Hotpluggable devices, this might
> change significantly? It's good if it is self-contained.

Did you mean to leave this comment on pci_flb_preserve() where it
decides how many devices to allocate room for?

> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
> > +{
> > +	return dev->liveupdate_outgoing;
> > +}
> 
> Is this expected to be called under the outgoing lock?

For now this API is only used during shutdown, at which point userspace
should have already been stopped so drivers should not be changing the
preservation status of an outgoing device. So I don't think this needs
to be under the outgoing lock, but it would be nice to have some more
explicit synchronization.
