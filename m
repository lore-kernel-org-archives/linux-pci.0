Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC5373C18
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678519; cv=none; b=MnB9wsEraEIzuKwzHx2oDNP+BvTAc1PgEQrileStI+tDB4HtIIBh6mnppSehsWuwo0vkBveoKmlcpJgSrNp0uxvEeUXl+qdqSDndBWLD7WGhKw64XMriow0qxwb8LsqRI65oY3jQnvB28bHnPXmc90dHoyy8X2HtuEJPs/URVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678519; c=relaxed/simple;
	bh=xUmQlTlcXO0pkAWEHxqHsgGNX6M/I17T0dQe/2xgkpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tikDbQ65nK3Wh5cJkqf/AeM6f4o39lXV2i7EfqlFLKMbo7PBLGH4kzQNxBIcQHB8IQnY0BITgnW0h37Nmw/ZLHaRVv8tRg/EFSRvObAgovEu9L501jzpqacEJfglZ289Bi2cP291AvoJfJAcTMte5VOJYZMLUa1tq8cf4BGqkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svV84213; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svV84213"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b052562254so125ad.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773678517; x=1774283317; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bdY0MHpBaQytGDjrwl6No73PmmhiNXL6flXFjxFT7cE=;
        b=svV842139aNRJxBp7JcxWBFf26kZOefs+oWMPmMW7QCpAnxEj8tYI7T/JafedbK1a5
         iF8LdZcm5+aDZzWLBY1UlkUKKmY7bq0vlPHGUZhrzz2XOwAN+/Rqpf0tGjmBaMFxAksM
         HdTVrrOlcZYFS70C77xwTLNQcTHoOKGV1joRhfr5KKN4hOgVePrvvbO7KxL6obJbMdjn
         LXRVskE064B3usbZnSg1ZOlAUJbgdLZpzBVQs/cUfGZ8kh0F5ieYROuHG71od7xyxPLl
         WXaDs4WJbyNHYLDKbWEJoY/bjHpTb5WCjA2mIsSwI6Uee422weVV88bvX263YVFfKqtC
         /sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678517; x=1774283317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdY0MHpBaQytGDjrwl6No73PmmhiNXL6flXFjxFT7cE=;
        b=l8r51cMXJ/ZgibzCsFbdhwjAGLwOUE9tk19LCJD5ZHIIGiNtMh9IN1Yfl5bvJFgwj1
         /3h+Du78dT9Ntva9B1abLNs3OJ/POT3So8yzjxJLwgcqbWw5bb4zYSk6SqpUc+77B4Ac
         NcNlsH+oSg1PYOuikoct8sM2QmwbfnQ6dR1WgIM5y4YvFykBrXcy55VUuVH72vtAqAcR
         8kotgcp/bljS4dEevmvYV3bYo0XQRSS2kZ5S99hiTtLUqlm8hq5Zb6wBYegIioZx1dbG
         KtLsx5HsryLVF6MANBGPhLJn3ZQSsnTkXbqD7AkCQwS/RbAs8foy2IaZ2SfJO5riXc6w
         qRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ZhsXazzWIOjNrq/kSR6UN75aRuI86CSPR6l6CM2q37c9jE/IZgmni5ys+Uis3wZeZcTjKh40Hco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYu3UOZ1niAM0H4Q53r6YtMzGEMg+L4SU85FkpIUfEgEc0jQwC
	ltM04DMDSSHXcvhBbeZ+pWt0wlxLqyU5HVwOEUCTY57YUtjYgCenocBlnVCxUv/gAQ==
X-Gm-Gg: ATEYQzy4EeVZxXHqvD9Q2hfTwum4ZTxQoZld9FM9Dx+iO4YkjyBCh+735CgNjSW6YOf
	5LrLD7FWQ43LtIU8pJpCfbP6cBMgFv+frKQdws6JBE/zqcHCVzI5orJ7mWfv7YgtAfpDnOI7/8y
	2xhkgXN9M2rrFoBbvYfp23HwWQqqo3xiEPft9EeTHV/UmeCKZRBXO9D5YD9kke+DxDVtzLqjABa
	l+Pk9rqr1P1hM2qcltkL+BncC0ND0yzYWPm1S7NA8fs3pGoeg+d5Vw//Ln5umkMXbGFTu1r0iDZ
	lb+j5PQE0hf5SYZnvhDe7iWJXbWafb5EgAzWBxjcps/Ul5Cg8ccVUhFOCFBBajiVvDLXeCi1Yxd
	1Fp0ow48jx87jtElDsX34mq9Sud6UIEEEauTYRC1g4xrNDPKood9riweJYmwfWc/RFM4JF45FaM
	u2bcbKgcpWe0pwXxsbxAzgevhGGX2t3AeUD2qxmh3LvMEATIbYPH8DjOEd/LZwgMzT1UTd
X-Received: by 2002:a17:902:d48b:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2b042d512d2mr5465485ad.11.1773678516811;
        Mon, 16 Mar 2026 09:28:36 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada5c760sm115860a91.5.2026.03.16.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:28:36 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:28:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260316162518.GB1767448.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
 <20260313083918.00005731@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313083918.00005731@linux.microsoft.com>

On Fri, Mar 13, 2026 at 08:39:18AM -0700, Jacob Pan wrote:
> Hi David,
> 
> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a
> > Live
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to
> > preserved
> > +         memory buffers and P2P. However there are many steps still
> > needed to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> In the interim, what do you think about moving forward with noiommu
> mode without preserving IOMMU driver state? I’ve tested your
> vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works as
> expected.
> 

Just curious, are you using qemu VM without iommu device for noiommu
work or do you have actual system without iommu hardware for testing?
