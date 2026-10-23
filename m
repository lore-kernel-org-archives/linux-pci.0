Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782054;
	b=gSci/+FnalQ9eZvLCBbiy7QebAmr0pI7PCCX22K3nuXcwOeJJ26Zx2bjdjj+F2GG1/vY
	 mTGrF+moWAozanMnhcqOmdYrC1/rhNM0jBv74KPt5aRoVJuTuDG4nXweOYNExFq5WeUz3
	 Kt0ELEAje1mWSVi8MaRYxVIpNELRk3xM9GiHBOD0YnofE0gLoNO0uFJG3Ar/u7Xt5AoWe
	 1aWLaiFtQQu12eDXWxa9e5/cfCdVtTreBtjdvt/Pa39xtMhjzqe7OG4HQrR0xuriIxcEh
	 UgSIC9AcM/vFNPsCxfatvLmcle8VkM1xFX01eXxvrPz+HbLD5iOWeD5TcNED4Zuor3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
	b=wyFlA1SsFEGa8L6VDwy+ssaVK+RuMl5KnExkHYepvzAU9jpGd0YPv+AEcHYGZKwYyhZz
	 DMNKNP5/5DhwcCroAeAcsFDFNcwJEQUkQ8cAHgr2eszc6AWrGZPBXwb296SM6aJzFbsLR
	 f2hO4yQ7qK0rsXLD10n0Jf7dwNoA5fX5GPYzGgPLa0TB7kw8jZ8x0kHoL2NRq0M7Y8tLS
	 6K2tNHrR6cwEnF3CRdZWog/FmhZGIIawbLwNCbcX+Pdu0F9shRdYRkIph7IkK1jLY8wWl
	 zLPio395lxGa6v8eckfJd8fYu+KlreUghLsb9dWq4yF7pQWOzvW/qO0rJ2ehLYcpc5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bzc4Cg9j;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D25606A327
	for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 19:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D25606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bzc4Cg9j
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53397554beaso12640391cf.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792782039; x=1793386839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
        b=bzc4Cg9jHc+EwZ+EF2GHA00SaE7XNzyRJ2jPm8VaHgqzKDLrehIHY+5e8wqB1yH17y
         sndSYk22aMmceP9P1fMLTu0Z4V8EzlM2RGsFmTw4gK3j741dLn2NCvrwBRx9Zs2Y9Nrl
         IH1Flz0MwkfAlUgvicHD3GXb1HCVFF/PCxVAEn/OVSguv9eR9Zs++ljRZWXpHTqI+xAr
         rfcFCA7qmIwN9IxX9GeYG2HRZ3YRwMSM0MH1BmgGZbTGcamONR+rAGI29PTmp5avInXD
         sAUAnL9pEXhpYTml9nJyCuJ6EjWQTeYXwbhCn5SvYnMgGcHEU9aguEL9UamXbiSuNSk7
         hQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782039; x=1793386839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tf4s8d8+MZT/ng3kYJALwtT1EAbBRaxelT7QvlTQng=;
        b=Y1VJWElqBurZsM/NgEOmweWOVdeAz1oMyh9yqJ7bkqSZqV3DcFeM7dQYRCwgpcrQ3P
         gIT2JsWI+1D3LtpeZv4/9vyz/G/bHi5CPh1fv7I3vjxS5Bo0BIHGubz6PhnFgxGYNuiq
         YfJTKkbNx9fjI1thSTthsBqaUvCdXzh5Ni3rq25NUoszZPGUnN/jbKEaTeXuPv5/gT3T
         OlWoVLCKsf6sqK1EvyQhjkr0+bhtnlV9wZErbbeP1TFh1laRmt8l3PUqT6zNSHNqQG5E
         RKVBCx3n1lEab+CvozKFkJfYjlsGHvonDI+Jgw+4fgzO72HHVG65cTxfwVu+pmbmx7rL
         E+Tw==
