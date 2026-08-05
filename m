Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1247CA8A;
	Wed,  5 Aug 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945078; cv=none; b=Lhm/4aRC5hyyygtmeobTTklt158uw6bW8Y2QmzpA80XlfBMwPEdr11HTCpNutMCzme1IMqWHUxqO6oQ4pNfhmFNPGXm0BdUR1npLEjm7pC5p5p1BCKgGW49MyzNEEQuFCPG+fbqgxGsxrE/UPokbbTUkv1UB60zbjOLqWIaw60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945078; c=relaxed/simple;
	bh=yOHojtbsy7asVZONusiKHGghzG0ww997+oWVpPx8PRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd5MuJwNCY7EehnkFziMQiPtCUAMMgswmoOjdEIxcAmujoBLyUReksw4gGnFhiccLKvB1cFfCFmXOxvCJvCe7TliuDKGsFSCkZffcIlkHC7m529IVmWmAo68/i1YMAxfKIZo6nD293JWBgoWVkBuJ26HGyv8ZIO4RjzVhgqbO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv8YZNOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv8YZNOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8191F000E9;
	Wed,  5 Aug 2026 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785945076;
	bh=c9MHgAu1BNJWML3hh9rzfWyC7GeIWT1JJVI3P1bX+C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dv8YZNOSek5XxHmILrO3OB8qkT7s6kPVgbfprX49cdT+tOKloB2Gn+17ogK3m1zKS
	 2dVhu/MYpg2mJlTaNFn85Vjpgxwwt+nS2hQL+tZ6OcdkkycbgxyfqlYkhaeea4IcJu
	 6iV6IuFkzbgOgeb10g1NfFRwJ8ofU739irmY3Wn3ZRsfHPGv1c5mrqRBN5aDWQEQMK
	 NIDs2H5iiYysakwTUye09xYXk0J42dKgZUpvCyKoowdLPWDksA8eRTiklVmdv2ejM4
	 TGFPZ+985BLAf5XjOQ8TU4RaX7lXicn9U9lf76U/UXFxIsVX8TlvsS0Ejzv5KFlwsu
	 BujI5xl1zeRXg==
Date: Wed, 5 Aug 2026 17:51:06 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Thierry Reding <thierry.reding@kernel.org>, linux-pci@vger.kernel.org, 
	conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support
Message-ID: <sdpakcbeferzpxn6bf2acic4kfnfoaa6kgxmmi3asw7jqprekf@66cnwvuwk4ye>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-3-fa2ed7350ae1@nvidia.com>
 <20260805121039.A79921F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805121039.A79921F00A3A@smtp.kernel.org>

On Wed, Aug 05, 2026 at 12:10:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The driver incorrectly accesses the ECAM window via `pcie->cfg->win` to read the root port configuration space, causing an out-of-bounds heap read on 32-bit platforms.
> - [High] The driver incorrectly uses the Negotiated Link Width (NLW) to set interconnect bandwidth for hotplug-capable ports when the link is down, permanently setting it to 0.
> --
> 
> --- Patch [3]: [PATCH v9 3/5] PCI: tegra: Add Tegra264 support ---
> commit af63006f768e2991e49a48de9855ea58d20662ed
> Author: Thierry Reding <treding@nvidia.com>
> 
>     PCI: tegra: Add Tegra264 support
>     
>     Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
>     driver is very small, with its main purpose being to set up the address
>     translation registers and then creating a standard PCI host using ECAM.
> 
> > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> > new file mode 100644
> > index 0000000000000..e0c5b9d0d20bf
> > --- /dev/null
> > +++ b/drivers/pci/controller/pcie-tegra264.c
> [ ... ]
> > +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> > +{
> > +	u32 value, speed, width;
> > +	int err;
> > +
> > +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> > +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> > +
> > +	value = Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]));
> 
> [Severity: High]
> Will this permanently set the interconnect bandwidth to 0 for hotplug-capable
> ports if the link is initially down?
> 
> When the link is down, the Negotiated Link Width (NLW) is 0, which means
> the bandwidth value will be calculated as 0. Since the generic pciehp driver
> handles hotplug but doesn't know about this driver's specific interconnect
> bandwidth requirements, it appears there is no way to dynamically increase
> the bandwidth later when a device is actually inserted.
> 

I think this is a valid concern. If the ICC BW is set to 0, then the hotplugged
device won't work properly.

> Should this read the Maximum Link Width and Speed from PCI_EXP_LNKCAP
> instead of PCI_EXP_LNKSTA to properly reserve bandwidth for a hotplug slot?
> 

If possible, BW should be updated once the device is added, but that requires
detecting Link Up using some custom IRQ if available.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
