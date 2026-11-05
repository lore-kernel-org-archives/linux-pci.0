Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902869;
	b=CW9r2ZRM7UfQyU5ekpq5XYgJHCtD6bwEyKycs+qrxEL4qZtOy1zaEuItsZkqK4ZLUB4t
	 rjyoZdkw5SJ8iFPTp0B3Sob4pDvVDJFT7EBEVN4gYSeJwKATSY476cCE5cXUpFcw8fz36
	 JBqsUCev8WijR4oZUd7Q5ijglhxZp03WBK4gUug3ciu959qRK/FFy1cYAt05uPu+OgYb4
	 LpI6CTfpYwEdNctf3e5cGvI8i/mVI47PoJcZiz3vEo80vtA8isODpKNFkvxP6jdJ3mdEG
	 /dPsFJG6RG5yuHcPUhzfCtU4beNaY4mv2EF00RWqmt/rxKCmS7lS2LEY/nhEtzlCbpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
	b=1D7ZTlVOC5rdmXjI4WKF96tLeZuZ0NLsrUzup/iFBYEZYvv0xF1pftIzagy6QQSxJ3bz
	 VID/ZvhCHnTLR9XzsCwZ0Nc7/x7t9aOeWAnuFY+fIZ4Nk7H4tKz+7tFTtrTr/swEpRfkI
	 FzlhBSh0tdmkgTC74IIcrNCEmZydm931HMlxpapfWoh0vEVueqfN8wgGIccTcLTWbwYX2
	 8QmHjSknJpFqS/GHV/aNsyFwyuFrXg2yz+Uaw+3NU5q+24GPYRyZ5Koq813GK7CLQ/Z2M
	 yoAc0O9QRozGPRontlC94lj7+Dpc+ZLZYwz2qkSO3M1wnGVeutSKxnrS4QRmd3MzdXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ire535yI;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2073606A32D
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2073606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ire535yI
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc365db987so1432393137.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793902867; x=1794507667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
        b=ire535yI4zQnLBCiIAurI9xJYsUwvc7Sip6NA8XOlKY8BmMk6D3rtdebYXDlLnb+ZP
         aEGddu2E8npnG7M4/+0EgOwpXWB5SDN4kgpIxamJ2Uy2NDnYvTWgObc3vELT08wtz/xF
         3xeWBALg5snzMuspxTmvkiNsDCe5u5k7BqFrm+FvEdrW+9g4YmpiWSs7IIKmBLSXprfT
         B76tw8MYCHnKMka4LW2C5MZT3rGdLaEtriq6m+jRXouhgJYmsUSLWxCwDQA/9gbJdM1n
         NRjQE5XtPnpZDvStPl0FX//pa+XdJ0rYFA3eynPysioKRTlm1rN1Vx2zxk6ZZNMhX2vJ
         yV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902867; x=1794507667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
        b=lHgcT+P/viHopxBTE7xeG84cMmzeM5NVC0IKTxr5o6Or3g+T+ZXBmypQ2ZCf04YIRt
         fWino2l9bKxAmCoMq4LWySRlUX50G+Zf7DmD803LCqZaQieFDr/OaTL9BvkP/9gzLeuA
         V3X+lxR97gXHV2Lseeghf8FfjT9gbY3akJC11mFE0IzK/puJqcJ0Zp5PFFjwQGT6bP5/
         6ae78ZW+QihbIcYT3dr7+rKyJQI/RFrvjMk3iRSpsn69ZO3Dj2irtto4myK7s3q6iWZh
         4loBsCm0w8UtloyyyUHJksViS4AAnLw87RRUpsz38wXU6pcvT0GnVKAqdHIfjOx4M2ji
         R+yg==
X-Forwarded-Encrypted: i=1; AKwUvByI321HVFUSr8OGX7qoAfBN9RX10lY3MUALrzFpvOuXYC6NY8SgU6ljsaC/4HXNq4JCGbsWVcSQ+Bw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pyUAgyIGiyQ9L4xfGjlilzl2jxI4oUT5BnwQVHL1P54DVdfBk
	5P9bKz4VVf3euh21415YyjaRxjzVwY/dMqnfw5MoQTrc2r1XoV55x6xJNeO2Z/mqeEg=
X-Gm-Gg: AYBFou3FkQBaFkDIyJTZ7vT8t4lZZwjkojkvhHv69kItAYIKm9cW5xZT3wWtBjZJ5Ah
	3INENGjfhCi+NZCMUeESuNpCvVtsGTAnr8ZfbE1LWByThRd5+gOvqu+h7kcA5NNs3/66ht9Ymx0
	w6Xjt0cvanwUpifBpr1V5eyIhggvJ4WquaDOMaile6oMF7JbylLGNRy61cE21qOobbnF/39fmOD
	qjd4Qv8k0YHbvCx666dUS/rtDwHR3vapipJs5A9267Qlk4NM8bBLRh7CCT/o64r9RIFO+NqUtNU
	Wos87THcuYMYDl8SytZYe8C2ymMHPmf7o+uHe/FC7UXj8DFGRw72SigQ9U7R+hPcFkm/t5aazwA
	FObYQd/JgR3yC45Ti/TFyig+hYdKqBiaQyhIgqyoe9FIdU24PsmSnPr6JY3pEirwCeRs1q0XPS1
	G12G2l1auJXvBWgAVeZgWTjQQU47Ukfu+Oo3JlYvckzWRQWkHOSyJBvKKsczzlK/9HYSNBsxTSD
	xbe1xLWi1MOVdN+l5hTuXzn6P/xw7wtG3EP0ekx/rUDO7aJfrATBfowo3mrhblnUObOzJ8pB1/k
	ZmrQpRPip72QJnPlnwzsewH2350d6h3wuDnNRrLLJL4l5o/EsM2PWKpSOrDqzatZiNrJuuXSWJK
	7w3TpfR6o1A==
X-Received: by 2002:a05:6102:5706:b0:7cc:2712:caf2 with SMTP id ada2fe7eead31-7d2a1628b19mr348440137.23.1793902867469;
        Thu, 05 Nov 2026 10:21:07 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm5242293241.12.2026.11.05.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:21:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP25C-00000003LsF-0vAz;
	Thu, 05 Nov 2026 14:21:06 -0400
Date: Thu, 5 Nov 2026 14:21:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <20261105182106.GD663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
 <20261104193139.GB3889730@ziepe.ca>
 <yq5afqxf97a1.fsf@kernel.org>
 <auzAivzpzSUHjEQj@nvidia.com>
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
In-Reply-To: <auzAivzpzSUHjEQj@nvidia.com>

On Thu, Nov 05, 2026 at 09:44:42AM -0800, Nicolin Chen wrote:
> On Thu, Nov 05, 2026 at 10:58:06AM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> > >> By dropping the nesting parent from VIOMMU, it just simplifies the
> > >> attachment to an S1 paging hwpt, right?
> > >
> > > Yes.
> > >
> > > The VMM must always maintain a S1 paging attachment that is the
> > > identity map of the VM on all devices, same action as when there is no
> > > viommu.
> > >
> > 
> > I am currently creating an S2 paging attachment. This results in a
> > configuration with S1 disabled and S2 enabled, which is used by all
> > untrusted devices.
> 
> For validation, that would work. Yet "no viommu" should would be S1
> paging, i.e. hwpt allocated without IOMMU_HWPT_ALLOC_NEST_PARENT.

It doesn't matter, consistently using a single S2 for everything is
probably better..

The VMM should try to minimize the number of hwpts involved, ideally
just one per NUMA

Jason
