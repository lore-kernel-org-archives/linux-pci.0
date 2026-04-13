Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2D2E888C;
	Mon, 13 Apr 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096329; cv=none; b=N9ZUxzdfxv2ajMcyBNl64xfkghgA60b2JS9u2so0Lp35q+5XtxVAUxcpKC+BpUjU1STtYCAO+EfJrjNIB1Yx6Gwo7EGK6mBNzmNM2rbeluYg+s1TVBtAj94XgCuAhs/H1PwJ30eriasNAZlgEGIkOMxJ80OlhPybrJ624t2USIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096329; c=relaxed/simple;
	bh=VC6YVG4xvB3uWGofxiLkJwCx9Wf3xHXSXBXwyzXleEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtg2xrBM+k0Y4xvFXkr3v1ebAVQg+7GeD1A9evlRMdufYElMLdi7J1ZsDYspt/MrgOhMlHmmY8VLZNUXH1CP58ishs1sH8YjX3gSm/K+stv/TANfIUZmHVGPEZnJyZr5sdgH+X8wsI5R30VF0USsUKdiPPmT9MLuzRHnMdXmI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8B1y4yZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8B1y4yZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BB9C2BCB0;
	Mon, 13 Apr 2026 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776096329;
	bh=VC6YVG4xvB3uWGofxiLkJwCx9Wf3xHXSXBXwyzXleEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8B1y4yZHPpZVer24NmGLVfYVkQwgxrxXm0Nk6xI1CS6eBAXdh6hJ/7IwwQ12orTC
	 wnzBYGDs6koLzdqCLnYIb5j5M0ubQqu6hMhO/524XuH57XXdqQ3j+kSm3e1ZsqoKTQ
	 F0ThPnDC7ew8M34bBmx2zRe16FGg8d8MuG+9T+hvK3cTHWULdAAPxiRmH6GszB766N
	 IDn7YZ6MPRKWLvAh/4/JVsYALVdyTgLN7NkWHNdpQARJgMbjJJpJ0QxkNyoOpm1Cud
	 SUUlewb+v/DooQ8yb9+AZqgnwFifLJ+/jFf7KKQtn3wTGKwACjUL6fL52OA6NhCaQq
	 J42R3DzzwavtA==
Date: Mon, 13 Apr 2026 21:35:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bhelgaas@google.com, will@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, vidyas@nvidia.com, 
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: host-common: Request bus reassignment when not
 probe-only
Message-ID: <d3xtqtnhki7qxebbnqkwezdu3g4ln4q3l5t56ecy6k6sq2v5oe@3uwp5rsrv7ci>
References: <20260410142124.2673056-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410142124.2673056-1-rkannoth@marvell.com>

On Fri, Apr 10, 2026 at 07:51:24PM +0530, Ratheesh Kannoth wrote:
> pci_host_common_init() is used by several generic ECAM host drivers.
> After PCI core changes around pci_flags and preserve_config, these hosts
> no longer opted into full bus number reassignment the way they did
> before.
> 

So pci_assign_unassigned_root_bus_resources() only assigns the unclaimed
resources, and do not reassign the bus numbers. Probably the offending commit
confused PCI_REASSIGN_ALL_BUS with PCI_REASSIGN_ALL_RSRC.

> When PCI_PROBE_ONLY is not set, add PCI_REASSIGN_ALL_BUS so
> pci_scan_bridge_extend() takes the reassignment path: bus numbers can be
> assigned from firmware EA data (e.g. pci_ea_fixed_busnrs()). Skip the
> flag in probe-only mode so existing assignments are not overridden.
> 
> CC: Bjorn Helgaas <helgaas@kernel.org>
> CC: Vidya Sagar <vidyas@nvidia.com>
> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
> Link: https://lore.kernel.org/netdev/adcXzcz2wWJFw4d7@rkannoth-OptiPlex-7090/
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d6258c1cffe5..860783553cca 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -68,6 +68,10 @@ int pci_host_common_init(struct platform_device *pdev,
>  	if (IS_ERR(cfg))
>  		return PTR_ERR(cfg);
>  
> +	/* Do not reassign resources if probe only */

This comment is still wrong and could be the source of confusion that lead to
the bug. PCI_REASSIGN_ALL_BUS only reassigns the bus number, not resources. So
please reword it.

> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_add_flags(PCI_REASSIGN_ALL_BUS);

This forces bus number reassignment for all platforms whose DT doesn't provide
'linux,probe-only' property. Maybe that's OK given that this was the behavior
before 7246a4520b4b. 

- Mani

-- 
மணிவண்ணன் சதாசிவம்
