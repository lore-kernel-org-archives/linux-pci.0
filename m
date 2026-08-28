Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827D35B657;
	Fri, 28 Aug 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937889; cv=none; b=ljM/fhw5zkk7vYZpo8b1VTgfmF5fXkr3/Q/Dt0C8hpqGPAmyBzznvDaDs8zUnOoC/mwy0/rxFJCL7Zc910EWycjGnWf/x1yAfYoERjCyRNe3QgwoMlJLE4maola60A7Z+qMlkKClNfL5uN7EwzzosY9mdEaaJD2/nqk8eVXCqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937889; c=relaxed/simple;
	bh=XQhewQ4FZ9qfZtrl4AOVjzr5yuIavUBz05bf0fF1RrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GTc0kWCBRbh5QGghnTQxpQtCzA3+S2ucM0BQbnjUhP40G0ayFk7TM7pRt3WJyumdAF3uki0/ao8jlrFtpQYVtOcUf8M9mxjJG9sweeV80YsPs1nfaU5eglp70vHx9aHcdJxB0tfpfpYmc3ssaAykykRTFVzvhYiRGdV/NLwZ06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkEVWvS1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkEVWvS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1F61F00A3D;
	Fri, 28 Aug 2026 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937887;
	bh=1H/lx7P2LmbfvXJal+ggGabL2bIHsPouZty6eX02v2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZkEVWvS1/h4XJijs9Kkj1mw6FHHxrkyrtndtCe93krvjlPDCtGr35ILelbUpgEJrP
	 FFMQC3yc8QxBZ50G1fiUojCvyxUJQgrjsaH/Jn4msDm1MuORPay7me0LNF1m0zklL0
	 2mAYgPA0byrOQcUea8tgk2uSoOpD3YYixXfuitZ9DUY5VEYPd1G65lStMIdF9Y8OFK
	 8G06rjrOebiRHaEugpDd8UWWIi/IeYKR0z/FacXf1sfw9hSoZ+TVHRRqtv3UvBlZMx
	 Z09zQuZTRj9wTGe1VYyJsF0wipz1AKIoaciNfVJezI5hJIAsdylK565uzHZ3/V8dkE
	 zuFRDVaA23mew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] PCI: endpoint: pci-epf-vntb: Export endpoint DMA
 channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260828170932.2735807-5-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:24:47 +0000
Message-Id: <20260828172447.AD1F61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Massive coherent DMA memory waste/failure when BAR_DMA shares an M=
W BAR.
- [High] epf_ntb_dma_set_active() overwrites the Memory Window (MW) outboun=
d translation address with local DMA memory, breaking peer-to-peer data tra=
nsfers.
- [High] Heap out-of-bounds write and memory leak when multiple memory wind=
ows share the DMA BAR.
- [High] Premature release of `ntb->dma` in `epf_ntb_unbind` leads to a Use=
-After-Free and data race with active NTB clients.
- [Medium] Mixing goto-based error handling and scope-based resource manage=
ment (__free) in the same function.
--

commit 4df8968cc2a35a760bfa7d8e252d1a4b9e0a04c2
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels

This commit allows a Root Complex to use endpoint-local DMA read channels=20
by exporting them via a private control-region extension. It adds new=20
configfs attributes and maps DMA resources through an optional DMA BAR.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index d12d134ce5531..142799f64fe17 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> @@ -219,6 +268,445 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
[ ... ]
> +static int
> +epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> +			const struct pci_epc_aux_resource *ctrl,
> +			const struct pci_epc_aux_resource *resources,
> +			unsigned int count)
> +{
[ ... ]
> +	if (ctrl->u.dma_ctrl.ep_to_rc_ch_cnt > EDMA_MAX_WR_CH ||
> +	    !ctrl->u.dma_ctrl.rc_to_ep_ch_cnt ||
> +	    ctrl->u.dma_ctrl.rc_to_ep_ch_cnt > EDMA_MAX_RD_CH)
> +		return -EINVAL;
> +
> +	struct epf_ntb_dma *dma __free(kfree) =3D
> +		kzalloc(sizeof(*dma), GFP_KERNEL);

[Severity: Medium]
Is it permitted to mix scope-based cleanup (__free) with a manual goto label
in the same function here?

The kernel cleanup guidelines explicitly prohibit mixing goto with scope-ba=
sed
cleanups in the same function, as it creates confusing ownership semantics =
and
can lead to double-free or resource leak bugs.

> +	if (!dma)
> +		return -ENOMEM;
[ ... ]
> +	for (i =3D 0; i < dma->rd_ch_cnt; i++) {
> +		u16 chan_id =3D ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
> +
> +		ret =3D epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
> +		if (ret)
> +			goto err_release;
> +	}
[ ... ]
> +	ntb->dma =3D no_free_ptr(dma);
> +	return 0;
> +
> +err_release:
> +	epf_ntb_dw_edma_release_channels(ntb, dma, false);
> +	return ret;
> +}
[ ... ]
> +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, dma_addr_t ad=
dr,
> +				      bool submapped)
> +{
> +	struct epf_ntb_dma *dma =3D ntb->dma;
> +	struct pci_epf_bar *bar;
> +	dma_addr_t old_addr;
> +	bool old_submapped;
> +	int restore, ret;
> +
> +	lockdep_assert_held(&dma->lock);
> +
> +	bar =3D &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +	old_submapped =3D bar->num_submap;
> +	if (dma->ctrl.submap.offset) {
> +		old_addr =3D dma->submap[0].phys_addr;
> +		dma->submap[0].phys_addr =3D addr;

[Severity: High]
When epf_ntb_dma_set_active() calls epf_ntb_dma_set_bar_locked(ntb,
bar->phys_addr, active) to toggle DMA, does this overwrite the peer's memory
window outbound translation address?

If a virtual ntb driver has previously set the translation address via
vntb_epf_mw_set_trans(), which writes to dma->submap[0].phys_addr, toggling
the DMA link state seems to permanently overwrite this with the local dummy
memory's physical address. This appears to silently break peer-to-peer data
transfers.

> +	}
> +	bar->submap =3D submapped ? dma->submap : NULL;
> +	bar->num_submap =3D submapped ? dma->num_submap : 0;
[ ... ]
> @@ -738,6 +1238,46 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> =20
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
> =20
> +static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_features *features;
> +	struct epf_ntb_dma *dma =3D ntb->dma;
> +	struct pci_epf_bar *bar;
> +	enum pci_barno barno;
> +	u32 mapped_size;
> +	int ret;
> +
> +	features =3D pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
> +					ntb->epf->vfunc_no);
> +	if (!features)
> +		return -EOPNOTSUPP;
> +
> +	barno =3D ntb->epf_ntb_bar[BAR_DMA];
> +	mapped_size =3D dma->ctrl.submap.offset + dma->ctrl.submap.size;
> +	if (!pci_epf_alloc_space(ntb->epf, mapped_size, barno, features,
> +				 PRIMARY_INTERFACE))

