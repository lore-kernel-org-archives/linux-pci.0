Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30826561E;
	Sat, 24 Jan 2026 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769286248; cv=none; b=qenT331IaBKADLlQnQHvIpxBLSQpCXDS4UQPtQyDEaKV7HmHYvFibPRvxThAw+bhWtR6y9aLSrTQlMXhncZUeZMJoRO96lfMIju/vkb1tr4JGmyxvHRHAuTkCCysy3Dn3Z8jKzSxu5hdOnLf3PQuEC3Jv1ywNoRdBM3qwmVLLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769286248; c=relaxed/simple;
	bh=LZT2FX9gel15TTuzcvgNnRsgxoL3KHhIFCm4WDGiUgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d2YYNkG8UfvtyB+S00vLLs9Ztznv8LVhcUORgEie9PL3no/Kh7lPzovVMQZdCUoghkyVtF5Elxatl5c0dXVRjPaJG524GVKJcsJlLkmcUItY4pkUZqOZgsnkSdBBXx/l3lqTQu7bwhKIrOycj0dQRKUxmJSQOrDe4seTFJYHzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPrFXTkU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPrFXTkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCFFC116D0;
	Sat, 24 Jan 2026 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769286248;
	bh=LZT2FX9gel15TTuzcvgNnRsgxoL3KHhIFCm4WDGiUgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NPrFXTkUxmm6z2SJt7Zk0xpvA4Isr1XZNZDuEnXOZ4AM62/fxCWGIGqtcfW4n5SSU
	 popSQ1aV52CVGz8I/KTa+rbaaExX50emjo3sEmDqnhnu8pHRuIZZA+/OcmV9OCkXGS
	 3tkjiBe+O/vwOuywv367gvk4wqfcWArTKO47Nbv1Mj/bNewITWpI0a+HnokwY5U7DO
	 o6CAO6qtPE3X34EMxvGez32L+asROsPOvICwz2yBzDYXitQvgFnMIpwUsGpiAZ8SzY
	 fSW2nimQXr+Pf4YGb1Z9twJNoJI4ncqPEv8YIqNHJ0bOgolTFtpVsFDa1CknQajsUb
	 m5BECGosE3DfQ==
Date: Sat, 24 Jan 2026 14:24:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Trent Piepho <tpiepho@impinj.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Fix device node reference leak in
 imx_pcie_probe()
Message-ID: <20260124202406.GA175382@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124-pci_imx6-v2-1-acb8d5187683@gmail.com>

On Sat, Jan 24, 2026 at 11:42:45PM +0800, Felix Gu wrote:
> In imx_pcie_probe, np is obtained by of_parse_phandle() and must be
> released when it's no longer needed. However, it doesn't release the
> reference, which cuases a reference leak.
> Fix this by using the __free(device_node) cleanup handler to release the
> reference when it goes out of scope.

Mani, if you apply this, can you add a blank line between paragraphs
and:

  s/imx_pcie_probe,/imx_pcie_probe(),/
  s/cuases/causes/

Felix, if you repost this for other reasons, please incorporate those.

> Fixes: 1df82ec46600 ("PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Changes in v2:
> - Use __free(device_node) clean handler to fix the leak.
> - Link to v1: https://lore.kernel.org/r/20260124-pci_imx6-v1-1-6f4379fc5160@gmail.com
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 1d8677d7de04..f459d05ecd7d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1643,7 +1643,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct imx_pcie *imx_pcie;
> -	struct device_node *np;
>  	struct device_node *node = dev->of_node;
>  	int i, ret, domain;
>  	u16 val;
> @@ -1670,7 +1669,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		pci->pp.ops = &imx_pcie_host_dw_pme_ops;
>  
>  	/* Find the PHY if one is defined, only imx7d uses it */
> -	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> +	struct device_node *np __free(device_node) =
> +		of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>  	if (np) {
>  		struct resource res;
>  
> 
> ---
> base-commit: a0c666c25aeefd16f4b088c6549a6fb6b65a8a1d
> change-id: 20260124-pci_imx6-f97d70887dfc
> 
> Best regards,
> -- 
> Felix Gu <ustc.gu@gmail.com>
> 
> 
