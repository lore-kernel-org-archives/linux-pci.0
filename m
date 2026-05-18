Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B352494D8;
	Mon, 18 May 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124564; cv=none; b=SDqopOFxdM7RuWnuDdWh1GkiwEYM1x99skL2UWAl6QF2UnhBjpUtcOF+b7l5iSX6j9DVVxAhMjthdLrZ1OLnEVH/5/O0Oz85ZRy3CI+eKvTY+KRPGRnBAK3Kj/UCgEpgo856TRdipZGxz2ZecGl5Ohyv0uxRt/0xkSgoUDRH/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124564; c=relaxed/simple;
	bh=ltw+MBUsozEFsHhnuh3NDNvRxc/gxh9k/yfsr8FqJWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaWGmoFW9di9jscULC0ifXRC30p/Mebx5gOFzMXKZ+zySq7Ecp/ZDc8VVsy9c6z/qRrZXR9sBHQnSd3oxlM/FTD4hQcFUQS+DA0zfu1MGrfoyPf8fOxhl4Lgh/iLzK9F45YXLW9DH2J1Ehzxvz3bDAmySF3+EoqSCUCEc1ghZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=yWPDVs08; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=poopsm07; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="yWPDVs08";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="poopsm07"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70DE27A00BC;
	Mon, 18 May 2026 13:16:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 13:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779124560;
	 x=1779210960; bh=0vhcXeLYKKSuo11LoXLfb6OBiyx8QacR2oJ/fQatqhU=; b=
	yWPDVs08mFEQgMqDKRj3RuuiTCYVROe1tYyGHyg+wCtI/CuSCbYGla09ZhtFHevi
	hfwjUiXdJF6F4kf9QOGfWiYp2hde6eDZ3FnMsgKRO16dOrbhH0sssJZhd16aG55U
	magITZ+CSDB1Q81j0btwUl1k73all6u5yNPTUgd1TrVrP4uzVkJS3owOXk5Kdri5
	59lYHzmIEXilegu0rGoitG20sMrxoDroWi2Ozgg7fXrIBNqlU5GmHKBUWSruTy+f
	c++ycaLnASbQHOMKfXmvkVMPK/RNhDamgPIRf7rAQFdfIO2sT4bLVQozQeh7QrH1
	QXM4UrwY/VZrz7xtr4B4MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779124560; x=
	1779210960; bh=0vhcXeLYKKSuo11LoXLfb6OBiyx8QacR2oJ/fQatqhU=; b=p
	oopsm07eLdkzONWRFpQv5AQ13JK5aJ3LijHIoEEqOLmv+6emHB5/pJwwDhfiFGCK
	ZL2Z1OVBQZESmjatU9yxh6vGliJx9ATjE2TA/KxWozrLIrlImTYK3GHGXKGns/nD
	xOk4blBH61fwSa3gU0Onxl4ZdYlBRXHn2b1aVaaisXa5xdUX014IFm62gLHD6L8c
	s0dhmBlA7y53Wlh43+oBEQnnDRfGBYRLyEmckEjAHWObtcFLnpT7raJrp0uNnY+y
	Nqq3A34t+7awllfMdnDC4fvirEw+8fd2N1LLCuPT3IndzUIksMTbl57Pdl00b/jQ
	5H3uMlaZ2qU+s7HXrG/gg==
X-ME-Sender: <xms:T0kLal37qmAa7kJPRbJ9MbJ07lu1dGO_dBA3Mk39DRxgh5B63_7OhQ>
    <xme:T0kLatm-_6viAm7rpt7YuF6dGzBWVjrjj2C-fp1bS0hBjUd979nL8pFFxsFFtGEKB
    Vs-C-qGLXTedYmDthddjrAhdTIJP5iJuXsJ0flJVk0MIcbdswzCyw>
X-ME-Received: <xmr:T0kLal_1fFQw1K79xJI9eByDtuqfgoZDp5M-pU2_SgXGnrIyQSL4R4j7ycY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeelgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepkeehjeeitefffeeuieetjedtje
    ffvdelledvuedvffdvfeetgefhveekuedvfedvnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhtohhrnhhoshhmsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgv
    giesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:T0kLaiotONeXA1PvUobZhTag2dYdDMjyPVSI4BH5rwjGC3emrBZn-Q>
    <xmx:T0kLauk-cICKyt_3hswYMUEdw0eajMbYnrTspwc0csgTrea-S5tkAQ>
    <xmx:T0kLaphgjYyWQ5D2DAdo--yYRUVJ_ohHgQMatDoJ942RLt-sUFBclw>
    <xmx:T0kLamcL3gF0Olr5TZB7TqxnWIZzfVydGuJtAYi-36HGMeqe5ezt3w>
    <xmx:UEkLahvY-Y505ppXM4o1aGI1pjQKKTBDX6chArYlphhUCLDmELE0x1h4>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 13:15:59 -0400 (EDT)
Date: Mon, 18 May 2026 11:15:55 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v4 2/3] PCI: Add soft reset method as last resort
Message-ID: <20260518111555.6b1ce60d@shazbot.org>
In-Reply-To: <20260518124836.460805-3-jtornosm@redhat.com>
References: <20260518124836.460805-1-jtornosm@redhat.com>
	<20260518124836.460805-3-jtornosm@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 14:48:34 +0200
Jose Ignacio Tornos Martinez <jtornosm@redhat.com> wrote:

