Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5A2772D;
	Wed, 10 Jun 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111506; cv=none; b=Z9394Tt80PIhAYg6Kif2e9h1THUaYCYBju3FF15DIPtmoYMH06OvnWFzh/ZpDQqKSDi1Hb24dt3ibIV/mkigJGqb8/i8XBOKm87NkoVGkJmfNs+eU0Bz7qxqhyiMQJdoSkoYsHFI0b8zp7XajJR8iPpOiko8xVTEMmHzZoc8Zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111506; c=relaxed/simple;
	bh=g0lPI33FFStkDP5akD+vHEUI6PMrKVCDJLQoCFxxA3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5hYQMKeylCVA76eSmNV6BJHI4ar53ESigXqys/xXNa15FclRPibtyelNtG6KOiJ7urYgxNI+aWmnAguVlNrO06HSStGXNQlI51z4OuCjgX29jTSjE00hUWeCxWbz9nj29LtaMtMZE0EM7per8uZ9Wd6lecF9/+OdU1u6iFx2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShkatzLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShkatzLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742A71F00893;
	Wed, 10 Jun 2026 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111505;
	bh=6+Dicx3yBkDHwtXXRtcAYCHgv9tNUOFr3xgglRO7RnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ShkatzLGlQ5IBc5D2gHFyPodsfO1EcWA4dn0TvBIIP9U3u4rkwDzx+LKdO8F7QQ1s
	 OrGCyOZpEiZfMSGK7Ct//XiX/9SX9rEwTY7ezZ5DZIQauTGMljklOsN+XVHahpdf7d
	 5Z2gbcBKb1MIltXqd0N7xV/FzVeoWKAK/kxFAEje3qXthEyNhPNkBZrhRGX5idtvIy
	 4OMMFKhvvbS9poYHFrUNSngdaLy3y8UbdnAsO1l/qcqxoBTYiQwTrydTYyWOT//6ZZ
	 Et447+DfPkoapV+tU/rWqv0PR8OBQCltMunnknbtlUlv4pR1xFKmanaQ7jZiXdbkXD
	 vMd9bR79xf/fw==
Date: Wed, 10 Jun 2026 19:11:39 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	sashiko-reviews@lists.linux.dev
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Message-ID: <orrpfub5f2hkrgkmxrdtykhzmxyuclnky4dn6vnz3cgvvbdcvb@5altvzufcq53>
References: <20260519195219.189323-1-marek.vasut+renesas@mailbox.org>
 <20260519202037.8BD001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519202037.8BD001F000E9@smtp.kernel.org>

On Tue, May 19, 2026 at 08:20:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Dynamically modifying a device's Max_Payload_Size (MPS) in the enable_device hook breaks PCIe fabric consistency and causes Malformed TLP errors.
> - [High] Endpoint drivers can bypass the Max_Read_Request_Size (MRRS) limitation because the bridge's no_inc_mrrs flag is not set.
> - [Medium] Ignoring the return values of pcie_set_mps() and pcie_set_readrq() allows devices to operate in an unsafe state if the limits cannot be applied.
> --
> 
> commit a6b8290401b7fa98e699e975574f47bfb1d20609
> Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> PCI: rcar-gen4: Limit Max_Read_Request_Size and Max_Payload_Size to 256 Bytes
> 
> This patch introduces a workaround for an R-Car Gen4 PCIe controller 
> hardware limitation where the Max_Payload_Size (MPS) and 
> Max_Read_Request_Size (MRRS) must not exceed 256 bytes. It implements 
> an enable_device hook to force limit these values to prevent data 
> corruption with certain NVMe SSDs.
> 
> Cc: stable@vger.kernel.org
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > index 8b03c42f8c84c..9fe34ca7ce532 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> [ ... ]
> > +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
> > +					struct pci_dev *dev)
> > +{
> [ ... ]
> > +	if (pcie_get_mps(dev) > 256) {
> > +		pci_info(dev, "Limiting MPS to 256 bytes\n");
> > +		pcie_set_mps(dev, 256);
> 
> [Severity: High]
> Will modifying the Max_Payload_Size locally in the enable_device hook 
> desynchronize it from the rest of the PCIe fabric? 
> 
> The PCIe specification and Linux PCI core generally manage MPS uniformly 
> across the hierarchy during boot via pcie_bus_configure_settings(). 
> Because this hook runs later during driver probe via pci_enable_device(), 
> if the upstream Root Port or Switch retains a larger MPS and transmits a 
> TLP exceeding 256 bytes, could the downstream device drop it as a Malformed 
> TLP and cause a fatal link error? 
> 
> Would it be safer to restrict the Root Port's MPS capabilities before 
> enumeration so the core logic correctly scales the entire fabric?
> 

Marek, you said that Root Port's MPSS is fixed to 256B. So this means, PCI core
will only set the endpoint's MPS to <=256B. So I don't see a need to limit MPS
here.

> > +	}
> > +
> [ ... ]
> > +	if (pcie_get_readrq(dev) > 256) {
> > +		pci_info(dev, "Limiting MRRS to 256 bytes\n");
> > +		pcie_set_readrq(dev, 256);
> > +	}
> > +
> > +	return 0;
> 
> [Severity: Medium]
> Should the return values of pcie_set_mps() and pcie_set_readrq() be 
> checked and propagated here? 
> 
> Both functions can return negative error codes on failure. By ignoring 
> these return values and unconditionally returning 0, the device could 
> be fully enabled even if the configuration writes fail, leaving the system 
> silently vulnerable to the data corruption described in the commit message.
> 

I don't think this function call can fail.

> > +}
> > +
> >  /* Host mode */
> >  static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> > @@ -313,6 +361,9 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
> >  	int ret;
> >  	u32 val;
> >  
> > +	if (pp->bridge)
> > +		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
> 
> [Severity: High]
> Could endpoint drivers (like high-performance network or storage drivers) or 
> userspace via sysfs subsequently increase the MRRS above 256 bytes? 
> 
> Because the host bridge's no_inc_mrrs flag is not set, a downstream 
> driver can call pcie_set_readrq() and silently bypass this workaround, 
> re-enabling the data corruption vulnerability. 
> 
> Should pp->bridge->no_inc_mrrs = 1 be set during this initialization 
> to enforce the limit permanently?
> 

This is a valid concern. I believe you should set 'pp->bridge->no_inc_mrrs = 1'
in the Rcar driver to prevent client drivers from increasing MRRS.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
