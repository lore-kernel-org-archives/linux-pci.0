Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50A47141E;
	Fri,  2 Oct 2026 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983567; cv=none; b=YJcxHrjPx5PYGUGZ0dxH8rkA83oyvPMTrI9g+mQVaaPmgrQxckY5WC2IRtLYiR4ZfJDjyhLIq7rqD23RcJkR2GDf6r31OFDMbn6C9HwJPVvsDDMM1fctAhH7GP4d/KEFyAKKUgebgrr3ISaP7lS2HwDGJ+2SXDTDS8VIjOXuGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983567; c=relaxed/simple;
	bh=pBcY2R+oI4tstgT/fIyDCw4Zl2VJIZsK3vlJwnGD03Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mHJU6qztpWoqv16jbSwuPoUkQNToiuirFaxc17ttdv5xojAfo0aR0yn855WqriXVGGcY+t1WnmI64+ubVX6YGtXQxVwXdTnu0O27wzrsfzu6r+mx2BscKLLTgiZcpBl4U3NjwSnzk+yr+RjVk8td7cU1LWdtBR/LUoXcJzkWu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv2UEINN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv2UEINN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFA21F00893;
	Fri,  2 Oct 2026 23:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790983565;
	bh=qu9dEtP9YAh4yNiAM94k1GvC1NXBsCRK7l37Wy+2FEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Jv2UEINNPTvxl6/MPEAJB5TLj2CtWVtUaWt1PnB2eSs3XfpFRY4Cy+Vne+ttmP/H6
	 Q32lJBAGdwM+eOBEvMbJtdGp8UcrqoQ+5yYTGTvOUqotijZ8xB6/JjbMoD2Nyor79L
	 3B/O0w29eVwrMC0fZFqD16EuRbN7DWW+pxmivi0L5vZ7H7qWIXkaKSOXhPnXX0pLoc
	 TGOHMazC+qltWb0nL1TC+OM3xfxQ26gQlWl1b6VV4mE9jGTte8E7DXxqk5QPF8rfeE
	 ctgWXgYJCN+534DL1CWDqSitYUxiliZdgxGc344IGBH4yX8u1WoDsR6x+o+RkzLXwj
	 d7qPkvu1XC18Q==
Date: Fri, 2 Oct 2026 18:26:03 -0500
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
Message-ID: <20261002232603.GA397281@bhelgaas>
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
> 
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

FYI, from internal Sashiko review while backporting this commit
(4b0dc84b2939 ("PCI: meson: Add missing remove callback")):

[Severity: Medium]
Will this manual call to meson_pcie_power_off() execute too early,
before devres tears down the clocks?

During probe, the initialization order powers on the PHY before
enabling theclocks. LIFO order requires disabling the clocks before
powering off the PHY.Because meson_pcie_probe_clocks() uses
devm_add_action_or_reset() to manage the clocks, they will be disabled
after meson_pcie_remove() returns.

Could this cause a hardware hang or undefined behavior during driver
unbind due to the clock and power sequencing violation?

[Severity: High]
This is a pre-existing issue, but does this remove function also need
to call reset_control_assert() to avoid leaking the shared reset
deassert count?

During probe, meson_pcie_get_resets() obtains a shared reset and
manually increments its deassert count:

  mrst->apb = meson_pcie_get_reset(mp, "apb", PCIE_SHARED_RESET);
  if (IS_ERR(mrst->apb))
    return PTR_ERR(mrst->apb);
  reset_control_deassert(mrst->apb);

Because the devm reset getters used here do not automatically assert
on cleanup, omitting reset_control_assert() in meson_pcie_remove()
means the apb shared reset will permanently have a non-zero
deassert_count. This prevents it from ever being asserted again, even
if all consumers unbind.

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
