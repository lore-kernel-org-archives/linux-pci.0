Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF048D89C;
	Wed, 29 Jul 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333016; cv=none; b=EZYSWo5ZL5zPbZQBIzywE8ComVjsZfQ4tRvKAQ0vYT2dauljeGiAmafdpbjVcyxHYq63vbcql0NDvhXIFuybHXbeRPWBkw3zkgwKLvfZvv7pA1x2H3wIlrG4Es18MUyWH+yJoTYLs0fM8/jG4n2R2ub61F4eYk4baVoJkY5N5YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333016; c=relaxed/simple;
	bh=FeRyEYvXf85BAUr93ElDNP9T163tcfn/PHVPvFqUJPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPlLpUnn7quAZo996OmDnBBqS8tnNn16bdPgqhBfqBGnr2b8Er7shR6F4Qn+Mza/flWk+dp3rFvieIqy57+j3MYlzPIWqo8O+UoLSm097hBzHq01Myg7NJeE7ZbZy9MkNbd3XxRM1yYpDS4HQARk/0BgcE4vRs37x+yniaY5VDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O62i0YZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O62i0YZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896611F00A3A;
	Wed, 29 Jul 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333007;
	bh=ayporV8thlJVnHca6S/0ntzjPPS1CO8wzdgD6pQcWFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O62i0YZsh31Mod8dEJxuL57d8Bv/MLEjmfNX5sprC5JGMqf/UaXVLtR1eL97ZjgH2
	 YBg2AaUUWYhcodV50cFDJ/GEAI+UAODltXeYAYkneunpdwPGoQG9lrkpcCAot2aC9F
	 GNkkAyPa33wblaMBqUvBznxFGuT6EZU15gGrIvnZcU77LnJg/8xEwRRl/k6NMUHfXi
	 rWE3W+ECWa5ndhJ66iU//KejB0gBauby7Do0fXm40ul2P5qOuKgA4kQ2DckfnUXTJt
	 Qz6FlZ78UQEPD/foGZII8IZhC9KcPnEYxG2qh4exKeqS4mHdHtPKLxq55aGIs+dTNv
	 7pah46gl/1xCw==
Date: Wed, 29 Jul 2026 15:49:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: wangjia@ultrarisc.com
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: allow DP1000 driver to build as
 module
Message-ID: <dz43ty5hgpefk67lmgxfn2tmppng4ws6oy66zns5ajt3qwdfai@k3exaapdqvxh>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>

On Tue, Jul 14, 2026 at 09:11:04AM +0800, Jia Wang via B4 Relay wrote:
> From: Jia Wang <wangjia@ultrarisc.com>
> 
> CONFIG_PCIE_ULTRARISC is a tristate option, so the driver can be selected
> as a module when COMPILE_TEST or platform configuration allows it.  Using
> builtin_platform_driver() leaves the module build without the module
> init/exit plumbing and causes modpost failures for the generated .ko.
> 
> Use module_platform_driver() so the driver works for both module and
> built-in builds while keeping the existing tristate Kconfig entry.
> 
> Add a remove callback and call dw_pcie_host_deinit() during removal so the
> root bus is torn down before devres releases the controller data.
> 
> Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  drivers/pci/controller/dwc/pcie-ultrarisc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> index 72ba5840b62d..9bee522a20e9 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -193,6 +193,13 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void ultrarisc_pcie_remove(struct platform_device *pdev)
> +{
> +	struct ultrarisc_pcie *ultra = platform_get_drvdata(pdev);
> +
> +	dw_pcie_host_deinit(&ultra->pci.pp);
> +}

Since this driver registers an internal MSI controller, it is not safe to
remove it due to irq disposal concern. But you can build this driver as a
module though.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
