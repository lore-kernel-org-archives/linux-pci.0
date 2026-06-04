Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6253BBFC2
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615970; cv=none; b=UrnMNj8uIYqkz+tEUqhpVstUwrPBx8wz0x7zLMtuN1myfbpmHg1uKUzXg5qMgUckl4UjmWDZbS8wGomLwlYLGINcwIxkzGWSdOUI1YEcTMFWrZ4WXSzxtbjMEqRGAOU5sBdcrBAnKRVDNsP3C36l3O3lA/ffOYrRUt/KGadIsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615970; c=relaxed/simple;
	bh=AMRdKOtHZk/vC/uA3CiORdDVzngI6NReEGp/Irn2YkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJXeOqbfm3NfQZ7pDjfiH/5DVL+XyfQ1pdGSjggt980OwQKmi+toR8+EiBh05cAfBZ0/ATthajb1BkKIYmdViS+1jrE2zV2QYFwp55EaAucQjKdXsBzuIhmH/1sFoCofWASPTurdORPkztqB8QzO+64pgbsVMErbsAOae6bNeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tt1Gt8ld; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tt1Gt8ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780615968; x=1812151968;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AMRdKOtHZk/vC/uA3CiORdDVzngI6NReEGp/Irn2YkY=;
  b=Tt1Gt8ldbzVcOPvaMU9a0rf4dVK9rIIDgS291oAk0OQuM72i3fUktGQD
   lZBCssT3B615+LippwhN/zODWcHsvvzADf7M0TMCnqdf7ozbj/rnK2CPK
   8/c4GT3gCRL5l2oMD3VZtnBVWcbtOBhy1GC01zL1av1l18buRgE/FQ3Xs
   4aAI/PPZIJr2f7KzqsZ+HaaR+NdfUHG4dC08e2hhHN0ydMZrMIv4K6lP5
   zCmMfOqU/cKnSARffNvkDKcyQYAtlbkfmRdoaK7IbrA1m29DKyq1vjfBX
   Bvfup0yhtLJcIcgPf713y5pggpjuzsvYDUh1uScb1ylE0ai1sK67PaSk8
   Q==;
X-CSE-ConnectionGUID: 82vWlE0kQ+i2laE6RyUhUg==
X-CSE-MsgGUID: qQtKVts7RsSOP1h9+r1/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="84030115"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="84030115"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 16:32:47 -0700
X-CSE-ConnectionGUID: 7Pz3C9k0TO+mmb02Dsd/mw==
X-CSE-MsgGUID: j25JKB0XRDG70siyZu776A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249020863"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 16:32:47 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>
Cc: linux-pci@vger.kernel.org, qat-linux@intel.com, Damir Chanyshev
 <conflict342@gmail.com>, Simon Richter <sjr@debian.org>, Tomasz Ossowski
 <tomasz.ossowski@intel.com>
Subject: Re: [PATCH v2] PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to
 whitelist
In-Reply-To: <6aac4922b5fe7070b11874427a9285e42ddd05a4.1780585518.git.lukas@wunner.de>
References: <6aac4922b5fe7070b11874427a9285e42ddd05a4.1780585518.git.lukas@wunner.de>
Date: Thu, 04 Jun 2026 16:32:46 -0700
Message-ID: <87qzmlq3tt.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Lukas,

Lukas Wunner <lukas@wunner.de> writes:

