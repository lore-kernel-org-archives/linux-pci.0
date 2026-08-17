Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEA470E82
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001140; cv=none; b=ew8Pn4Ek7uYG+7FS7xpkUmhAa5Py5mUlp2efldRyV9Ea+JeShXUYRDR51O8pqVIuOYppeiFrfVIUIG/09fSUBU0JlEN2adTO8aRxMAkI/4e9kvRsz7yakbQQHFMZ0ZgGpfUX2rDHj2lKEmxrUv96//Qm58DRslVgldegMWFg8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001140; c=relaxed/simple;
	bh=feYyRrzAVrbwe6Q6bLDQHGa2NlKsylvjthlQKxO/EoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6VbGkWyIM18yBp6t51J/30lRIaZMJFAYIJwD+z+N5cesBG9JDuVDdxhg4AFSo4DcZD6F34ofVfQCCTFIJNYgG6+RkDOFPmAdG39O0xH5DdsS2MaUhLImwDmw/d1Lm5BZb6FMkdzzqTcuIjT1iK24rPP2MaXHszk1i32ZoEO9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJPP0kCJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJPP0kCJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdf36f63dso29115ad.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787001138; x=1787605938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oma5+/tlfa1RRzhj7JpkkV8zgHZVnZM8SsuwDuMX0+U=;
        b=pJPP0kCJfa9QrYBixCoeq2+YRoTfFkLjFn/ZVuqA2Z5PrunHn/mB/x4LgER6IWJeB6
         /aWw5JOELEvrtTlJfUPzqnla7hYeDenlaNegMooYKpy9yagxRqA+8p6xkkBAbQQfCBdQ
         5gB8cm89oaw4xww7n7GFetCevia10JU5DhrNN+JEQZs4kekerVFflBoIK4n0/WnWgw7M
         r/PsVcFODAaheGrcn/kJWtcWhvS4DOoeFXANPA/eGGt6Au5x1fIyONsQqgJ8Om3PKIzr
         tFNKq8Ascwdj+Oy3kRHbzQbK1DqcIEfPf+gbjHc3it3XvoEaKWgpKzCqK6bpH+4Jyq6E
         lygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001138; x=1787605938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oma5+/tlfa1RRzhj7JpkkV8zgHZVnZM8SsuwDuMX0+U=;
        b=NH3ODvjdW9dIIBvdYAj7FPvLEfpqeZ0x5gLZYo4CFwBAVaaatZZrzjwwV8l4D1O84s
         43vPzmukelSFMHlu8uCo/+XXZR4b2Y2+ZnM+wwJSc9VHG7VlWXUMSb7pYc+oZaflS4nL
         5Ry+hslgyTV0PFQ8gdDuquB63Drob+8Cn8vemGoL2QfLrAVNnyqHki/VtUvGiV88Kiq/
         Gnk4VGXK/POhRh4KKvBLSiOzNKb9irC+fmE3sN+Iw8ss7E4gt2cH7oRGZQ0uUGrZZjil
         bR1CCk3ANbh/vOQwCZSSJeXtziEmfLE3DqkkMANwKY5gTUgakvf7D7mQeWCmPIMyW4MS
         iFPQ==
X-Forwarded-Encrypted: i=1; AHgh+RriCdb9MUQhGqSFmvCG5bgJqQUUT8yrinujPt8GDkiwHsGRfq2SbjVfgNryeg8qxI1ojc+aqCxEZSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHtLRUarqTTAxn0xO/8WXfqTFVnCGG0NL3/4J4UPkaeFyc94R
	OSVefRVRurXjKDrAc7W7n8aFby9fbHod3irKY5frJD3z6zwEV+RdlR481M9W/pNG2Q==
