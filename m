Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C3434408;
	Fri, 18 Sep 2026 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752609; cv=none; b=FswZJU9oOHjgtJrfu4De7wBd1DAnO8Z06MyWNMsjlKtbgCj894K/7O692RSMPLZMWdZA22DkL3xikJ7cP01k4xqWnpgjflWCCOM+0R2nIqGDJ6UVAWDUgk7c4glUmf5l5AIxZLrSUQydFqb2Rl0sOw1WSWKKoxsFMfsHl3OI5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752609; c=relaxed/simple;
	bh=x8wldGWyyWMnCdarHhJEE25eWE8oOrYPjZIjxCuS3mg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kDcWU+G2u7HAfpa9GC6LkW2uLXIf7ep+0lYxsMeYYZG87NAAuSRYdC0X43dyTjojdrl09vevB8Jk4ydlFxYO8XzcYUTwace4GEpKH9aqSwDKbFX+vgvxqVki7Ixa3EnVZagACkiYRRRG9jCycpGyLSfbnGzybjpG2omG7z8RS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8BvtwGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8BvtwGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ED71F00899;
	Fri, 18 Sep 2026 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752605;
	bh=GYT0EMLGU7b7a+ogC9A2xX9O2g8gH12f0FUa3uckf9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=A8BvtwGRXq3vPV2/CyMddj0V1n/JQHEh25sEotzwKQuZ1HzEapSyd2q1JC67j+cKp
	 +ju2TqnulTVTZ7BK9FlxDQqR3fgYy6w7c7434tsCd0ql+3o98zWFovv+Vv0RXfysjE
	 A6CfgQnUQY1ZyyO6rg4URqTaakH0iGtZV86SPPSUPszW4z/LNreRwMmfAFassQ97De
	 APwq+KOwFr5qZMbkfhlmk0W4Mpr0m0SAG7BgDemwpJTbpeRUbKzMLTYxh+WBH4wvqR
	 VU8eWoXudlUHxdram+Q0/iUj8rPzVHoO4vaTxXZiRcX/f2GepNwHUJ1inD0hmxlAqX
	 iqjz5hZtRINYQ==
Date: Fri, 18 Sep 2026 12:30:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, bhelgaas@google.com,
	andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
	daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH v4 2/3] misc: tc9564: introduce base PCI driver
Message-ID: <20260918173003.GA1166280@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918152659.413268-3-elder@riscstar.com>

[+cc Andrea, Herve, Lizhi for of_pci_make_dev_node() quirks]

On Fri, Sep 18, 2026 at 10:26:57AM -0500, Alex Elder wrote:
> The Toshiba TC9564 is small and highly-specialized SoC that implements
> a PCIe switch as well as an Ethernet AVB/TSN bridge.  In addition to
> these, the SoC implements other functions, including a reset and clock
> controller, an address translation unit, and a few other devices.  PCIe
> BARs provide access to registers that manage these IP blocks, and the
> SoC is modeled using a PCI endpoint bus in devicetree.  This allows the
> IP blocks to be bound to platform drivers that do MMIO via the PCI BARs.
> 
> Create a new PCI driver under drivers/misc that binds with the embedded
> PCI endpoint functions within the TC9564 SoC.  Because these functions
> will use devicetree pci-ep-bus to provide access to other IP blocks
> within the TC9564 chip, the main purpose of this driver is to do basic
> PCI initialization, then call of_platform_default_populate() to scan for
> the any endpoint bus children, and probe all devices defined therein.
> 
> Because we're using pci-ep-bus, we need to use the PCI quirks mechanism
> to have of_pci_make_dev_node() be called for each endpoint device in
> pci_bus_add_device() (via pci_fixup_device(pci_fixup_final, dev)).
> 
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# quirks.c

Not an issue for this patch, but I'm not sure the quirk mechanism is
the best mechanism for doing this.  It's not working around a device
defect like most quirks do.

I wonder if pci_bus_add_device() should unconditionally call a wrapper 
that calls of_pci_make_dev_node() for bridges and any device that
appears in an allow-list.  I guess it sort of amounts to the same
thing in the end, but it might be a little more explicit and not
subject to CONFIG_PCI_QUIRKS.

> +++ b/drivers/pci/quirks.c
> @@ -6391,6 +6391,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
>  
>  /*
>   * Devices known to require a longer delay before first config space access
> -- 
> 2.53.0
> 
