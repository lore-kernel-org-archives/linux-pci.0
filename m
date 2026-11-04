Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822210;
	b=0KEvhl+TFvs4sYqo5chO5HO8ItfoUPaVQ/hIfGohK4xV+axYbfyKeQLwtx1PWhX76or1
	 lwUwuHsPbtBvOaGjY0HdZqgxEeqz7qUN7um63ByF+lqggdLxN8JiQMagMcL6su8GwYAC7
	 cZone8o/qTJ9gab9d0Fc7/gImOXTX69uz7GBNUIT6VlXGShFq0xVgp1RwKvpRvRTQy7X4
	 cCyNpjYtNCI18bH90DIjLiHqr6CAE7eezstarZZmNMJANgZrnPiOaTsekxGZpx2blUi+X
	 2lXA8waI7TNKwMRuINU0hbvXlurYZ4VDtG2T8AvDw1stX9lqgm0S7OkutkRo0qfLjtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
	b=fYzfKSEC4ytKLd/mu8KTw0Yy3Udey0XwwfzjhrAajvK0npBoHH/6jdMv8cvbDmWcDexy
	 0OidTpAmCiNQt6QCveVBjy2zncIu/i8boC+t7i4zSqLVsOVpW7dc16W/cNXvbHNDu56P0
	 idG38FFMlL3OEr9MvrzGJEEG+vyLX8KLH4Xcc/JN1Xn+Qke6unMo6ILe8iUBmvf8TJxS5
	 dqz01Mv5WZJAojzyRcRRiinNTYPuOUScP0hwkVsb+3ssKtGNJ2UrGCvAlXygqqQBuCSzj
	 iyFXTQy3LZV1mdUaKby7kL2fJjVrvhLUupMnie4ZY/+olbQZs2egAwQix3FCJZPXjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NOYbjt4I;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087660E751A
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B087660E751A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=NOYbjt4I
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c791d5460so14168816d6.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793822208; x=1794427008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
        b=NOYbjt4Imc3+qorIumC+DRJZJAO0qhFz2+pHwAqi1zEfxbu5bWra1k03HlG+YF8OE0
         WKjfE/pOBFyetohPjOlWRIhA3mHsvRg3GEzx+kZNd85Tcw9pNYivl5EYC1NXy62tmniP
         gfHDnSvMNrT/1wmCWo8qKmeaA6avWngSwYmx+WOENThvjaf8vGgHAM8uDVShiGtqafNB
         dZi4T7vTdEPrAERrYO9q6y9kwI0R3aYEicWhk+Jpjlz0jrkNcq8bxHaiqcO0GVGivwc/
         nsafW92bbB7UgGLKxsQlYu14YFh/SmKKEmptiEwveqc9jy3+1WkRK+IFeCBabo6QyWsw
         eAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822208; x=1794427008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
        b=te5DNUSHBZ5NymhI8ibeLYx62dFmAaIYLplsrmZ6rwk80HQoDiNWbLiPj4GTs4ECRO
         GuFLnd2ryYso2HNLzZiuHV2jSoUcMuP2MEYpboLP2esohoBTntFrjY5IXLDWE84zduub
         6lKkR7QZS7caghY8Ovx0kNLPHQIlAy1Niw7l8O3kDUKcNd3d4VOcyoZMaxr+TmLrjw+4
         PWe4CF7ZVaPqOHN1fTXu6qKl8qdc3fcdhvZkyTR97yp9L5SW0ZOvVrrLBHuTu6mRVrfY
         EKtYFSV3qeSSxM2UJLmNWoPJw+01VU/FWISZchTqjsCuipvIy4/Rtbe6f1VrnjaWnEzp
         4vVg==
X-Forwarded-Encrypted: i=1; AKwUvBzzmicyiwnXnwm1Df9RoToIySYiKrzNAhs/FQ5DRpYrJsXVNF7UTvOcMXNReKG7/GWL/vU//lMEvdQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ngy1ETXjo8fjh1UQLi6s5JkrO0bCheaK5CEcXR5Cw1v8IGZGc
	kGSPS8PhiJ/y/nKGwGT7ami/pKAQwpzXPaaL8gcGsLSMcu3+jcd2TqaNwGKFvibFk/I=
