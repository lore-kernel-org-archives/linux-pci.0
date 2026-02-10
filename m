Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E73128A3;
	Tue, 10 Feb 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744396; cv=none; b=Ftes1j2oZftowFnmfFBkFDVMTH6xgg05j9+Exu9eUFjMAndHJnqh9lUXEQP0iZwfNCBBO9i/N106ut8ma4i2vosIdqhhJPeKaEwlqvoPJ51Bwb373iSmBIIz2CnVnyCCcXPEIwO+8HjsxLxKSK1lk9e9+Dk1AsOkH8Z1Dt8kNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744396; c=relaxed/simple;
	bh=JuSaTqET9AgbGSuilSdaWrKf0PNtOEI1hRFWCwNdBNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OOjAJnL99m9t7NZyjp3qEs5iHv/9h0zMSYhUXtikB0slUAKZvm57uYHRKagAdyIzf4jrJ8ZB40Lhwx3alkOkrFrjMEP6jrm+9dHaC723dpvqcwiQAFk17bILZQQuXzlJ1ZVMH3zlgeeu/6rYAeObFyuMgcHKzhhR1DqVko/i6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjqxb/WY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjqxb/WY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91322C116C6;
	Tue, 10 Feb 2026 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770744396;
	bh=JuSaTqET9AgbGSuilSdaWrKf0PNtOEI1hRFWCwNdBNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Sjqxb/WYC9aclkY2Rw1DiC142glj6Byzsak5f4DFxS3gsWpNYkKwicrtu6QSxoVn9
	 epxaoURGpCjZon9+3OuCyLGVk8LaFGS2V1nr/Lb9IQp0fhE0P95VbXl7Qrp2r+YIu8
	 WmuSwZhMVx5VkE5HKSlppcCJxFOgsbhPa0meZbopC/YyZtkJ2mOMymbrhIK5doiWT1
	 dk3jobpOeesfxZ/FgXhD4vbt9IKF4I0l/RHKa9QgorBWSuqfHhkMIzoIsQ4xct9QCP
	 Grys1GZjaQNNMGVraZwSuTNUU69WYEExpv/6xjwVdI8P2E96etzBNr2tXzRnVjQ6wx
	 N52A2Pb+tFWkw==
Date: Tue, 10 Feb 2026 11:26:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Validate window resource type in
 pbus_select_window_for_type()
Message-ID: <20260210172635.GA31498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210142058.82701-1-kaihengf@nvidia.com>

On Tue, Feb 10, 2026 at 10:20:57PM +0800, Kai-Heng Feng wrote:
> Afer commit ebe091ad81e1 ("PCI: Use pbus_select_window_for_type() during
> IO window sizing") and commit ae88d0b9c57f ("PCI: Use
> pbus_select_window_for_type() during mem window sizing"), many bridge
> window can't get resource assigned:
> pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:04.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:08.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
> pci 0006:05:0c.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign
> 
> Those commits replace find_bus_resource_of_type() with
> pbus_select_window_for_type(), and the latter lacks resource type
> validation.
> 
> This commit adds the resource type validation back to
> pbus_select_window_for_type() to match the original behavior.
> 
> Fixes: 74afce3dfcba ("PCI: Add bridge window selection functions")

74afce3dfcba, ebe091ad81e1, and ae88d0b9c57f all appeared in v6.18.
Interesting that nobody else reported this since.  In any case, this
looks like post-merge window v7.0 material after an ack from Ilpo,
probably with a stable tag.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221072
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Thanks for bisecting and fixing this!  From the "dmesg with fix"
attachment (https://bugzilla.kernel.org/attachment.cgi?id=309333):

  pci_bus 0006:00: root bus resource [mem 0x618040000000-0x6180bfffffff window] (bus address [0x40000000-0xbfffffff])
  pci_bus 0006:00: root bus resource [mem 0x6180c0000000-0x627fffffffff window]
  pci 0006:05:00.0: [15b3:197b] type 01 class 0x060400 PCIe Switch Downstream Port
  pci 0006:05:00.0: PCI bridge to [bus 06]
  pci 0006:05:00.0:   bridge window [mem 0x618040300000-0x6180403fffff]

Looks like the 32-bit (non-prefetchable) window was programmed by
firmware but the 64-bit window was not programmed or maybe programmed
incorrectly (a dmesg with "pci=earlydump" would show the raw state
Linux received):

  pci 0006:05:00.0: bridge window [mem 0x00000000 64bit pref] to [bus 06] requires relaxed alignment rules
  pci 0006:05:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 06] add_size 200000 add_align 100000

For hex_range() to print a resource with a single address like the
"relaxed alignment" line, I think the resource must have
start==end==0, which would mean a window at 0x0 that's one byte long.

A memory window res.end should always have 0xfffff in the low 20 bits
because these windows are a multiple of 1MB in size, so this suggests
another bug somewhere.  

  pci 0006:05:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 06] requires relaxed alignment rules
  pci 0006:05:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 06] add_size 200000 add_align 100000
  pci 0006:05:00.0: bridge window [mem 0x618040200000-0x6180404fffff]: assigned

I think these three lines all refer to the 32-bit window.  It's a bit
confusing that the logging shows what looks like a
IORESOURCE_STARTALIGN and size (same applies to the 64-bit window
above).  I wonder if resource_string() should do something different
when decoding this so it doesn't look like we actually programmed the
window to this.  And maybe pci_resource_name() should explicitly say
which window this is.

Also slightly interesting that we reassigned the 32-bit window,
increasing its size from 1MB to 3MB.  Maybe this is because the bridge
supports hotplug.

Unrelated nit: I think we should add "0x" prefixes for add_size and
add_align to match the addresses.

  pci 0006:05:00.0: bridge window [mem 0x6180c8800000-0x6180c89fffff 64bit pref]: assigned

  pci 0006:05:00.0: PCI bridge to [bus 06]
  pci 0006:05:00.0:   bridge window [mem 0x618040200000-0x6180404fffff]
  pci 0006:05:00.0:   bridge window [mem 0x6180c8800000-0x6180c89fffff 64bit pref]

> ---
>  drivers/pci/setup-bus.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e680f75a5b5e..1b5185697011 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -224,14 +224,21 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
>  
>  	switch (iores_type) {
>  	case IORESOURCE_IO:
> -		return pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> +		win = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
> +		if (win && (win->flags & IORESOURCE_IO))
> +			return win;
> +		return NULL;
>  
>  	case IORESOURCE_MEM:
>  		mmio = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_MEM_WINDOW);
>  		mmio_pref = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_PREF_MEM_WINDOW);
>  
> -		if (!(type & IORESOURCE_PREFETCH) ||
> -		    !(mmio_pref->flags & IORESOURCE_MEM))
> +		if (mmio && !(mmio->flags & IORESOURCE_MEM))
> +			mmio = NULL;
> +		if (mmio_pref && !(mmio_pref->flags & IORESOURCE_MEM))
> +			mmio_pref = NULL;
> +
> +		if (!(type & IORESOURCE_PREFETCH) || !mmio_pref)
>  			return mmio;
>  
>  		if ((type & IORESOURCE_MEM_64) ||
> -- 
> 2.43.0
> 
