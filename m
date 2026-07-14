Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541F3321B1;
	Tue, 14 Jul 2026 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051936; cv=none; b=D26pyNUfciBBlWPnx/5pR7r77PV8dfjBOoyER2CSWHTmm4vTToZdyUNVvcxqZ1tjGSX6dVcXDNssHpCF33E9znXzyP0mCM9MPmIB/rgciOFTDT2pHNWzmikOYoh9TtrQ8JenJb35TLYswKAqO5FhkYlDpTHHXhq0u/QZbP5TY4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051936; c=relaxed/simple;
	bh=njl+Dkzfzihsz99gMGSXT3qBnA/HCpQF+YLJSeVCmQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MwK3oBrSZc18/k24kg1qjI3TV4+vqjbBvorbuHbhncMh5tRemrsmMB9NZXjuoW3VGrhiKv+UwbBxCaudO8gGKsPwiQM7fAEskyU4ltcXB1eVSWdLhTOXYiVbRuIW2rNAfCyM8fdWXKm1jJ9ihoDNPmx7A3LNLmog4YYWrB5yXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z02Q9v5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z02Q9v5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9AE1F000E9;
	Tue, 14 Jul 2026 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051933;
	bh=HdDhxUYvigRmEq1ez/8kLOLgELmp0yi9ngv+r+kwxA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Z02Q9v5sRzqEFL2TT9SOB/I9cCVO72xEWbjkbcc9WdYrDLNOKDr+NxDvHe3vPkUGq
	 6V5PD0v6SsN589V9vEA26H1sWzpJP1mOkrVz8vqo7PcMT5c+UVkQV6oOC3hc8y63du
	 wNh8KdF2d9isFih0IKOBXs9YzyiR0kXrYX7zcxB170gWGpT0bKWoJ92lbu4MsfGZ6g
	 2ASACc+6B5dzG9wbJYpomTlYdqMeylm9V/O06gD/w00ZF8wqYHz4bhP8E4CKSdpwjz
	 njn9RNwn6XCc7eyg6++rMDdJGYC0qXgTtGVu7+yALAJx8EstvOvQwiAarxjuYiUDbO
	 EowqVSBdOjsbw==
Date: Tue, 14 Jul 2026 12:58:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ali Tariq <alitariq45892@gmail.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Mason Huo <mason.huo@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	"open list:PCI DRIVER FOR PLDA PCIE IP" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: plda: Synchronize chained IRQs during
 deinitialization
Message-ID: <20260714175852.GA1387886@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714174345.1073909-1-alitariq45892@gmail.com>

On Tue, Jul 14, 2026 at 10:43:45PM +0500, Ali Tariq wrote:
> During driver unbind or probe failure teardown,
> plda_pcie_irq_domain_deinit() unlinks the chained interrupt
> handlers for the main, MSI, and INTx interrupts using
> irq_set_chained_handler_and_data(). However, this function
> only updates the handler pointers and does not wait for any
> in-flight interrupt handlers running on other CPUs to finish.
> 
> If a PCIe interrupt fires concurrently with the teardown
> process, the handler could continue running on another CPU.
> If the hardware clocks are disabled shortly after in
> host_deinit(), the executing handler will attempt to read
> un-clocked PCIe registers, triggering a fatal system bus
> fault (external abort) or kernel panic.
> 
> Add synchronize_irq() after clearing each chained handler to
> guarantee that any executing handlers have fully completed
> before proceeding with interrupt domain removal and hardware
> deinitialization.
> 
> Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> ---
>  drivers/pci/controller/plda/pcie-plda-host.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index f9a34f323ad8..f6759e255c75 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -560,8 +560,13 @@ EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
>  static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
>  {
>  	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> +	synchronize_irq(pcie->irq);
> +
>  	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
> +	synchronize_irq(pcie->msi_irq);
> +
>  	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
> +	synchronize_irq(pcie->intx_irq);

Several other drivers call irq_set_chained_handler_and_data(..., NULL)
without synchronize_irq().  Do they need similar fixes?

>  	irq_domain_remove(pcie->msi.dev_domain);
>  
> -- 
> 2.34.1
> 
