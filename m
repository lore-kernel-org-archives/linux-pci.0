Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86C324716;
	Wed, 13 May 2026 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714159; cv=none; b=cn9RTdk+Yrp4TxIkOYQMvw5l+hRNAXOR3hVCf73wDApr+vvk0awlkDO5bxQLb9Ppyna8GE4q/noWN6AGjh7CdT07wg383G8q/nPHPrcJWy2QpSJcZ/GNYihl+oEHVMk9tkFfogjnJCltbDwGX9/HpwaRxseHEbV/3ZC83y8/j2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714159; c=relaxed/simple;
	bh=MVk6jb5+GkT5DVuM/HR3gjPwoz3JXsYZFjvxYAUvIYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eauTKEU5766Nt9+PFK9GV8mb2vpiBGhvxAu76bkj2DkJH6m7I+hckLlUaDU7pG7sGOgtVu0eQsIsep0LQfJ76V599iNIek8k1qoibgsQy9FluXYxSNIXWiMCWUHbN18v1d6VWGAJqoddmugW3GxHp13IEo7GDii6/fX7QtIfhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOC64afI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOC64afI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B443C19425;
	Wed, 13 May 2026 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778714158;
	bh=MVk6jb5+GkT5DVuM/HR3gjPwoz3JXsYZFjvxYAUvIYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOC64afIrDERd2fOrXgXfbN4m/Xur81K87ISHnIHzR0TlMceY1eoGi2GrQRGiLZdg
	 pleJb6E3c9C8oX69vcVnoPK+kpjn9q8hJzWrf6hjQqYE+eL0hKcZspbUcAPNEUDsJU
	 6qJ110qgu6axlR3qRYuODw7eCVWxTYUhV3cVLCQG1jemBxC+pwxEr3jBP15aTATfUR
	 dnO4UjPqLFjJrVNhheiAqBX1X2qWZ4eQ+S7keDWowaCH8Xx27QstBlBIqeK7juguAV
	 dBPK9V9uwnUqtmu00mo0gyjPRj74woaTLrAhW4WmIdzTvXolxbIpc4/G+4lnZuX7Kf
	 squxFvozDUqAg==
Date: Wed, 13 May 2026 18:15:50 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
Message-ID: <20260513231550.GA2280946-robh@kernel.org>
References: <20260508063633.3894348-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508063633.3894348-1-wenst@chromium.org>

On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> controller memory access could be limited to a small region by the
> firmware configuring a memory protection unit. This memory region
> must be assigned to the PCIe controller so that the OS knows to
> use that region. Otherwise PCIe devices would not work properly.
> 

What you are describing is dma-ranges. Why not use that?


> Allow the memory-region property with one item pointing to a
> restricted DMA buffer.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This patch compliments another patch that moved the memory-region from
> the PCIe device to the PCIe controller [1].
> 
> [1] https://lore.kernel.org/all/20260430120725.241779-1-wenst@chromium.org/
> 
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 4db700fc36ba..4a9e41d01628 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -115,6 +115,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  memory-region:
> +    maxItems: 1
> +    description: phandle to restricted DMA buffer
> +
>    mediatek,pbus-csr:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
