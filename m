Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7F374A0F
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042855; cv=none; b=fR4cmXmZClhi+DHAYeZLff5HvzpnMioLi/pjyQKidm8UILvuffHZNIPrq/FXLBDWAh7TfneySuAQYAyTTe6Z0PsdKNWby83xLfFStAUKvPdtI1klg7hXDzZJna2N1W5FNAQ6/ZHTHke/RRDcpf1njtLhh3W0Y7HwNvIUEFSOQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042855; c=relaxed/simple;
	bh=eiV6sQiVxbvcvUaNRZjKe5UdB4zuOSF6a78WgZZTalU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ng/WB5nWmNWi9Z8LsH4a/asBbSYr5/iOOPMwTeb3ltJYlyiVPvD4ZhlYQGnvznzANCe6GgstMa28OsMZzBu11VMdeyDu9beV7xreKNCR2mIHZxy8yRsjyHqxXTgWpPSjrDh0SNiuqvFRJP/goc+hMx0aaf+fLXE/ClUeJ7Bg77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfLh3IdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfLh3IdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DCF1F00893;
	Tue,  9 Jun 2026 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042853;
	bh=8g4pul8M1WeB0Gfbq/12qO8SXWORuMnqYfHM6OxuyWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HfLh3IdFdKELLZ5ijylt+nLa8WgqH9H7wEECMkYrzNm2wflKWdTAEGz+a1FDE9j91
	 HjEnjCjEIjMHojkLRxiP8zHG2CbBWXicXFUJjtjl5QvEwjCdWLGX5SdGs01G3+Zx1y
	 s7Yxk4Ht6CNWnL46Wn31/VgTp08KzE+TIn0OtZf9sjGyGN6QsJTdlyTjgpF0az21eK
	 WUgwg6BZ3dkT3UnOxQ+9InHqrGcdttCeGi3/Sk1F5xrU/1P3lva+2/DBwhVlxYxBqs
	 9Wf7Zfka+WnZvOXu2b49iofCFdAtZDTSFgoo/Hteqxp9EQ94v0zaUQP6jCEr5w8Lvx
	 BbYU1djC+Wn4g==
Date: Tue, 9 Jun 2026 17:07:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	linux-pci@vger.kernel.org, qat-linux@intel.com,
	Damir Chanyshev <conflict342@gmail.com>,
	Simon Richter <sjr@debian.org>,
	Tomasz Ossowski <tomasz.ossowski@intel.com>
Subject: Re: [PATCH v2] PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to
 whitelist
Message-ID: <20260609220732.GA131461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aac4922b5fe7070b11874427a9285e42ddd05a4.1780585518.git.lukas@wunner.de>

On Thu, Jun 04, 2026 at 05:12:08PM +0200, Lukas Wunner wrote:
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

Applied to pci/p2pdma for v7.2, thanks!

I changed the IAA description to be "compression accelerator" as
Vinicius suggested.

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
