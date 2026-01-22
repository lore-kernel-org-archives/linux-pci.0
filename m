Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73336F43C;
	Thu, 22 Jan 2026 18:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106267; cv=none; b=LE624H/SiEMg2NUCVtJ/CCGmOanCiFzVUgUHh9Bcev4qr2RXpbsptZ75XH4OtnZMuH/wvGyK27XxGuWaICS0gJJNXwfn3ONiUjmnLdzlLhVOR7bmK9wvgQkVKhWvtsnvVZmpVP7TTiOWSoAlmJJgubH3zO8bx+JtEd4EnD9RIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106267; c=relaxed/simple;
	bh=kpCnCHCuyAfMjLG8e0EIwdg3VXYaqjiaCAacU2gtR5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qfWsdhCkpqAH/rqHpvTrM7Xq5SrLL9OHgTKAwTKiIsMZcN3AGZN14ZxwYL2GgOe8hFXrMdcMZXcI0CDBYQY0d4QDzed+2sWLW32qbuoGycX5byjK45sOynNCTiWnZ2vGtzxMCLo38A528cvHrFBNCRc14BPJsady0PtUTr+WVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S852EfgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S852EfgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B087C116C6;
	Thu, 22 Jan 2026 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769106266;
	bh=kpCnCHCuyAfMjLG8e0EIwdg3VXYaqjiaCAacU2gtR5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S852EfgReyO6MKWBaveKm8x4XpPMt7v25klGCA4wHWb16Rp36eSDDfEb4MDK91D6z
	 OmAaTlIHuEWPIxqTiXP2wGbHmxImqkEgHQlRghZi2q2T++VtHLU/u+kQNnQx3yAliJ
	 TlbKqyE0rC0cACbX2gAtB0VtMl1p3CebF9cK1+kEfpFCYhjv1cIVGCILmCpv56FRxc
	 lv2jQA5DHkmqtGs0ZLMm2akHA+56MKTE3WbAMkFAOO+ZpkbnCybQWJBP+9cFhsP2I/
	 hAnEXOaGSEl4dxpOqDS53ZuoeamlegAU8YFtVRBLoL1NLat3rDIpA2oCb2W32hLnkT
	 KCfLW0tPpMaCg==
Date: Thu, 22 Jan 2026 12:24:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 13/34] PCI/AER: Replace PCIEAER_CXL symbol with
 CXL_RAS
Message-ID: <20260122182425.GA16814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-14-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:34PM -0600, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> One of the primary reasons for the CXL driver to exist is to perform error
> handling. If both PCIEAER and CXL are enabled then light up CXL error
> handling as well. The work to remove CONFIG_PCIEAER_CXL started in:
> 
> commit 4ae6ae66649c ("cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c")
> 
> Finish that off with conditionally compiling all CXL RAS related helpers
> with CONFIG_CXL_RAS.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> 
> ----
> 
> Changes in v13->v14:
> - New commit
> ---
>  drivers/cxl/Kconfig      | 2 +-
>  drivers/pci/pcie/Kconfig | 9 ---------
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 217888992c88..70acddc08c39 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -235,6 +235,6 @@ config CXL_MCE
>  
>  config CXL_RAS
>  	def_bool y
> -	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
> +	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
>  
>  endif
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 17919b99fa66..207c2deae35f 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -49,15 +49,6 @@ config PCIEAER_INJECT
>  	  gotten from:
>  	     https://github.com/intel/aer-inject.git
>  
> -config PCIEAER_CXL
> -	bool "PCI Express CXL RAS support"
> -	default y
> -	depends on PCIEAER && CXL_PCI
> -	help
> -	  Enables CXL error handling.
> -
> -	  If unsure, say Y.
> -
>  #
>  # PCI Express ECRC
>  #
> -- 
> 2.34.1
> 
