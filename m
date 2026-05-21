Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8F37DEB7;
	Thu, 21 May 2026 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381578; cv=none; b=WdN/f0yifjHbAurW9R0BCFljH9ccoCxtHp8yQvfFdJAaaektVceHtVcICr9Mfqi8nJVUullIPCgM71fRcL2EFgC7P++4aobeNpDtTHWp/qzKb4KkY/DQNTbMyWtkR5vROfp+BgBcqCOAJrLwsTDdlNjDNOuaOQLRJVOQLGZ+rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381578; c=relaxed/simple;
	bh=n3MuwHapM/hrBODI2X5tV07YNVPlsrN5A5CvPe5jga4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C8E0dPFNXcvpA03MR20MtyKA9XSfc4OnhH15Y/EnOUiDgJCZU7+1wDo6+3VS6fK/BY/lcfmSoRoeZoNpMUhjAyZfvCKj51X1gU8RcNBzoDdXBWVE2u6NcIVmGLOAVybCEw8y23MsUw3pKZMRoas5ReBmRgKPCjLsudmIfAbW92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clIereZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clIereZg"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D18C71F000E9;
	Thu, 21 May 2026 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779381577;
	bh=2a6wwPpW1ojECBUISg/hzE0ca4S14xjGEKu518bKBiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=clIereZgjuHtoej9f7GxvzvbO0q0gsqdB7mQspBJcHD2sxkNEY1ulMsi/zCb9rEPg
	 VM/0t0q8028Z/Gt3Gx9Q/hukjwLkX2Co7L2UeOLjZR9qImv+AqLvU2MHH6l/1tP2Kg
	 HwqPaVLykrNrAsQ3IFpPrCB0OJmYe3xO52vwaf0iSYQGrXnNtFsp37lI2ePk9WZogO
	 XCXC8o8cJSnkJwttpa5JsCCk/83yrktLY5fX3LDpq/ey9K2hNX/1D/I/5gL3drsxbM
	 mifICOQlzA8YCDzf13/7U5wmIAJXX+TZw5/c/QIzzakvB7G4K+flOgQoZO0iEud0Wo
	 WjVn3ukIrnRDw==
Date: Thu, 21 May 2026 11:39:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qiang Ma <maqianga@uniontech.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VPD: Disable VPD for Lenovo Realtek RTL8111xP devices
Message-ID: <20260521163935.GA169388@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521094138.1634411-1-maqianga@uniontech.com>

On Thu, May 21, 2026 at 05:41:38PM +0800, Qiang Ma wrote:
> The Lenovo 17aa:507e RTL8111xP multi-function device exposes a VPD
> capability on all functions, but the VPD storage is not usable.
> Function 0 returns an invalid first tag and functions 1-4 never complete
> VPD transactions.

"Lenovo 17aa:507e" suggests that this affects Vendor ID Lenovo and
Device ID 0x507e, but those are actually the *Subsystem* IDs.

It seems likely that the problem is with the way the device is
integrated into Lenovo systems, but the primary hook here is the
PCI_VENDOR_ID_REALTEK and 0x8168 etc., so I think we should say
something like:

  When integrated into some Lenovo systems, the Realtek RTL8111xP
  multi-function device advertises invalid VPD Capabilities.

> This produces noisy dmesg output when userspace reads the VPD sysfs
> attribute, including:
> 
> [   16.654155] r8169 0000:02:00.0: invalid VPD tag 0x00 (size 0) at offset 0; assume missing optional EEPROM
> [   16.790913] serial 0000:02:00.1: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
> [   16.931963] serial 0000:02:00.2: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
> [   17.071445] pci 0000:02:00.3: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update
> [   17.210910] ehci-pci 0000:02:00.4: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

Timestamps are pointless distraction here.  Drop them and indent the
quoted material two spaces.  Two lines is probably enough.

> VPD is optional. Disable VPD for this exact subsystem and revision so the
> PCI core does not expose a broken VPD sysfs file that cannot be read.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  drivers/pci/vpd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 153394a652d3..492e0d669ea8 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -597,6 +597,32 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd
>  DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031,
>  			       PCI_CLASS_BRIDGE_PCI, 8, quirk_blacklist_vpd);
>  
> +/*
> + * The Lenovo 17aa:507e RTL8111xP multi-function device advertises VPD
> + * on all functions, but the VPD data is not usable.  Function 0 returns
> + * an invalid first tag and functions 1-4 never complete VPD accesses.

Same here.  It's a Realtek device that happens to be integrated into
some Lenovo platforms.

> + */
> +static void quirk_lenovo_realtek_rtl8111xp_no_vpd(struct pci_dev *dev)
> +{
> +	if (dev->revision != 0x0e ||
> +	    dev->subsystem_vendor != PCI_VENDOR_ID_LENOVO ||
> +	    dev->subsystem_device != 0x507e)
> +		return;
> +
> +	dev->vpd.len = PCI_VPD_SZ_INVALID;
> +	pci_warn(dev, FW_BUG "disabling VPD access (can't determine size of non-standard VPD format)\n");
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8168,
> +			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816a,
> +			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816b,
> +			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816c,
> +			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x816d,
> +			 quirk_lenovo_realtek_rtl8111xp_no_vpd);
> +
>  static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
>  {
>  	int chip = (dev->device & 0xf000) >> 12;
> -- 
> 2.20.1
> 
