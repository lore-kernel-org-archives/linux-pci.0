Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FA4052D4;
	Wed, 14 Oct 2026 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005653; cv=none; b=WFbAImIASFJRHPJH9yvN95EIZOalhN04aL+u/7lkat2EGlwhubYvSXL9PQlWp+FiyqDcueVIUou2v1qkufW2gjT3OIpLFRZNTeFOgWDGley8r/TFe/zS2mXeq3tbmT6qPhlASwgkaBxmq4IduEQG6XrKV/QjEOmkXbmZqN4v0SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005653; c=relaxed/simple;
	bh=pDmTop8BydgD2ybL2HcX1RP/U45dYAP4r5m5IqunrBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AHfsZEN6efs7aoG6EuMcTo/QFzDykK2yZVyo6njTS5/YR+xB50zTgwIj0v8VZ4WjHgIIz5MQMj1ma8ZSK6XbOyUErZI+9gRpt+tqN66tXsPE1tVyyQc8KI7nrkU09/Y0JlwJezHrHcDYnVl6KSi8ewd9kMFpv1c2+9Ngv3TFe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtHnBXN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtHnBXN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77881F000C4;
	Wed, 14 Oct 2026 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792005651;
	bh=gYj6Ssb4Y0qTANOC8LZlRZc7A0UjRimm4BD4FoPdOjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mtHnBXN/S6ULFpffBTaEE21x6yZLfQpy/DKuHtLKw1att0fMfnH5aHqsgpD1mfJe3
	 3ngJGExwgKUbHT3ZyVwwSlSr1seacsFU603+QZPkU46yAd5En5VVK9HN71f39yk9zh
	 yk2ghumqG6bzx5n+Sk3a9g4XiEdzRAspB+7sXqoLl47snPJc4lYWFlrEtBG6sbEcI9
	 RWc2hMyMGo96KDvSVpNydYBK/4qJZVoA0JQvoMkq0/1HMeOP6RhOeXNy4SJG39SKn4
	 uDGu4k6qpSGBMOFl6L04xjjQ9Uwbb4h2G0yCiy2dRa4GEBhM2iAC1oXGPernTqVyEB
	 PuQoB/RsIt6Gg==
Date: Wed, 14 Oct 2026 14:20:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <20261014192049.GA1654252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>

On Tue, Sep 08, 2026 at 11:48:22AM +0530, Sumit Kumar wrote:
> An outbound iATU region matches any local (AXI/application-side)
> address that falls within its Base/Limit window and rewrites it to
> the PCIe-side address programmed in that region's Target Address
> Registers before the transaction goes out on the link. This matching
> does not distinguish CPU-initiated transactions from ones issued by
> the internal DMA engine (eDMA/HDMA).
> 
> Example: outbound region 0 is programmed with Base/Limit covering
> local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
> CPU-initiated accesses. The DMA engine is later given a descriptor
> whose destination is the host address 0x8000_0080, which happens to
> fall inside region 0's Base/Limit range. The iATU matches the DMA
> transaction against region 0 too and rewrites it to 0x1_0000_0080
> instead of passing 0x8000_0080 through unchanged. The transaction
> then lands on the wrong host address, causing data corruption or an
> IOMMU fault when the rewritten address has no valid mapping.
> 
> Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
> programming outbound iATU regions so only CPU/AXI-initiated
> transactions are matched against the region; DMA engine transactions
> bypass the translation and go out on the PCIe link with their
> original address.
> 
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>

Thanks for the fix.  A data corruption is pretty disastrous.

Is there a Fixes: tag we can add here?

Probably also a stable tag?

What is the connection with ver 460A?  It would be nice to have
something meaningful here, e.g., "has_eDMA" or something that connects
the test with a controller property.

> ---
> pci: designware: Set DMA_BYPASS in outbound IATU to prevent HDMA
> interception
> ---
> Changes in v2:
> - Rewrote the commit message according to suggestion(Mani).
> - Link to v1: https://lore.kernel.org/r/20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 593388f29bdd48381cb04710f445042aaf2be29f..9297d0e607e3a1caaeb585b23742f9a29607b7f2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -577,6 +577,8 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  		/* The data-less messages only for now */
>  		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
>  	}
> +	if (dw_pcie_ver_is_ge(pci, 460A))
> +		val |= PCIE_ATU_DMA_BYPASS;
>  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
>  
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0735ae94092404bc2976af67a58f6842cc5e5c50..668a5ba1c6f59aef1aaf15566b77a649bd282ce0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -201,6 +201,7 @@
>  #define PCIE_ATU_ENABLE			BIT(31)
>  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
>  #define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
> +#define PCIE_ATU_DMA_BYPASS		BIT(27)
>  #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
>  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
>  #define PCIE_ATU_LOWER_BASE		0x008
> 
> ---
> base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
> change-id: 20260826-dma_bypass-bbbf8a0c9af7
> 
> Best regards,
> -- 
> Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> 