> Add a software-initiated "soft" reset method that attempts D3hot->D0
> transition as an absolute last resort when all other reset methods
> have failed.
> 
> Some devices incorrectly advertise NoSoftRst+ (blocking PM reset) but
> the D3hot transition does provide sufficient reset for certain use cases,
> particularly VFIO passthrough scenarios. This method provides a "better
> than nothing" option when the device would otherwise have no reset
> capability.
> 
> The method only becomes available when:
> - pci_pm_reset() is unavailable (typically blocked by NoSoftRst+)
> - pci_d3cold_reset() is unavailable (no platform _PR3 support)
> - Device has PM capability (required for D3hot transition)
> 
> Extract the D3hot transition logic into a shared helper function
> (pci_do_d3hot_transition) used by both pci_pm_reset and pci_soft_reset.
> 
> Reset hierarchy with this change:
> 1. device_specific
> 2. acpi
> 3. flr
> 4. af_flr
> 5. pm (proper method, checks NoSoftRst)
> 6. bus
> 7. cxl_bus
> 8. d3cold (requires _PR3)
> 9. soft (NEW - D3hot without NoSoftRst check, absolute last resort)
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v4: Implements D3hot transition as last resort when pm/d3cold unavailable
> v3: https://lore.kernel.org/all/20260513122349.268753-1-jtornosm@redhat.com/
> 
>  drivers/pci/pci.c   | 98 ++++++++++++++++++++++++++++++++++-----------
>  include/linux/pci.h |  2 +-
>  2 files changed, 76 insertions(+), 24 deletions(-)

NAK.  This cannot happen as a general case, it will cause vfio-pci to
report reset capabilities for essentially all devices, whether
validated or not.

The suggestion was that for devices where this has proven "better than
nothing", we could think about a device specific version of this,
matching devices IDs, not a fall-through for any device.

Given the "partial reset" nature of this, even on the target device, I
still wonder though whether userspace cannot already handle this by
forcing the power state through sysfs prior to assigning.  Thanks,

Alex 
 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 839903b59698..8dad386bd65d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4437,6 +4437,43 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>  	return ret;
>  }
>  
> +/**
> + * pci_do_d3hot_transition - Perform D3hot->D0 power state transition
> + * @dev: Device to transition
> + *
> + * Common helper to perform D3hot->D0 transition for PM-based reset methods.
> + * Handles IOMMU preparation, state transition, and waiting for device ready.
> + */
> +static int pci_do_d3hot_transition(struct pci_dev *dev)
> +{
> +	u16 csr;
> +	int ret;
> +
> +	if (dev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	ret = pci_dev_reset_iommu_prepare(dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &csr);
> +	csr &= ~PCI_PM_CTRL_STATE_MASK;
> +	csr |= PCI_D3hot;
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> +	pci_dev_d3_sleep(dev);
> +
> +	csr &= ~PCI_PM_CTRL_STATE_MASK;
> +	csr |= PCI_D0;
> +	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> +	pci_dev_d3_sleep(dev);
> +
> +	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> +	pci_dev_reset_iommu_done(dev);
> +	return ret;
> +}
> +
>  /**
>   * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
>   * @dev: Device to reset.
> @@ -4455,7 +4492,6 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>  static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  {
>  	u16 csr;
> -	int ret;
>  
>  	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
>  		return -ENOTTY;
> @@ -4467,28 +4503,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	if (dev->current_state != PCI_D0)
> -		return -EINVAL;
> -
> -	ret = pci_dev_reset_iommu_prepare(dev);
> -	if (ret) {
> -		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> -		return ret;
> -	}
> -
> -	csr &= ~PCI_PM_CTRL_STATE_MASK;
> -	csr |= PCI_D3hot;
> -	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> -	pci_dev_d3_sleep(dev);
> -
> -	csr &= ~PCI_PM_CTRL_STATE_MASK;
> -	csr |= PCI_D0;
> -	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> -	pci_dev_d3_sleep(dev);
> -
> -	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> -	pci_dev_reset_iommu_done(dev);
> -	return ret;
> +	return pci_do_d3hot_transition(dev);
>  }
>  
>  /**
> @@ -4530,6 +4545,42 @@ static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
>  	return pci_set_power_state(dev, PCI_D0);
>  }
>  
> +/**
> + * pci_soft_reset - Software-initiated reset via D3hot as last resort
> + * @dev: PCI device to reset
> + * @probe: if true, check if soft reset is supported; if false, perform reset
> + *
> + * Attempt a software-initiated reset via D3hot->D0 transition as an absolute
> + * last resort when all other reset methods have failed. This method only
> + * becomes available if the device has PM capability, pci_pm_reset() is blocked
> + * (typically by NoSoftRst+), and pci_d3cold_reset() is not available.
> + *
> + * Some devices incorrectly advertise NoSoftRst+ but D3hot transition does
> + * provide sufficient reset for certain use cases (e.g., VFIO passthrough).
> + * This method provides a "better than nothing" option when the device would
> + * otherwise have no reset capability.
> + *
> + * Returns 0 if device can be/was reset this way, -ENOTTY if a better reset
> + * method is available (pm or d3cold) or device lacks PM capability, or other
> + * negative error code on failure.
> + */
> +static int pci_soft_reset(struct pci_dev *dev, bool probe)
> +{
> +	if (pci_pm_reset(dev, true) == 0)
> +		return -ENOTTY;
> +
> +	if (pci_d3cold_reset(dev, true) == 0)
> +		return -ENOTTY;
> +
> +	if (!dev->pm_cap)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pci_do_d3hot_transition(dev);
> +}
> +
>  /**
>   * pcie_wait_for_link_status - Wait for link status change
>   * @pdev: Device whose link to wait for.
> @@ -5105,6 +5156,7 @@ const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
>  	{ pci_d3cold_reset, .name = "d3cold" },
> +	{ pci_soft_reset, .name = "soft" },
>  };
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1ca7b880ead7..bcd2987b868b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 9
> +#define PCI_NUM_RESET_METHODS 10
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false

