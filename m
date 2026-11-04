Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820701;
	b=brdF8fDfykHhtEJDc3P54FyaVk9aiCmZpnMaFwDKmquItwo6ICAdxDABpgSwjbX9oRhf
	 CpjhRrbVUbHcfe4mDULIPpcQ4ALSrmTDIHlNKj86BJ4KNiGAkkSh8Lui9YKXbF3v4NSI2
	 5+ry25AMT7uxtzTUSUcdNss+H6SPGSCEy8QeK6j1cnZnJmPTPtaMPDJXJO1o6l2CDlSeX
	 cIrdJ2R7TD99iFpEQQn54Lmkq9p7xcTz9Y1W2IhDAVTPJhxYuSja3vKki/3Jp0tIIPJV7
	 zHGm3pfstxBrmB/rnAErPBAwRiXd52mHdqUY3l18Zze820sczKUzyHDZeGiz0d+xQdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
	b=rQyR/fjivXPj088U6umtsfaSdA/vNjEcaJ5zfUjvNDwkI6/Touxlris4i1qJlH8MDVAD
	 3Pf9Xan4ogWfoSoQzIOwwh2jltmJIqDvx4IEt9Uhc78Wd8Ki88vCyPIitePmywQ2JwBMa
	 /D131UIH5tF9AZgNXLmtlzpIEA3XgF69xTCvvh46uu9YM8GLChuL4LM0+pZDpOF522zlW
	 Z+0UuglNtTGKxAE1dM14VCaNiW5XxwWjtT7FVYEwYt8RASOMH9xxWCVOafEL9hSwcPn8+
	 vPOEj7TPVNC7TG1K/mOrFUtHzJ+uM97vxCbphRnSbUqOnS85NrLKqtox4pXGAmD55Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=EZcf2wTk;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660006078171
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660006078171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=EZcf2wTk
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f3c895a0eso102632285a.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793820700; x=1794425500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
        b=EZcf2wTkD+DUBFkK4Kf7IDSujj65CxJ1zv9d2f8p3SG06gtvsT0t+m2FBEKwTaLbdx
         FjlAU/gzIVFzN48oCK0JegUU3l6CcBvJYreTY8FfKEqN+7xSbQMxUyxTzpJuRNInWtNX
         bU34dNFsk1Hz4MbrSLbWANgqJFVMh3fjtT+PhutTYP31XcpWwodufBHzJysUUvDTjzjm
         z2wlWgpMF/QNFWFWE7mx8gDC6FV//vyjLuAhsthVQBtJiTVxhVJTyMJrETbYVwJRAVJH
         vpeGwkg4fYdDVWnxGdeXV6ybzqiM6icctzpK30WFh0sYTH5osJ07n+0FWdDxwzHibYfd
         YaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820700; x=1794425500;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
        b=ecFqUIsEg5PK/gbMHJF9bha3j0xrXWBnbXpntqFus5mQQBpguYUUiBX7D0oXbuiWjz
         farnS/lm8KpeANxtZP8AB9NbrVgcth6kZSHTV4p0EuM9d8Z1QVy6ftEO0TseUyFoc9T1
         1v/PLyW31Gmlt7OB8Z9rjvY+vwyZPb7Plsl6tLSSlbMweAo+7z3bH8XXRVtCr4mr7vPs
         FqeHd0jrSBPH3H7ba28aPf9Y66U6DJMNsEAwJyZjzsBspzoASJIi6NxjtQUZkzD4iN4C
         qYV3r2LQGMdUWZLP9fSUNNwgRCFFibJarjviwmEMeheXAOlldbawiy4j8sgQiREJhxyo
         qGeg==
X-Forwarded-Encrypted: i=1; AKwUvBw5BkgAMyU8bS7GDsY/xEsfzLiy/DB2bbx/GLOZsJVmAvJs3im5SqML8gCypUwokLXSXSg5pvToZlY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FtDVse9ROhu6bZ9LLWas5AZRYVlGCQS4u5AyvKolupjt3vkbh
	BtTO86+iq+QMdCPVZ5wD6q7nfzF+Xk6a2//BPGpGHlgmOKpGOtWPnLvGdwPrdKAma9I=
X-Gm-Gg: AYBFou2VAClGBiWz/HJ0rvpE5BB/XW+rKIQtD4gbK1AaOdW/+GsBeGr2Azg+s/+yo0s
	SYvFqjc4UT/yl0lvlqN1PhQOZ19GB1y7hDeAHkpkjYk0fHBMIgjf6rmLGsPEicaId9G0cXmoX4a
	Y8OfNt0hjDbMO+SrNucelVuBencVRH5WDoy8j/EmLr+WN+7Ti8bvdLIrG2R2WlSQupGlbccOpUV
	KH+GN7/EjuhKsk3WKTP2iT/PiQsxTTVbHxTXV2000G92e7NIj1qfIXlKGUdFfPeFubcWSVLscay
	0qFtCF2nIBiacNNuFFMF26atNx2lxabbp9MF6IThOND0pv9IbDZqqpEDNPH9qouPvFspBvCW9Hk
	MM/2dmTUgH0YDgtodw9IH4YgrIuFDBFoN6OuN5icQYALKGMuUR/ny8UJfsmp7v/CnXaRGipzkqE
	kJ0Cp78AYUTxu+Z+2QQ06ZHTdLLiFGDYGrZdCaae4jUIJCPlV+q8mGpY8frBedvyzQ1ZmOG3kYy
	BkGShnfObVh2fLPcCjaCbuSdJUwo7WbNqqDuFOdvi6mFxRvPJsmCsV1kIXcIsF/eblh1Z4RhbCu
	GFSRT1M5LPEJ3lnl65MiflK+h+T7cds7qhzAgbOqrUgPcCJOOL4xwxQfg6g5lOS93lYbBeDJ34g
	KHTwI+joi1Q==
X-Received: by 2002:a05:620a:1a24:b0:93c:6534:d04d with SMTP id af79cd13be357-9442167725emr2767779185a.35.1793820700269;
        Wed, 04 Nov 2026 11:31:40 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4844991sm278199585a.28.2026.11.04.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:31:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOghv-0000000HG9b-0zIw;
	Wed, 04 Nov 2026 15:31:39 -0400
Date: Wed, 4 Nov 2026 15:31:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
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
Message-ID: <20261104193139.GB3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
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
In-Reply-To: <auuBjRjQwXl7UvvO@nvidia.com>

On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> On Wed, Nov 04, 2026 at 09:46:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
> > the selected vIOMMU implementation has no use for one. This would force
> > implementations such as the following Arm Realm vIOMMU to create an
> > unused parent.
> 
> IIRC, MSI on ARM still goes through the NS pathway. So, it wouldn't
> be "unused" if the device attaches to it (or its nested hwpts)?

It is unused by the RMM VIOMMU. I think that is what is Aneesh is
explaining.

> By dropping the nesting parent from VIOMMU, it just simplifies the
> attachment to an S1 paging hwpt, right?

Yes.

The VMM must always maintain a S1 paging attachment that is the
identity map of the VM on all devices, same action as when there is no
viommu.

Jason
