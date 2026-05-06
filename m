Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAAD3ED133;
	Wed,  6 May 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076038; cv=none; b=jym7ddpB7A7au1eEB0eEq+InsORAfBX+CRdu5OKa08IDohmW2NXFEmR6vWQ25zgHKPTE3bR56Hu2ANem+XtSVkS4TzbIsnIZmjvtprsXRNeo/iU92ulOqTF5y6B5kXRxCX11zOE78BFNKk8qDT7XllRjX/I4uYmvrJq+qV1nOTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076038; c=relaxed/simple;
	bh=3ABq0vmLnrToEl3embQcbEbCFFAlngxTw8HcWTYfpyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujnvUheQ8DD9qGoE+E1tfmtHAO4etVWDaZqxHV0UFvsX8j6Q6SiqdKL8v6sCjVxt9A12CJyNDECsWKWOxlUUGeU9DdHVAtQzoS8d6hh2OPriNWF19nb6SVMkRtQjeol8eolP5DoddnEDeMgozlqTTyKX39YGgEyXBhz5O+yAB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbbRqzsH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbbRqzsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B25C2BCB0;
	Wed,  6 May 2026 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778076038;
	bh=3ABq0vmLnrToEl3embQcbEbCFFAlngxTw8HcWTYfpyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lbbRqzsHEvuSkXGa4Rq5zx+PXjsv9/714dfoVAo7p5j+HQdbVor0KXnElBQ4b/Xal
	 PiXiGmTODUQOu3x3zRDyPM3eHLpMmqcJBmgyz1WIio5CPxG35X1OlkckWcoE/no36v
	 Ut3/ZcCjRTyc+Jj5F2Efp3PIaLh4oiaIrshTXG8ZS8syUYP6SUkVyzXeupWAml3r2N
	 +YOf6WdB1pFgwaZrybzDsYRUyIVerbufJTdirhipRIXKfIj/YQvE6FwbwHZ0/K2FLQ
	 +E6XjYuV3ytgHjZ8zOAcEEEVHeE0RYiQ71TdguOZSPBSH2/A/plVO6PZsyZptYT2yo
	 hFH7PAMulrExQ==
Date: Wed, 6 May 2026 19:30:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: helgaas@kernel.org, bhelgaas@google.com, 
	Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, heiko@sntech.de, 
	yue.wang@amlogic.com, pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, 
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, cassel@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
Message-ID: <vpuzlzry7uulctur7kwtlogniuhogd5ybmrwjtos2v7yryf47v@yj2ocobbog6s>
References: <20251127170908.14850-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127170908.14850-1-18255117159@163.com>

On Fri, Nov 28, 2025 at 01:09:06AM +0800, Hans Zhang wrote:
> Current PCIe initialization exhibits a key optimization gap: Root Ports
> may operate with non-optimal Maximum Payload Size (MPS) settings. While
> downstream device configuration is handled during bus enumeration, Root
> Port MPS values inherited from firmware or hardware defaults often fail
> to utilize the full capabilities supported by controller hardware. This
> results in suboptimal data transfer efficiency throughout the PCIe
> hierarchy.
> 
> This patch series addresses this by:
> 
> 1. Core PCI enhancement (Patch 1):
> - Proactively configures Root Port MPS during host controller probing
> - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
> - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
>   and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
> - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
> - Preserves standard MPS negotiation during downstream enumeration
> 
> 2. Driver cleanup (Patch 2):
> - Removes redundant MPS configuration from Meson PCIe controller driver
> - Functionality is now centralized in PCI core
> - Simplifies driver maintenance long-term
> 

For the series,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Bjorn: Could you please take a look? This series has been floating for a
while...

- Mani

> ---
> Changes in v7:
> - Exclude PCIE_BUS_PEER2PEER mode from Root Port MPS configuration
> - Remove redundant check for upstream bridge (Root Ports don't have one)
> - Improve commit message and code comments as per Bjorn.
> 
> Changes for v6:
> https://patchwork.kernel.org/project/linux-pci/patch/20251104165125.174168-1-18255117159@163.com/
> 
> - Modify the commit message and comments. (Bjorn)
> - Patch 1/2 code logic: Add !bridge check to configure MPS only for Root Ports
>   without an upstream bridge (root bridges), avoiding incorrect handling of
>   non-root-bridge Root Ports (Niklas).
> 
> Changes for v5:
> https://patchwork.kernel.org/project/linux-pci/patch/20250620155507.1022099-1-18255117159@163.com/
> 
> - Use pcie_set_mps directly instead of pcie_write_mps.
> - The patch 1 commit message were modified.
> 
> Changes for v4:
> https://patchwork.kernel.org/project/linux-pci/patch/20250510155607.390687-1-18255117159@163.com/
> 
> - The patch [v4 1/2] add a comment to explain why it was done this way.
> - The patch [v4 2/2] have not been modified.
> - Drop patch [v3 3/3]. The Maintainer of the pci-aardvark.c file suggests
>   that this patch cannot be submitted. In addition, Mani also suggests
>   dropping this patch until this series of issues is resolved.
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250506173439.292460-1-18255117159@163.com/
> 
> - The new split is patch 2/3 and 3/3.
> - Modify the patch 1/3 according to Niklas' suggestion.
> 
> Changes for v2:
> https://patchwork.kernel.org/project/linux-pci/patch/20250425095708.32662-1-18255117159@163.com/
> 
> - According to the Maintainer's suggestion, limit the setting of MPS
>   changes to platforms with controller drivers.
> - Delete the MPS code set by the SOC manufacturer.
> ---
> 
> Hans Zhang (2):
>   PCI: Configure Root Port MPS during host probing
>   PCI: dwc: Remove redundant MPS configuration
> 
>  drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>  drivers/pci/probe.c                    | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 765e56e41a5af2d456ddda6cbd617b9d3295ab4e
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
