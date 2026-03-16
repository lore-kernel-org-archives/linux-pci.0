Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8593358B0
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678160; cv=none; b=NUu5gb18CGwGRqbF/uq4J4eLhKHMzskao0Z1TzuJpxJ6PYOOoriqDTRMGpesRBPgyvAeZ98q01t1mr4WxIAihksL3BF08C4/3Jn0tPfGAo2gdlv/iP2zAjXT/NZQik1qEjsfqMKW0ZxZTEwT62faX9h7IC8Ho3KCFg09vrUnZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678160; c=relaxed/simple;
	bh=zApGoFyAcej+fGePwU6DOnsDPAGQmLesVQjqihPzKsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMZZWRPSGc2gjab4szWy0vwWxiMeWkdXVEFqBMi3FW53zET84rnryl3usuJSNujq6wpKXlDiF8qZWKjROGl0kY+g7KlnDKn2749wwGzNusxrnbhdrRJ69tcJhayRT4hWPkuFFfpbaEYgQNd3A6I7bJ1Gci0zKxFlMpNxNPc0KaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cP3lT+zh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cP3lT+zh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so103585ad.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773678158; x=1774282958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qInQBteouiFFrqfiLhXSZXU3zqWyev9a+m0PyBXHRjI=;
        b=cP3lT+zh+FCJ6OXDDpAVgw6whOWVihSt3nqNwNsmunvouLZgjDIjh5VEVp3qQzC8ON
         y5OVa23XQU3gefsNcoH1w2TzBPnHXXH3cEGZ1UNQCxl3Rw6Gn9ZRvnqVzVDLYGIAex1O
         suEN6YKSY9UPiDUsSfDxuJhG/KKUFxFsHZv1pZWWIQZwiWpuRWznzmCVy7XcuNk7FpLI
         L25bBlW4x2j4pvKX4Zwta1trY9msxi+Jamna5W7QowfX6Axy7FM5QCnobU07ZqX5398L
         W/UwdWNaeG1V1met9yniQe7a72OPyHTgm0q4VpUnHnOAl6I0oWiM7WPy4MgCo6CmAl1E
         8PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678158; x=1774282958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qInQBteouiFFrqfiLhXSZXU3zqWyev9a+m0PyBXHRjI=;
        b=ND0exLq9ZRtJh4rOoeNu+KEfKah0aRQHIduJf88eV1MjhAeFcrJ6QwEdXUDbi+nMus
         yJ7++2JsMsOHy7z20oiQFK27A0jqJTIi5IAxKBYzli1GsfaOLfbKsSHTpLMJjjEgiWNf
         xaPCSvxySZcOhTn2RDn1zo73qCoKMOYAJCy316iDb/18bo+AdlMW9J7bzNouyZm85cZY
         iOFHfL/zi3MHh4yGCJNfxyk2qpM0zEKtFxs3xNVUFkYTAZO1HyY8+uBVsIWKusUIYraP
         RbuD7iqkNjWEtr14Wsu8WlMcDzpP4MsReuJuzBUUHaf7IjLlX9WxpYw1v7BXnhU+sOm/
         eEZA==
X-Forwarded-Encrypted: i=1; AJvYcCXEFtIbukIIC/jNPhnEQkJPwebFi7ILiFxxyIu56VL0iu4VLgTavPnrF0/1wKG5YSbDdMj6RGBZ3/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp78uqNAYnH/IWVgQGUtbqZ5Rjsvxo4UwbjmL0X8KGsImSqONX
	cAW6OcQAZtszsDQTx4f5JZScSXuy6q1JxUAPnvYLhAHYEZ1zx0qZoMynF850Zvu1Rw==
X-Gm-Gg: ATEYQzw8l2RVHW+5MiQzQDYrtZVSNNgBfLdS6B84UABwPQEixiUmTi1qJI3bmsg1OXW
	0zdQKetIfp9S28XifHpVTXMO4V2/nAPaZPIe8+i1Lw4Sp8qO4TDHUDMnzKpyLx5HbOF7qu24Tjv
	44IwoFXZKmzat+fyEIAKN1qUZy/j9zN9YvipISDvI6l2VzXeY6I9aJQBni459Ib0HYoi3vyTAlq
	8N/LcrDuMFJGQ3OoL/aShOhDfjr8rLzOk1O1px9k/7MsylG6Xal4/50v0vn+rUXWZy5zYFlt04t
	Y4le4foI1bM+e3iifml7UPVX1UfjZIBo+MfZX/ulPPwqbSJvucGHytLks8/pUyleQ8HJ4R3xbiI
	2+YGonY0hoz8zPEcsNEaTMEJxlI63ZH6947IkumhimHm7TypRS4BGYU4PBx0H7Vtq8bA+Jy8KVn
	WlB9BBLV/o5ObkwTE4yHjFVXTxo070AWqiRDs/pksAmXQsh4WGgcV0sK+++uOU
X-Received: by 2002:a17:902:c94d:b0:2ae:4572:50e8 with SMTP id d9443c01a7336-2b04208841fmr5460915ad.8.1773678157593;
        Mon, 16 Mar 2026 09:22:37 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada43329sm111822a91.6.2026.03.16.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:22:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:22:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
Message-ID: <20260316160759.GA1767448.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org>
 <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abNOwcOTXqxCxNzt@google.com>

On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> On 2026-03-09 10:32 AM, David Matlack wrote:
> > On Fri, Feb 27, 2026 at 9:57 AM Alex Williamson <alex@shazbot.org> wrote:
> 
> > > Sorry if I don't have the whole model in my head yet, but is exposing
> > > the restriction to the vfio user of the device sufficient to manage the
> > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP pushes
> > > the knowledge to QEMU... what does QEMU do with that knowledge?  Who
> > > imposes the policy decision to decide what support is sufficient?
> > 
> > Hm.. good questions. I don't think we want userspace inspecting bits
> > exposed by the kernel and trying to infer exactly what's being
> > preserved and whether it's "good enough" to use. And such a UAPI would
> > become tech debt once we finish development, I suspect.
> > 
> > A better approach would be to hide this support from userspace until
> > we decide it is ready for production use-cases.
> > 
> > To enable development and testing, we can add an opt-in mechanism
> 
> Here is what I am trending towards sending in v3 as the opt-in mechanism:
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 1e82b44bda1a..770231554221 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
>  config VFIO_PCI_DMABUF
>         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> 
> +config VFIO_PCI_LIVEUPDATE
> +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> +       depends on LIVEUPDATE && VFIO_PCI
> +       help
> +         Support for preserving devices bound to vfio-pci across a Live
> +         Update. The eventual goal is that preserved devices can run
> +         uninterrupted during a Live Update, including DMA to preserved
> +         memory buffers and P2P. However there are many steps still needed to
> +         achieve this, including:
> +
> +          - Preservation of iommufd files
> +          - Preservation of IOMMU driver state
> +          - Preservation of PCI state (BAR resources, device state, ...)
> +          - Preservation of vfio-pci driver state
> +
> +         This option should only be enabled by developers working on
> +         implementing this support. Once enough support has landed in the
> +         kernel, this option will no longer be marked EXPERIMENTAL.
> +
> +         If you don't know what to do here, say N.
> +

To use VFIO liveupdate, user has to do at least two things:
1. Enable CONFIG_LIVEUPDATE
2. Pass VFIO FD to a live update session.

This means someone using it has to know what live update is and
intentionally pass the VFIO FDs. Isn't act of doing this itself an
opt-in mechanism?

I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
about how userspace will know that sufficient VFIO support exists. May
be write in liveupdate documentation (PATCH 11 of this series) that
support is experimental?
