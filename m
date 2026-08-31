Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65537E2E5;
	Mon, 31 Aug 2026 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210351; cv=none; b=s7Jur0xQZcrZJ6UJr8oDq+LiY3NYImmNZ9DEd49s6aIP41ZX9hlZXZthKlWP+vYEMOtXxqcRaHM3CMObPBiRXApVS/9OVP4hA7LtWbWh7zn54EEoTcpIBT6lhH4gX2MHVyItFxnWNUz0bnj5eoSydQydTudwKgpbYQtocWnVAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210351; c=relaxed/simple;
	bh=1J+YGBFf4nghH/syv/ZnmKuQ1StZJEBnVwfl68Jij24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qL+jUeOBZr/a7Pkqz04XVYSY9sMfcjM3JUsjthKoxsErAEpqyY2+VKsP/jce0SctzUmBo6Du1bGWo2oZoHqM3DPveE7qDWnU4cY8B0qAZeUr2/PWO6snxB03LgvdJxcViBMbleRCcOBMYMQr/6vaLjr+U+sJHS2luCHgoN182Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aItLIXG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aItLIXG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AC31F000E9;
	Mon, 31 Aug 2026 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210349;
	bh=+oSDp1uiom5GRI+rtquXQOseR1wFKr+IyB+VQGYsMh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aItLIXG/foxK0c8CriWQpgJQQtFI9zomwrV78Z7yB0GdpNtSGZ15tw3r38K+FKf/Y
	 GCZRwSvVHyZtrbWPPtVJkJrZ1ZFRgKzLtEylIzuXOZD9x15nNrseG8+wT9R8ndpoKs
	 Jy11Rv9Q56OLF5UY1PcKHztdpscjGya98BfIHsvb2F7BBN43goBN9xMcxcTeGAc8xc
	 6Up4fyQHxBoU3heGFLJfhU/SNwDHSxh7Nn0DTaY834eKkFFFDQVwGJvPUoNoZaVVJn
	 puaTipWWTwD9rEjWFP34iAJmuyXplMdkMOl8fKF523NANGqSgYUgECBmVetDAyxYFn
	 Tw1wNzjNcGwUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] PCI: endpoint: pci-epf-vntb: Allow DMA and MW to
 share a BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260831182657.329614-6-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:05:48 +0000
Message-Id: <20260831210549.30AC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Deactivating a shared DMA BAR unconditionally clears all subma=
ps, breaking the active Memory Window (MW) mapping and causing severe memor=
y corruption.
- [High] The `ntb->dma` structure is freed in `epf_ntb_unbind()` before the=
 driver is unregistered, allowing concurrent NTB subsystem operations to us=
e a freed pointer and its lock.

Pre-existing issues:
- [High] The virtual PCI driver `vntb_pci_driver` lacks a `.remove` callbac=
k, causing the NTB device and virtual PCI bus devices to leak and potential=
ly use freed memory.
--

commit 4680cfd6b651b64bf9225e9233e1d66310c8b0da
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR

This patch modifies the PCI endpoint vNTB function to allow a DMA BAR to
select an MW BAR and place DMA ranges after it. This enables configurations
that have no spare BAR for DMA resources to share one.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 1842493c33b02..aa659ec62d931 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> @@ -621,17 +648,25 @@ static void epf_ntb_dma_release(struct epf_ntb *ntb=
, bool quiesce)
>  	ntb->dma =3D NULL;
>  }
> =20
> -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb, bool active)
> +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool active,
> +				      const dma_addr_t *mw_addr)
>  {
>  	struct pci_epf_bar_submap *old_submap;
>  	struct epf_ntb_dma *dma =3D ntb->dma;
>  	struct pci_epf_bar *bar;
>  	unsigned int old_num_submap;
> +	dma_addr_t old_mw_addr;
>  	int restore, ret;
> =20
> +	lockdep_assert_held(&dma->lock);
> +
>  	bar =3D &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
>  	old_submap =3D bar->submap;
>  	old_num_submap =3D bar->num_submap;
> +	if (mw_addr) {
> +		old_mw_addr =3D dma->submap[0].phys_addr;
> +		dma->submap[0].phys_addr =3D *mw_addr;
> +	}
> -	bar->submap =3D active ? dma->submap : NULL;
> -	bar->num_submap =3D active ? dma->num_submap : 0;
> +	bar->submap =3D active ? dma->submap : NULL;
> +	bar->num_submap =3D active ? dma->num_submap : 0;

[Severity: Critical]
If the host sends a COMMAND_TEARDOWN_DMA while a Memory Window is still
active, epf_ntb_dma_set_active() will call this function with active set to
false.

Does this unconditionally clear all submaps on the BAR, including submap[0]
which covers the MW prefix?=20

Since pci_epf_assign_bar_space() used address 0 as the fallback base physic=
al
address, clearing the submap would cause pci_epc_set_bar() to map the entire
BAR to CPU physical address 0 on the endpoint. Could this corrupt memory wh=
en
the host subsequently accesses the MW?

> =20
>  	ret =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
>  			      ntb->epf->vfunc_no, bar);
[ ... ]
> @@ -1974,6 +2019,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *n=
dev, int pidx, int idx,
>  	dev =3D &ntb->ntb.dev;
>  	barno =3D ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar =3D &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		/* DMA submaps follow this MW, so its extent cannot be changed. */
> +		if (size !=3D ntb->mws_size[idx])
> +			return -EINVAL;
> +
> +		guard(mutex)(&ntb->dma->lock);

[Severity: High]
Can this lock be accessed after ntb->dma has been freed?

In epf_ntb_unbind(), epf_ntb_dma_release() is called, which frees ntb->dma
via kfree(). However, pci_unregister_driver(&vntb_pci_driver) is called
after this.

If a host MW configuration command runs concurrently with unbind, could
vntb_epf_mw_set_trans() check epf_ntb_dma_shares_bar() and then attempt to
acquire this mutex on the freed ntb->dma pointer?

> +
> +		return epf_ntb_dma_set_bar_locked(ntb, true, &addr);
> +	}
> +
>  	epf_bar->phys_addr =3D addr;
>  	epf_bar->barno =3D barno;
>  	epf_bar->size =3D size;

[Severity: High]
This is a pre-existing issue, but I noticed that vntb_pci_driver lacks a
remove callback:

static struct pci_driver vntb_pci_driver =3D {
	.name           =3D "pci-vntb",
	.id_table       =3D pci_vntb_table,
	.probe          =3D pci_vntb_probe,
};

When epf_ntb_unbind() calls pci_unregister_driver(), it unbinds the driver
but ntb_unregister_device() is never called because there is no cleanup
function.=20

Since the struct epf_ntb instance is allocated via devm_kzalloc() tied to
the EPF device, it gets freed when the EPF device is removed. Does this
cause the NTB device and virtual PCI bus devices to leak, leading to a
use-after-free if the NTB subsystem makes subsequent calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182657.3296=
14-1-den@valinux.co.jp?part=3D5
