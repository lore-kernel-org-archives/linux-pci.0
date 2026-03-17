Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C12BDC05;
	Tue, 17 Mar 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773725610; cv=pass; b=oXN8IhVqR1HmDTNDnQylOmrlH7NiRMayUQRmHHKVekGRFju4//TZJevjfW/WnfTUgjNXdiyXQf323IKRs1J8AYeh6eJyd9lZUB3IA5aUpvQ2I0ev7UrOqMEKZcO0WIbeu66UABi/XeWp62ilyoH1dtB9IYGEuNekoB8DUzup2Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773725610; c=relaxed/simple;
	bh=oEMHgdcLN4ZjmCvZ6oFicibDv5Sww1FGtEFGTLH3xLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2iLFmdjiO50LyYCduAxXmSNJ3GwjWcV/SvuOgGUuxNJQT8EhD6MaHOwGeZOChmztbigizK8njpBLAu6KyPC6V/43c1t05T+NK57ZC/pQgt0SpQwMWUnoGpR1TFILITavDpklNdeZGAkUmSBzMb1d2P0ND9Ni0IhrsVV3eEZ4IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=ImJqzBha; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="ImJqzBha"
ARC-Seal: i=1; a=rsa-sha256; t=1773725589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qsmefrqsk7KvHZu9LJfj3ZnxXaXC8oWr1zwkioGNa6MfAlX4sPJtm2L/TmBOkUqd5/dbeG6jSseZtptEB7U7hLPIs5P3xjqn7PUEZAO2RKFXCL8adfrXpVbeaugUzyTMrmIsJ0KEE4/yJ03QUJ22fgqWTUOeswEt7Uaj2doCb0U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773725589; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eyhiSFd7TnnR0Y4KPBjzhgYS3ePqfaic4BGkMyXWNsw=; 
	b=mZP9Fh7ks1MBeclBECCuJouLSVmAo1S3kP+g3XJyaJo4EK9nSYO3mHOHz0ekBs8A0/dHe5Apu8wb1N227eM6sES3ZKWHV3Um+PPTp/Ovpy9qc5Gyj9mrDt3O3gOvj0izJOldmf0ZdA/xQs0knMttMDN2FjDp0WS+9dTUaIwb1oc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773725589;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=eyhiSFd7TnnR0Y4KPBjzhgYS3ePqfaic4BGkMyXWNsw=;
	b=ImJqzBhaykJ7b6/ZZttuDa2mVkhAhgDaSE6bshmKI944v399pbVfoE7pBrw+w0s7
	3jyglFuOx3pr6RFQB9UJV8Nx9sIzKyQ0123yzbCRoTT6QXZhGKYysfsaK2IWwFHCq79
	tuhORvK26dfLgOeQgY0foUHdkkgE5XaiFrZJ3J44=
Received: by mx.zohomail.com with SMTPS id 1773725587000567.8249611127286;
	Mon, 16 Mar 2026 22:33:07 -0700 (PDT)
Date: Tue, 17 Mar 2026 05:32:54 +0000
From: Yao Zi <me@ziyao.cc>
To: wangjia@ultrarisc.com, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: dwc: Add UltraRISC DP1000 PCIe rc driver
Message-ID: <abjnhn5sqnJv1fYY@pie>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-4-ef2946ede698@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-pcie-v1-4-ef2946ede698@ultrarisc.com>
X-ZohoMailClient: External

On Mon, Mar 16, 2026 at 03:07:00PM +0800, Jia Wang via B4 Relay wrote:
> From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> 
> Add DP1000 soc PCIe rc driver.
> 
> Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig           |  15 ++
>  drivers/pci/controller/dwc/Makefile          |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h |  22 +++
>  drivers/pci/controller/dwc/pcie-ultrarisc.c  | 202 +++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d0aa031397fa..0a33891bf7ef 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -548,4 +548,19 @@ config PCIE_VISCONTI_HOST
>  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
>  	  This driver supports TMPV7708 SoC.
>  
> +config PCIE_ULTRARISC
> +	bool "UltraRISC PCIe host controller"

Is there any reason preventing the driver being built as a module? If
no, it would be better to change it to "tristate", to allow distribution
to customize the configuration for image sizes, etc.

> +	depends on ARCH_ULTRARISC || COMPILE_TEST
> +	select PCIE_DW_HOST
> +	select PCI_MSI
> +	default y if ARCH_ULTRARISC
> +	help
> +	  Enables support for the PCIe controller in the UltraRISC SoC.
> +	  This driver supports UR-DP1000 SoC. When selected, it automatically
> +	  enables both `PCIE_DW_HOST` and `PCI_MSI`, ensuring proper support
> +	  for MSI-based interrupt handling in the PCIe controller.
> +	  By default, this symbol is enabled when `ARCH_ULTRARISC` is active,
> +	  requiring no further configuration on that platform.
> +
> +
>  endmenu
>  #define PORT_LOGIC_LTSSM_STATE_L0	0x11

Best regards,
Yao Zi