X-Gm-Gg: AYBFou3/1sFvUmBQGyRGGDv4fNcLDnWdCQwweUVF7KWTsMryeIqSHRyhAffxXDiPJL5
	yhQRCL3gSbKR6R6YCOkybFHImhR0vfJIwk741pnlAZIdjY9t3fxlmCW07OjLdiy3Uwqwl7uLsXj
	iNGkwZ3sTXdViZ+E9XaI03A9nmxck8JBhOMcbfNsv9FNFUClUTkgNrBvvYM5cHbDIH6U9KRYGXo
	SAzHXZ0WaVTqB8bn/gODatmz91eA5pME+P2mwvS4b40YpJHlRbdF8y10LyxKY06hKrsEwczjKvg
	3tiEwAjWShYEMMVfekTPK/UpGVRFL6EBsVBDTG2bEm/ixrjTKx6j9uggVF3eJAvpqVtxuNVAigN
	/vyQ384Bl0boyTSCu/px4YA1AebhI1E+jUE6L02qTyBooS6HuoWsgFQpW2FJnn3z31mhUYdfP15
	o9WRirM2RlOv7cSp8BW7jKIBTN9JRq8DA5+b7KXpc1swodBSUfMe3HGwGrSDLTSAMadnK7k5UsU
	PEbXru6NDSxT6ZGOrpHjEHkrNsdQ0SLSz+TqgjkltiFJxiolz4iuyE9yTgSifkIOKp059cgpd9x
	fm1YXERw7qr9jvXW3qEfa9oY8UYx2x12x8attvqUNiX+w83pdSyfqGR3K6Sv8SmlTnuuXxf2eTS
	1+OQqk9a6BQ==
X-Received: by 2002:a05:6214:2dc2:b0:917:9cd8:f26f with SMTP id 6a1803df08f44-91ca4b1b1afmr281180966d6.25.1793822208495;
        Wed, 04 Nov 2026 11:56:48 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e7b1e92sm27199686d6.45.2026.11.04.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:56:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOh6F-0000000HJlF-1F1D;
	Wed, 04 Nov 2026 15:56:47 -0400
Date: Wed, 4 Nov 2026 15:56:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v12 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261104195647.GD3889730@ziepe.ca>
References: <20261104084328.GP264423@unreal>
 <20261104171412.GA1247928@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104171412.GA1247928@bhelgaas>

On Wed, Nov 04, 2026 at 11:14:12AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 04, 2026 at 10:43:28AM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 03, 2026 at 05:37:42PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 03, 2026 at 10:29:39AM +0200, Leon Romanovsky wrote:
> > > > PCI P2PDMA applies Request and Completion Redirect throughout
> > > > both paths.  This misclassifies asymmetric and nested switches,
> > > > and reports one answer for every kind of TLP.
> > > > 
> > > > Three ACS controls act on TLP attributes the Requester chooses
> > > > rather than on the topology: Translation Blocking and Direct
> > > > Translated P2P act on a Request's Address Type, and Completion
> > > > Redirect skips Completions carrying Relaxed Ordering.
> > > > 
> > > > Evaluate each direction at the path divergence, decide every
> > > > class from the one walk, and treat a client with ATS enabled as
> > > > translating unless its driver declares per-mapping ATS.
> > > > 
> > > > This completes the P2PDMA side; dma-buf and mlx5 follow
> > > > separately.
> > > 
> > > Is there a one- or two-sentence explainer of why we want this?
> > > I'm thinking in terms of what Linus will want in the merge
> > > request: a fix for something that's broken or some new
> > > functionality.  It sounds like this is solving a problem, but I
> > > don't know enough to translate the nitty-gritty details to the
> > > higher-level user-visible problem or feature.
> > 
> > Not AI; these are my own words with grammar fixes from AI:
> > 
> > "The existing implementation of PCI peer-to-peer assumed that all
> > PCI TLPs were the same: ordered and carrying untranslated addresses.
> > It did not account for the variety of traffic types defined by the
> > PCI specification. As a result, only simple systems supported
> > peer-to-peer transfers in the upstream kernel; real-world systems
> > required out-of-tree patches and careful platform design.
> 
> Can we be any more specific?  E.g., what makes real-world systems
> different from simple ones?  What does careful platform design mean?
> Something about ordering beyond what PCIe requires?
> 
> ACS P2P Completion Redirect affects Relaxed Ordering (RO) Completions.
> Translation Blocking and Direct Translated P2P affect Requests with
> Translated addresses.
> 
> So I assume the existing P2P implementation breaks somehow when RO or
> Translated addresses are used?  How does it break?

Let me try, something short for Linus:

"Enhance detecting if the PCI fabric can support a peer to peer path
by evaluating the full bi-directional fabric path over each of the
three traffic type ACS controls. Expand the number of fabric
configurations where the P2P algorithm makes the correct determination
of support to include non-uniform ACS and situations where translated
takes different routes from untranslated."

Jason
