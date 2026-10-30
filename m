Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379508;
	b=R4R8PnnNR8ui9wz5O5DY1Rgejkx2ouZ4jiw9ubQPoMogXZV8WEAembkpy+qzAoCOohmi
	 kXPCoWGG+A5Gxj8C7CF8yAt8JCrycMZQ5shm062y0WefwIg2u5DeR/OWjLD3Rit/vIigF
	 mGe5BaTXhEWjpN06rqNyPWfMIlamoz2/GGncmSzlxvxWLLRlSnC8KrNw4iAeGbPpWe/Qz
	 FmyhR9fLOfGfYuUrrLolj6RQKtfu48sgHhv8p0XeSoR0Ex+jv4TS3zzaKCPJyFVeTLBBP
	 5ggYMefyL5hotcNLgsjm8X/X1rxs/1zWMdd8I9Rr6EwZOdDynp99dYjD2cbMth+h5pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
	b=xxFQEw7GIXeq5HItg2Qo7syqcI11j64KeoRY4EP8VxUVFiClnvU3dkyt2rVq1PeEvMsq
	 ZiuwSiSsULqcFAhDgUqDdQ13Ii3+CHHRJgHUEAigMS6KDHonczuVT9z30eKNVpKhzLCOt
	 FE8k6cnpRt9wrfIEHXILDRgDKiIsZdCpL1LD2enu2m8QktyN26KuXR7fS+S2nDjfhB0O3
	 QUJn0B6BJmPq/T9hCDp4DqyogdTlxd4UrD3jebBUcP4Og38p16CHP7wDRgyGOaX8SbAbD
	 HS/i2MpQ8TlgciY0s+NFq/KDytHYDhKGElLTPa3X36/VrHdFmAL8lq1LzY4ypCof3lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bhjVVBdq;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1A606A320
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 16:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B1A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bhjVVBdq
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c79f306e9so10969406d6.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793379506; x=1793984306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
        b=bhjVVBdqP0p5ncqFTagx6Bs8saftcLn5bietHySzPVy+OkEz6ZQ9M/fOli6KxslP2k
         EkGkkKWXOROR+xZ5Y66zJosRACFVLr3t/huYutlqxtRTvemmBSyY8XCDaB4+AHAme/cE
         TUzJOIx69n/1h++BVedB8bNC+bSirPirKyjQj4ta1JNOyf0n7xCiBi3Sgqnppr3n74jW
         MRXn8TAOSdTG77kw9kIjE6+ApVorj0R20JMOvkgwCfupAdhbz9Ne3709GxfyCy0J6QCA
         hcNNS7dNywL5KAaD63ZlJ3I9EzgudyhIHPI13g7bUNcUrkZTtmh9+K8wnpmq1kIruP9q
         kJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379506; x=1793984306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
        b=D/S53F2/G0S/VYrnagBkUfodc8dt9N0k2KXabReE2gyr6oKCmuikopfFAH1pTjRUrr
         gq2h0rYWaW4ezv80l/t9PPkROIgLaEbVWxh2WW2wER5lZvVaT/rqvNEAurXS+/8lTlMJ
         vjFoWcjRg620SM0RBiwH9rB40la63M4jLLWeVjbYni9yJEpRlUPsrdo4Fv+z2J4Aa7C7
         N6r/Q5WVY7wJbWATLiKyDvntoM53h8EwwG4/LiLKKoA6olv7W11IYuZk3UVF4fdHidxz
         h9+Ybs+yD1igX4CCj7iT++eKDsWc47OGaJkzWVbTtX0LJShMjHzhR6L7nUwjsbTxQNoV
         QirQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8gZg66QmM+pauTqooC4S3FD44WFiaLkJw+T3r4WoV3nJcomb5DqDl8QrFI85QXBZWL/x6xJ9uKXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPxxsXlP94MouJYuMaM3ct9KLdR5tqlR6DfHQ1peVg0PkadafD
	u2vAxO8IVUYDjwbNpFIyqUtIYT2zUsGLlmmyk4B9jUpbJsNT6RFKBUCAZ/kad2mcAN4=
X-Gm-Gg: AYBFou3wyfqKPMxE/u2mXnxEEY/0vTVdtg9fhn8JYrPt/jTzYvGphsVhSh1sy6KA9AG
	/QOoi/Vj9c/lzkGfGU/cyBJlNlCLk4eJN0qq49WBDCwfw6wc2gLVx7yBUJPCB8zjv6gj6Ht0NW8
	1SE+W3ZST1t5xwALJSZkXuRJyIzrWKvrtT7omLAvmRaGRpuS/zX5+37Cg7UGpGS9zsm4EogulPY
	8PzSWz4w0kOpM+Iv/zJkFZQKCwj6DNDFx53DUOCtItff+3B+PZl8FIrPf8/7YOkJ1a0s6BfsnDw
	kWYMd9pGC335nOuA5TzCr8YtQYDVxzS1DPZL50FItfVu5N3Qob8Qgh5pXjNzZx0Nuw9Jau1VDBV
	gobSDnNZt+K8t50BnROdDf/1dsp8OP7KtgPcJqAHBTiNRzcc1mwgUm3K1xSoFA04c4n1MKF8KXo
	N+H1wrDTc/yXehQF4CPGmR13VXcQ6Qp+dwHEkQ1Ctgze3ytl7NPtgMzM6E4daAqA6y5tgvjrJ/o
	8MuOPVrsF3O/08itT0QQeZc67rBiLA0UlOGeD99j60oDi4s29rlvG1ERv4jLDvcnVwU5peU7RVw
	LYMl59F2uqF21q/qUtlh8WhiSj2u/+a60OyTtX3VQjGPTvQIKhN04HoXM1ACVoOjm0tfFT4yVCr
	TWAZpr2pI8Ww=
X-Received: by 2002:a05:6214:226b:b0:91b:ec0b:9671 with SMTP id 6a1803df08f44-91ca4b9a540mr46456036d6.52.1793379506439;
        Fri, 30 Oct 2026 09:58:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca80700b5sm19825486d6.38.2026.10.30.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:58:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMpvt-000000019rO-0nKn;
	Fri, 30 Oct 2026 13:58:25 -0300
Date: Fri, 30 Oct 2026 13:58:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM file
Message-ID: <20261030165825.GE3889730@ziepe.ca>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-9-aneesh.kumar@kernel.org>
 <20261014105913.00001217@linux.microsoft.com>
 <yq5aecd9aupx.fsf@kernel.org>
 <CO1PR11MB48351C4BD0BAD3BF6AFB2E0C8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>
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
In-Reply-To: <CO1PR11MB48351C4BD0BAD3BF6AFB2E0C8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>

On Fri, Oct 30, 2026 at 07:54:04AM +0000, Tian, Kevin wrote:

> Besides, it might be a good idea to return an error if idev->kvm_file is
> NULL in iommufd_viommu_alloc_ioctl(). I don't think the viommu logic
> is designed for native application...

That's probably going too far..

It should be possible to fully test most of the viommu stuff without
an actual kvm, for example.

Jason
