Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DD3C0602
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842844; cv=none; b=AXzgvjgs77qWBhG5pIysSbHvAXn1cr7u/6HuLWVBFrClCRlPj1WXAfVLNJgTD5kzDv3J4mZ0dSauGRCXG8KTFurx+rfFd4gESjlZ2jWwuW6kqWSFJZDbtA7Ebbh9IlpkrnR+lRrdHMaj0gRkMunDktSEd/u8aY4lGTPWcG4V1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842844; c=relaxed/simple;
	bh=xEttuf2Eyhw+BoO33ZGNw9U0KT03DEXPSVNgZPiVhJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pL7rh1+Vx0nAjwelhsX8iozoDOY1ZNExlslHbJzz8psHEJIsQGG2JDzSQTtD+vX4wai1nQpAUzmlDWhfePBxjHj2sbcFCYBmurIx9pn2+1NOhI+1iZchlq6ksESGx42HVGhLwAP/MBRs+wK57thwBZriJjCiQ0ZnghpmKqBmBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtFnrjfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtFnrjfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB531F0089B;
	Mon, 12 Oct 2026 22:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791842843;
	bh=6PVJFzjPMA7qNHqs2dFBMgouUeHMvFrAyguDRkUZ3f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gtFnrjfYjnYvomiUA7c6+FN6nlqzX3eH2pI45V1iODFTdX2oD7uIb93/FJhyJG69l
	 9lgOa1kzfEmF71pemhSYL47BN3oJ8lDj+tSK9cpqmg8oQjIM+y0baEMM2khNqEE0Od
	 zZxgXoklPgdIOkU1fIIpQ0fEmYzebBG81zEVTWKFpTxuWeDh8xMSmS5/Py+j6CXa42
	 Th2bwm2LGFsiNeRztZ0Uhvl9EUXYUmb2lLR4RUPy2D+fibiUvpxPUO6GDJig18xj/I
	 HUzdr22DTTkZ1hlSTv33jkLTRHqN5N6AeO5zdFaesEEkjxFeiVRDuZp6hEHAkre/Ta
	 anFPT3fR1yTaQ==
Date: Mon, 12 Oct 2026 17:07:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Diederik de Haas <diederik@cknow-tech.com>
Subject: Re: [PATCH v4] PCI: dw-rockchip: Move the INTx irq setup to probe
Message-ID: <20261012220721.GA1407960@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1790222793-77182-1-git-send-email-shawn.lin@rock-chips.com>

On Thu, Sep 24, 2026 at 12:06:33PM +0800, Shawn Lin wrote:
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
> rockchip_pcie_configure_rc(), just before dw_pcie_host_init(). The
> lookup has to happen before the host is initialized, because
> dw_pcie_host_init() enumerates the bus and probes the downstream
> devices, and pci_assign_irq() maps their INTx interrupts at that point:
> if the domain does not exist yet, the mapping fails and the devices end
> up without a usable INTx. This also mirrors how the qcom driver requests
> its global IRQ, and leaves .init() with nothing but idempotent register
> programming, so both .reset_root_port() and dw_pcie_resume_noirq() can
> safely re-run it. Re-running of_irq_get_byname() on every resume is also
> gone.
> 
> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/for-linus for v7.3, thanks for the reminder.

> ---
> 
> Changes in v4:
> - drop the code comment (Niklas)
> - create the INTx irq domain before dw_pcie_host_init() instead of
>   after it. dw_pcie_host_init() enumerates the bus and probes the
>   downstream devices, and their INTx interrupts get mapped at that
>   point, so registering the domain afterwards left every downstream
>   device without a usable INTx (flagged by the Sashiko review).
> - this also removes the failing steps behind dw_pcie_host_init(), so
>   there is no error path left that would return with the root bus
>   registered and the rockchip structure about to be freed (flagged by
>   the Sashiko review).
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
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1497686..bd86e32c 100644
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
> @@ -731,6 +717,19 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
>  				 PCIE_CLIENT_GENERAL_CON);
>  
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
>  	pp = &rockchip->pci.pp;
>  	pp->ops = &rockchip_pcie_host_ops;
>  
> -- 
> 2.7.4
> 
