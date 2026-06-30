Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E961DD525;
	Tue, 30 Jun 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782806625; cv=none; b=AKfE9yfRWmz9rJqkHOqHOSqj4mdTRQOEKN0PlfncNT36ROSbi3AlKdRHGQhyHIv+joKjG08kc1cfIkKhHGY23I05nBvnZx0e8sei5nZunqbrBWJrK0LVQRjrliBzPned7IH4RYgxjY/SCYyFp7IPVmaJ5O1zGDclNhetgbYBmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782806625; c=relaxed/simple;
	bh=kZ0lHqr/Qm+MZZg9bHttGiWVjJfxinrgqZbaxa1d6ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEhc5M1wpPZMsWhAY+OIYvG3TfCnPb8TxEcRdkppamdfrm9gU5Yz3TprEQBIa7z1aimKYrjYM8vOqrgsOblwuGrVv8J0l6SPQnphnqtZ78fNVVFDJ75yIgmJrLs8S3MPgywocU0kAfWP4HecuFGTYVbqyRjDLiV1wo1qA+bbj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI3p9o8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI3p9o8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDBA1F00A3A;
	Tue, 30 Jun 2026 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782806624;
	bh=Q1CnJZuzdqRqrXbQOY1KrOxkKiVRaNwQ5PMPSeSwmyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HI3p9o8LsCtg6Srxj8v1lfZCk6daGvVh4kE8F5nwWfIMOKRq4572HagmqtEjc+n2t
	 l7Rf+zleSiwbvT45g0Zy9nL6w/1ABCza3NiFj52uitO1Z3roYtmrCv3iTo2tIauVlX
	 YFgHFer7oSshsLGLEauzupjGuP9C4vrfC0FW/74LV7tJJdIbG4MGov/ismJEQ6+mB0
	 1BUF1Obqf1Q229PeFVCSDsCu6QbJuFykJ1+Ax0MnEGakmfNCgJXf0GJ4PZPXUOTIqE
	 1/OdKUY6EjQ6jrdo89pZTB8TD8eWtN2sgU7FaYgngb7WBODd4p5XdWiNaNKNNB7v/D
	 etEm6GbRArB+Q==
Date: Tue, 30 Jun 2026 10:03:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v7 3/4] PCI: tegra: Add Tegra264 support
Message-ID: <23rcfdnhnjhdlhiw6eclxap2tk6j5ni7qkfsd3fkfmucvjemie@fvf4j5earp47>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
 <20260617-tegra264-pcie-v7-3-eae7ae964629@nvidia.com>
 <slfaxyt6p5mwsqmxvmriy6npilpjhjxv5ruegj4hnivj6zufkl@o6adjy5jmzfy>
 <aju3jokcWR5DzPrv@orome>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aju3jokcWR5DzPrv@orome>

On Wed, Jun 24, 2026 at 02:35:04PM +0200, Thierry Reding wrote:

[...]

> > So not hotplug support? Also, you do not want the driver to error out? I'm
> > wondering what's the use then?
> 
> Hotplug is supported via pciehp. We skip probing the host bridge if no
> link was detected because there's simply nothing attached to the port,
> otherwise the link would've come up.
> 
> pcie->link_up is slightly misleading because it actually means something
> along the lines of "link could be up at some point", either during probe
> or after some hotplug event later on. It is only ever false if there's
> no link during probe and hotplug isn't supported at all.
> 

Ok. But if you skip pci_host_probe() then Root Port won't be enumerated at all.
I think that would give a false indication to the user. Typically, Root Port
would get enumerated during probe even if there are no devices atttached and
once the device gets attached, pciehp will enumerate the device.

