Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720E4CA27E
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071014; cv=none; b=GNlhCHgLTJNghYuhh4uO4evLmfBTzjfxVcwaQkNkL8F3zF8ZV7jzOgn0qSwj0MkNsKt30eoC87M1KMhc8hQVfPf9Iowz2WE9pj+WTsQibIbO5WxGMEdxIIqtVfgT5/WoNG5TmnglH8jooa13O8quMJ/LQwKKZkdnnIYO9fIwf58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071014; c=relaxed/simple;
	bh=D3hnI5c6MFcLKTmMiIFG8WvUvSHtJ2yByrCMHzAazOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4L5q7XeIyjJtqzLtdSUP7VJ45yvX+afa+dbJCrdFFsxbdBG1tficEnfZQw9zQ5LhC5IbzBYjOJlGpvamIeYK6NsK243pTGX4Aeavc24DGQN4O2HnFqQKTDX3lHZIj6yW43tR/No+Ra5O6k5tpJYxCpA8UOtw2WwwoyF6mcauPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrCidzDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrCidzDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5321F000FF;
	Tue, 22 Sep 2026 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071011;
	bh=AnvrllaJNenlmFTgkElMCALNKYJ6cjipSA7VxVT2mhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VrCidzDw2npJykvwE8JRRRjBaI2fcYgUjBYaeq58Km8H+kvvnpjjw/rn24GUXy411
	 6aZTbjhqgFl/HJhi2KEyLezwF81+6gbdYUYDn7JtCtzbmPjRx5qsGAK1eMugiDcZ0B
	 8A+yQN4vIu5Q9jv4ZyUolSn6xe8vj+iH3dBaiZIH2n/o5gr0MEygdysir1jAeRGx3F
	 n1muAAH//eAbc4ov+z1FIYXnL99S+exNXBUk0iT0RSnHEnb1aoncaZU1egSzmEl7nj
	 YAJV3jbySBM8eW55j4G6tvT5qg9oGMYMkriaLF78Mw3QOafqrz5XidvUssVNO/kavQ
	 LsFIijb2snX8Q==
Date: Tue, 22 Sep 2026 11:56:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: dw-rockchip: Move the INTx irq setup to probe
Message-ID: <arJQ3_hkbKE9Yn0a@ryzen>
References: <1790044622-164744-1-git-send-email-shawn.lin@rock-chips.com>
 <1790044622-164744-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1790044622-164744-2-git-send-email-shawn.lin@rock-chips.com>

Hello Shawn,

On Tue, Sep 22, 2026 at 10:37:00AM +0800, Shawn Lin wrote:
> Since commit b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port()
> and use for link down"), .reset_root_port() re-runs the host ops .init()
> callback to reprogram the Root Complex after a controller reset. That
> works for the register programming, but .init() is not re-entrant: it
> also creates the INTx irq domain and installs the chained INTx handler.
> Every root port reset therefore ends up with a second irq domain
> registered for the same fwnode: the previous one is leaked, as it is
> never removed, and worse, the INTx virqs of the downstream PCI devices
> were allocated in the previous irq domain and are never re-mapped, while
> the chained handler now looks up virqs in the new, empty domain. After a
> link down recovery, INTx interrupts are silently lost.
> 
> Fix it by moving the of_irq_get_byname() lookup, the INTx irq domain
> creation and the chained handler installation out of .init() and into
> rockchip_pcie_configure_rc(), right after dw_pcie_host_init(). This
> mirrors how the qcom driver requests its global IRQ, and leaves .init()
> with nothing but idempotent register programming, so both
> .reset_root_port() and dw_pcie_resume_noirq() can safely re-run it.
> Re-running of_irq_get_byname() on every resume is also gone.
> 
> rockchip_pcie_configure_rc() can abort probe, so propagate the irq
> domain creation error instead of only logging it as .init() used to do.
> 
> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v3:
> - split devm-managed part into a seperate patch
> 
> Changes in v2:
> - Moved the of_irq_get_byname() lookup, the INTx irq domain creation
>   and the chained handler installation out of the host ops .init()
>   callback into rockchip_pcie_configure_rc(), right after
>   dw_pcie_host_init(), as suggested by Niklas Cassel. This supersedes
>   v1 patch 1/2, as .init() no longer creates the irq domain, and
>   removes the rockchip_pcie_host_hw_init() helper from v1.
> - Made the INTx irq domain devm-managed with
>   devm_irq_domain_instantiate() and uninstall the chained handler
>   through a devres action, addressing the probe failure leak and
>   use-after-free flagged by the Sashiko review.
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 32 +++++++++++++++------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1497686..8788a10 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -422,23 +422,9 @@ static void rockchip_pcie_stop_link(struct dw_pcie *pci)
>  static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> -	struct device *dev = rockchip->pci.dev;
> -	int irq, ret;
> -
> -	irq = of_irq_get_byname(dev->of_node, "legacy");
> -	if (irq < 0)
> -		return irq;
>  
>  	pci->dbi_base2 = pci->dbi_base + PCIE_TYPE0_HDR_DBI2_OFFSET;
>  
> -	ret = rockchip_pcie_init_irq_domain(rockchip);
> -	if (ret < 0)
> -		dev_err(dev, "failed to init irq domain\n");
> -
> -	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> -					 rockchip);
> -
>  	rockchip_pcie_configure_l1ss(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  	pp->bridge->reset_root_port = rockchip_pcie_rc_reset_root_port;
> @@ -740,6 +726,24 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> +	/*
> +	 * This is done here instead of in the host ops .init() callback,
> +	 * which is also re-run by .reset_root_port(), so that the INTx irq
> +	 * domain is only created once, at probe time.
> +	 */

I don't think a code comment is needed here.

But with or without the code comment:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


> +	irq = of_irq_get_byname(dev->of_node, "legacy");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = rockchip_pcie_init_irq_domain(rockchip);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init irq domain\n");
> +		return ret;
> +	}
> +
> +	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> +					 rockchip);
> +
>  	/* unmask hot reset/link-down reset */
>  	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
>  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> -- 
> 2.7.4
> 
