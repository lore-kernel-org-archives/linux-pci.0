Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF4457E64;
	Fri,  2 Oct 2026 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790934973; cv=none; b=XxGpHmVm01lccrXp8NtmVHos2F0hjlR7YeZoqAKxxnE1/MIEhX6vJoe42cBxXEeElcKuF+kj0BmOg4lZ18ngSOI+VbaT99gGJ02/60/gt24jeKBiPQpaq02k/ealeQ2aUq2mSE+rGWZeL6y39nFWySvCoPIl5O6H/Yd9i2FrvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790934973; c=relaxed/simple;
	bh=5oDWEXAErWcWClaMLl4Wym2DzqbWIFMZZzTEgbzozfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ie688dh/d3OWeAngq3dtNJEjx74znNCnSmZIWWko2y3ODZDFgXQR7RmYUOU7tZXlRemhMtoviEyZX7SKxasFgzPKB71TooJvdABli7JVfoIgIqEKk4tdw8dBuEjLfwtHFlpl7EpS63sDZiKbeHbbxa5ejlI5ak1n0VTxbZCn9YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJSHMtEL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJSHMtEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790934971; x=1822470971;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5oDWEXAErWcWClaMLl4Wym2DzqbWIFMZZzTEgbzozfM=;
  b=jJSHMtELmb9Hp6otNXIc3b1AzLSPzoyypbeY9aNsVaWwrCFEx4p5cBjC
   zcgZfX4Oz+iinQafn720HjzSqhFDzGGVXaJB2YAKj8RYc0uNbX5FBb+lo
   WVeab3opArCa6vETxocs3IERv7eGQCM1vixG7id+Jo7fdqOczI1h65AfH
   BDfA6l+9bK78eZY8fBb0dUu9ZRgsaM1cJ8h/zkrecAZB5hBqsiaPMyUg0
   lbRoRcngtencq1pbAKqFXeyK5DVs+hnamDyZbg1Wl6SjJIFJvgXMtn9G3
   1AUa1XSh64tE9EtMQh//GJTTZmNy77X5BLOnwmgtAp9wvu8m6fw8MV1UN
   w==;
X-CSE-ConnectionGUID: kAVIcvY1TKWYO7SRks6qgg==
X-CSE-MsgGUID: 2oDtfFqSQRajOYjt6RQurg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113484357"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113484357"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:56:11 -0700
X-CSE-ConnectionGUID: B1w6CqLHRvC1bBz/2EYLcw==
X-CSE-MsgGUID: PsXB79ADTye+LFGg4kMy8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279958960"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:56:06 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Hans de
 Goede <hansg@kernel.org>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Andy
 Shevchenko <andy@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] media: Consolidate AtomISP v2 PCI IDs in the
 pci_ids.h
In-Reply-To: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261002094813.856439-1-andriy.shevchenko@linux.intel.com>
Date: Fri, 02 Oct 2026 12:56:03 +0300
Message-ID: <991d1bbaed89d36dfc2f311f4efe6f6b26f86ad3@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 02 Oct 2026, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> We have a few drivers using same pair of the PCI IDs across the kernel and
> there seems more to go, consolidate AtomISP v2 PCI IDs in pci_ids.h database.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> Assuming that media subsystem is the main beneficiary I think it is the best
> to route it via that tree. For others (i915, PCI, PDx86), please Ack if you
> are agree.

Acked-by: Jani Nikula <jani.nikula@intel.com>


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

-- 
Jani Nikula, Intel
