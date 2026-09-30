Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996D3A451B;
	Wed, 30 Sep 2026 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745229; cv=none; b=LzZZyc8pT+VypYnoxu2tDkA5vIBH4eipqVRCdTodW5DbOTVbXPYfUG9dKiZn4cVfHlbHPuE67sP/mJ6Nshmy9Pe8t3gn1QL860UPBMNdTPuXAuVsMMEvvCE+IXuWznDsSJJUTNwB/ZSqQFgpMqH8e1BE/dhMmiNg/jSd9Umycjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745229; c=relaxed/simple;
	bh=9InepKRhqdxTtpIlf0m7y/RELCBjCLrHVYnkTluu1eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3B7pyY/QNGNw2Kazy1jf1Ue/h/UZjdXdvr6ZFZVf7on1Kbr7+OY09PDyEOrQZdE09PovPDnecOL2+mHQh55hi0376A9T+DDBVscW0a+mnAd8mRj0UlUWj0SlNvly4l3vB5+eqf8woPPGzXuZbPxvoOisdSaVdb/GvCAZ6LUOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+fxr7wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+fxr7wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8C91F000FF;
	Wed, 30 Sep 2026 05:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790745227;
	bh=AslUM2lUo6zD38QDpyEW5gH0KsNLmoeA0u6LegwyTtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=e+fxr7wtHemalreywtqv0bwoTJ8T8AQEkpf+pTQI2hhaQtR2TAZXiap1mtvOj68PK
	 xEalDijuWDnqzMv17GsDmPpX10n2Cbwfsb1tQifZQlm8X2CAxpNWD138U3ANoBBsCt
	 OOLvvjkQBJhbHGVPLw1FmYnbKUbcJZb9PmwuXD8BT8XyUMFV6XnGzGCfeSU1rVPm4G
	 kXlvoSrWaM0iqIDa/KEsDdQUGkKfJpA374BZQ+E67FWxcTungLDg+bHCQNa1yu8XBs
	 rMKinESOLo4yLMeUT8TudRZgkb/AskpKg54BsB4JW4uEPpW/Y659BXZbE7XWdO9udF
	 YIJNiyy58uFrQ==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, ankita@nvidia.com,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Cedric Xing <cedric.xing@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Kai Huang <kai.huang@intel.com>, Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	Thomas =?utf-8?Q?W?= =?utf-8?Q?ei=C3=9Fschuh?= <linux@weissschuh.net>,
	Lukas Wunner <lukas@wunner.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Fontenot,
	Nathan" <Nathan.Fontenot@amd.com>,
	Fang Peter <peter.fang@intel.com>,
	Petr Pavlu <petr.pavlu@suse.com>, rick.p.edgecombe@intel.com,
	Samuel Ortiz <sameo@rivosinc.com>,
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
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Date: Wed, 30 Sep 2026 10:43:33 +0530
Message-ID: <yq5aik3nuxs2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
>

Acked-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

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
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.43.0
