Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3C41228D;
	Wed,  7 Oct 2026 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406001; cv=none; b=LZE63ojcqGAAozegyAFz4EeM0eZzrpjbGsjqi+fmqQRmFhcvc4kJm0OR1qeRo5+38uLWEAM+JSsREViHHpo/cybI2TRhnERLZSXXLBkUIU1CSms7xa0EsCI0pLKPJRgnxdnErZeI9ThBa931GFGyqL+v1eAOGJOrYCyh6wP6Wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406001; c=relaxed/simple;
	bh=gTwxBYTl+pHDh47KmeB80cZ5j+8y40mfAwfHJkEeusQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OY6y1C633zZE6ERsMYIOADY+RkJNI8tqsQuQ0hGoXpkskYHImWUoBwt1K/WBsA5HW1VarBPQCjKPn4lBKaUudMbg8mhRx+v8fJ2E8J2pIG9zOoDeO5fPWaKB0/G2IoJ4MR26zqRlF89IjqywNsceraNEDX/ZI/+OnDfuHfA3HYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzRBCnbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzRBCnbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCAF1F000FF;
	Wed,  7 Oct 2026 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406000;
	bh=34+KA6aRWlauHcZvLDUgRaDFa7lnmvJ3bU3k1UoQnyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FzRBCnbtC0AKOKMea5+7ceoLBzxC2dnl/kOVAzt1S7RLQCqRjqFMXtgWt7tIYdSpb
	 6x7JbayU+CuijLwxk+tz4spqSmMx7xaOeJSH5MQIj+V7aUuiHycsXvGu6Ejv84AtDp
	 HuOtoqVu6YTvbgos6i7xvhdRXYPupAQss+HOfC1RE9Xk6tkxMjysz4oNsC71h646Eu
	 +70F0hNf884qLjJZRVnQC6SyfY6ZmSty10KgLZiN/Ije7ViaMk4HoB0sWmNISHY0G7
	 xTk14UNoMWcsGHX+dEeU317Q7eyYQ6cgqOjbXY/3N91aR2OuvoeuNv1Er9zYvaVy/X
	 me2ov68d1q96w==
Date: Wed, 7 Oct 2026 15:46:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: phucduc.bui@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: tegra194: use dev_err_probe() for PERST GPIO
Message-ID: <20261007204638.GA785135@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007104847.507776-1-phucduc.bui@gmail.com>

On Wed, Oct 07, 2026 at 05:48:46PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Use dev_err_probe() when getting the PERST GPIO to simplify error
> handling and properly handle -EPROBE_DEFER.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

For future posts, please match the subject line capitalization style:

  PCI: tegra194: Use ...

And style as "PERST#" in the subject, commit log, and dmesg text to
match spec usage.

No need to repost just for this; we can tweak these when applying.

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 63a0f56cad8e..767e11216196 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1200,18 +1200,9 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>  
>  	/* Endpoint mode specific DT entries */
>  	pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
> -	if (IS_ERR(pcie->pex_rst_gpiod)) {
> -		int err = PTR_ERR(pcie->pex_rst_gpiod);
> -		const char *level = KERN_ERR;
> -
> -		if (err == -EPROBE_DEFER)
> -			level = KERN_DEBUG;
> -
> -		dev_printk(level, pcie->dev,
> -			   dev_fmt("Failed to get PERST GPIO: %d\n"),
> -			   err);
> -		return err;
> -	}
> +	if (IS_ERR(pcie->pex_rst_gpiod))
> +		return dev_err_probe(pcie->dev, PTR_ERR(pcie->pex_rst_gpiod),
> +				     "Failed to get PERST GPIO\n");
>  
>  	pcie->pex_refclk_sel_gpiod = devm_gpiod_get_optional(pcie->dev,
>  							     "nvidia,refclk-select",
> -- 
> 2.43.0
> 
