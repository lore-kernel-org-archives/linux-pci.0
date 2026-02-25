Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892183101B1
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006612; cv=none; b=YQhCo05N86+73b4MiLKz7gI0gHjqEIUatRUYZAYdiW8InW+BqDMDyomPa4gwEtoexoWMFL377wUkWyPHAfBMW+yo37+V4xcNUh6g4GSReJ5Vrs0VhfRYa7c/rR/1N/yBqELTt80AYW85BUloi4qlo7kmDTzHeRHVhcMFsTTAin4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006612; c=relaxed/simple;
	bh=bq6zwXtFCcnqrhZIHxjGnvBS+KlyTU9xlpYaT604hrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN0oEiYQ31iNhJ/a0Bvhou79nxQVyu0VFCxMDH/3roFF1wKKIHrJskV9dioQQC6Cqu9l92MKvCCn97aL+Q/2Hab8gSyKrIUpS0fjX0crvWKjv9I4yP5Dmb4+xBhzgiwSGycxx9QvRHWkLCRQl/KuQW3Qcuaz3Xn4bw6ZW9keI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEN4BMRI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEN4BMRI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ada9e4ea32so55895ad.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 00:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772006610; x=1772611410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCJxVjDFn9Nx1ZVu0w3V3L8nPN74ZP9DglkzEBV+/BI=;
        b=QEN4BMRI3NcE4s4dHITuXTcZZePBS1pa5N7KS5NPIL0HW2SIO+xI7LqmE+gzxENW1t
         db5f3juWENY4Cn13Po/FHPGa2PSZML3rqQLoVgVs0ZW5e+H4Ke+OnwrhtSAtlGK2FVqo
         i+68/6axzRRuCqzk/1Ot2WM0e7XUc0VpfbGTUl/ATa6rLoZMx/nwxjQUcxtY3TYaiNIM
         aG8kHl3ipr/WLb0kjr6y4FjsD9tOj1Nr+nngKm3+etCnD/jXOL9VJXjVPi/OOQB038JG
         0rYUrOs8KTU0z/pHYb4Bkd3RhtzvNoqjEbwBimPDUcF87cY2BemjgWPUfvPP7XkqWXrK
         hfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772006610; x=1772611410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCJxVjDFn9Nx1ZVu0w3V3L8nPN74ZP9DglkzEBV+/BI=;
        b=bQ5sWemOaBIaRua/tol1sJ9JOiFfT2VHeK09YOmmMQQXUUMS/G4o5S/R4bhW7R6uvY
         Peu09tlvIobRjCBp11Nmo6UkAa1UsoDBFf0tZYI81gHeUUrYiuJJjC7l6rmjVN22zaN7
         XRvSEILZMSqX31FDl6Eehd8Iv+ASAfPkmYyi2yvM+J+G+xr2LeISUMz0FEOYs3gn2IF2
         reBc8XR+Yp3a8CbSDq+7cgdxjT4yxnpl3R27VQht9tlwb6dMspXlreT0FY3ZQC7fLx5X
         7GP1oP6fzidq67X9jUWPIDSY+SHxXQD85xBypbM4SRQYa22VvZwWnnYlEreaI9IMRPNB
         psnA==
X-Forwarded-Encrypted: i=1; AJvYcCVGOl+lyDPwYA9TGFPkTlgNaxA9Ms4SrccxT+WBbyUQq0IbODLQwpoHa/G/mbu14XOy3utohlPb3qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbX61+n3lki0yAFr2tkalBuhJ0HwRG+ubfUP/It/ByrXN9Fepi
	l16YLxpaLXRb5U2WHS55QQV/j1rFcKw5PKLsoEreEDwKN8VvAKUxk4NiNyfxc5sWRw==
X-Gm-Gg: ATEYQzw6A83/djoozqU9fU6DwKDD9SzMtyCc7QvIXYoldv6+p4aGWsydK166JV5h0BG
	OY4/ngU2umi3SXHJ4VW/zQFlOPfwWFO3AvuQypKmbO4j2BaVDS3rwjCLQpUxPDE0YFLb8gC27mR
	lXkwcoC7hJYyTA1xpURjZelXa6WoudJUDh3/swhIjkw0aJk4RslTwap1rQ8gx13/zXn6tjDJAjY
	8ewx52dGwQHeG2Llz9qPpBzVVRDsdOcCKyexS6gXpDTpOwzg5VnPEXLK4JKXt32yDsKomLPEJwe
	hsIPfj8rTYT9IvRtBMmI2+WJq1NZ/KnjFsFjnvLA8kEO2XdOXadOy4W4HQHl9PcRlgceWKK2uFm
	DWDJPW+FFJiqntJWiRGVy7jr659Xx9126BFWpO0Q6w3UCukZck+1JS8ayWmSXBiGlZGtjgSl73N
	Kbx9dy22+wFMJBtGnksnHKdbLnhHjMKVukgIGIiL7YNKSE5WNcTUKrb+HFfg5m
X-Received: by 2002:a17:902:ecc2:b0:2a7:7f07:340e with SMTP id d9443c01a7336-2adca6c9d85mr1313215ad.4.1772006609152;
        Wed, 25 Feb 2026 00:03:29 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3591342f19fsm421683a91.10.2026.02.25.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 00:03:28 -0800 (PST)
Date: Wed, 25 Feb 2026 08:03:18 +0000
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
Subject: Re: [PATCH v2 08/22] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <aZ6sxhNeHqy-hqhK@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-9-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-9-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:55PM +0000, David Matlack wrote:
> Enforce that files for incoming (preserved by previous kernel) VFIO
> devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
> opening the corresponding VFIO character device or via
> VFIO_GROUP_GET_DEVICE_FD.
> 
> Both of these methods would result in VFIO initializing the device
> without access to the preserved state of the device passed by the
> previous kernel.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/vfio/device_cdev.c |  4 ++++
>  drivers/vfio/group.c       |  9 +++++++++
>  include/linux/vfio.h       | 18 ++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
