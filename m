Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32C33C18C
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921581; cv=none; b=h+SdWmU1JpDOLlVdy4TKyUdvM0PMkrCRdGw7ym2z0+jB8XtNpUE0KTMoezPNsKPtSp4WRv57NrHhbb5HjLUl28+D8wwyFlSusxsEtvFDvDBFGgOD6yQ4HCq4awLOyE0cG7jgxYa9M+X5kjQ1oeNiFG5tv/zRNmE6ge1947r1R3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921581; c=relaxed/simple;
	bh=FtVWnKmSAhQscaTbVknx7Fz3wyNfwC/jGqjGpMz7VS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7K1iWsRj+/vDUAt4jvUqUwRAIxutbDPVQPfv3ESCr6fX5A+v45wTYkGNywjBTMoPWd+qTjxQ9BGr7rQCfn03JVg+SpwhCDOz9rUMWMWcTLRpM9eQZrPeN9d4akHGyZpINdCUNVTwPC20wmMlXeq4VlnriMVOWnpDN7m/BsW8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4CFCtsM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4CFCtsM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a964077671so69475ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 00:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771921579; x=1772526379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iUKKSXBfGZuIEKcFLX2f8iJcwGvlTC3YM5y4lXwVnQE=;
        b=G4CFCtsMICVyzaAypfUZ338DIBY4soPUuU0FX3024SLL9l4H00OcgqGF6c9hviu/dF
         J41eDXW05Ks4RBO7Ds5Nhj1WCm9uLK4XiYCaulfk/w49OHDWYMajuutoLuzgYB+Wl3xh
         hDtfhHGv5C6yz8z/yqv/FaqwI4g9LRtCNwOd6nzCJHpCOcpOgVrKm+uHioWFW0bh/KhH
         2RvCRzKl6tz9Py3Sn04bbF3PwE7r+jgbVzzWkZj89y+9OPofQ2CZzHTRsvrZX5AC2bGN
         oo3379qQzfaOHCQ5euxTJRqNUcYRgQy139PVKTdlNfq6wz7nKSw68X59IedHMvyIBJQR
         BZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771921579; x=1772526379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUKKSXBfGZuIEKcFLX2f8iJcwGvlTC3YM5y4lXwVnQE=;
        b=QTvD5ML+TYRxan2oCH3hjZN1IiXmYWxv1quHXDd9jUq5KgwMZ87Rve0ReMQjRJWdzv
         pN7zsvKSx4ti/YxbSMdjnkXjWDSpuT9l8yx5YExMg4bG39cztvBnaq8qq4EWqigNAjyB
         yqYPydqbH178AlRMAxBJ05vDG+n9JmEkBCrG/OX7w3Ihbaz71wBk/Inl3ryxLDq2GpR5
         x6IasdVC8FkHbKsYkiBmLrRJ06/wLtqkGLsyuj84sadjH6OAA3h74p+SjCzBebldIGw6
         35pAX8PIKzRlpwHVecu3WpzfVPPGG46qQ6GBDR7N08MC4Ta54NioJZEa/kSHeAvZN/KN
         mzGw==
X-Forwarded-Encrypted: i=1; AJvYcCVk+9cLyoq4F6gGJI2toEWVXVlbVimeBJ/VDhWhw61uc/41q8+TZb1NjISVUCRnae6r/jlmTJZvz3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHTdNEXGqMB8tleiI6LXc0OtfIks6joA006sPYZ+gu9cmb1Fn
	0ihTYbPsmnJb8E7dvb3CjTWWRPMlKYhXoFEgWn8RGbW3ukGg82Om7f3ZDm+apDfuQw==
X-Gm-Gg: ATEYQzyV3KOCFIQZLyiANsT2ENgTZc5p2YwUc9+3NqB5fIIvhQTL+wqR7C3WshlXMNC
	98gQ5u8nkxhjhzCouiFJdwQzfEDsjT9mFwl7mWx7i/RYlmb2ZRVYGWwaSz73sZakEFxVcpF4ZSw
	uGh7XJmG6dshnPvtf5dLfll+GjlnJLUj7a/fvyROM4ygxvEhiTRLNy7EPqqQIYVi10U7xFSD53F
	BVGFGITcRCbQSkHNtmnrDnLo1Mk1gIN3Sc1+cpIoiUwNyOTb20tQGC/e39hV22Cp2w9xiQqQsss
	Ks8Ph7PezWUmZiQoZPNjgvvGoE2GjCNm+TgtLqP7rjuWYJdNYjGMZmhgplqF0SQJ6OZnI0WNOwr
	URunn1QokvAKx3SfJmf6eAIsuzOEnjV7QrUgNEmMTj/7xthLZoJa3yvyEiIDwOZ50321kFgWBpC
	Dst3WFiD2rm63df3A4UQDmi+6LzYPMfCK1p6MIQZvueLasVYSgCgFmKxs5pukcFy5U/d0jK+s=
X-Received: by 2002:a17:903:2f04:b0:2a0:7fac:c031 with SMTP id d9443c01a7336-2ad997f5113mr1474945ad.14.1771921579006;
        Tue, 24 Feb 2026 00:26:19 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ada77cc13bsm13228715ad.47.2026.02.24.00.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 00:26:18 -0800 (PST)
Date: Tue, 24 Feb 2026 08:26:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 01/22] liveupdate: Export symbols needed by modules
Message-ID: <aZ1goNCgY8xz9n6K@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-2-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:48PM +0000, David Matlack wrote:
> Export liveupdate_enabled(), liveupdate_register_file_handler(), and
> liveupdate_unregister_file_handler(). All of these will be used by
> vfio-pci in a subsequent commit, which can be built as a module.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  kernel/liveupdate/luo_core.c | 1 +
>  kernel/liveupdate/luo_file.c | 2 ++
>  2 files changed, 3 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index dda7bb57d421..59d7793d9444 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -255,6 +255,7 @@ bool liveupdate_enabled(void)
>  {
>  	return luo_global.enabled;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_enabled);
>  
>  /**
>   * DOC: LUO ioctl Interface
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index 35d2a8b1a0df..32759e846bc9 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -872,6 +872,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
>  	luo_session_resume();
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>  
>  /**
>   * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
> @@ -917,3 +918,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>  	liveupdate_test_register(fh);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
> -- 
> 2.53.0.rc1.225.gd81095ad13-goog
> 
