Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522727;
	b=Le0u9UP2M48WptWapuu7Wb2hl3tAQbakwaNX8c6rovHT0YOPbXueev4Gi7dhSKoCyXh+
	 y1xzXrKkPnYjOtNB7ZWztLoVZBHIv3TBJqxEBcCk2gI61iYmtJcSHiNJntDxKHeTy8dNO
	 xEQ8hZPaV3L7GyfCkrfpV0Ry60pirh2a8LkDQdf8rLQpEFDhf1T6rvk/a/1ofg52WXu6b
	 YLX5mWuVnyIrxnN2RWW5ErplG94gIOVZb0IJFwScZRXuFnSXImaFjlatFAX/fxe7XzwbD
	 zpiLVpcxfIt9XZmhyTFatBnlTeyUkfOS5ATwPEfEHUhWF9X9rLuvH++YUMp3pnjGLkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522727;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mvElZZI+CeG4IxR+qpAqQMv0MhCUAS7GHtlXGfa/VvA=;
	b=dTWjWlJKIX091XkwWVHPqcqfsfSoE6bXbzRKD+Xgit/miZZhv55iCEoCP/xfmVxayAZc
	 Z2UJGMW4KGhs9C9wHWzalP2mUIBMM+0ibCv+G8zdrB0waEFz6BJj4hKhx15I685kD3Cpo
	 /mH4kwA6B4fR0aLepaFs5vddXLqne98X9CfGas/AB/TIB/eSVqcCfdrSP0Lzrz4f+Z+oX
	 EEJ2NoML/ZwoGk/kQIsAFSG8ukQgiSGf2mNf2GgRKDjhAInHMDfT4+tx7TPCfgF5oB+tN
	 c2Kf3cXX1X1HVUJ/wLVYZMpctwmpXgtdybFlqkZLWhMZ/0LdvmkVQckKkOPGQlk2NwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahcqJ7mg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3B606A333;
	Thu, 12 Nov 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahcqJ7mg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C681F000C7;
	Thu, 12 Nov 2026 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522727;
	bh=mvElZZI+CeG4IxR+qpAqQMv0MhCUAS7GHtlXGfa/VvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ahcqJ7mgpLGd3tjUQBdsp8VTv/TxUUsB2E2bLAtRNlTuad3FwsMdiKHay0jU+gGlS
	 o9hljcPepbUxV2iRROh67JMIHrudz1iFu0DDGcdnFA9hbbqBWQAGMS2kL0iqs20UFM
	 1CaD9+MFyTndbUlCJxMAuWe8T600gdAwhuJu29MX/eg1xs8kU41CJ9EeYhUXVBM919
	 PV0LxGAHOvq1eW1+uVniZ2KZjXnEHc7fuRi+VvhFwpCfayNJQXNwXYEoD9+xY6P+wg
	 OEmuj+cVTXvIJ1weuj/q/XTR6+AfX/FFHoQxyY/3aoNyw70qlfejswaGwzR5XIc12a
	 toSgegG7hQJVQ==
Date: Thu, 12 Nov 2026 16:32:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-pci@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] media: Consolidate AtomISP v2 PCI IDs in the
 pci_ids.h
Message-ID: <20261112223205.GA919701@bhelgaas>
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
In-Reply-To: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>

On Fri, Oct 02, 2026 at 11:43:43AM +0200, Andy Shevchenko wrote:
> We have a few drivers using same pair of the PCI IDs across the kernel and
> there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h database.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

