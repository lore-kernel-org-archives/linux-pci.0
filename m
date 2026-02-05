Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E01D198A17;
	Thu,  5 Feb 2026 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278173; cv=none; b=GpQPgWAifzhLvU7hALgY5n1d4q0vlPAKkPgJsvzwEhviMik3T9kFSYcwwgTpjAwtNr/D4L5OG5FbfiBdpTNzHAaNvRd6Ba93ebz8QsK9uBQckXPV/ThDF7XLPVbXBPiRVCqEeYvpcDuax68s3TuyluX9J4hiobkLq/e0rC6c6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278173; c=relaxed/simple;
	bh=iAqePYBH9r6Pea3NTQMyXP1EmjnGKfuKyDxDpuh5aQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7fTmMQW3bdD/OVeRBH6jc37ciKZRiOJBJsRq4MNPZExDXGp/ejg1Hru3Z+3qA63rcJV3IXXlYXAxU/ufNSwZTLjuHwRd2NW/I5kp0kLlnwy9/ouX0tz88dIqtSok6r0iK97DpNxadt+1Rz171eJI/zVaJluuwSo5IJuA4q7P7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPxGULA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPxGULA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E77FC4CEF7;
	Thu,  5 Feb 2026 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770278173;
	bh=iAqePYBH9r6Pea3NTQMyXP1EmjnGKfuKyDxDpuh5aQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPxGULA9ZAWSdGAmKU2s2UsFoSkCvALA5LQsFG57Lj98a3op/YO8P51TNlwdIHK0e
	 Js0Wx3NZJM7tMpv9QudyyoFnNBFQWl3BiqjNJdrI27qhk541mIe72moVgcwNEDauld
	 sRxKJ18xtEvWe8C1fsj0IC9lQX9Y2skZsz20L/Hu2OZ0TWnbCjPYWzZNN7OSFeo7HY
	 XNchMt4KO4Xhjed5jT/Tk4Ad5v4k9nYkOe7onX/RlZAiFGITtVlRSBk6JAH5Kp2eXd
	 N9+3h0l3WzkX/6YC7Rq5C2sZGpBS49LuRIizL9EoPHNi5l3YnLWYTukvyo+sNIkpbN
	 AaPrkurhj7ZSQ==
Date: Thu, 5 Feb 2026 13:25:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, jingoohan1@gmail.com, vidyas@nvidia.com, 
	cassel@kernel.org, 18255117159@163.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/22] Enhancements to pcie-tegra194 driver
Message-ID: <u7doih67vqljroq674ymf7vlm2weysk5xbnhtuyxp3johd3yty@s2clguxon5hp>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>

On Mon, Jan 26, 2026 at 01:14:57PM +0530, Manikanta Maddireddy wrote:
> This series[1] was originally posted by Vidya Sagar, and I have rebased
> it onto 6.19.0-rc6-next. I addressed review comments, reworked a patch
> and included four new patches. I verified these patches on Jetson AGX
> Orin(Tegra234 SoC).
> 
> Disabling L1SS capability based on support-clkreq device tree property
> is moved to common DWC driver, so I reworked below patch to disable
> just L1.2 capability on Tegra234 SoC.
>  - PCI: tegra194: Disable L1.2 capability of Tegra234 EP
> 
> I added below four new patches to fix bugs, commit message of each
> patch has the details on the bug and fix.
>  - PCI: tegra194: Add ASPM L1 entrance latency config
>  - PCI: tegra194: Use HW version number
>  - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
>  - PCI: tegra194: Disable PERST IRQ only in Endpoint mode 
> 

Please send the fixes separately. It is hard to review a big series like this. I
don't recommend sending more than 10 patches per series.

- Mani

> I added more context in the commit message for below patch based on review
> comment in V3.
>  - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration
> 
> Rest of the patches are same as the original V3 series, just rebased them on
> 6.19.0-rc6-next.
> 
> Verification details.
>  - I verified both Root port and Endpoint mode controllers on Tegra234 SoC.
>  - Basic sanity Link up, configuration space access and BAR access are verified.
>  - I verified that ASPM L1.2 capability is disabled for Endpoint mode.
>  - I verified suspend to RAM tests with Endpoint mode.
> 
> [1] https://patchwork.kernel.org/project/linux-pci/patch/20221013183854.21087-1-vidyas@nvidia.com/
> 
> Manikanta Maddireddy (4):
>   PCI: tegra194: Add ASPM L1 entrance latency config
>   PCI: tegra194: Use HW version number
>   PCI: tegra194: Fix CBB timeout caused by DBI access before core
>     power-on
>   PCI: tegra194: Disable PERST IRQ only in Endpoint mode
> 
> Vidya Sagar (18):
>   PCI: tegra194: Use devm_gpiod_get_optional() to parse
>     "nvidia,refclk-select"
>   PCI: tegra194: Drive CLKREQ signal low explicitly
>   PCI: tegra194: Fix polling delay for L2 state
>   PCI: tegra194: Apply pinctrl settings for both PCIe RP and EP
>   PCI: tegra194: Refactor LTSSM state polling on surprise down
>   PCI: tegra194: Disable direct speed change for EP
>   PCI: tegra194: Calibrate P2U for endpoint mode
>   PCI: tegra194: Free resources during controller deinitialization
>   PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
>     registration
>   PCI: tegra194: Enable DMA interrupt
>   PCI: tegra194: Enable hardware hot reset mode in Endpoint
>   PCI: tegra194: Allow system suspend when the Endpoint link is not up
>   PCI: tegra194: Disable L1.2 capability of Tegra234 EP
>   PCI: tegra194: Set LTR message request before PCIe link up
>   PCI: tegra194: Don't force the device into the D0 state before L2
>   PCI: tegra194: Free up EP resources during remove()
>   dt-bindings: PCI: tegra194: Add monitor clock support
>   PCI: tegra194: Add core monitor clock support
> 
>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |   6 +-
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    |   6 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 268 +++++++++++-------
>  5 files changed, 181 insertions(+), 103 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
