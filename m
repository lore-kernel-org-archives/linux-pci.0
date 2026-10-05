Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B8421259;
	Mon,  5 Oct 2026 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791243481; cv=none; b=dk2xq6pjw2/tEwj86itR0hVaz2zW9TS66O7Dx0TtuxItJcnD+GaAQk1LVIyXP3KCkc1pw9HCenGNbS/TQ9rGvw268k2xfjxI+hrmdpyAKiFTx5fHqy72jaBlfuFdCdYjmGYuKzrZMSQ7lgmyTSiscWtKw3uJ0LGwld8AtuWJw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791243481; c=relaxed/simple;
	bh=wHhFpuZX54/313lqoel9OUyPQIGXxcFUhf5FAjdR2Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D9Xwui4rQHqPLu12IpigbNCVN6N/N4fq++CFnX6xZiL30J8NvyKMXU4fKfWKQTVdP4MC40HmR/42yAtccJ6NnI1EtLhebQTAdkhSTY5ApzAyoE0V0mKqvhhrbU9nr/3dW10fH8ZLbsnqolZgA397utASdbqnBY9mVnm7rgy1qOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVafL/jF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVafL/jF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF151F000FF;
	Mon,  5 Oct 2026 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243479;
	bh=F9mj9hBOR4INL/J0dw4RHuFc+zlALPDdCwtt8rXEwx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oVafL/jF7wbNV8UIs9FpvDi7Q24YuKgnGDwngw1i7TpMYQq6KjEomG+s21lza/nYs
	 KfHiTikEFtwfozV0j3MOGC6NBGuz2dHMHXaw21Ae5dxHtmRxZtmJ2PHDFQpcRNT6nh
	 Kja2MveAf51QPd7G+apbw2fajqK6FojV4WEUPzcM/pjeHRaCRASko1ELi2zMDvKSMQ
	 I9r4oICbQVlzMQyRxvDHCO2Zns7d87s4zYo3HSyzPEbyoNtAF4MLRT2yZkab8QYm3L
	 R+eXCOs71vZAgLtorZlk2w4zB22xuBfrWKkpZ9AGkPlF2zENaunLXZ8TsKLqXr3z20
	 NlDDc1TapaLjA==
Date: Mon, 5 Oct 2026 18:37:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-host: Validate IO/MEM resource count in DT
 ranges property
Message-ID: <20261005233758.GA646371@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003073701.354551-1-marek.vasut+renesas@mailbox.org>

On Sat, Oct 03, 2026 at 09:35:59AM +0200, Marek Vasut wrote:
> The R-Car Gen3 PCIEC controller supports up to 4 memory area mappings.
> Count the IO and MEM ranges described in DT 'ranges' property of the
> controller DT node, and in case there are more than 4, refuse to probe
> the controller driver, because such DT does not describe valid hardware
> configuration. Do the IO and MEM counting early to avoid controller
> configuration rollback in case of failure.
> 
> Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 31 +++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index cd9171eebc289..4bcc8c3051ac4 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -341,6 +341,32 @@ static void rcar_pcie_force_speedup(struct rcar_pcie *pcie)
>  		 (macsr & LINK_SPEED) == LINK_SPEED_5_0GTS ? "5" : "2.5");
>  }
>  
> +static int rcar_pcie_validate_resource_count(struct rcar_pcie_host *host)
> +{
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
> +	struct rcar_pcie *pcie = &host->pcie;
> +	struct resource_entry *win;
> +	int i = 0;
> +
> +	resource_list_for_each_entry(win, &bridge->windows) {
> +		struct resource *res = win->res;
> +		unsigned long type = resource_type(res);
> +
> +		if (!res->flags)
> +			continue;
> +
> +		if (type == IORESOURCE_IO || type == IORESOURCE_MEM)
> +			i++;
> +
> +		if (i > RCAR_PCI_MAX_RESOURCES)
> +			return dev_err_probe(pcie->dev, -ENOSPC,
> +					     "Too many IO/MEM entries in DT 'ranges' property, limit is %d\n",
> +					     RCAR_PCI_MAX_RESOURCES);
> +	}
> +
> +	return 0;
> +}
> +
>  static void rcar_pcie_hw_enable(struct rcar_pcie_host *host)
>  {
>  	struct rcar_pcie *pcie = &host->pcie;
> @@ -947,6 +973,11 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	host = pci_host_bridge_priv(bridge);
>  	pcie = &host->pcie;
>  	pcie->dev = dev;
> +
> +	err = rcar_pcie_validate_resource_count(host);
> +	if (err)
> +		return err;

I guess you did this here to avoid rolling back controller config, but
the code would be a lot more readable if it checked the index at the
point where it might exceed the array bound, e.g., (I think) in
rcar_pcie_set_outbound().

This is for an invalid DT, which is unlikely.  What if
rcar_pcie_set_outbound() just printed a warning and ignored any excess
windows?

>  	platform_set_drvdata(pdev, host);
>  
>  	for (i = 0; i < ARRAY_SIZE(rcar_pcie_supplies); i++) {
> -- 
> 2.53.0
> 
