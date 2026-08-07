Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E13F39FF;
	Fri,  7 Aug 2026 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080029; cv=none; b=OYUuSB4mpmFk3VTZopSmCd+KBCYLVCeDR12BeQ30d9O9p43drKhAlMxtEaPFhFTgDve/rIMYmqI4xBgOuxds8SqN4UITKeszSxCK85o44p6ccixzWXyNBXlTyrqu9EyJkMSqixZNpdXV95eEnd3d+09sFIEEiQIRJrtiYR8wuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080029; c=relaxed/simple;
	bh=gcVMBKePjvoLma3pUiI9XIayU3YaiGEgoyKCSpWOliM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIn9AGLlkStLzp+e37ocaApAptcGK56B1Arqt2IjQ1lDKbhaHV2S9r1CyEHjM4x82aP+1LE0SORJi/oYRcn9E0XbC8AQAOslARvEstBs5q8lbAqun0DJpEfdWejcj9kUi+dY1L6PvpsnpXVUqjtQ40lU0sZQAg2vbLFMGVoKNLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN9cwaix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN9cwaix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A931F000E9;
	Fri,  7 Aug 2026 05:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786080014;
	bh=+KtEZyQf0X70BuqHmgO5EuQqaCcj/hmsg61NBYDnlPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oN9cwaixhVG7q+WqTwISJOGan4fULIYIxOo9sWbAxUqYRNTYfzKPVR5TsJEBilcFI
	 rYMn107SYaX4kEF5hSBGZ4cXMrcvkmD3N8MwuZ/bkFQcinzs+ftmCIw+8xNy0SWMdn
	 NJiWxXcPOBamwUMvN4AXynBUEtfG6AhMTR9ZMOrHT/rVFSAp5v3iheubguupKA/F2v
	 iqVWShd/kWfuzX99Qt2qA/BCxv6xnEoBjK8TXq9eeSZ9B4LDbMatFv2C276wsuIiIu
	 9OOVrqJi6FEj4sGVY+xQ8PdpZu1hAHfigQXCHTbgjALUoUeaJRqs9025RblUxnNqWO
	 kSTHpSTREL9dg==
Date: Fri, 7 Aug 2026 07:19:57 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, 
	Thierry Reding <thierry.reding@kernel.org>, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support
Message-ID: <lgtaaastqoikhq2btjqgnlqml35phsevfykuf6ernmd2hz2lmz@wsx62f3pvzpx>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-3-fa2ed7350ae1@nvidia.com>
 <20260805121039.A79921F00A3A@smtp.kernel.org>
 <sdpakcbeferzpxn6bf2acic4kfnfoaa6kgxmmi3asw7jqprekf@66cnwvuwk4ye>
 <9cc29a0b-6a9c-4b97-9cfd-f24ccad654fc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cc29a0b-6a9c-4b97-9cfd-f24ccad654fc@nvidia.com>

On Fri, Aug 07, 2026 at 10:35:30AM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 05/08/26 9:21 pm, Manivannan Sadhasivam wrote:
> > On Wed, Aug 05, 2026 at 12:10:38PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > - [High] The driver incorrectly accesses the ECAM window via `pcie->cfg->win` to read the root port configuration space, causing an out-of-bounds heap read on 32-bit platforms.
> > > - [High] The driver incorrectly uses the Negotiated Link Width (NLW) to set interconnect bandwidth for hotplug-capable ports when the link is down, permanently setting it to 0.
> > > --
> > > 
> > > --- Patch [3]: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support ---
> > > commit af63006f768e2991e49a48de9855ea58d20662ed
> > > Author: Thierry Reding <treding@nvidia.com>
> > > 
> > >      PCI: tegra: Add Tegra264 support
> > >      Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> > >      driver is very small, with its main purpose being to set up the address
> > >      translation registers and then creating a standard PCI host using ECAM.
> > > 
> > > > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> > > > new file mode 100644
> > > > index 0000000000000..e0c5b9d0d20bf
> > > > --- /dev/null
> > > > +++ b/drivers/pci/controller/pcie-tegra264.c
> > > [ ... ]
> > > > +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> > > > +{
> > > > +	u32 value, speed, width;
> > > > +	int err;
> > > > +
> > > > +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> > > > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> > > > +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> > > > +
> > > > +	value = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));
> > > 
> > > [Severity: High]
> > > Will this permanently set the interconnect bandwidth to 0 for hotplug-capable
> > > ports if the link is initially down?
> > > 
> > > When the link is down, the Negotiated Link Width (NLW) is 0, which means
> > > the bandwidth value will be calculated as 0. Since the generic pciehp driver
> > > handles hotplug but doesn't know about this driver's specific interconnect
> > > bandwidth requirements, it appears there is no way to dynamically increase
> > > the bandwidth later when a device is actually inserted.
> > > 
> > 
> > I think this is a valid concern. If the ICC BW is set to 0, then the hotplugged
> > device won't work properly.
> > 
> > > Should this read the Maximum Link Width and Speed from PCI_EXP_LNKCAP
> > > instead of PCI_EXP_LNKSTA to properly reserve bandwidth for a hotplug slot?
> > > 
> > 
> > If possible, BW should be updated once the device is added, but that requires
> > detecting Link Up using some custom IRQ if available.
> > 
> > - Mani
> > 
> 
> Custom IRQ support for link up and down events is not available in this IP.
> For now, we have two options:
> 
> 1. Don’t set ICC BW for the hot-plug controller.
> 
> 2. Set ICC BW according to the Link Cap settings when the link is down and
> it is a hot-plug controller. When the link is up, use the Link Status
> settings.
> 
> We can get changes in link speed/width from the BW notification status.
> IIRC, the BW notification port driver has been reverted. If it comes back,
> we can consider integrating the ICC BW set logic into it instead of
> implementing it in each controller driver.
> 

Yeah sure. Option 2 sounds sensible to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