X-Gm-Gg: AR+sD11C1P2k2T2BgIHqbAEuYsrvOXd35Celse/71rDZV+ApqsmlOHadGndAnBOdHiM
	+gSwyM9RM9kcP19F/++qZYRJ8DAcwM2uBcJSCYU1oTHRyUQEv0WVihLqAzgtJjPG3Zy4GwgjJ9d
	AXR3p55wz+BY3KcWw7GdXQdLYBvGeY/LT4hwX7l0d+0B2DV9Yb8tmEjtnB5u+nrppl1oU7StP/A
	1FDcYFQuW++etpeQBlfFRLnij08oie9pdUVlaJs8NbKvWB6ieY1/KXgx6emm13/2tXYT9XhetU/
	okBvNZ7+VTrXhx1oYT3+qzcmsYFjzh9AEGpja0RmZtyFWFYQjHxFIJr4wzNpGCRcJJPMNzYu2L5
	Z3zQPFAXhLHpWGA52jMc4KYqTHVYSbMYoY+oyNFCaOOr532Qw+/zpCS2CzKMQzBzQF5b4KAnqJR
	+Nb7GD/U4qBN9br7cg70ac77Vf+jBwDuybf54xrWVGc9lAgTiYp/hRqEjAKIAr4ldYeGKxHTJ4W
	EHvcmYKNlgKrwYvaYqdAmFSOgIXLxdVqTMthFR+02/IFrdT00VyGFo19D5EcHU9SHbwTQ==
X-Received: by 2002:a17:903:1b6c:b0:2c9:d89f:fd98 with SMTP id d9443c01a7336-2d5ccb2615emr3070545ad.1.1787001137341;
        Mon, 17 Aug 2026 14:12:17 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e528b3sm7631765ad.46.2026.08.17.14.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:12:15 -0700 (PDT)
Date: Mon, 17 Aug 2026 21:12:12 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aoN4YxRo1TEcVuaP@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-2-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:09:55PM +0000, David Matlack wrote:
>Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
>it to participate in the preservation of PCI devices across Live Update.
>Essentially, this commit enables the PCI core to allocate a struct
>(struct pci_ser) and preserve it across a Live Update whenever at least
>one device is preserved.
>
>Preserving PCI devices across Live Update is built on top of the Live
>Update Orchestrator's (LUO) support for file preservation. Drivers are
>expected to expose a file to userspace to represent a single PCI device
>and support preservation of that file. This is intended primarily to
>support preservation of PCI devices bound to VFIO drivers.
>
>This commit enables drivers to register their liveupdate_file_handler
>with the PCI core so that the PCI core can do its own tracking and
>enforcement of which devices are preserved.
>
>  pci_liveupdate_register_flb(driver_file_handler);
>  pci_liveupdate_unregister_flb(driver_file_handler);
>
>When the first file (with a handler registered with the PCI core) is
>preserved, the PCI core will be notified to allocate its tracking struct
>(pci_ser). When the last file is unpreserved (i.e. preservation
>cancelled) the PCI core will be notified to free struct pci_ser.
>
>This struct is preserved across a Live Update using KHO and can be
>fetched by the PCI core during early boot (e.g. during device
>enumeration) so that it knows which devices were preserved.
>
>Note: This commit only allocates struct pci_ser and preserves it across
>Live Update. A subsequent commit will add an API for drivers to tell the
>PCI core exactly which devices are being preserved.
>
>Note: There is no reason to check for kho_is_enabled() since it can be
>assumed to return true. If KHO was not enabled then Live Update would
>not be enabled and these routines would never run.
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>---
> Documentation/core-api/liveupdate.rst |   4 +
> MAINTAINERS                           |  13 +++
> drivers/pci/Kconfig                   |  15 +++
> drivers/pci/Makefile                  |   1 +
> drivers/pci/liveupdate.c              | 158 ++++++++++++++++++++++++++
> include/linux/kho/abi/pci.h           |  63 ++++++++++
> include/linux/pci.h                   |   1 +
> include/linux/pci_liveupdate.h        |  30 +++++
> 8 files changed, 285 insertions(+)
> create mode 100644 drivers/pci/liveupdate.c
> create mode 100644 include/linux/kho/abi/pci.h
> create mode 100644 include/linux/pci_liveupdate.h
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
