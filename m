Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FE3C8C5D;
	Thu, 11 Jun 2026 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216816; cv=none; b=euNKWAa9F9M1PEAta5B3BfS1ZOg6NuQtYiXaq4d6xOi6orifbfbbX4jMsLg/1//VYXKaJcnIreUQkfG4mi51p3kf8bnG5kYXM2udTT2IdiViHOuLmUM48BgmUcG47zc9q74GG8n5wS9dE93osakcWEFDE0WuMhTNDAVRfDt+CTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216816; c=relaxed/simple;
	bh=xVW9Bdt1R8FfYrs1bdcu57axvNjxmpnDpigeImiS8og=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mTOCAomoV2g+53pcmBHxWSHKxdqka0mENA5R1+nQPY2aaJyxAJV2MwVRgmWG16zmzrsiiz1MmQTpjuIyVwGqyrYjgbO5Tl8PQkr7fCbNnLGPCfIgwIaH/wFlZ7wM+COY0r/ZBMzYL7cfjzzQ7AoSbiuvQP89mU9GOF9+KnZwGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcNwpAN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcNwpAN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB71F00A3A;
	Thu, 11 Jun 2026 22:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781216815;
	bh=BlddrtjDVCAlCgNHnLo0GABr55ofYJLh22S8cPPK6vE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BcNwpAN9g6CyY54DyXzcOwLS0ZaRuogb/V+aAniatqyJ+wzg1FSqY5AOqNpmXnUTO
	 Ql/Q4qQoJYEKmyRlevaGJa32KVHmqEYeM4y+sJ6gg+PMaoYdt9EsJU2Oz6XQ9S2/Ui
	 ybBpcuVJWpAmmIEummwCwLeauvAlD+lEzDYeuYoJjElyiSEw8npN1zizgdbab/I7aB
	 5sla8YC1c08m19/0XjV8mpISxV4W4zSRmoGssrfFqlGwfNJ3p2JiGVRJjHaFHD0g1I
	 w3Uv1f7M5LBV0DaXbcE5tKiG8KeWUh8MRCtoD747Af2ovlYngx6DiEkVJlggtNlU5u
	 QecWu1lX5QjZw==
Date: Thu, 11 Jun 2026 17:26:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Fan Ni <fan.ni@samsung.com>, Shradha Todi <shradha.t@samsung.com>,
	Hanjie Lin <hanjie.lin@amlogic.com>, linux-pci@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: meson: Add missing remove callback
Message-ID: <20260611222653.GA527114@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a0c86ab264cdc1c79c917e984b90991af51d827.1779123847.git.shuvampandey1@gmail.com>

On Mon, May 18, 2026 at 10:44:18PM +0545, Shuvam Pandey wrote:
> meson_pcie_probe() powers on the PHY and registers the DesignWare host
> bridge with dw_pcie_host_init(), but the driver has no remove callback.
> On driver unbind or module unload, the driver core therefore proceeds to
> devres cleanup without first unregistering the host bridge or powering off
> the PHY.
> 
> Add a remove callback that deinitializes the DesignWare host bridge and
> powers off the PHY while device-managed resources are still valid.

What's the user-visible effect of this?  Does it avoid an oops?
Reduce power usage?

Of the 34 instances of .probe() in drivers/pci/controller/dwc/, on 12
implement .remove(), so if this fixes a problem, I'm wondering whether
other drivers have the same problem.

> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 0694084f6..c96e2244a 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -451,6 +451,14 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void meson_pcie_remove(struct platform_device *pdev)
> +{
> +	struct meson_pcie *mp = platform_get_drvdata(pdev);
> +
> +	dw_pcie_host_deinit(&mp->pci.pp);
> +	meson_pcie_power_off(mp);
> +}
> +
>  static const struct of_device_id meson_pcie_of_match[] = {
>  	{
>  		.compatible = "amlogic,axg-pcie",
> @@ -464,6 +472,7 @@ MODULE_DEVICE_TABLE(of, meson_pcie_of_match);
>  
>  static struct platform_driver meson_pcie_driver = {
>  	.probe = meson_pcie_probe,
> +	.remove = meson_pcie_remove,
>  	.driver = {
>  		.name = "meson-pcie",
>  		.of_match_table = meson_pcie_of_match,
> -- 
> 2.50.1 (Apple Git-155)
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
