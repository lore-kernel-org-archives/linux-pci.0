Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC849227EB9;
	Wed, 10 Jun 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112096; cv=none; b=hUlCtLEvzUJ2n+XzWV1IxsT7694nyKN0WKovCgBrm2FVmPIng2FHp2c6FMfUpDpu7HWuloYQbA8iqmO1HiY+w5L3pD1iuCFLU+cSqukcH3Amog5hx50vuQUmXfq+Mi8Q1Aury50wyNdh9281WJJlTRfYQfm+mGeWLMowgQWRuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112096; c=relaxed/simple;
	bh=p7/yjDGnNGGaeD9XDdVqkaLGsm0yeDEEVsRNJsLKJBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gua2JMiYYKrEJflp3n/VfK+IpI/tlxdil09XFN8Z5UxkKi6720LfrJ9H/T3idfzZZmeXtbRZfGuziIn3huHUoczU4Xg4tUNYSMw/QjT66/FUnyRL1qGJ1/8Hn8zaCcB5giqbEI94Ob+prJVUTzksiI0AIk921yuqGqMe2a/hbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK5y7GjK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK5y7GjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69291F00898;
	Wed, 10 Jun 2026 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781112095;
	bh=iYpMpZcFJx4XV2SVcjE2n2VQBLmYwju4cPVuo0RdT/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LK5y7GjKsQfZFyVb1haUXwH8ig0lKBJ1Dz2R4q8xxh/1K6P/qSFql4ukmZHA192Bk
	 J9kcHpIhxM+CfZaDJmK3P8rd8ShdKFR0wYv0HfJWKJJORg6COz97Ht3AKdX1O/hUrT
	 V6jeGXI1NOikJ+RP/C4hQZ6DmSlHxTNztqUH42VF6SBjZJAEVYcDO+c1aiUmRytoQ5
	 ZrL5SVjwuIGG2GKzPqPk1zPKXhbrx+m1I/+bFNePc3krheRa4zJL16JL3l4IdMT9rj
	 nCkjgHDowr5O9Sw8WrH2YL6bMWFbpAIUhJYYTi4omqTrHkGHs3hRhxLmNR+46z5a2Y
	 rbQUG7z1g5IfQ==
Date: Wed, 10 Jun 2026 22:51:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Yu Ning <ningyu@eswincomputing.com>, 
	Yanghui Ou <ouyanghui@eswincomputing.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
Message-ID: <tpmaqs6ndkjzqktp6wyvlfbjl2clh3crim4unjvyemggmeilyx@rw7bcroyp32w>
References: <20260520-eswin-v2-1-a221438a6317@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-eswin-v2-1-a221438a6317@gmail.com>

On Wed, May 20, 2026 at 10:45:04PM +0800, Felix Gu wrote:
> When dw_pcie_host_init() fails, the code jumps to err_init which
> only calls pm_runtime_put() but skips the cleanup of port resources
> allocated by eswin_pcie_parse_ports().
> 
> Additionally, the incorrect port cleanup code in
> eswin_pcie_host_init() error path is removed since port resources
> should be released in probe's error handler, not in host_init.
> 
> Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>    Changes in v2:
>    - Fix Mani's comment.
>    - Remove incorrect port cleanup code in eswin_pcie_host_init() error path.
>    - Link to v1: https://lore.kernel.org/lkml/20260416-eswin-v1-1-a4991725b5ca@gmail.com/
> ---
>  drivers/pci/controller/dwc/pcie-eswin.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
> index ce8d64f8a395..7a02ab91a190 100644
> --- a/drivers/pci/controller/dwc/pcie-eswin.c
> +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> @@ -182,7 +182,7 @@ static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct eswin_pcie *pcie = to_eswin_pcie(pci);
> -	struct eswin_pcie_port *port, *tmp;
> +	struct eswin_pcie_port *port;
>  	u32 val;
>  	int ret;
>  
> @@ -252,10 +252,6 @@ static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
>  	reset_control_bulk_assert(ESWIN_NUM_RSTS, pcie->resets);
>  err_deassert:
>  	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> -	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> -		reset_control_put(port->perst);
> -		list_del(&port->list);
> -	}

Unrelated change.

>  
>  	return ret;
>  }
> @@ -347,18 +343,17 @@ static int eswin_pcie_probe(struct platform_device *pdev)
>  	ret = dw_pcie_host_init(&pci->pp);
>  	if (ret) {
>  		dev_err(dev, "Failed to init host\n");
> -		goto err_init;
> +		goto err_pm_runtime_put;
>  	}
>  
>  	return 0;
>  
>  err_pm_runtime_put:
> +	pm_runtime_put(dev);

When pm_runtime_get_sync() fails, pm_runtime_put_noidle() should be called in
the error path. But now pm_runtime_put() will be called, which may attempt
suspend.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
