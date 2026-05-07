Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740F3BED55
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168866; cv=none; b=TKtQkgCBUXHm9AIn2zYPPmMpnqulw8KNxJc42shl+p5tj6hnvaymmZmxxenAnPQvysSiGQKqGjHj/c116db99Fpiz99bvamIAYOD3JtUspgARmrKn0WkkUqRVriTifBCTuKA/Enu4ERpZvF5285PM7XatX4ZHjhVtw5ZJPhV50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168866; c=relaxed/simple;
	bh=XnKk5NVsgHUStExAtIyjAjrkPvaMaYkuwLAtAgF99oM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mFCmkVJoQ0FbNn4vmGiVFoVfLxRl/ta2xChycxCMDdJNSyeQbX+UC2yH7IsDQFZcwEdVrs0C2WOpoVNgID8VtqkZWGjcQE8krvV0cOIjGg8flwHSbDdrrB1jnOaZM7wqTjN8HgrxD2qI399Sh8uffl+UbxAQHmlvoa4fDLX3g8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR+rpeoE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR+rpeoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713D4C2BCB2;
	Thu,  7 May 2026 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778168865;
	bh=XnKk5NVsgHUStExAtIyjAjrkPvaMaYkuwLAtAgF99oM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aR+rpeoEEuUvLTKbCRsnjdzr3se5Vpcx8pMG+byRmhQ3Ol/7IvJygBtZUy8u2UzHO
	 n6xMY68m+HJ4f9/i1Rj6BvDd6cbm0YzbfAJfXnJ07bSgIeEp1ycl9TLrUvBJUPIhLP
	 nrsxC0shv3ThUiABgQ0qbWbcz/dS8Drpsa24aHoDHbCUenZ313s+qovNGSzKA0dMM3
	 qccKghxdWyjCs5I29SiRDIpKTXj1IkgHE3eXaUdin1Td9feLhaIU4QQVmAOqA+pV7C
	 4G+Uf4QF+hjWK18ZzPSLobZnzKNlfsWS4hqq1ln5bjJoQQxqjJyDoFy/WOwMo9X8zz
	 uiFyUUKj4GhCw==
Date: Thu, 7 May 2026 10:47:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan K Pillai <mpillai@cadence.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 phy-next 09/31] PCI: Remove device links to PHY
Message-ID: <20260507154744.GA971447@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507075959.47D77C2BCB8@smtp.kernel.org>

[+to Manikandan, Siddharth, Vignesh, Hans]

On Thu, May 07, 2026 at 07:59:58AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Critical memory corruption in cdns_plat_pcie_shutdown() due to incorrect pointer cast.
> - [High] Asynchronous pm_runtime_put() is called immediately before pm_runtime_disable(), cancelling suspend transitions.
> - [High] Shared IRQ handlers access hardware registers without checking PM runtime state, causing spurious interrupts or bus errors.

Please take a look at these potential issues and see whether changes
are needed.

pcie-cadence-plat.c and pci-keystone.c are orphaned since

  0ee2030af4e3 ("MAINTAINERS: Orphan Cadence PCIe IP")
  57e1d8206e48 ("MAINTAINERS: move Murali Karicheri to credits")

Would anybody like to step up and take care of them?

> commit abda94a24ef1bb0817706ae87aa20f04251c14ad
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> PCI: Remove device links to PHY
> 
> This commit removes device links between the PCIe controllers and PHY
> providers in the Cadence, DRA7xx, and Keystone drivers. The device links
> are now redundant since the PHY core automatically adds device links to
> order suspend/resume operations.
> 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> > index 8b12a46b56019..6fd16e09e2444 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> > @@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
> >  	struct pci_host_bridge *bridge;
> >  	struct cdns_pcie_ep *ep;
> >  	struct cdns_pcie_rc *rc;
> > -	int phy_count;
> >  	bool is_rc;
> >  	int ret;
> 
> In cdns_plat_pcie_probe(), the driver data is initialized to point to a
> struct cdns_plat_pcie object:
> 
> 	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
> 	...
> 	platform_set_drvdata(pdev, cdns_plat_pcie);
> 
> However, in cdns_plat_pcie_shutdown(), the pointer is extracted and cast
> directly to struct cdns_pcie *:
> 
> static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
> {
> 	struct device *dev = &pdev->dev;
> 	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> 	...
> 	cdns_pcie_disable_phy(pcie);
> }
> 
> Since struct cdns_plat_pcie is only 8 bytes large, but the phy_count field
> is at an offset of roughly 36 bytes in struct cdns_pcie, does this lead to
> an out-of-bounds read and memory corruption when cdns_pcie_disable_phy()
> attempts to iterate over the PHYs?
> 
> [ ... ]
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index fe4836925c4e3..cab9fad212add 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> [ ... ]
> > @@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
> >  	pm_runtime_disable(dev);
> >  	ks_pcie_disable_phy(ks_pcie);
> >  
> > -err_link:
> > -	while (--i >= 0 && link[i])
> > -		device_link_del(link[i]);
> > -
> > +err:
> >  	return ret;
> >  }
> >  
> >  static void ks_pcie_remove(struct platform_device *pdev)
> >  {
> >  	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> > -	struct device_link **link = ks_pcie->link;
> > -	int num_lanes = ks_pcie->num_lanes;
> >  	struct device *dev = &pdev->dev;
> >  
> >  	pm_runtime_put(dev);
> >  	pm_runtime_disable(dev);
> 
> Does calling pm_runtime_put() immediately before pm_runtime_disable() cancel
> the suspend transition?
> 
> pm_runtime_put() queues an asynchronous idle or suspend work item, but
> calling pm_runtime_disable() immediately afterward cancels this pending
> transition via __pm_runtime_barrier().
> 
> Could this leave the hardware in an active or incorrect power state from
> the controller's perspective? Would it be safer to use synchronous
> pm_runtime_put_sync() instead?
> 
> This asynchronous put pattern also appears in the error paths of
> dra7xx_pcie_probe() and ks_pcie_probe().
> 
> While reviewing the power management handling in these drivers, I also
> noticed that the shared interrupt handlers read hardware registers directly
> without verifying if the device is active:
> 
> drivers/pci/controller/dwc/pci-dra7xx.c:dra7xx_pcie_irq_handler() {
> 	...
> 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
> 
> If another device sharing the same IRQ line triggers an interrupt while the
> PCIe controller is runtime suspended, will these handlers attempt to read
> powered-down hardware?
> 
> Should the handlers check the PM runtime state using
> pm_runtime_get_if_active() to prevent spurious interrupts or bus errors?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260505100523.1922388-1-vladimir.oltean@nxp.com?part=9
