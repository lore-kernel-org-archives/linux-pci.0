Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028729B228;
	Thu, 21 May 2026 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348843; cv=none; b=VuecPM65slcXkfLxNiQvjyOx6eKwA4D/EzNUvSZEH5Zk/8Valfo5aBLpyHTIHYBkDjwkC04QllwmzFJK1T/+9RtyU69CBYvjZrGFP+Xih1Ec+GrUlltDLZsMS1evlx5lqd1+I8mIjQBxUJe0+t3u10773qeKXMXnPIL3gMz8eNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348843; c=relaxed/simple;
	bh=+57qmBqsfH2yB6VQDWcel9jtXkQ6YV/XF17EdDqHT1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5ovjhjM4dEL4nTU19azEhZYl891lqkeC5n/A65PTTbwdaifBI2fbeKdMwRktCt1W68me1fiC4HAHdLYDb2hbhG6Ei6vCZr7MrA59FbR3YbsL217xI9O3XI0FGv+arqc8EOeQUuGzPM4BmMPUJKovgjwqnSsitdNXCLHcMtKCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJaTb0BT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJaTb0BT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3261F000E9;
	Thu, 21 May 2026 07:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779348841;
	bh=XDptwRg4xKg27amdn8Wlm2h1aOyMSzRy1QjpV2/Ikhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AJaTb0BT/WYnEY5NIICQVRSb10hhMfUGcUj/VlVtQ6tQg4RUk3YSt7HwYz6/2RV3K
	 M9eh854AoOF88iE/k03Q5CbrKGEw2+Z9PeU50YpJNVppiVQIRx1XBxybXqOv1y8rmU
	 KCreEYXxRf5z1FtJXcpZqEaCMRjQn3OTA2Bvmmmy0iDGl9TWagcGxLPWjfVnkXjGxD
	 3AYA2pOjo8oSAKa9FoC1zkYiunNGJAjbGVVIYOh7TdJsVENOqVQCjart6SA3OKmlEz
	 Lj8i/VD/GODloD0gwSfUwwX5jgw0pzm9/cV4/hVVlgfSOFq+HGeFbD50bKjrk+znlc
	 xwTH2HfQNS21w==
Date: Thu, 21 May 2026 13:03:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Caleb James DeLisle <cjd@cjdns.fr>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v8 3/3] PCI: mediatek: Add support for EcoNet EN7528 SoC
Message-ID: <r2l6c665a3feivxabhlkqx5hghvg4s6spxz7xmqvlxawqijkub@qz3gcdxuavf7>
References: <20260520183827.908243-4-cjd@cjdns.fr>
 <20260520195806.4726A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520195806.4726A1F000E9@smtp.kernel.org>

