Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97A238166;
	Wed, 29 Jul 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335176; cv=none; b=nBcfhXTixBf2EQxDz6vo0+vUCzPKZedMwu28mI/Uj2+IqCUgx8KQPg3c3HvrUExpobKA8GodO2xozyjO2oomxMNn7Uk4g+eNwdrqwtStwV65j2VEX9RJogwCsXYy1I/O54hxcLWQyJO1OhHHWpU1zul+WKhTHEaPF9QXTcB/GbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335176; c=relaxed/simple;
	bh=yFlXnG0ur/Otw0N6Nkkw8CSvjnpqzUz/IXWbJov3m+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvMrn8aEt1b21MtIX3ac5NXUatWSn97s7yBVwcJZclZex1AmfScFRnRznUKmlkKOD3uZNJYpJcx3zy3LmZXN5vZELnIzje5UeqtuXRQCMhSot66AxFZggq3xKbguxWgeyBWJu2AVwwstHq0woyR35Urjtu86NZ4LXf0p+vRu3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwwYyVBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwwYyVBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC6E1F000E9;
	Wed, 29 Jul 2026 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785335175;
	bh=gGSf24Anm/3gY02Cfg9fyD38hHxiAaKDsAJVM7+eVI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FwwYyVBCB0W6Z2ZQsGNJEf7ezaOW0YoMC8J7BRn0baHpwWDfv793TrivO+ecmMldS
	 jghDuubuo0DDNoRYKMQZMdOdpb86Pi/0CfAEpJClu5Rsm+tjg187XKarU8KjZd8+9Q
	 qelGYnxPLursQGH0hFjF85QsR/CW/IW2WhSMQZ7L51QpRoEzMR6MFuhvSmZycqEtJJ
	 4lBUZSdiUUp8Z7ZVVlD4eehdWrhaSfvsR+XMlLVV7EhCQeD1WEPlnjfQnvl0cxfzRa
	 HMsv4HlxmI1l8ilLze62+LqCecxaknld6UOM604kyRD4oeOdUBV9tX29A9lDQqSiOo
	 cfhbJIyCzPkJQ==
Date: Wed, 29 Jul 2026 16:26:04 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Aksh Garg <a-garg7@ti.com>
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
Message-ID: <nhl5l745nomss74qguitht3xy6skebmpfzngl5nmmqvaen74w5@agnwbcj67xbb>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-4-23e51589229b@nvidia.com>
 <063777d8-cd4d-43cc-8f65-102191848c9d@nvidia.com>
 <amd8FoDqTNV2z2vM@orome>
 <a12ed6d2-ceca-496b-b104-aa669cace5cd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a12ed6d2-ceca-496b-b104-aa669cace5cd@nvidia.com>

On Tue, Jul 28, 2026 at 09:25:17AM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 27/07/26 9:14 pm, Thierry Reding wrote:
> > > > +static int tegra264_pcie_suspend(struct device *dev)
> > > > +{
> > > > +	/*
> > > > +	 * No need to do anything device-specific here, BPMP handles the
> > > > +	 * details of taking the link into L2.
> > > > +	 */
> > > > +
> > > > +	return pinctrl_pm_select_sleep_state(dev);
> > > > +}
> > > > +
> > > > +static int tegra264_pcie_resume(struct device *dev)
> > > > +{
> > > > +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> > > > +	int err;
> > > > +
> > > > +	err = pinctrl_pm_select_default_state(dev);
> > > > +	if (err < 0) {
> > > > +		dev_err(dev, "failed to configure sideband pins: %pe\n",
> > > > +			ERR_PTR(err));
> > > > +		return err;
> > > > +	}
> > > > +
> > > > +	tegra264_pcie_init(pcie);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static DEFINE_SIMPLE_DEV_PM_OPS(tegra264_pcie_pm_ops,
> > > > +				tegra264_pcie_suspend,
> > > > +				tegra264_pcie_resume);
> > > PCI subsystem registered pm_noirq callbacks. So, controller should also
> > > register to pm_noirq callbacks.
> > Unfortunately that causes illegal uses of msleep() in no-IRQ context.
> > Sashiko complains about it and is right. I don't observe any runtime
> > issues with switching to the _noirq variants, but it doesn't seem right
> > to stick to it.
> > 
> > Is there any reason why this needs to be _noirq, or any benefits if it
> > was?
> > 
> > Thierry
> 
> The PCI subsystem registers pci_pm_resume_noirq() as a noirq resume
> callback. This function accesses PCI configuration space to transition the
> device from D3hot to D0. Therefore, the controller driver must first bring
> the PCIe controller out of reset and make its configuration space accessible
> to the PCI subsystem.
> 
> Many other controller drivers in drivers/pci/controller/ are registering
> noirq callback.
> 

Since the PCI client drivers use noirq callbacks, they would expect the device
to be accessible by the time the callbacks get executed. But if the controller
driver disables the resources or puts the devices into D3Cold in regular suspend
callback, then it will cause the client driver to fail or even crash.

This is why it is recommended to use noirq callbacks in controller drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