X-Forwarded-Encrypted: i=1; AKwUvBwhwiOU2WZi0hY7UkNYc5qmv5hI3E/7z4RYr6pO8ip2+Ub9Ce4XDnqId8RaOr9+BpcF3aOJBgze76M=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5d3M6zklcxKYtIksD9s7uQOdqu1woZ8rVhpS/4qJ3iFlzvjGJ
	Ak3eI+hwgONEi3ME4GzFrYO+ROFVss8uvFgshmT3jk/09PA/6uztNSWmlUmffSdW59c=
X-Gm-Gg: AYBFou2RowhxGssLfY4osdqkgfWKks27P9zTbEqbPTpBX1Qo6yg9ferePzo/nb4UWEP
	vKJFd8mH8q9+yPefsRY3dg1GeRLllAYbCnUiYy/aAZ7rAqqjYv8dIF8q7Kn5NF7uS2JppiyOzYK
	/IODuoZKEPH8ezYlvEuV8NLXafwUX7iIB7L5c4TvmvMQfhh50WAllTGhFXnXHZsjBFQ4I1pHUyz
	8+nFGWtGZkxEbbr0Nmkgq9UjjxZZdOGgxbLfTR98K+NeuMj8+m5BDLCoBPJIXlMGSltld6oVA1l
	Ndy5Zj6wQIS5IxydAFd7RrsYxexY4oNtTEn6xsvQERBxLVynv4gxNgTBua8Pw58RBsOW0Ci9j6F
	pd9NQTiHhchdeJNKiDtdggp3npR8Ihr6NUOyB6XiLudw4AUVxkzZLmD1LK2os+55KDwRUGlP56t
	d36D8NAJlY2AsSrjB4vFKJTML4r5fAgjVVy8hynqYz0kDeTEinxzXaL85FCY44cxcDRY7JFG8rr
	mKjaii0yiTR4sLkwBv4RgYHiOc3VpDPx+UYPoEwbn5ICN7/hQAwYV0qwRuFRSiuEXBvJp+pvaXW
	MnEk0JnqX0iiflYaCmoQ3R+C65RHXohPUAXxuQ==
X-Received: by 2002:ac8:5d8e:0:b0:535:a5f9:7520 with SMTP id d75a77b69052e-536c26e2168mr47897061cf.63.1792782038589;
        Fri, 23 Oct 2026 12:00:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53839709ed6sm1185741cf.16.2026.10.23.12.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:00:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKKVI-0000000GxzN-4BG5;
	Fri, 23 Oct 2026 16:00:36 -0300
Date: Fri, 23 Oct 2026 16:00:36 -0300
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
Subject: Re: [PATCH v9 02/18] PCI/P2PDMA: Derive routing from directional ACS
 controls
Message-ID: <20261023190036.GL3977851@ziepe.ca>
References: <20261023155914.GK3977851@ziepe.ca>
 <20261023182715.GA2798722@bhelgaas>
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
In-Reply-To: <20261023182715.GA2798722@bhelgaas>

On Fri, Oct 23, 2026 at 01:27:15PM -0500, Bjorn Helgaas wrote:

> > Yes, the ACS combination is selected to avoid ordering issues
> 
> Does a user have any way to know whether the configuration is safe?

No, unfortunately in PCIe so much is really difficult when it comes to
deployment :(

> I'm wondering whether users might use "pci=config_acs=" to configure
> ACS so things appear to work as they prefer but may not provide the
> ordering guarantees drivers depend on.

I imagine that could happen, but on most practical systems the root
complex will blow up if you do asymmetric routing so there is an early
indication.

I know this because I've help debug such configurations at
customers. Some servers helpfully MCE if you do this. Lovely.

> If that's a possibility, do we have any notes in dmesg that we are
> depending on fabric behavior that the OS can't discover and verify?

Maybe, it could be interesting if the P2P logic found asymetric paths
it refuses to permit it.

Jason