> ---
> 
> Assuming that media subsystem is the main beneficiary I think it is the best
> to route it via that tree. For others (i915, PCI, PDx86), please Ack if you
> are agree.
> 
>  drivers/gpu/drm/i915/display/intel_display_power.c   |  6 +++---
>  drivers/platform/x86/intel/atomisp2/pm.c             |  6 +++---
>  drivers/staging/media/atomisp/pci/atomisp_internal.h |  2 --
>  drivers/staging/media/atomisp/pci/atomisp_v4l2.c     | 10 +++++-----
>  include/linux/pci_ids.h                              |  2 ++
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
> index 2e534ddb7347..ee2c59b72b4a 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_power.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_power.c
> @@ -2086,9 +2086,9 @@ static void assert_ved_power_gated(struct intel_display *display)
>  static void assert_isp_power_gated(struct intel_display *display)
>  {
>  	static const struct pci_device_id isp_ids[] = {
> -		{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0f38)},
> -		{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x22b8)},
> -		{}
> +		{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BYT) },
> +		{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BSW) },
> +		{ }
>  	};
>  
>  	drm_WARN(display->drm, !pci_dev_present(isp_ids) &&
> diff --git a/drivers/platform/x86/intel/atomisp2/pm.c b/drivers/platform/x86/intel/atomisp2/pm.c
> index ad1f99140962..f3dee0e58f62 100644
> --- a/drivers/platform/x86/intel/atomisp2/pm.c
> +++ b/drivers/platform/x86/intel/atomisp2/pm.c
> @@ -121,9 +121,9 @@ static UNIVERSAL_DEV_PM_OPS(isp_pm_ops, isp_pci_suspend,
>  			    isp_pci_resume, NULL);
>  
>  static const struct pci_device_id isp_id_table[] = {
> -	{ PCI_VDEVICE(INTEL, 0x0f38), },
> -	{ PCI_VDEVICE(INTEL, 0x22b8), },
> -	{ 0, }
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BYT) },
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ISP_BSW) },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, isp_id_table);
>  
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_internal.h b/drivers/staging/media/atomisp/pci/atomisp_internal.h
> index 5a69580b8251..1a05fc331557 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_internal.h
> +++ b/drivers/staging/media/atomisp/pci/atomisp_internal.h
> @@ -37,7 +37,6 @@
>  	(((isp)->media_dev.hw_revision & ATOMISP_HW_REVISION_MASK) == \
>  	 ((rev) << ATOMISP_HW_REVISION_SHIFT))
>  
> -#define ATOMISP_PCI_DEVICE_SOC_BYT	0x0f38
>  /* MRFLD with 0x1178: ISP freq can burst to 457MHz */
>  #define ATOMISP_PCI_DEVICE_SOC_MRFLD	0x1178
>  /* MRFLD with 0x1179: max ISP freq limited to 400MHz */
> @@ -45,7 +44,6 @@
>  /* MRFLD with 0x117a: max ISP freq is 400MHz and max freq at Vmin is 200MHz */
>  #define ATOMISP_PCI_DEVICE_SOC_MRFLD_117A	0x117a
>  #define ATOMISP_PCI_DEVICE_SOC_ANN	0x1478
> -#define ATOMISP_PCI_DEVICE_SOC_CHT	0x22b8
>  
>  #define ATOMISP_PCI_REV_MRFLD_A0_MAX	0
>  #define ATOMISP_PCI_REV_BYT_A0_MAX	4
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> index 476fe143a591..ab8727a806bf 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
> @@ -1239,7 +1239,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  		}
>  		isp->hpll_freq = HPLL_FREQ_1600MHZ;
>  		break;
> -	case ATOMISP_PCI_DEVICE_SOC_BYT:
> +	case PCI_DEVICE_ID_INTEL_ISP_BYT:
>  		isp->media_dev.hw_revision =
>  		    (ATOMISP_HW_REVISION_ISP2400
>  		     << ATOMISP_HW_REVISION_SHIFT) |
> @@ -1284,7 +1284,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
>  		isp->dfs = &dfs_config_merr;
>  		isp->hpll_freq = HPLL_FREQ_1600MHZ;
>  		break;
> -	case ATOMISP_PCI_DEVICE_SOC_CHT:
> +	case PCI_DEVICE_ID_INTEL_ISP_BSW:
>  		isp->media_dev.hw_revision = (ATOMISP_HW_REVISION_ISP2401
>  						 << ATOMISP_HW_REVISION_SHIFT);
>  		isp->media_dev.hw_revision |= pdev->revision < 2 ?
> @@ -1487,12 +1487,12 @@ static const struct pci_device_id atomisp_pci_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_MRFLD_1179)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_MRFLD_117A)},
>  	/* Baytrail */
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_BYT)},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ISP_BYT) },
>  	/* Anniedale (Merrifield+ / Moorefield) */
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_ANN)},
>  	/* Cherrytrail */
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ATOMISP_PCI_DEVICE_SOC_CHT)},
> -	{0,}
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ISP_BSW) },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, atomisp_pci_tbl);
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 63774ae2bf71..0693e4532a68 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2732,6 +2732,7 @@
>  #define PCI_DEVICE_ID_INTEL_HDA_HSW_3	0x0d0c
>  #define PCI_DEVICE_ID_INTEL_HDA_BYT	0x0f04
>  #define PCI_DEVICE_ID_INTEL_SST_BYT	0x0f28
> +#define PCI_DEVICE_ID_INTEL_ISP_BYT	0x0f38
>  #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062
>  #define PCI_DEVICE_ID_INTEL_82573E_SOL	0x1085
>  #define PCI_DEVICE_ID_INTEL_82573L_SOL	0x108f
> @@ -2787,6 +2788,7 @@
>  #define PCI_DEVICE_ID_INTEL_VMD_201D	0x201d
>  #define PCI_DEVICE_ID_INTEL_HDA_BSW	0x2284
>  #define PCI_DEVICE_ID_INTEL_SST_BSW	0x22a8
> +#define PCI_DEVICE_ID_INTEL_ISP_BSW	0x22b8
>  #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN	0x2310
>  #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX	0x231f
>  #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
> -- 
> 2.50.1
> 
