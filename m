Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C7349B1C;
	Mon,  3 Aug 2026 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795734; cv=none; b=n+kKfqwkor7q3Tx0tWwcJpmDz8zEOBOfGJp0JU5tp5/GbNQQ3SKCvu8svDmrlh1ikcEJqvWtEEthWeesTXS/KMBZArnmndv9e1jQsvXmSkCQW9pWaQ76kHqDvmxRY0dj4kSsvMG0thmA1Oa4vaetJDLn6KxrFrjxhn0X5Dcv2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795734; c=relaxed/simple;
	bh=qGcFmsj37iCiof7WhoELCTXk88tN0K0+lrwJkSo6zYg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kyyPU12VJywOsVdhdrCRoTdwLsO+HDJAEHiCpXaP0x6uUlp+r0g98wFlwJIF6oA23ZmG1a7TdTvvHwX3DEkrkHJLDooO3BO8Q3Ha28GFe/ozG9WgZ1qWijz2RAeQRXnJ5+2UNxYpb/Gc1nc8qEUQKmwSBvhb8NugRlK8SIwADcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxs0Jack; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxs0Jack"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C41F000E9;
	Mon,  3 Aug 2026 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785795732;
	bh=NzqBUkUuPUSSxOc0UQtDlqdgKn9f1XFPYeVeP6ULshk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Yxs0JackqidroKiBTsQw0a6aKHYM5sHkUglO0D5wq//b+JopEqC23meSCWke9mAnm
	 0XF7SkYHw8enfeLF66Irvx6mAeEIgdSO4uAMQ7ztk5PfdvWLWJ4MpiudXlEIAksMU5
	 +EFh2fTHQjGQJxaDCxGcWNKFkTD/L0vj9K7RXH7ZeZqHEx45256dSjotnZHUbD6eiB
	 +WT4HUCItINluODmxK+d6k5/qFwffpcOhx8W/j1mGDQtL7NvJb6zY+pkYAbWcNi7WS
	 wIRFzNrZ5mU5oUd05WePDK9DIBknkC0NIMAHP7pXqX3S9skm5jp7HpheyDxmUMFUxD
	 dlunoWY6FNyKQ==
Date: Mon, 3 Aug 2026 17:22:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sangwoo Han <sangwoo.han@nearthlab.com>
Cc: jim2101024@gmail.com, florian.fainelli@broadcom.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, bcm-kernel-feedback-list@broadcom.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
Message-ID: <20260803222210.GA1804081@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730072215.2090974-1-sangwoo.han@nearthlab.com>

On Thu, Jul 30, 2026 at 04:22:15PM +0900, Sangwoo Han wrote:
> brcm_msi_alloc() reserves a naturally aligned power-of-two region with
> bitmap_find_free_region(order_base_2(nr_irqs)), but the irqdomain core
> releases the vectors of a block one at a time:
> 
>   /* irq_domain_free_irqs_hierarchy() */
>   for (i = 0; i < nr_irqs; i++)
>           if (irq_domain_get_irq_data(domain, irq_base + i))
>                   domain->ops->free(domain, irq_base + i, 1);
> 
> That loop is the only caller of an irq_domain's ops->free(), so
> brcm_irq_domain_free() always sees nr_irqs == 1 and
> bitmap_release_region() clears exactly one bit per call. A request whose
> vector count is not a power of two therefore reserves
> roundup_pow_of_two(nr_irqs) bits but releases only nr_irqs of them, and
> the difference stays set for the lifetime of the controller.
> 
> Multi-MSI regions are order-aligned and the controller has at most 32
> MSIs, so the pool is quickly exhausted. Observed on a BCM2712 with a
> 5-vector endpoint behind a 4-port PCIe switch: the switch ports take
> hwirq 0x0-0x3 and the endpoint's block walks 0x8 -> 0x10 -> 0x18 across
> three driver reloads until no aligned order-3 region is left.
> pci_alloc_irq_vectors() then falls back to a single vector for the rest
> of the boot, silently multiplexing the endpoint's four completion
> interrupts onto one hwirq.
> 
> Devices that ask for a non-power-of-two vector count are not exotic:
> wil6210 asks for 3, the MHI modems for 5 (Quectel EM1xx, Foxconn SDX55,
> Telit FN990, MediaTek MV3x) or 7 (Qualcomm v1), ath11k WCN6750 for 28
> and ptp_ocp for 17. MSI-X is unaffected because it allocates one
> descriptor per vector with nvec_used == 1, so the order is always zero.
> 
> Reserve exactly the vectors that are handed out, at a base found with
> bitmap_find_next_zero_area(), and clear exactly the vectors that are
> freed. The number of reserved bits then matches the number the core
> releases, whatever arity it uses.
> 
> The base still has to be aligned: PCI Local Bus Specification 3.0
> (section 6.8.1.6) lets the endpoint encode the vector number in the low
> order_base_2(nr_irqs) bits of the Message Data register, and in this
> controller those bits are the hwirq itself. The alignment mask has to be
> roundup_pow_of_two(nr_irqs) - 1 rather than nr_irqs - 1:
> bitmap_find_next_zero_area() requires a mask of the form 2^k - 1. No
> align_offset is needed because the bitmap index is the value the
> endpoint ORs in, see brcm_msi_compose_msi_msg().
> 
> For a power-of-two nr_irqs the alignment and the region length are both
> nr_irqs, so the base returned is the same as before and those
> allocations are unaffected.

