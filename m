Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332AE3DCD8E;
	Fri, 10 Apr 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838873; cv=none; b=nPx5jN7pT5k8f8+7hF1q7pkyGNoMnd3ssl91+YZF1EoQnrL6oDDBlGwDxqQ9rC1au/TugLCOnv2LF2KEflYMBCjw5hlBlnQlVST/ArlFN74H26fi8EZ+ioQlxX0up7vJk8ZyDfqCjeDhGCa+zhMu8LoCaEIQb4hZPHrIi2/zIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838873; c=relaxed/simple;
	bh=0GNmJYWWFmVhVV4nIg36bDblcBd/4S2M8hMuiDQOjUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7etfmih4Tf6udtpHtZjIqtOqDh8BMD4Su7onp1NZyJEkdhcJkj7IK2FCXbArQNHqXOmFqpHHJOuKbo09vpL/MJmm5w2Fu0MBRyBi/87LaogJrY+uLw1ZJ+BitOy4efbCT8Au0pGoBwSxhyeYKJEeQ9OlcuLyxe5wEg2mjQ/HWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6yRzHum; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6yRzHum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2098AC19421;
	Fri, 10 Apr 2026 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838872;
	bh=0GNmJYWWFmVhVV4nIg36bDblcBd/4S2M8hMuiDQOjUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6yRzHumYoqUvW46IDcJv1biGCgOPkVYHTUQJAaejVyV7yGNVQJD+bZkpzsdPp/rz
	 fDEMkqIQLmW3rSuKyrw1YbMsPwg2IqL+q9i/IaY+YrHznB2IeUwuAO7L1QnmSYtxMn
	 En1ZeXUAkbMjJ10NH+F0uKR6SiHNvRE8ATe7whYZh9bbFh2w4zGdzRo9islLpHmw+a
	 ahyobHPsqJ/PnCPQNt2AiNLrW7JKbmQSliRGjI6G1rQIJ7IpUEJgsl3DwxHmAOmaLx
	 ZtVkMqX6UXr8VzRLZtfzqZEVQ7hhWAaN1QOxNfyvtcs1LfZHwEui7WZ47ODNMdsZOX
	 khotrbWqMUKmA==
Date: Fri, 10 Apr 2026 22:04:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v4 3/4] PCI: tegra: Add Tegra264 support
Message-ID: <ukeelrtmjgxxwlkkzsojygzo6us5ijshis66a4x2a44hg4bw25@hggglahvrajy>
References: <20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com>
 <20260402-tegra264-pcie-v4-3-21e2e19987e8@nvidia.com>
 <iaoee5r5e2w52fap7ex23wdikbuvpjpesinedgjkehsedszhzo@64yoo2avmxle>
 <adTAVYEzfD9FQl8N@orome>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adTAVYEzfD9FQl8N@orome>

On Tue, Apr 07, 2026 at 11:38:28AM +0200, Thierry Reding wrote:
> On Thu, Apr 02, 2026 at 11:02:02PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Apr 02, 2026 at 04:27:37PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> > > driver is very small, with its main purpose being to set up the address
> > > translation registers and then creating a standard PCI host using ECAM.
> > > 
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > What is the rationale for adding a new driver? Can't you reuse the existing one?
> > If so, that should be mentioned in the description.
> 
> Which existing one? Tegra PCI controllers for previou generations
> (Tegra194 and Tegra234) were DesignWare IP, but Tegra264 is an internal
> IP, so the programming is entirely different. I'll add something to that
> effect to the commit message.
> 

Yikes! I completely missed that this is a non-dwc driver. Sorry for the noise.

> > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > index 5aaed8ac6e44..6ead04f7bd6e 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -254,7 +254,15 @@ config PCI_TEGRA
> > >  	select IRQ_MSI_LIB
> > >  	help
> > >  	  Say Y here if you want support for the PCIe host controller found
> > > -	  on NVIDIA Tegra SoCs.
> > > +	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
> > > +
> > > +config PCIE_TEGRA264
> > > +	bool "NVIDIA Tegra264 PCIe controller"
> > 
> > This driver seems to be using external MSI controller. So it can be built as a
> > module. Also, you have the remove() callback for some reason.
> 
> Okay, I can turn this into a tristate symbol.
> 
> > > +	depends on ARCH_TEGRA || COMPILE_TEST
> > > +	depends on PCI_MSI
> > 
> > Why?
> 
> I suppose it's not necessary in the sense of it being a build
> dependency. At runtime, however, the root complex is not useful if PCI
> MSI is not enabled. We can drop this dependency and rely on .config to
> have it enabled as needed.
> 

