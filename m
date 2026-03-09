Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336102C15BA
	for <linux-pci@vger.kernel.org>; Mon,  9 Mar 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089411; cv=none; b=s1P/A9DpOt4QNXz9Gxi0aq7BX/IWmirYHnOQSqavgDbAb6uj6JFOYVdie0GnbL4gDib8QHWqyA+Zanlvw3Bemw2VNSyEF1Xr/QgYhX1Pd6wJINlkbTAdQL4iQ/nwi0zqqYec/fxZ0To1PEqUlyo8RzLPbEW4ZrnHT15oDIvJDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089411; c=relaxed/simple;
	bh=D9o7HUYGiIX12/Vm9Z8Jq1MTyKuuasiiAOeIYqBvBPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lnRihiFun08/uOq2Gb1+hO1TjrgAz9FDwnCTvpwVBH8GaRiFS6xFkeHkDe9s1TYWC0qpsWbirKnqdNuzcDwOy/G8v8RBvEB45EXa5Bse6Gj6CDmmRgXJOqNNLZDeghBWcHZZW9nl/AbyM7JR15xNbp9Z/F53LixOf7MDt6Ti+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhbT2fUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhbT2fUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF6AC4CEF7;
	Mon,  9 Mar 2026 20:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773089410;
	bh=D9o7HUYGiIX12/Vm9Z8Jq1MTyKuuasiiAOeIYqBvBPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AhbT2fUJvQZl34NTL6mns6Fa+gpLHzwodOEjipAqu1om6l71Sb69tcbMABVJfmjDB
	 qsbMoDr3vyGZDEe0Qu2yrBE632F0JL5rT2yYbIPF6FYWqiX+Kj5u/s3TuUGiCtvCkz
	 DnJoLbpGy2AqYoGJtDrB0EaPKaK2a2ASqffZssmsR+iWUY4iHtuoGNAQRxY6oXJXuu
	 OEXk/iKH2XlkB+cp0iM8HsziBIrBTRX/wcJUZEnJz7wlpetaVlbOqeRNB4M8BqxUyN
	 7bQ0ReoWXE4orTdA/XneqP+7Xp+hJYCSEgO6tytJv1/lJlJ5LdLeK9rVfrj1tzSSL9
	 NYWnZujxhGNIg==
Date: Mon, 9 Mar 2026 15:50:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, dan.j.williams@intel.com, alex@shazbot.org,
	ilpo.jarvinen@linux.intel.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 2/3] PCI: allow all bus devices to use the same slot
Message-ID: <20260309205009.GA582379@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217160836.2709885-3-kbusch@meta.com>

On Tue, Feb 17, 2026 at 08:08:35AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A pcie hotplug slot applies to the entire subordinate bus. Thus, pciehp
> only allocates a single hotplug_slot for the bridge to that bus. The pci
> slot, though, would only match to functions on device 0, meaning all
> device beyond that are not matched to any slot even though they share
> it. A slot reset will break all the missing devices because the handling
> skips them.

I tweaked this a bit to (a) refer to the "secondary" bus instead of
"subordinate" to avoid confusion with the PCI "subordinate" term
("pci_dev->subordinate" already has this confusion but is harder to
fix), and (b) mention ARI, which I think is what causes the problem
you're solving:

+ A PCIe hotplug slot applies to the entire secondary bus. Thus, pciehp only
+ allocates a single hotplug_slot for the bridge to that bus. The existing
+ PCI slot, though, would only match to functions on device 0, meaning any
+ devices beyond that, e.g., ARI functions, are not matched to any slot even
+ though they share it.

> For example, ARI devices with more than 8 functions fail because their state is
> not properly handled, nor is the attached driver notified of the reset. In the
> best case, the device will appear unresponsive to the driver, resulting in
> unexpected errors. A worse possibility may panic the kernel if in flight
> transactions trigger hardware reported errors like this real observation:

> @@ -222,6 +233,13 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
>   * consist solely of a dddd:bb tuple, where dddd is the PCI domain of the
>   * %struct pci_bus and bb is the bus number. In other words, the devfn of
>   * the 'placeholder' slot will not be displayed.
> + *
> + * Bus-wide slots:
> + * For PCIe hotplug, the physical slot encompasses the entire subordinate
> + * bus, not just a single device number. Pass @slot_nr == PCI_SLOT_ALL_DEVICES
> + * to create a slot that matches all devices on the bus. Unlike placeholder
> + * slots, bus-wide slots go through normal slot lookup and reuse existing
> + * slots if present.

+ * For PCIe hotplug, the physical slot encompasses the entire secondary
+ * bus, not just a single device number. If the device supports ARI and ARI
+ * Forwarding is enabled in the upstream bridge, a multi-function device
+ * may include functions that appear to have several different device
+ * numbers, i.e., PCI_SLOT() values.  Pass @slot_nr == PCI_SLOT_ALL_DEVICES

>   */
>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  				 const char *name,

> +++ b/include/linux/pci.h
> @@ -72,12 +72,18 @@
>  /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
>  
> +/*
> + * PCI_SLOT_ALL_DEVICES indicates a slot that covers all devices on the bus.
> + * Used for PCIe hotplug where the physical slot is the entire subordinate bus.

+ * Used for PCIe hotplug where the physical slot is the entire secondary bus,
+ * and, if ARI Forwarding is enabled, functions may appear to be on multiple
+ * devices.

Let me know if I got any of this wrong.

Bjorn