On Wed, May 20, 2026 at 07:58:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Link retraining is performed after device enumeration and driver binding, causing a severe race condition.
> - [High] Iterating the PCI bus devices list without holding the pci_bus_sem read lock.
> - [Medium] Early return in mtk_pcie_retrain() aborts retraining of all remaining root ports if a single port fails.
> 
> Pre-existing issues:
> - [High] Freeing port in error paths causes a Use-After-Free because the active IRQ domain's host_data still points to it.
> --
> 
> commit c1c3bb9bcba6bb8a070037578912a2f02c381591
> Author: Caleb James DeLisle <cjd@cjdns.fr>
> Subject: PCI: mediatek: Add support for EcoNet EN7528 SoC
> 
> This commit adds support for the PCIe controller present on the EcoNet
> EN7528 (and EN751221) SoCs. These SoCs feature a mix of Gen1 and Gen2 ports,
> and require a manual link retraining after startup for Gen2 ports to function.
> 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index c503fbd774d09..4e4d4b1559f71 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> 
> [ ... ]
> 
> > @@ -755,6 +766,132 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  	return 0;
> >  }
> >  
> > +static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
> > +{
> 
> [ ... ]
> 
> > +	/* 100ms timeout value should be enough for Gen1/2 training */
> > +	err = regmap_read_poll_timeout(pcie->cfg, EN7528_LINKUP_REG, val,
> > +				       !!(val & link_mask), 20,
> > +				       PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
> > +	if (err) {
> > +		dev_err(pcie->dev, "EN7528: port%d link timeout\n", port->slot);
> > +		return -ETIMEDOUT;
> > +	}
> 
> [Severity: High]
> This is a pre-existing issue, but returning an error here can cause a
> use-after-free crash.
> 
> When a port fails to start up (for example, if the slot is empty and link
> training times out), the caller frees the port structure by calling
> mtk_pcie_port_free(). However, mtk_pcie_port_free() does not call
> irq_domain_remove().
> 
> Since mtk_pcie_init_irq_domain() sets the newly allocated port structure
> as the IRQ domain's host_data, the domain remains registered with a
> dangling pointer.
> 
> Could we make sure the IRQ domain is properly cleaned up in error paths?
> 
> [ ... ]
> 

This is a valid concern. I've sent the fix for it:
https://lore.kernel.org/linux-pci/20260521071907.13614-1-manivannan.sadhasivam@oss.qualcomm.com/

> > +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *host)
> > +{
> > +	struct pci_dev *rp;
> > +	int ret = -ENOENT;
> > +	u16 lnksta = 0;
> > +	u32 speed;
> > +
> > +	/* Should already have been warned about during startup_port */
> > +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK))
> > +		return 0;
> > +
> > +	for_each_pci_bridge(rp, host->bus) {
> 
> [Severity: High]
> Does iterating the PCI bus devices list here require holding the pci_bus_sem
> read lock?
> 
> Since mtk_pcie_retrain() is called after pci_host_probe() completes, the PCI
> bus is live and devices are exposed to the system. Concurrent operations like
> sysfs hotplug events could modify the host->bus->devices list during traversal.
> 
> Should we hold down_read(&pci_bus_sem) or use pci_walk_bus() to avoid a race
> condition?
> 

This is also a valid concern. You should wrap the loop with 'pci_bus_sem'. I see
a few other drivers are also doing the same, but I'll fix them separately.

> > +		if (pci_pcie_type(rp) != PCI_EXP_TYPE_ROOT_PORT)
> > +			continue;
> > +
> > +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
> > +		ret = pcie_retrain_link(rp, true);
> > +#endif
> > +
> > +		if (ret)
> > +			return dev_err_probe(&rp->dev, ret,
> > +					     "failed to retrain port\n");
> 
> [Severity: Medium]
> Will this early return abort the retraining process for all remaining root
> ports?
> 
> If pcie_retrain_link() fails on the first port, we immediately break out of
> the loop.
> 
> Should this log the error and use continue instead, so that a failure on one
> independent slot does not prevent the others from retraining successfully?
> 

This you can ignore as we should treat retrain failure for a single Root Port as
a hard failure.

> > +
> > +		pcie_capability_read_word(rp, PCI_EXP_LNKSTA, &lnksta);
> > +		speed = lnksta & PCI_EXP_LNKSTA_CLS;
> > +
> > +		pci_info(rp, "link retrained, speed %s\n",
> > +			 pci_speed_string(pcie_link_speed[speed]));
> > +
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> > @@ -1159,6 +1296,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
> >  	if (err)
> >  		goto put_resources;
> >  
> > +	/*
> > +	 * Ignore error because pci_host_probe() was already called, and in any
> > +	 * case it is possible that the port will still work as Gen1.
> > +	 */
> > +	if (pcie->soc->quirks & MTK_PCIE_RETRAIN)
> > +		mtk_pcie_retrain(dev, host);
> > +
> 
> [Severity: High]
> Can retraining the link at this stage cause issues with actively bound endpoint
> drivers?
> 
> By the time pci_host_probe() returns, devices have already been discovered,
> exposed to the system, and their drivers bound. Retraining the PCIe link forces
> it into recovery, which could stall transactions or temporarily drop the link.
> 
> If an endpoint driver (like NVMe or Wi-Fi) is actively performing MMIO or DMA,
> could this cause unhandled exceptions, AER errors, or initialization failures?
> 
> Would it be safer to retrain before devices are added to the system (e.g.,
> before pci_bus_add_devices())?
> 

This can also be ignored as you don't have much choice here. Once the driver is
bound to the device, doing any link level activity without quiescing the device
warrants trouble. But since it happens right after the pci_host_probe(), most
likely the client drivers wouldn't have started functioning i.e., initiating DMA
transfers etc... So the chances of failure are very less.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