> The first device on a PCI root bus determines whether the host bridge is
> whitelisted for P2PDMA.  All Intel Xeon chips since Ice Lake (ICX, 2021)
> expose a device with ID 0x09a2 as first device.  It is loosely associated
> with the IOMMU.  All these Xeon chips support P2PDMA, so since the
> addition of the device with commit feaea1fe8b36 ("PCI/P2PDMA: Add Intel
> 3rd Gen Intel Xeon Scalable Processors to whitelist"), P2PDMA has been
> allowed on all new Xeons without the need to amend the whitelist:
>
> Xeons with Performance Cores:
>   Sapphire Rapids (SPR, 2023)
>   Emerald Rapids (EMR, 2023)
>   Granite Rapids (GNR, 2024)
>   Diamond Rapids (DMR, 2026)
>
> Xeons with Efficiency Cores:
>   Sierra Forest (SRF, 2024)
>   Clearwater Forest (CWF, 2026)
>
> However these Xeons also expose accelerators as first device on a root bus
> of its own:
>
>   QuickAssist Technology (QAT, crypto & compression accelerator)
>   Data Streaming Accelerator (DSA, dma engine)
>   In-Memory Analytics Accelerator (IAA, dma engine)

Minor: I think it's more correct to call IAA a compression accelerator
instead of a dma engine.

For the changes:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

>
> Whitelist them for P2PDMA as well.  Move their Device ID macros from the
> accelerator drivers to <linux/pci_ids.h> for reuse by P2PDMA code.
>
> Unfortunately the Device IDs vary across Xeon generations as additional
> features were added to the accelerators.  This currently necessitates an
> amendment for each new Xeon chip.
>
> For future chips, this need shall be avoided by an ongoing effort to
> extend ACPI HMAT with PCIe P2PDMA characteristics (latency, bandwidth,
> ordering constraints).  The PCI core will be able look up in this
> BIOS-provided ACPI table whether P2PDMA is supported, instead of relying
> on a whitelist that needs to be amended continuously.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> ---
> Changes v1 -> v2:
> * Drop code comments associating QAT generation with CPUs because a
>   QAT generation can go to different CPUs or plug-in cards (Giovanni)
>
> Link to v1:
> https://lore.kernel.org/r/4ea5265495876beb5fb5e6d479b2782f882bcbb3.1780570508.git.lukas@wunner.de/
>
>  drivers/crypto/intel/qat/qat_common/adf_accel_devices.h |  5 -----
>  drivers/dma/idxd/registers.h                            |  3 ---
>  drivers/pci/p2pdma.c                                    | 10 ++++++++++
>  include/linux/pci_ids.h                                 |  8 ++++++++
>  4 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> index 03a4e96..cbd1d1e 100644
> --- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> +++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
> @@ -28,15 +28,10 @@
>  #define ADF_4XXX_DEVICE_NAME "4xxx"
>  #define ADF_420XX_DEVICE_NAME "420xx"
>  #define ADF_6XXX_DEVICE_NAME "6xxx"
> -#define PCI_DEVICE_ID_INTEL_QAT_4XXX 0x4940
>  #define PCI_DEVICE_ID_INTEL_QAT_4XXXIOV 0x4941
> -#define PCI_DEVICE_ID_INTEL_QAT_401XX 0x4942
>  #define PCI_DEVICE_ID_INTEL_QAT_401XXIOV 0x4943
> -#define PCI_DEVICE_ID_INTEL_QAT_402XX 0x4944
>  #define PCI_DEVICE_ID_INTEL_QAT_402XXIOV 0x4945
> -#define PCI_DEVICE_ID_INTEL_QAT_420XX 0x4946
>  #define PCI_DEVICE_ID_INTEL_QAT_420XXIOV 0x4947
> -#define PCI_DEVICE_ID_INTEL_QAT_6XXX 0x4948
>  #define PCI_DEVICE_ID_INTEL_QAT_6XXX_IOV 0x4949
>  
>  #define ADF_DEVICE_FUSECTL_OFFSET 0x40
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index f954113..1dce26d 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -10,9 +10,6 @@
>  #endif
>  
>  /* PCI Config */
> -#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> -#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> -#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>  #define PCI_DEVICE_ID_INTEL_IAA_PTL	0xb02d
>  #define PCI_DEVICE_ID_INTEL_IAA_WCL	0xfd2d
>  
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 7c89854..206e3fe 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -548,6 +548,16 @@ static bool cpu_supports_p2pdma(void)
>  	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_DSA_SPR0, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_IAX_SPR0, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_DSA_GNRD, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_DSA_DMR, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_IAA_DMR, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_4XXX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_401XX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_402XX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_420XX, 0},
> +	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_6XXX, 0},
>  	/* Google SoCs. */
>  	{PCI_VENDOR_ID_GOOGLE,	PCI_ANY_ID, 0},
>  	{}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f..1c9d40e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2732,6 +2732,9 @@
>  #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
>  #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>  #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
> +#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> +#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> +#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_82437	0x122d
>  #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
> @@ -3052,6 +3055,11 @@
>  #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
>  #define PCI_DEVICE_ID_INTEL_HDA_TGL_H	0x43c8
>  #define PCI_DEVICE_ID_INTEL_HDA_DG1	0x490d
> +#define PCI_DEVICE_ID_INTEL_QAT_4XXX	0x4940
> +#define PCI_DEVICE_ID_INTEL_QAT_401XX	0x4942
> +#define PCI_DEVICE_ID_INTEL_QAT_402XX	0x4944
> +#define PCI_DEVICE_ID_INTEL_QAT_420XX	0x4946
> +#define PCI_DEVICE_ID_INTEL_QAT_6XXX	0x4948
>  #define PCI_DEVICE_ID_INTEL_HDA_EHL_0	0x4b55
>  #define PCI_DEVICE_ID_INTEL_HDA_EHL_3	0x4b58
>  #define PCI_DEVICE_ID_INTEL_HDA_WCL	0x4d28
> -- 
> 2.51.0
>

-- 
Vinicius
