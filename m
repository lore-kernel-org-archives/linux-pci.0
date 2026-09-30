Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD06B3FE37A;
	Wed, 30 Sep 2026 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751494; cv=none; b=oajvG9jDWO+3lcB9jWE16XuoxehqTPQ4igaFOj17MUK9wUr3Tts67T5AvudgX/YtSvG3OERVH94JHPDPd9GH77PVz7n6i7C//GW93MK7+KNUim+2EpoFzX7Z2SdCzOujRI4bNpvZaCkI+Nyn6qMNKQRGVfVglWRIZAiuWlNozJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751494; c=relaxed/simple;
	bh=Xk8DEFs2cNrWuMHZ6GQ2EZCL/oamNlBzVYplJVyzKL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJl9tlQWbXyaP9hZaYnz4nADkgX9MoqUjfMTygTMXf2a8YJIx6ZoVVbHtfA6UcI61LexHelqD78tt2udMn5yUMhmKT2zzIPDYBchgPQToW3mzZwHuhoYlAJps7YE+2ppUeI2D7uOelcqce6wRY+bdbr1e50LRSlJ0GzTLRJ5+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUByI61m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUByI61m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE611F00893;
	Wed, 30 Sep 2026 06:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751482;
	bh=uZm2ZzTH7mgc/9bG+QGHa6xuFuylQoUoBuZROPJvY8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oUByI61mNruELsoKeGwKZnm8DL/70O0iGT8UK3oy3q9WkZXBsVOqY5LEhkviVDmF5
	 Y8W1LrBPAjsaiWu+Hrg9COy/MeGlZoeXa0utgrzZ13RffbyV9eWx+6LCTmweLs0Fkz
	 SotiMx+c8Kq+Tee0ETIU6uXKmeuP/i+lxDIjYHlmskalCJVTLsiWQ2phPmBN6t4eXy
	 FK2weDfw7mQz2kOgL07T0NhnDihScc6M6S6HqFLtOSxYi4fpLu3aYadJK60DbGT4iv
	 qXa9d0fuVkGyQ7BsV0sywOjiFtIjb/VA9uP5SqUo7yBnaNBqH0b6vSzxtEEOEV3zSs
	 9XxHNV498TOaA==
Date: Wed, 30 Sep 2026 09:57:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	ankita@nvidia.com, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Cedric Xing <cedric.xing@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Kai Huang <kai.huang@intel.com>, Kees Cook <kees@kernel.org>,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Lukas Wunner <lukas@wunner.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	Fang Peter <peter.fang@intel.com>, Petr Pavlu <petr.pavlu@suse.com>,
	rick.p.edgecombe@intel.com, Samuel Ortiz <sameo@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Will Deacon <will@kernel.org>, yilun.xu@intel.com,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH] coco/tsm: Update maintainership
Message-ID: <20260930065756.GN563127@unreal>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>

On Tue, Sep 29, 2026 at 08:26:41PM -0300, Jason Gunthorpe wrote:
> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  CREDITS     | 9 +++++++++
>  MAINTAINERS | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> I've now spoken to all the main companies contributing here and asked for
> volunteers. This is what I could confirm at this point. I'll be at LPC also
> for any further discussion. Regards
> 
> diff --git a/CREDITS b/CREDITS
> index a0bd941ca5dd26..7749f1e477ab43 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -4414,6 +4414,15 @@ W: ftp://ftp.uk.linux.org/pub/linux/people/willy/
>  D: Linux/PARISC hacker.  Filesystem hacker.  Random other hacking.  Custom
>  D: PPC port hacking.
>  
> +N: Dan Williams
> +D: Technical Advisory Board member
> +D: Asynchronous Transfers/Transforms (IOAT) API, Compute Express Link (CXL),
> +D: Device Direct Access (DAX), Filesystem Direct Access (DAX),
> +D: Intel I/OAT DMA driver, libnvdimm BTT: block translation table,
> +D: libnvdimm PMEM: persistent memory driver,
> +D: libnvdimm: non-volatile memory device subsystem,
> +D: Trusted Execution Environment Security Manager (TSM)
> +
>  N: G\"unter Windau
>  E: gunter@mbfys.kun.nl
>  D: Some bug fixes in the polling printer driver (lp.c)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72294ddfa5b757..729ab465af96a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27788,7 +27788,8 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/trigger-source/*
>  
>  TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
> -M:	Dan Williams <djbw@kernel.org>
> +M:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> +M:	Jason Gunthorpe <jgg@nvidia.com>
>  L:	linux-coco@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/ABI/testing/configfs-tsm-report
>

For some reason, your patch is missing a `To:` field.
https://lore.kernel.org/all/0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com/

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