[Severity: High]
When the DMA BAR shares a memory window BAR, will this mapping attempt fail
or cause massive memory waste?

The mapped_size is calculated by adding the large memory window size (often=
=20
1GB or more) to the small DMA descriptor size. Then pci_epf_alloc_space()=20
tries to allocate this amount via dma_alloc_coherent(). Requesting gigabyte=
s=20
of contiguous DMA coherent memory typically exceeds the page allocator limi=
ts=20
and fails.

[Severity: High]
If configfs allows multiple memory windows to map to the same BAR as dma_ba=
r,=20
could calling this function repeatedly in a loop in epf_ntb_mw_bar_init()=20
cause a memory leak?

Since space is allocated for the same BAR without freeing prior allocations,
this appears to leak the previously allocated memory on each iteration.

> +		return -ENOMEM;
> +
> +	bar =3D &ntb->epf->bar[barno];
> +	if (bar->size > U32_MAX)
> +		return -EOVERFLOW;
> +
> +	if (dma->ctrl.submap.offset)
> +		dma->submap[0].phys_addr =3D bar->phys_addr;
> +	if (mapped_size < bar->size)
> +		dma->submap[dma->num_submap++] =3D (struct pci_epf_bar_submap) {

[Severity: High]
If epf_ntb_dma_bar_init() is called repeatedly for multiple memory windows,
can this overflow the dma->submap array?

If dma->num_submap exceeds the 11-element capacity, it creates a heap=20
out-of-bounds write that corrupts adjacent fields like reg_submap.

> +			.phys_addr =3D bar->phys_addr + mapped_size,
> +			.size =3D bar->size - mapped_size,
> +		};
> +
> +	ret =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			      ntb->epf->vfunc_no, bar);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
[ ... ]
> @@ -833,20 +1388,43 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>   */
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  {
[ ... ]
> +	if (ntb->dma && ntb->dma->num_submap) {
> +		barno =3D ntb->epf_ntb_bar[BAR_DMA];
> +		if (!ntb->epf->bar[barno].addr)
> +			return;
> +
> +		ntb->epf->bar[barno].submap =3D NULL;
> +		ntb->epf->bar[barno].num_submap =3D 0;

[Severity: High]
Is it safe to update the submap fields locklessly here?

This can race with concurrent accesses to ntb->dma, as ntb->dma->lock is not
acquired before modifying the submap and num_submap fields.

> +		if (!bar_cleared[barno])
> +			pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
> +		pci_epf_free_space(ntb->epf, ntb->epf->bar[barno].addr, barno,
> +				   PRIMARY_INTERFACE);
>  	}
>  }
[ ... ]
> @@ -1423,6 +2026,15 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *n=
dev, int pidx, int idx,
>  	dev =3D &ntb->ntb.dev;
>  	barno =3D ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar =3D &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		if (size !=3D ntb->mws_size[idx])
> +			return -EINVAL;
> +
> +		guard(mutex)(&ntb->dma->lock);

[Severity: High]
Can an active concurrent virtual ntb client trigger a use-after-free here=20
during unbind?

In epf_ntb_unbind(), epf_ntb_dma_release(ntb, true) frees ntb->dma before=20
pci_unregister_driver() stops the virtual ntb clients. An active client=20
calling vntb_epf_mw_set_trans() might evaluate epf_ntb_dma_shares_bar() as=
=20
true, get preempted, and then dereference the freed ntb->dma to acquire the=
=20
lock.

> +
> +		return epf_ntb_dma_set_bar_locked(ntb, addr, true);
> +	}
> +
>  	epf_bar->phys_addr =3D addr;
>  	epf_bar->barno =3D barno;
>  	epf_bar->size =3D size;
[ ... ]
> @@ -1795,6 +2414,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
> =20
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> +	epf_ntb_dma_release(ntb, true);
> =20
>  	pci_unregister_driver(&vntb_pci_driver);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828170932.2735=
807-1-den@valinux.co.jp?part=3D4
