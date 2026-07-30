Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B83D75CF
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454400; cv=none; b=OC5d3pvweH4J5/OxVbrUC0/vZzk44CwU3UHZpPwv6vTlkUbgbdE+P2tlCo8cvLSbGIed9d2vdcVDJHdymiEq81DDmV14oE0BPS1UjmdJ2OhsTEKItrHt8S35ODBqGp5lQMlcip1MXi7xrBPdj483DrgTKuZY0JHRVanI3Um4o6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454400; c=relaxed/simple;
	bh=Iq9ol7OXU1ahRu/wapfwTXujNB5WFM05r9AjxlRtuJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGmySabPJHTsP2h/CzdbyO5wapHaq+n8RbfZ1FRPzqtGzN60CBsP7W2IfuMa8VaeQeA4d6Sgm9XlYZPXj3sNsfDnW0TqDlfdLzNmXzajJXYaq0nFt/Yn37Jt4FknvgQ8ekivt0fBIGW/pStFdaMmu/24Pf4DxlLc0RQwaml3ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjqlfTNA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjqlfTNA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso43145ad.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785454399; x=1786059199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dg+/alpKqQYpNCx1oouhanYFhK3x1/3K8PlW/VCS3GE=;
        b=cjqlfTNAiSvEl5DjFzjhn2TZHWvD/qPUKQkzC3qE2q52M9I+ieIrMU+iTI3KyCVZky
         wyrWozOwOzCROIWE6TEN4BH+GfAuloUBOU9XXU9xW5n32SwwIl5kpVU3Vv4xUzI9wYSp
         NfkHO8p740TS0M5wlKByt+mU1Gm+7ipDwuIIO6TLcBYw1+TGtAhKXXDnrtgvKzgPuDHP
         H0n3QsfEz4YKkRXd4oHNyv7CPqGjuDbhDcIkK2zJCkHmnCMMsnzx9NFqil/KnrgH8ULm
         3xbk4OgmJlSC4EPtGRCKabo/3/Gg4W8Wud1J0JU7TiHmaslv5SJAMfEczrTOLd68lCCc
         w4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454399; x=1786059199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dg+/alpKqQYpNCx1oouhanYFhK3x1/3K8PlW/VCS3GE=;
        b=CqjJC/ZbYih167AkhtCc7eoDAaA6/Z6yL70LEKGpCx/QY47gp5JreJojiEaUT/HcqP
         j+GMDeWd8Kz2svNVsQFBxiPKpxE418lz9p8ElIz8mrh8TgegXZzX1GMOsdMJayabKcQT
         MeQDX9ms8BkhgGEWgU8R+lDFvgaVxz2GMXHUWvSAclrXDrGENu9/GcgUOneeaUlx2Aff
         oPuK/+91LRlSueulHq9kflTCmGKpe1mI4lpB5rM1r33NpmGYlgmL7WtlAnG0ckjcy8QD
         IGbBDaO2PPHfHfT5FVYHW4+69ie7SMHkP4GMorjazw0rfS45EXU9kRBl491iZK5LQWyD
         fRzA==
X-Forwarded-Encrypted: i=1; AHgh+RrBokxb+ewhnpZ6UAdpHBYSQV0yUCbEZ9rKmCEEfy2Eo/ni7lm+GGtFRLo36wxqrhUpaI4JGMJy++w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSeXFeGJyFtW9BJ49ZgPRKE5KXINF97ywxL/ymG3z/yYrFvJsG
	qnIMxjGl0fwDxEC6C/RqMk6caxGXqJDs80ua0668AlOQ7hixIH9oCBGO8+opqCpBbA==
X-Gm-Gg: AR+sD11mB7auowGjmOzFGxhLIUt45XG9n9R3BcF8OakvGMqvFQGwNjYdB3X6ZmNXppG
	bm5DQ75PURa9PdWx3ilXnvqvhPJMglEykWZ7Av1Hc1cx3G6gU669nevhRfph+26spI940ciNtHy
	WEyQIYK3VRhICT81BE/G3MQryAUZklnioLqgVOHZ1RTjAY75Fn7Dhy8S+VVs9M2EoeOASZudtN7
	/Uyk+TEo/cqHjxSDb2tiAnow+MniSt4+3pMFzjJYZvnaMSaFRIGAniXYGeFXpdZe7mOjsDCmfPT
	YKtwWCFTZ2uRpu/2qZLj2/NVMn3aJcEI/1onTNwUMur0kLKjn/ns6gmVjjSKra1G8AdO0bjwNH3
	PDhUME+gy/LfO1Mlho97hlS5w8yx/wOaW/ZXooLtdR5tmU1cmCSOjdl8sGvrWB4428Anaol04zr
	Etdj+AEvGYtxt38ITOsQENJ5oThjaMmQy7MQ2JpqR0AtVfR3ixJBDV30JHj7NBLHChd783tXpCM
	aIcYx2kHzsm2C5M4ZgcNgM=
X-Received: by 2002:a17:902:f2d1:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d041127ae9mr3387895ad.2.1785454398363;
        Thu, 30 Jul 2026 16:33:18 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm39399784c88.5.2026.07.30.16.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:33:17 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:33:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Message-ID: <amvfNhagavtGqZ-W@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-9-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-9-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:31PM +0100, Matt Evans wrote:
> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> support for mmap() of this fd.  This provides another route for a
> process to map BARs, in which the process can only map a specific
> subset of a BAR represented by the exported DMABUF.
> 
> mmap() support enables userspace driver designs that safely delegate
> access to BAR sub-ranges to other client processes by sharing a DMABUF
> fd, without having to share the (omnipotent) VFIO device fd with them.
> 
> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
> the existing vm_ops.
> 
> The lifecycle of an exported DMABUF remains decoupled from that of the
> device fd it came from, i.e. the device fd could be closed with DMABUF
> VMAs present, meaning a fault on a VMA could happen concurrently with
> vfio_pci_dma_buf_cleanup().
> 
> To deal with this scenario, the fault handler now temporarily takes a
> VFIO device registration to ensure the vdev remains valid, and then
> vdev->memory_lock can be taken on it.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Nice note on locking, enjoyed the lock dance!

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
