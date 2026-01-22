Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B9354AF6;
	Thu, 22 Jan 2026 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071543; cv=none; b=fVPibutomt9RltxSRp+CWj274ZRVxVELJ/TWcdsWCHJCZtsPD4w8jMCywR8C/4Ktxu2cliSGR1nrTZW98gFQNyXKPtMO6vec3wLTymrD0XIviXhjdSNV5rxhYHSEQa7ZfFybWpHjm90Z9e8cW8/4rwQ6NDH/bX6AP6IZ/e7pcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071543; c=relaxed/simple;
	bh=RtFDAIqUVJ8hnNlcAlGwf4FDnXtou9jJhN3icapM/J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poVYDua631Ki1lAbs+8OR+iSmn2t4wuuXe/mZgB6cwT6Zb/kQjCxB+BIVdR9tHNL7YGel+IqYU4xkpRvkEW5oStyFoq6+7yZM1lrg5mpsn2HOkGnjnF1ZLmAwoBWMP69Opu9MnsDtljHzQHqIxK2vEE3w0tlX+HkuOAVyBfYd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/crP5EM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/crP5EM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31861C116C6;
	Thu, 22 Jan 2026 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769071542;
	bh=RtFDAIqUVJ8hnNlcAlGwf4FDnXtou9jJhN3icapM/J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/crP5EMnBQwDPdjXsPE/w2ybnTmHKk8RJqfbgMxIWSZrXFSmqJSEjGSXt3GFWbZl
	 V87Uen2b5YcpwnKEYIpF+mHoF+8E5RUIFEDs+x4qT5tNQhrOQ7XdqbVyUdwOq3B95N
	 +SwqFJncmduZ/zv5xrd5r3nzs2vKhJykMIjRRt0DuOObbkm8HgPVBdu7n0Tvx6w0Y/
	 9dVYpwlVKE7UA9UJ5EGzwFNEPbENETqyEKvCzaQiT9VuR9dAMuaxFvIMoJeha+u+Ho
	 GuLvI/Blw0VMCx11QFZqULQZV4EX12722mW4yDmw/prFyRTwGvRgNQ7soYEl9L2EHi
	 kDJYL4dfOTFQw==
Date: Thu, 22 Jan 2026 09:45:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH v2 3/3] PCI: dwc: ep: Add comment explaining
 controller-level PTM access
Message-ID: <aXHjiSiP3If37Hln@ryzen>
References: <20260122082538.309122-1-a-garg7@ti.com>
 <20260122082538.309122-4-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082538.309122-4-a-garg7@ti.com>

On Thu, Jan 22, 2026 at 01:55:38PM +0530, Aksh Garg wrote:
> PCIe r6.0, section 7.9.15 requires PTM capability in exactly one
> function to control all PTM-capable functions. This makes PTM registers
> controller-level rather than per-function.
> 
> As suggested by Niklas Cassel, add a comment explaining why PTM
> capability registers are accessed using the standard DBI accessors
> instead of func_no indexed per-function accessors.

Nit: I think you can remove: "As suggested by Niklas Cassel, "
and just start the sentence with:
"Add a comment explaining .."
since you already give me credit using the Suggested-by tag.


> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 12625a1059a4..0a9d5402f23a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -995,6 +995,17 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ep->ops->init)
>  		ep->ops->init(ep);
>  
> +	/*
> +	 * PCIe r6.0, section 7.9.15 states that for endpoints that support PTM,
> +	 * this capability structure is required in exactly one function, which
> +	 * controls the PTM behavior of all PTM capable functions. This indicates
> +	 * the PTM capability structure represents controller-level registers
> +	 * rather than per-function registers.
> +	 *
> +	 * Therefore, PTM capability registers are configured using the standard DBI
> +	 * accessors, instead of func_no indexed per-function accessors.
> +	 */
> +

Nit: don't think this empty newline is needed.

>  	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>  
>  	/*
> -- 
> 2.34.1
> 

With nits fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>
