Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C15372ECA;
	Thu, 30 Jul 2026 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398430; cv=none; b=mBsemC+zd6hETrIc7JeHMAkmDZh+D6U2tDzSNW4vXKOtZgNa/KMMNC2JvnQM59w2d/dqrRAaLDHBTw9I7mnAyfym58UqWIdDLbpuxM0+GfO9vSSY0yJQ1Q/+Vp6OBzB25J+/pGKj6EO4tM7qQFkoYzl+LbfSSSSKgfPO1hwN/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398430; c=relaxed/simple;
	bh=tdm9Mi337yvdTptEf6WzmkT35aAa5hjyDo8ZGlJHlYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjS2IGPgpwWvMPAC4xLeb6dm2tk5bylVX6FKX9U1NCudE42bSTUFZmBOSsaKw2L+21QASK+T6QA0CRnICM1uInBdzfEX9ddQNc1Ai4qwZ+6I5AZri9RixbQy/dWWdSN/3XtNoQmE8mNRDudRFUsLLWKym7221a+OOJ5BX/WbMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn9QAcHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn9QAcHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FB91F000E9;
	Thu, 30 Jul 2026 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785398426;
	bh=yCR50frgPUeRicBugHq2OSU6qq0FudS+2HtBwsJdmRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hn9QAcHy/U3OMLuiutzOiEaJhBCZZBFDH015LsVN/rlQhpfkaqwuVWCn2Psn7mQGZ
	 1UB+2eFJ+jXXR0FhLv3AjHVGATcao44gioL0OBFuvPYffHh/9KaoLGpamDQsI5AbaX
	 N7Aa3LhPPrp4tuIWxHZsMYCuMfkZvtpsNYMErFhKcBE7R4+Eqbro0WZwHYap49bVdy
	 jSYNTgun8jpbzn4kIIwhNbrsTYdjZf/klBxyRXDPKSE3fanmtKmpqPB0gq2fiEg6I0
	 8VY6bxT9VJ+6fnhvvIetYGZJ+tLWOUsqji3R30y9GRYYvPaoarYtVMaxFLJ04KNkIR
	 /54Gpdfd7UQoA==
Date: Thu, 30 Jul 2026 10:00:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Message-ID: <hqzcquvsbd2kpmkup6be6lxwihitugai7aubeyyz3rxtgmra4a@wfhz4rdfp5mw>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-2-e72723fc0ef1@ultrarisc.com>
 <2n44tfzw26mfis3nvnre2fph4u2whns5xgxvdmcczyfebt6gt2@ln53o5bi773e>
 <178539410375.553273.13405298466842007043.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178539410375.553273.13405298466842007043.b4-reply@b4>

