Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4021ADC7;
	Wed, 18 Mar 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871114; cv=none; b=lrNFNhQfvcdpScA5O8xqQfM8chlGxsXKfORHj9dB09w3crw6NNDUgvOnDIILgkoeDxxvYazLrnfm5M3cikB2OJX5WDJFvt21AphFee7Q9IoXAE+9QKONx0l/eB4NNlTKLJxgietVA7rMdD44zAXD5W9VX7c+Oe5xDALj6eOWvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871114; c=relaxed/simple;
	bh=g+UfRkP0ayM7nlit+xXvMF47RJk+YzbVbcsTEDZHgVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=co6u/tmqsnoTt4vJguMmJOh4Nb+ibXhCsQxstAu2WKFGHFpKFcx1OT5zMlXmNmhF6BukfkVJzjWZDFICOEntGf64QgEdAhH2Zmo6V/BWuViqZ+IeCteKI12jwOlJxvbHYZ/IAsCNfqnCJ8rw9vMyafCTqk9/TwzVziTUK66lTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbINCqq+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbINCqq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9CEC19421;
	Wed, 18 Mar 2026 21:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773871114;
	bh=g+UfRkP0ayM7nlit+xXvMF47RJk+YzbVbcsTEDZHgVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bbINCqq+QGr4OWvGM+Asg8zE2iaZmTEvvOpUaWY1IeaK3ZsDKJm71QFgRR+VpJPSo
	 LzzpRAQr+EsxbuZyal3Ew9cgEQfNQbF6Z7uxISaPB0df3VqX6kKQhcdULV8/ziy3Vs
	 uYIo88kfuvE0WH6PN/3RzPVYhurGOkqoRxjr/Pwb89rOtmv7fPor972DZAkW0MapR9
	 4NjJJHGj7j7wH3ZsK+KxlHopfyKqXw/mUnBL2Meyv94uWyzMfsfnN0ALQcY7fEk1by
	 IEnr8DdjSDXXQe71Nhteew4nqipFCsZ73WwP/dp+z9i05PZSmjTOinRN7OYBV9eZvl
	 W2oUEi1fTJyaA==
Date: Wed, 18 Mar 2026 16:58:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
	naseefkm@gmail.com, ryder.lee@mediatek.com, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	ansuelsmth@gmail.com, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: Skip bridge window reads when window is not
 supported
Message-ID: <20260318215832.GA476412@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316155157.679533-4-cjd@cjdns.fr>

On Mon, Mar 16, 2026 at 03:51:57PM +0000, Caleb James DeLisle wrote:
> pci_read_bridge_io() and pci_read_bridge_mmio_pref() read bridge window
> registers unconditionally. If the registers are hardwired to zero
> (not implemented), both base and limit will be 0. Since (0 <= 0) is
> true, a bogus window [mem 0x00000000-0x000fffff] or [io 0x0000-0x0fff]
> gets created.
> 
> pci_read_bridge_windows() already detects unsupported windows by
> testing register writability and sets io_window/pref_window flags
> accordingly. Check these flags at the start of pci_read_bridge_io()
> and pci_read_bridge_mmio_pref() to skip reading registers when the
> window is not supported.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Link: https://lore.kernel.org/all/20260113210259.GA715789@bhelgaas/
> Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>

I applied this to pci/resource for v7.1 with the following commit log:

  PCI: Prevent assignment to unsupported bridge windows

  Previously, pci_read_bridge_io() and pci_read_bridge_mmio_pref()
  unconditionally set resource type flags (IORESOURCE_IO or IORESOURCE_MEM |
  IORESOURCE_PREFETCH) when reading bridge window registers. For windows that
  are not implemented in hardware, this may cause the allocator to assign
  space for a window that doesn't exist.

  For example, the EcoNET EN7528 SoC Root Port doesn't support the
  prefetchable window, but since a downstream device had a prefetchable BAR,
  the allocator mistakenly assigned a prefetchable window:

    pci 0001:00:01.0: [14c3:0811] type 01 class 0x060400 PCIe Root Port
    pci 0001:00:01.0: PCI bridge to [bus 01-ff]
    pci 0001:00:01.0: bridge window [mem 0x28000000-0x280fffff]: assigned
    pci 0001:00:01.0: bridge window [mem 0x28100000-0x282fffff pref]: assigned
    pci 0001:01:00.0: BAR 0 [mem 0x28100000-0x281fffff 64bit pref]: assigned

  pci_read_bridge_windows() already detects unsupported windows by testing
  register writability and sets dev->io_window/pref_window accordingly.

  Check dev->io_window/pref_window so we don't set the resource flags for
  unsupported windows, which prevents the allocator from assigning space to
  them.

  After this commit, the prefetchable BAR is correctly allocated from the
  non-prefetchable window:

    pci 0001:00:01.0: bridge window [mem 0x28000000-0x281fffff]: assigned
    pci 0001:01:00.0: BAR 0 [mem 0x28000000-0x280fffff 64bit pref]: assigned

I also set the author to "Ahmed Naseef <naseefkm@gmail.com>" per
https://lore.kernel.org/all/abRQYM1If/6Vv/tI@DESKTOP-TIT0J8O.localdomain

You can make this work correctly next time by including a
"From: Ahmed Naseef <naseefkm@gmail.com>" line as the very first line
in the message body; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.19#n723

> ---
>  drivers/pci/probe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..4eacb741b4ec 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -395,6 +395,9 @@ static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
>  	unsigned long io_mask, io_granularity, base, limit;
>  	struct pci_bus_region region;
>  
> +	if (!dev->io_window)
> +		return;
> +
>  	io_mask = PCI_IO_RANGE_MASK;
>  	io_granularity = 0x1000;
>  	if (dev->io_window_1k) {
> @@ -465,6 +468,9 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
>  	pci_bus_addr_t base, limit;
>  	struct pci_bus_region region;
>  
> +	if (!dev->pref_window)
> +		return;
> +
>  	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
>  	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
>  	base64 = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
> -- 
> 2.39.5
> 