> > > +
> > > +	err = pci_host_probe(bridge);
> > > +	if (err < 0) {
> > > +		dev_err_probe(dev, err, "failed to register host\n");
> > > +		goto free_ecam;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +free_ecam:
> > 
> > Nit: Prefix 'err' for the labels.
> 
> I don't see any benefit of adding a prefix. Seems pretty redundant, but
> I also don't feel too strongly about it, so I can add it.
> 

People tend to use goto labels to do skip some steps also. So if the error
conditions are prefixed with 'err_' it helps to differentiate between them.

> > > +	pci_ecam_free(pcie->cfg);
> > > +put_pm:
> > > +	pm_runtime_put_sync(dev);
> > > +put_bpmp:
> > > +	tegra_bpmp_put(pcie->bpmp);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static void tegra264_pcie_remove(struct platform_device *pdev)
> > > +{
> > > +	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
> > > +
> > > +	/*
> > > +	 * If we undo tegra264_pcie_init() then link goes down and need
> > > +	 * controller reset to bring up the link again. Remove intention is
> > > +	 * to clean up the root bridge and re-enumerate during bind.
> > 
> > But the controller will be consuming power even if PCIe is not used. Do you
> > really want that? Can't tegra264_pcie_init() handle the initialization? I'm
> > wondering how tegra264_pcie_deinit() in tegra264_pcie_suspend() works then.
> 
> I had to clarify this with the PCI team and they indicated that
> tegra264_pcie_deinit() is actually useless and maybe even harmful. The
> reason is that there's a processor on these boards (BPMP) that takes
> care of power sequencing and it will automatically take the PCI links
> to L2 on suspend and assert PERST#.
> 

Then why are you calling tegra264_pcie_deinit() in tegra264_pcie_suspend()? If
tegra264_pcie_deinit() is harmful, then calling it during suspend should also
be, right?

Or tegra264_pcie_deinit() has to be paired with BPMP doing its own power
sequencing?

Not a big deal, but it just feels weird to see suspend() and remove() doing
different things.

> Another reason why we don't want to reset the entire controller is that
> it is already set up during early boot by UEFI and the kernel driver
> does not redo the entire initialization.
> 

So tegra264_pcie_init() is not the full initialization? If so, is it sufficient
during resume()?

> So yes, I think a little bit of power consumption is the compromise that
> we will have to live with. In the bigger picture it's probably not going
> to be noticeable in most cases, and given that these are embedded
> platforms we'll likely see fixed configurations most of the time and the
> case where we remove the PCIe host controller will not be common.
> 

Fair enough.

> > > +	 */
> > > +	pci_lock_rescan_remove();
> > > +	pci_stop_root_bus(pcie->bridge->bus);
> > > +	pci_remove_root_bus(pcie->bridge->bus);
> > > +	pci_unlock_rescan_remove();
> > > +
> > > +	pm_runtime_put_sync(&pdev->dev);
> > > +	tegra_bpmp_put(pcie->bpmp);
> > > +	pci_ecam_free(pcie->cfg);
> > > +}
> > > +
> > > +static int tegra264_pcie_suspend(struct device *dev)
> > > +{
> > > +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> > > +	int err;
> > > +
> > > +	tegra264_pcie_deinit(pcie);
> > > +
> > > +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> > > +		err = enable_irq_wake(pcie->wake_irq);
> > > +		if (err < 0)
> > > +			dev_err(dev, "failed to enable wake IRQ: %pe\n",
> > > +				ERR_PTR(err));
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int tegra264_pcie_resume(struct device *dev)
> > > +{
> > > +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> > > +	int err;
> > > +
> > > +	err = pinctrl_pm_select_default_state(dev);
> > > +	if (err < 0)
> > > +		dev_err(dev, "failed to configure sideband pins: %pe\n",
> > > +			ERR_PTR(err));
> > 
> > Please remind me if you justified this manual pinctrl handling before.
> 
> This is just regular pinctrl PM boilerplate. There's plenty of other
> drivers where we do this, too. We want this because some of the pins
> get configured to non-default states on boot/resume, so doing this
> here ensures they are muxed correctly.
> 

But pinctrl core should already be doing it for you, no?

> > > +
> > > +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> > > +		err = disable_irq_wake(pcie->wake_irq);
> > > +		if (err < 0)
> > > +			dev_err(dev, "failed to disable wake IRQ: %pe\n",
> > > +				ERR_PTR(err));
> > > +	}
> > > +
> > > +	if (pcie->link_up == false)
> > > +		return 0;
> > 
> > How is this possible? If 'pcie->link_up' was 'false' during probe(), then it is
> > going to stay until tegra264_pcie_init() is called below.
> 
> Yes, this keeps confusing me, too. The purpose of this is to skip
> initialization if we've already determined during probe that there is
> never going to be a link.

But you are calling tegra264_pcie_deinit() during tegra264_pcie_suspend()
unconditionally. So even if 'pcie->link_up' was false, the controller needs to
be initialized (atleast partially), right? Because, you are calling
tegra264_pcie_init() during probe() before 'pcie->link_up' check.

> link_up will be false if and only if there was
> no link during probe and we don't expect there ever will be a link
> because there is no hotplug support.
> 

But above you said that this controller supports hotplug. Which one of the
statement is true?

> Maybe a different name for link_up could help here? maybe_link_up
> perhaps? I don't know if that's any clearer, but I also couldn't come up
> with a better name.
> 
> Or maybe we should split this into two booleans, since we're essentially
> trying to use one boolean to track a tristate. What we want to know is
> if a link is truly up and if the controller should be kept powered for
> the case where hotplug is supported.
> 
> I suppose we could do:
> 
> 	bool link_up; /* track the link state */
> 	bool supports_hotplug; /* track whether port is hotpluggable */
> 

Based on what criteria you'll set 'supports_hotplug' flag?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
