Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCF3815E8
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397588; cv=none; b=cDNxNZhT90ETgnATDCotYpOYTBN3vlUFfjpkf07sHGWQGWMApNFDaSnysfUPsk1TWzjPVkh2zEpoHQV8QzxItbB8T3LfbGiyzzgkEPUiQmjh17Ro019dKpvgYSxFqwjDEr5RXpVngUvg16f3TI6N4MszFU+6toDHGYM59HSKUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397588; c=relaxed/simple;
	bh=3swYSbgF2h8D8Spo5M5ilTMMfr97R86FPexfcylh/hQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EkhAwBOvql1rRMEAzX6X5VJ5CRGvPdJhtmw+SZ8DrNRxS7JGZGh8dC5+5HJP/B36tftbHmp4bJkg3Z2mRJJSOU+52+5zs7d68092Cgt+sXdpuIVmCEPcwlu94iXdKAlNv201NS6N34NGiryg3u+Sfk9ZevtYAGKnc5Gxafcw+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M19Tglh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M19Tglh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED8B1F000E9;
	Thu, 30 Jul 2026 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785397587;
	bh=PZpbbjuKDsrDHOsUr3H+XoFZJAKX2E8WS+OV53O4eRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M19Tglh4k+66BEeDEE4fYL4jJFnTOLOuVmeuxxPDsXCTyu5hLwDEErNxVry9GuU46
	 Buh232+2GIVmGmal7MyijDy9RiQV0/+4FFE71P2Je0IWV3rNAaw8VO9VdX9u9IbLB1
	 WVK15hNbl86W2jsOpzhzB6aZ/gwpKHQ+36Njiw7YpPQkLOYt1VUwEEDqlVEPzBTZrr
	 3zMXuMlVe4Om6mDMuSye9R37C7oxTP1YADlAx6Mjv39LMnjm4kFBnC4SNfBZP6JA9r
	 7tSGeIy2F6zYbkdY8R3ZcWVOC0vRwv6j4cOg1HEmIN/4KVXfrCKTO967/CXkYq6qUE
	 69df9aUu8Jj5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sangwoo Han" <sangwoo.han@nearthlab.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730072215.2090974-1-sangwoo.han@nearthlab.com>
References: <20260730072215.2090974-1-sangwoo.han@nearthlab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 07:46:26 +0000
Message-Id: <20260730074626.BED8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch only reserves `nr_irqs` bits instead of the full power-o=
f-two block in the controller's bitmap, breaking hardware IRQ isolation and=
 allowing cross-device IRQ collisions if trailing vectors are reallocated.
--

--- Patch [1]: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are =
handed out ---
commit 627a58c7a939ca8de261414f13dbb9fd516289b4
Author: Sangwoo Han <sangwoo.han@nearthlab.com>
Subject: PCI: brcmstb: Reserve only the MSI vectors that are handed out

This commit modifies the Broadcom STB PCIe MSI allocator to reserve and free
exactly the requested number of interrupt vectors rather than rounding up to
the nearest power of two. This aims to prevent exhaustion of the 32-vector
pool when endpoints request non-power-of-two vector counts.

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controll=
er/pcie-brcmstb.c
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -595,11 +595,22 @@ static struct irq_chip brcm_msi_bottom_irq_chip =3D=
 {
> =20
>  static int brcm_msi_alloc(struct brcm_msi *msi, unsigned int nr_irqs)
>  {

[ ... ]

> -	hwirq =3D bitmap_find_free_region(msi->used, msi->nr,
> -					order_base_2(nr_irqs));
> +	hwirq =3D bitmap_find_next_zero_area(msi->used, msi->nr, 0, nr_irqs,
> +					   align_mask);
> +	if (hwirq >=3D msi->nr) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +	bitmap_set(msi->used, hwirq, nr_irqs);

[Severity: High]
Does this leave the unallocated trailing vectors in the power-of-two block
vulnerable to cross-device IRQ collisions?

When a device requests a non-power-of-two number of MSIs, the generic PCI
core rounds the allocation up and programs the device's Multiple Message
Enable capability to the next power of two. The device is then
hardware-authorized to modify the lower bits of its MSI Message Data to
distinguish between vectors.

Because bitmap_set only reserves exactly nr_irqs bits, the remaining bits in
the device's hardware window remain marked as free in the allocator. If
another device is subsequently assigned one of these trailing vectors, can
the first device's interrupts be incorrectly routed to the second device?

>  	mutex_unlock(&msi->lock);
> =20
>  	return hwirq;
>  }
> =20
>  static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq,
>  			  unsigned int nr_irqs)
>  {
>  	mutex_lock(&msi->lock);
> -	bitmap_release_region(msi->used, hwirq, order_base_2(nr_irqs));
> +	bitmap_clear(msi->used, hwirq, nr_irqs);

[Severity: High]
If the allocation needs to reserve the full power-of-two block to prevent
collisions, does this also need to clear the full power-of-two block when
the vectors are freed?

>  	mutex_unlock(&msi->lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730072215.2090=
974-1-sangwoo.han@nearthlab.com?part=3D1
