Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1532BEFEE;
	Thu,  5 Mar 2026 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691135; cv=none; b=fUAP+cG/kSbcLailwav6qW1zrJDDPkAaf4nN+eDkmz2GlfW+QDByAqgmheKiQKx+Ddmh8tw+K4BKlJ2oZ8au14gJapuFLor02Ozd/NDLkx2k4UG+LxqmX1mSLs55Kq4+b/6xCuIt5S8iL0Lvv8KsT/Jh+DImSRcfL+FhLMFlq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691135; c=relaxed/simple;
	bh=Ucql6G8fikWgKmYhVeI8oG8c/q5qH54SMiTmcR+3pc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl7gIaZ5z+hpk4m4k4Jtj/FKbCEicqeoloFB6rYFCHRoYlGmLKaZs7tpJ48y/nziPgj6zgOC50ViWSeQZl32wHlNMgdIZF/d5UjbtaihdspUMWZesL6dOAb0VVRRNV/Se1JjM5kJqR4+2yY1ub7Gsd2Hu6ZyXQsv5c5a3doVf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW/TlmMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW/TlmMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CBEC19423;
	Thu,  5 Mar 2026 06:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772691134;
	bh=Ucql6G8fikWgKmYhVeI8oG8c/q5qH54SMiTmcR+3pc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OW/TlmMSjxRIv76YYa4Rs3TTKdVmDKfZyk6dpYyjGwu8hZPI8q9/tALDdhrTgPXCk
	 TvFQZwOO0XLXTBqmRMD94KV5dkiUuCwaAgE0SABadsIP7FTT41JeBCuqrTTZnar76v
	 7xzV53tMPTsQL4dmjL9ZpYS7AzR0EzNM8lw8JRTKPzMDg37PUglTVhta3eVtpIswSv
	 m3ie/kefrQes5hscO8INQBz+PN0FFVav36SQ8BtiJCGJZY9xx3ilKMigN78geJZcCC
	 holj2XmP7TDRs/AplJARasMXjbqG7mnA4gbnX854Wi2RKDhAihv28nVSf6cUCF6Quk
	 sxZXCo5e8ZLVg==
Date: Thu, 5 Mar 2026 11:42:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] PCI: tegra: A couple of cleanups
Message-ID: <ogfkqs6s6zsrnmamqwnk3rugwsjmknu74piwko3zzgfumsb2us@cib4xktivpip>
References: <20260224121948.25218-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224121948.25218-1-linux.amoon@gmail.com>

On Tue, Feb 24, 2026 at 05:48:56PM +0530, Anand Moon wrote:
> Hi All,
> 
> This small series provides two cleanup patches for the Tegra PCIe driver.
> The overall goal is to replace custom, open-coded logic with standard
> kernel helper functions.
> 
> These changes improve the driver's readability and maintainability by
> everaging modern, well-tested APIs for clock management and register
> polling.
> 
> v3: Fix the DT binding for nvidia,tegra-pcie.yaml
>     tried to address issue for Krzysztof and Jon.
>     Added missing regulator and new patch to fix the device tree check.
>     Added missing entry in MAINTAINERS.
> 
> v2: Fix the DT binding for nvidia,tegra-pcie.yaml
>     switch back to devm_clk_bulk_get_all to get all the clocks
>     improve the commit message.
> 
> v1 Added new devicetree binding nvidia,tegra-pcie.yaml file.
>    Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() api.
>    Fixed checkpatch warnings.
> 
> Tested on Jetson Nano 4 GB ram.
> 
> jetson-nano:~$ lspci -tvv
> -[0000:00]-+-01.0-[01]----00.0  Intel Corporation Wireless 8265 / 8275
>            \-02.0-[02]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller
> 

Given the history of this series, I want an Ack from Jon/Thierry or other Nvidia
folks for the driver patches.

- Mani

> v2:   https://lore.kernel.org/linux-tegra/20251215141603.6749-1-linux.amoon@gmail.com/
> v1:   https://lore.kernel.org/linux-tegra/20250926072905.126737-1-linux.amoon@gmail.com/
> RFC : https://lore.kernel.org/linux-tegra/20250831190055.7952-2-linux.amoon@gmail.com/
> 
> Thanks
> -Anand
> 
> Anand Moon (5):
>   dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
>   arm64: dts: tegra: tegra186-p2771: Fix invalid PCIe nvidia,num-lanes
>   PCI: tegra: Simplify clock handling by using clk_bulk*() functions
>   PCI: tegra: Use readl_poll_timeout() for link status polling
>   PCI: tegra: Use BIT() and GENMASK() macros for register definitions
> 
>  .../bindings/pci/nvidia,tegra-pcie.yaml       | 528 ++++++++++++++
>  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
>  MAINTAINERS                                   |   2 +-
>  .../boot/dts/nvidia/tegra186-p2771-0000.dts   |   2 +-
>  drivers/pci/controller/pci-tegra.c            | 237 +++----
>  5 files changed, 621 insertions(+), 818 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> -- 
> 2.50.1
> 

-- 
மணிவண்ணன் சதாசிவம்
