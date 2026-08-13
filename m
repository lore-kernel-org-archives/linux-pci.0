Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A4477E2A
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628980; cv=none; b=uNQc7T1dOiXaqiU3nzjTf+hj2OVWmcNLPa+Zzuh1ztMmfc9Ww5cc43qLpHBggVcBt8rG/4YbyTjPfvtlEP+pxZYyTh0RcVpr/kuImM7da6oOC7DjuyzYPCnQ5vTXvxhec3uVvhYJR7Ran+u/huBuohYu932ztBLHzeZ1XpkuncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628980; c=relaxed/simple;
	bh=0/BIRfMphfS1OGwGGVzoT/+z7v+H5hzNBd1OvKLo6R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2AXSCJ1LvE8ql/gcDsEdh7dlkIZv9sgpTU7sNgT88tr0I7gX0TWke2KlplNN2x9HCaTDOa3IEL8o0uy37r62df4zD4A8w52IcIRWOSeuFHaHlIMH84S/BHhFxCUa+AVq2zJTLwIWGtlCw/amcvEmkWdf6GX6SrlyqLl+fyWrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MkYOV5dD; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MkYOV5dD"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-930f618435cso36660985a.3
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786628978; x=1787233778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Yi6QACY6Sk+pPvGX2LOJZA5tLUZ+nGsCUcFWjEbL98=;
        b=MkYOV5dDeYB6Ka49dQF3qGymlcQNeahvXC657wTWSh5bc13cs3WKyp6KlUju2hOTLr
         OZDQ1Jizl3VHXYlH/f+DXmDDjNpT6zDDhxHAnOFDZ2RmaDsVsazaihXqTcl0kXwsFhJp
         N2MQeFqpiQICZqgOvaTA8pY69vWKBnHC7gulzwU0xfrjU01gbgEZRQR/BynJJIWwQ4nx
         P6zkNCZv6DUjD78Nv4xeIHfmeBX4SQpaBB930lcXI0UKHxjsamNGqoIWuyqUqb6FyIOX
         85aFuVThogCAOjIvihgEEQvnO49vpgCTXHOPDzwOyIPQxslnbrMkxoMPlqvRQo+gLzk8
         Fzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628978; x=1787233778;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Yi6QACY6Sk+pPvGX2LOJZA5tLUZ+nGsCUcFWjEbL98=;
        b=bwsfD/CEWIHE1pmLAiIpDzeui1D0dCa/Nm/kd7CdalZ1dIbR7uurgVrSuDRcyvqNUL
         pGkEdKLsQLCR5ry7hL5LTQHqNJpbsIgUxLcF+x1K575M+aXDs6nOuVYMIfgB6Eu9+nFH
         42ng2TDQlDgtzm+YiuPadbXaupo5AIQj/Vfy5U6P4k4QITAw9rjPK1sXiFkirCqYeU63
         gRB3N16ofUgCWC3kocwdKvUxybr4w6imOTWKJBw9QUtZwovZ1qysY8U37vi6zfDp2/fV
         rXHC0L1wSd3bAJslUFQ/FaRONickHtNuI4dU+nmn3hcjtQFipQy/5BKmyHRtHA6OmW/I
         qFUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5+2U8e10MluIyL65TiE/04fy9DvlUgfo9QNDdKQf1NEYSRi9DTYsB4P/znTKOjjkU8OVQa1PcbBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMrIMNhFse10TWSeV9MjfkMh7nswyXt+nB+B8tuhj7z3qaReG
	T0M/usKqQ50Z1i1rJVihxgF5OLPsdeyok+1DvxmFmc0zfaGqjxp+deeuk5fToCVgGrw=
X-Gm-Gg: AR+sD13fQJBIOrM7CLX3BPSlr+yWIB/MwtpO7HLJhf9xLOchX6MzHoEskDWxJe9SsuV
	yOqUA7p5by0o3Bos40hoGAL1nHx6Yn/uMXBIIBbhdMJ3HIjowL3hwkDNoOHbbjBmFbfZaqnE3Jy
	z+G7kHgLVxJgJvfSQMXIA7lriKHaxM/qt5yGcJq93EKSSX/TnBUmB0SnaOsOQGTvSpqhiHGxTY9
	geKT2ADYoK+jots8fPpYY5sAXwx4YqHq58fuaKukrrJKQTgBOiRtWcBoWhWPTl+GbIvt1fynnxn
	6yTRU1CvTDCJTxqnMRl8RR52hPu9Axk4FeMSuLK5Q5t8WRHSN/auFbSsDfMsQeW0XQmyiAuuNvB
	3sF4AUip78s0QJZJZ7ILpIW6zHLiq/xx0iw+FTM6j60k4Uq7xMUurIhjRS1dkmiuvvfp+ffIjgB
	tXICMYeL+5L5xpHhQCb/QQRrRwcN+jzmH/lcU+vQ==
X-Received: by 2002:a05:620a:1995:b0:936:bc78:791b with SMTP id af79cd13be357-936bf90b78cmr572103285a.15.1786628978075;
        Thu, 13 Aug 2026 06:49:38 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b12344sm150528085a.29.2026.08.13.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:49:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuVoO-00000003nYa-1b6m;
	Thu, 13 Aug 2026 10:49:36 -0300
Date: Thu, 13 Aug 2026 10:49:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260813134936.GM662699@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811155022.108148-5-zhangyu1@linux.microsoft.com>

On Tue, Aug 11, 2026 at 11:50:20PM +0800, Yu Zhang wrote:

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);

Since attaching blocking does this and you set blocking as your
release domain, this is redundant.

The new flow looks alot better, removing the detach operation entirely
makes sense if the HV can support attach on attach

Jason
