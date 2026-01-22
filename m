Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658E358D13;
	Thu, 22 Jan 2026 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071583; cv=none; b=fQOWv5gyH4bUj4BFWye5m1XuGsFTVLAodNHq8F1vfquybfVliWiz4YIFBdyMUBEFjyFMHeangNT8L8E+wz5Ta1S/5khcrrbo6eX/nOpgmzZUm0A7kn5bCbAFCpx+8M1hdPyzyWCchPxJ7kUEtzMHvVDWbmSWUaZrwYI6527Qmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071583; c=relaxed/simple;
	bh=tmUuuQrJVS4rVT48VkPF/d6qwQEZeTs62TSctawDc6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb8GhE9/co9HGeSk5zwAGH2c2Sc5ic6WQXKRdq/vRnB3znf2B1d8y4fq0mujvVpC5q9sct+vuOX9D7y58dEKed5TOhdJ58lDLn/bOzRCJMhaFoq9Xmw6C54/ZIwgVgeGLolsbXa7DmVW2D7ygJNInOfU02u8KaNSNIVjvD7QYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhWgUAGw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhWgUAGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9198C116C6;
	Thu, 22 Jan 2026 08:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769071582;
	bh=tmUuuQrJVS4rVT48VkPF/d6qwQEZeTs62TSctawDc6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhWgUAGw9xSwfwQ/BkN2rpfSh3ilFye4EdYYG7AX6o93CLZD0QXX5FO9jr/WMY+pW
	 37vPZXSO+Gsfci1pLCZgQXm708lFV1C4E8eaLPxkzBivurQmjxyGA3zgEsRcoee2t8
	 vbKcIS92SrxcxsMM1Jhz8APLYwtgej73j0U07Uq9gZjZ6qCTjO75jgszoTkHtOMzTM
	 N2X+7K8Is1ZS+l893mtnEbPIWz9EMjbVx8Thlf8AQ1cG6Q8Eu2iz+k+VUtmYActDLv
	 VfE6YrcRsLb0A7KCxkvoJsTvJrwwamDIt/JTlNFMoMu2LxRwWFL/02MKxpymskA6OW
	 LrAot0YZMPCNA==
Date: Thu, 22 Jan 2026 09:46:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH v2 1/3] PCI: dwc: ep: Fix resizable BAR support for
 multi-PF configurations
Message-ID: <aXHjRBEE7H3WwGXH@ryzen>
References: <20260122082538.309122-1-a-garg7@ti.com>
 <20260122082538.309122-2-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082538.309122-2-a-garg7@ti.com>

On Thu, Jan 22, 2026 at 01:55:36PM +0530, Aksh Garg wrote:
> The resizable BAR support added by the commit 3a3d4cabe681
> ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable
> BARs") incorrectly configures the resizable BARs only for the first
> Physical Function (PF0) in EP mode.
> 
> The resizable BAR configuration functions use generic dw_pcie_*_dbi
> operations instead of physical function specific dw_pcie_ep_*_dbi
> operations. This causes resizable BAR configuration to always target
> PF0 regardless of the requested function number.
> 
> Additionally, dw_pcie_ep_init_non_sticky_registers() only initializes
> resizable BAR registers for PF0, leaving other PFs unconfigured during
> the execution of this function.
> 
> Fix this by using physical function specific configuration space access
> operations throughout the resizable BAR code path and initializing
> registers for all the physical functions that support resizable BARs.
> 
> Fixes: 3a3d4cabe681 ("PCI: dwc: ep: Allow EPF drivers to configure the size of Resizable BARs")
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> 
> Link to v1:
> https://lore.kernel.org/all/20260121054214.274429-2-a-garg7@ti.com/
> 
> Changes from v1 to v2:
> - Fixed the suggested nit
> 
>  .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++-------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 19571ac2b961..1458477a6ba9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -75,6 +75,13 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  				 cap, ep, func_no);
>  }
>  
> +static u16 dw_pcie_ep_find_ext_capability(struct dw_pcie_ep *ep,
> +					  u8 func_no, u8 cap)
> +{
> +	return PCI_FIND_NEXT_EXT_CAP(dw_pcie_ep_read_cfg, 0,
> +				     cap, ep, func_no);
> +}
> +
>  /**
>   * dw_pcie_ep_hide_ext_capability - Hide a capability from the linked list
>   * @pci: DWC PCI device

I'm not sure to which branch Mani wants to apply this series.

But if the answer is pci/controller/dwc then this patch will not apply,
because the context lines "dw_pcie_ep_hide_ext_capability()" specifically
has been removed there.

If he intends to put this patch on the endpoint branch, then this comment
can be disregarded.


Kind regards,
Niklas