Several other PCI controller drivers have similar code.

I think we should fix them all at once (or explain why they don't need
similar fixes).  Might be worth a little helper so they all work the
same way (e.g., some use order_base_2(), others use get_count_order(),
which seems like a pointless difference).

> Fixes: 198acab1772f ("PCI: brcmstb: Enable Multi-MSI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sangwoo Han <sangwoo.han@nearthlab.com>
> ---
> 
> Notes:
>     Tested on a BCM2712 (Raspberry Pi 5) with a 5-vector endpoint behind a
>     4-port PCIe switch, running 6.12.25 where brcm_msi_alloc() and
>     brcm_msi_free() are byte-identical to mainline. Without the patch the
>     endpoint's block walks 0x8 -> 0x10 -> 0x18 over three driver reloads and
>     then falls back to a single vector for the rest of the boot; with it the
>     block returns to 0x8 on all of eight reload cycles and the inner
>     domain's mapped count round-trips cleanly.
>     
>     Compile-tested on mainline for arm64 with W=1 and C=1 (sparse); no new
>     warnings.
> 
>  drivers/pci/controller/pcie-brcmstb.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 8a0c353d2a..6c5166666d 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -595,11 +595,22 @@ static struct irq_chip brcm_msi_bottom_irq_chip = {
>  
>  static int brcm_msi_alloc(struct brcm_msi *msi, unsigned int nr_irqs)
>  {
> +	/*
> +	 * brcm_msi_compose_msi_msg() puts hwirq in the low order bits of the
> +	 * message data, which a Multi-MSI endpoint rewrites per vector, so a
> +	 * block's base must be aligned to the Multiple Message Enable count.
> +	 */
> +	unsigned long align_mask = roundup_pow_of_two(nr_irqs) - 1;
>  	int hwirq;
>  
>  	mutex_lock(&msi->lock);
> -	hwirq = bitmap_find_free_region(msi->used, msi->nr,
> -					order_base_2(nr_irqs));
> +	hwirq = bitmap_find_next_zero_area(msi->used, msi->nr, 0, nr_irqs,
> +					   align_mask);
> +	if (hwirq >= msi->nr) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +	bitmap_set(msi->used, hwirq, nr_irqs);
>  	mutex_unlock(&msi->lock);
>  
>  	return hwirq;
> @@ -609,7 +620,7 @@ static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq,
>  			  unsigned int nr_irqs)
>  {
>  	mutex_lock(&msi->lock);
> -	bitmap_release_region(msi->used, hwirq, order_base_2(nr_irqs));
> +	bitmap_clear(msi->used, hwirq, nr_irqs);
>  	mutex_unlock(&msi->lock);
>  }
>  
> -- 
> 2.53.0
> 
