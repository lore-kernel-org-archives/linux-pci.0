Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F8279903
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976362; cv=none; b=fjlPa+H0drdBhyMcBn2iG67S7V3j1HcTZE5inAGuYOVewKktukaMfljrMt4EJ0LAphZJsypGNw7CXavreP9SknXofBkPLyrR7g0179GofzjriiVYEjmZsxIUKASWaY+YtR0jzvvXd4aQFsyfVAEYGj1ixYHCU4K+Xqc1BzZMR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976362; c=relaxed/simple;
	bh=xLRGnmQ9mlwHMbeN1gHgGaovXF38xHpZlIzHhc4xOEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R/zzV2M9jjoYI6NTMu/lUY0vRr270pvMrEa2zvLlJZoWJO5wDJGsPXt4l2nz8U3Hhrhd28lY04oSzadNeHfufqkpC4RWrbBWXY/1InUbfUJTrg0muoV5FxFbKZ6W9VJM3tvNKgFPqR3WQcDXEW8MhHlHDte7a1++XOS6AC0nIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHdesjlr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHdesjlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B5F1F000E9;
	Sat, 20 Jun 2026 17:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976361;
	bh=gmwIirOLZYmGMsPLqbZ9PV8mqRYcY8ZVE+fcgpsLlB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHdesjlrbfvw88UAJAaxp4HBMI1gwCgtWuUPjTMSARf2wpP5BNSOx2NqJ4zVSX62e
	 yOFfefZR44VZPjZe6v2TnOPiUKJulH5x0RBzTfjPi67Z856QQxp5wq6dRlERMB3QX2
	 lf3EGszXG6MsiFYT+U06R3FhsZYFl9SIt1ZKs3ExV4rYkbyhSIG9awtq/V4XBXdJS+
	 TWoptxa6NXWx3LS5HvxQe5bHCwT8Km9LvnzTEvJzS81hbYOl8DKVPaQ6ZGP0M/DzkZ
	 kQHDPPZjxuqkdmoefA1op3xMcM0ihySnQeWMHRUG+UEfMp6q+CPQB3gbVotoGQ/Q0v
	 JAONBtiOtjftg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] PCI: endpoint: Add API to delegate EPC DMA
 channels to the host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260620170438.3756593-4-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
 <20260620170438.3756593-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:26:00 +0000
Message-Id: <20260620172600.E8B5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Error pointer dereference in `pci_epc_delegate_dma_chan` due to in=
correct validation order.
--

commit b5fefb01d3a350b55650bc026830cacbecfcc978
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Add API to delegate EPC DMA channels to the host

This commit adds pci_epc_delegate_dma_chan() and pci_epc_reclaim_dma_chan()
to allow generic endpoint functions to delegate integrated DMA channels to
the host. It introduces matching EPC operations and uses an opaque handle
for channel state management to avoid backend-specific dependencies.

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/p=
ci-epc-core.c
> index 831b40458dcd8..0f71c4633ee54 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c

[ ... ]

> @@ -236,6 +243,99 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u=
8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> =20
> +/**
> + * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to th=
e host

[ ... ]

> +int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_=
no,
> +			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
> +			      struct pci_epc_dma_chan **chan)
> +{
> +	struct pci_epc_dma_chan *epc_chan;
> +	void *data =3D NULL;
> +	int ret;
> +
> +	if (!chan)
> +		return -EINVAL;
> +	*chan =3D NULL;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;

[Severity: High]
If a caller passes an error pointer for epc, will the !epc->ops check
trigger a crash?

Functions like pci_epc_get() return ERR_PTR(-EINVAL) on failure rather
than NULL. If epc is an error pointer, the !epc check evaluates to false,
causing execution to proceed to the !epc->ops check. Dereferencing epc->ops
on an error pointer will trigger a kernel crash.

> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;

The subsequent call to pci_epc_function_is_valid() internally uses
IS_ERR_OR_NULL(epc) to safely handle error pointers, but placing the ops
dereference before it circumvents this safety.

Would it be better to move the pci_epc_function_is_valid() check before
dereferencing epc->ops, or explicitly check IS_ERR_OR_NULL(epc) first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170438.3756=
593-1-den@valinux.co.jp?part=3D3
