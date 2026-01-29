Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315D28934F;
	Thu, 29 Jan 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704802; cv=none; b=HJ2cGDhb3fxFXwGNH0Yk48+nK0mCg9WHruqipq722o8OgKJOsb/zwNLgW82v90qN5r7FrYE0Bb2eGiSRNLeb77J0wh+hdrWMexmaFtS3LvZlmexm257bcxrTtq88DZfqbuYRTJTN6C3IpWNUY7PO8w7JGGcIdCMIUrEEJ6pxF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704802; c=relaxed/simple;
	bh=meb9eeFpiUhd/nG1EPVBIBFbEuDz6POWH5Dfs4OmnmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmU3yN1+CssWfSVpNPlVKI9COBRmQEYh5VkTZ5u2N3goAbnh0B68FLteJcMkusfb7suaYOcmfvrp6fpRRux6qNA4/ObS43GTAeUYFxfeqeJLWiBLabZeyz+bpsIabRuNy9zoex6q1zpifgXI4bcBOJ1r3ijcs9BkGHYz1HJtjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnA0+JTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnA0+JTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3B8C116D0;
	Thu, 29 Jan 2026 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769704801;
	bh=meb9eeFpiUhd/nG1EPVBIBFbEuDz6POWH5Dfs4OmnmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnA0+JTvcB0GCd7G15Qgbrb98ZuqiIsn5CEjWvunBNrO6J9kmchUqlgJKa4Z0EpmX
	 KuuiUK1y3zy6GkPXy8OxRnL0hxWBMMfOTxtmH5P37LCV/Ahsc5JwczJXzvXv5pFiQF
	 +mrNP85i3VDTHsl+GudcSPjeZnOcYpAUpxXPbWe7eeTFkCl+ygtbsWSJ4BSl5l5YLy
	 klkkywvu/1dBByDIuE5A5WsopczFgXk8d0ogGOKeJM/rOvlwhBy6lb3agEVuaobkSo
	 iPKzkUyoi/2pmJlLOmePPp5sLQAjLgNS5OibZdeKGRqfV2Ri93a6Z7MPv9hRoohxQi
	 sGhna8+ztp9aw==
Date: Thu, 29 Jan 2026 10:40:00 -0600
From: Rob Herring <robh@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org,
	18255117159@163.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 17/22] dt-bindings: PCI: tegra194: Add monitor clock
 support
Message-ID: <20260129164000.GA1237815-robh@kernel.org>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
 <20260126074519.3426742-18-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126074519.3426742-18-mmaddireddy@nvidia.com>

On Mon, Jan 26, 2026 at 01:15:14PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Tegra supports PCIe core clock monitoring for any rate changes that may be
> happening because of the link speed changes. This is useful in tracking
> any changes in the core clock that are not initiated by the software.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V4:
> * None
> 
> V3:
> * This is a new patch in this series
> 
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml    | 6 +++++-
>  .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml       | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> index 6d6052a2748f..ca5da919c347 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
> @@ -55,12 +55,16 @@ properties:
>        - const: intr
>  
>    clocks:
> +    minItems: 1
>      items:
> -      - description: module clock
> +      - description: module's core clock
> +      - description: module's monitor clock

Drop "module's"

>  
>    clock-names:
> +    minItems: 1
>      items:
>        - const: core
> +      - const: core_m

I would use "module" unless this corresponds to h/w documentation.

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