On Thu, Jul 30, 2026 at 02:48:23PM +0800, Jia Wang wrote:
> On 2026-07-29 15:48 +0200, Manivannan Sadhasivam wrote:
> > On Tue, Jul 14, 2026 at 09:11:03AM +0800, Jia Wang via B4 Relay wrote:
> > > From: Jia Wang <wangjia@ultrarisc.com>
> > > 
> > > Add the required core, dbi, and aux clocks for the DP1000 PCIe
> > > controller and enable them before initializing the DesignWare host.
> > > 
> > > Also manage the clocks across system suspend and resume.
> > > 
> > > Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-ultrarisc.c | 102 ++++++++++++++++++++++++++--
> > >  1 file changed, 95 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > index 6ee661ceff67..72ba5840b62d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
> > >   */
> > >  
> > > +#include <linux/clk.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of_device.h>
> > > @@ -23,6 +24,12 @@
> > >  
> > >  #define ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS	0x6
> > >  
> > > +struct ultrarisc_pcie {
> > > +	struct dw_pcie pci;
> > > +	struct clk_bulk_data clks[3];
> > > +	bool clks_enabled;
> > > +};
> > > +
> > >  static struct pci_ops ultrarisc_pci_ops = {
> > >  	.map_bus = dw_pcie_own_conf_map_bus,
> > >  	.read = pci_generic_config_read32,
> > > @@ -98,17 +105,66 @@ static const struct dw_pcie_ops dw_pcie_ops = {
> > >  	.start_link = ultrarisc_pcie_start_link,
> > >  };
> > >  
> > > +static int ultrarisc_pcie_enable_clks(struct ultrarisc_pcie *ultra)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (ultra->clks_enabled)
> > > +		return 0;
> > > +
> > 
> > This check looks redundant and I don't see a need for the 'clks_enabled' flag.
> > Just do:
> > 
> > 	return clk_bulk_prepare_enable();
> >
> 
> Thanks for the review.
> 
> Agreed. I will remove clks_enabled and have ultrarisc_pcie_enable_clks()
> return clk_bulk_prepare_enable() directly in the next version.
> 
> > > +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ultra->clks_enabled = true;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void ultrarisc_pcie_disable_clks(void *data)
> > > +{
> > > +	struct ultrarisc_pcie *ultra = data;
> > > +
> > > +	if (!ultra->clks_enabled)
> > > +		return;
> > > +
> > > +	clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> > > +	ultra->clks_enabled = false;
> > 
> > Same here.
> >
> 
> Agreed. I will make ultrarisc_pcie_disable_clks() call
> clk_bulk_disable_unprepare() unconditionally in the next version.
> 
> > > +}
> > > +
> > > +static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
> > > +{
> > > +	struct device *dev = ultra->pci.dev;
> > > +	int ret;
> > > +
> > > +	ultra->clks[0].id = "core";
> > > +	ultra->clks[1].id = "dbi";
> > > +	ultra->clks[2].id = "aux";
> > > +
> > > +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ultra->clks), ultra->clks);
> > 
> > Use devm_clk_bulk_get_all()
> >
> 
> I used `devm_clk_bulk_get()` to make the driver require the "core", "dbi",
> and "aux" clock names. Using `devm_clk_bulk_get_all()` would instead accept
> the clocks without requiring those names. Is that intended, or is there a
> requirement or convention I am missing?
> 

Your DT binding should ensure that the DTS supplies the required clocks. So the
driver shouldn't hardcode the clock name and just get whatever clocks DTS
passes. Otherwise, the driver will become a DTS validator.

> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> > > +
> > > +	ret = ultrarisc_pcie_enable_clks(ultra);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
> > > +
> > > +	return devm_add_action_or_reset(dev, ultrarisc_pcie_disable_clks, ultra);
> > > +}
> > > +
> > >  static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > >  {
> > > +	struct ultrarisc_pcie *ultra;
> > >  	struct device *dev = &pdev->dev;
> > >  	struct dw_pcie_rp *pp;
> > >  	struct dw_pcie *pci;
> > >  	int ret;
> > >  
> > > -	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > > -	if (!pci)
> > > +	ultra = devm_kzalloc(dev, sizeof(*ultra), GFP_KERNEL);
> > > +	if (!ultra)
> > >  		return -ENOMEM;
> > >  
> > > +	pci = &ultra->pci;
> > >  	pci->dev = dev;
> > >  	pci->ops = &dw_pcie_ops;
> > >  
> > > @@ -117,7 +173,11 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > >  
> > >  	pp = &pci->pp;
> > >  
> > > -	platform_set_drvdata(pdev, pci);
> > > +	platform_set_drvdata(pdev, ultra);
> > > +
> > > +	ret = ultrarisc_pcie_init_clks(ultra);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > >  	pp->num_vectors = MAX_MSI_IRQS;
> > >  	/* No L2/L3 Ready indication is available on this platform */
> > > @@ -135,16 +195,44 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > >  
> > >  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
> > >  {
> > > -	struct dw_pcie *pci = dev_get_drvdata(dev);
> > > +	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
> > > +	struct dw_pcie *pci = &ultra->pci;
> > > +	int ret;
> > > +
> > > +	if (pci->suspended) {
> > > +		ultrarisc_pcie_disable_clks(ultra);
> > > +		return 0;
> > > +	}
> > 
> > Same as above. This looks redundant. Actually, it is wrong too as there cannot
> > be more than one suspend callback invocations.
> >
> 
> Agreed that suspend_noirq() is invoked once per transition. However, a
> failed resume leaves pci->suspended set and the clocks disabled. The PM
> core records the resume error and continues the transition, so a later,
> independent system suspend can invoke this callback again. In the next
> version, I will keep the entry check as an early return for that case,
> without disabling the clocks again.
> 

OK!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