Yes. I think the rationale is to depend on the symbols that the driver needs for
build dependency.

> > > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> > > new file mode 100644
> > > index 000000000000..3ce1ad971bdb
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/pcie-tegra264.c
> [...]
> > > +struct tegra264_pcie {
> > > +	struct device *dev;
> > > +	bool link_up;
> > 
> > Keep bool types at the end to avoid holes.
> 
> Done.
> 
> > > +static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
> > > +{
> > > +	int err;
> > > +
> > > +	pcie->wake_gpio = devm_gpiod_get_optional(pcie->dev, "nvidia,pex-wake",
> > 
> > You should switch to standard 'wake-gpios' property.
> 
> Will do.
> 
> > > +						  GPIOD_IN);
> > > +	if (IS_ERR(pcie->wake_gpio))
> > > +		return PTR_ERR(pcie->wake_gpio);
> > > +
> > > +	if (pcie->wake_gpio) {
> > 
> > Since you are bailing out above, you don't need this check.
> 
> I think we still want to have this check to handle the case of optional
> wake GPIOs. Not all controllers may have this wired up and
> devm_gpiod_get_optional() will return NULL (not an ERR_PTR()-encoded
> error) if the wake-gpios property is missing.
> 

Ok. In that case you can just bail out:
	if (!pcie->wake_gpio)
		return 0;

> > > +static void tegra264_pcie_bpmp_set_rp_state(struct tegra264_pcie *pcie)
> > 
> > I don't think this function name is self explanatory. Looks like it is turning
> > off the PCIe controller, so how about tegra264_pcie_power_off()?
> 
> Agreed. The name is a relic from when this was potentially being used to
> toggle on and off the controller. But it's only used for disabling, so
> tegra264_pcie__power_off() sounds much better.
> 
> > > +{
> > > +	struct tegra_bpmp_message msg = {};
> > > +	struct mrq_pcie_request req = {};
> > > +	int err;
> > > +
> > > +	req.cmd = CMD_PCIE_RP_CONTROLLER_OFF;
> > > +	req.rp_ctrlr_off.rp_controller = pcie->ctl_id;
> > > +
> > > +	msg.mrq = MRQ_PCIE;
> > > +	msg.tx.data = &req;
> > > +	msg.tx.size = sizeof(req);
> > > +
> > > +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> > > +	if (err)
> > > +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %pe\n",
> > 
> > Why not dev_err()?
> > 
> > > +			 pcie->ctl_id, ERR_PTR(err));
> > > +
> > > +	if (msg.rx.ret)
> > > +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %d\n",
> > 
> > Same here.
> 
> These are not fatal errors and are safe to ignore. dev_err() seemed too
> strong for this. They also really shouldn't happen. Though I now realize
> that's a bad argument, or rather, actually an argument for making them
> dev_err() so that they do stand out if they really should happen.
> 
> > 
> > > +			 pcie->ctl_id, msg.rx.ret);
> > > +}
> > > +
> > > +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> > > +{
> > > +	u32 value, speed, width, bw;
> > > +	int err;
> > > +
> > > +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> > > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> > > +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> > > +
> > > +	bw = width * (PCIE_SPEED2MBS_ENC(speed) / BITS_PER_BYTE);
> > > +	value = MBps_to_icc(bw);
> > 
> > So this becomes, 'width * (PCIE_SPEED2MBS_ENC(speed) / 8) * 1000 / 8'. But don't
> > you want, 'width * (PCIE_SPEED2MBS_ENC(speed)) * 1000 / 8'?
> 
> This is M*B*ps_to_icc(), not M*b*ps_to_icc(), so we do in fact get the
> latter. I almost fell for this as well because I got confused by some of
> these macros being all-caps and other times the case actually mattering.
> 

Oops, I was misleaded too. But you can simply do:
	bw = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(speed));

> > > +	err = icc_set_bw(pcie->icc_path, bw, bw);

And here you were setting the MBps, not Kbps.

> > > +	if (err < 0)
> > > +		dev_err(pcie->dev,
> > > +			"failed to request bandwidth (%u MBps): %pe\n",
> > > +			bw, ERR_PTR(err));
> > 
> > So you don't want to error out if this fails?
> 
> No. This is not a fatal error and the system will continue to work,
> albeit perhaps at suboptimal performance. Given that Ethernet and mass
> storage are connected to these, a failure to set the bandwidth and
> erroring out here may leave the system unusable, but continuing on would
> let the system boot and update firmware, kernel or whatever to recover.
> 
> I'll add a comment explaining this.
> 

Yeah, that'll help.

> [...]
> > > +static void tegra264_pcie_init(struct tegra264_pcie *pcie)
> > > +{
> > > +	enum pci_bus_speed speed;
> > > +	unsigned int i;
> > > +	u32 value;
> > > +
> > > +	/* bring the link out of reset */
> > 
> > s/link/controller or endpoint?
> 
> This controls the PERST# signal, so I guess "endpoint" would be more
> correct.
> 

Yes!

> > > +	value = readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> > > +	value |= XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
> > > +	writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> > > +
> > > +	if (!tegra_is_silicon()) {
> > 
> > This looks like some pre-silicon validation thing. Do you really want it to be
> > present in the upstream driver?
> 
> At this point there is silicon for this chip, but we've been trying to
> get some of the pre-silicon code merged upstream as well because
> occasionally people will want to run upstream on simulation, even after
> silicon is available. At other times we may want to reuse these drivers
> on future chips during pre-silicon validation.
> 
> Obviously there needs to be a balance. We don't want to have excessive
> amounts of code specifically for pre-silicon validation, but in
> relatively simple cases like this it is useful.
> 

Ok, fine with me.

> > 
> > > +		dev_info(pcie->dev,
> > > +			 "skipping link state for PCIe #%u in simulation\n",
> > > +			 pcie->ctl_id);
> > > +		pcie->link_up = true;
> > > +		return;
> > > +	}
> > > +
> > > +	for (i = 0; i < PCIE_LINK_WAIT_MAX_RETRIES; i++) {
> > > +		if (tegra264_pcie_link_up(pcie, NULL))
> > > +			break;
> > > +
> > > +		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
> > > +	}
> > > +

[...]

> > > +	pm_runtime_get_sync(dev);
> > > +
> > > +	/* sanity check that programmed ranges match what's in DT */
> > > +	if (!tegra264_pcie_check_ranges(pdev)) {
> > > +		err = -EINVAL;
> > > +		goto put_pm;
> > > +	}
> > > +
> > > +	pcie->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
> > > +	if (IS_ERR(pcie->cfg)) {
> > > +		err = dev_err_probe(dev, PTR_ERR(pcie->cfg),
> > > +				    "failed to create ECAM\n");
> > > +		goto put_pm;
> > > +	}
> > > +
> > > +	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> > > +	bridge->sysdata = pcie->cfg;
> > > +	pcie->ecam = pcie->cfg->win;
> > > +
> > > +	tegra264_pcie_init(pcie);
> > > +
> > > +	if (!pcie->link_up)
> > > +		goto free;
> > 
> > goto free_ecam;
> 
> It's not clear to me, but are you suggesting to rename the existing
> "free" label to "free_ecam"? I can do that.
> 

Yeah, I was just asking for a rename.

> > > +	err = pci_host_probe(bridge);
> > > +	if (err < 0) {
> > > +		dev_err(dev, "failed to register host: %pe\n", ERR_PTR(err));
> > 
> > dev_err_probe()
> 
> Okay.
> 
> > 
> > > +		goto free;
> > > +	}
> > > +
> > > +	return err;
> > 
> > return 0;
> 
> Done.
> 
> [...]
> > > +static int tegra264_pcie_resume_noirq(struct device *dev)
> > > +{
> > > +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> > > +	int err;
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
> > > +
> > > +	tegra264_pcie_init(pcie);
> > > +
> > 
> > Why do you need init() here without deinit() in tegra264_pcie_suspend_noirq()?
> 
> That's because when we come out of suspend the link may have gone down
> again, so we need to take the endpoint out of reset to retrigger the
> link training. I think we could possibly explicitly clear that PERST_O_N
> bit in the PERST_CONTROL register in a new tegra264_pcie_deinit() to
> mirror what tegra264_pcie_init() does, but it's automatically done by
> firmware anyway, so not needed.
> 

Hmm, so firmware asserts PERST# at the end of suspend? It is not clear to me why
it is doing so. But for symmetry I'd like to do it in tegra264_pcie_deinit().

Also, I'm not certain about the 'pcie->link_up' check here. If it is 'false',
then probe() should've failed. So why do you need the check here anyway?

Maybe you should get rid of this check and return the link status from
tegra264_pcie_init() directly?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
