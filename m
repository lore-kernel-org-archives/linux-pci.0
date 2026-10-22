Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659029;
	b=nsq0kR4GJadXvIE27b4q23jhnTej6LiCHvkA4ZuzDv9lN9Afxz/l5INVyJ5q61W5ojYr
	 yl/7jCRULJpVMuxDMSFAmeGmVZtuWrPtWgF2+plM/AwlJupGO44zE7rSGH45nxL6BPZ2N
	 qBkwrDj4gdhQAK0lCnlTq2+Iq1yqcJjE35hkDCa6OlHsPcH1lbuoyX+CYkbXDliji48Vy
	 CXDq1w01JlVYt/lmrcA4X/HxGwhoXBV3Js8PxCSZtTgqi2diWCVIb0V8dHCf1aQSLH4kv
	 xszR4cY9JclzA4BipTjh5167oa+AD/pZMgzTrsdoA+/+Okh+5M/yKgOUDvzEyEd8V8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659029;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ym/bJM6ntGbFb7UTtzUJAMH1qtkQtOEvzym1w8CkNPA=;
	b=J5Qral2b0f7QzKioqXMH572rPeCsjiC7ks1YgdEBmllReDN4S4/VarcQz+O7WtsBKInX
	 +gu3e+uO+GRnhRRxH78xSTR38SMldu4FQQq3HWz5zY6+DMh482jkbI/+mI2NfzPDG4l8X
	 2VraQSCQKPMomCEiiFyAocXDuPRKd/qMBRxDLaSO9uEuf3s6tsdvMKKUbRaK4FhP/5++R
	 EtvMXzufjOEVRMhe6pwkwemminQF+14K4bV58x9wadW6hq1JiLq6BnYY3TdOJRlrlzAoe
	 N+o1SEQyPtbKXXtK1x41VCxcWVP/GEuwzbiNdgvaddryDkWE0pSNnSSZyxDkEJzPOpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bd8LSUbQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95A606A319;
	Thu, 22 Oct 2026 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bd8LSUbQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAE01F000C1;
	Thu, 22 Oct 2026 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792659028;
	bh=Ym/bJM6ntGbFb7UTtzUJAMH1qtkQtOEvzym1w8CkNPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bd8LSUbQtGQA8IiDV3+eyly33lMpzBpMlOxt8xVsrhRzHnXH/psLrVMPxtbyzUWtG
	 X0X7YVuhbs/kpJ+AlbnusiefC1h8fr50lDNNfCriZcgMBoEBpngcghDBmWyvZmkRMy
	 pRokqxprbTrQDlPp33ardhgGZ7yTjW/1zDDC+rA3oP73PuwALLIKRsDP5KVLwqivzB
	 whhun6H8cwPFtmN20paxAC+AWhY7QafgdSgJYSMYUwRH/FeNJXs+RMRTWFpNQymskD
	 Y16A3mGYhSPDeLL0O/7xXgwNdmFxKWNvIxhyyNnzRnICuMo2MMzV/vdSiapiqnLUcR
	 v4GL6Eqyjw2WQ==
Message-ID: <sashiko-outbox-181205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20261022082230.3164834-7-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:50:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: endpoint: pci-epf-vntb: broken BAR state transitions in mw_fa=
llback mode
- [High] PCI: endpoint: pci-epf-vntb: invalid MW size and alignment on shar=
ed DMA BAR
- [Medium] PCI: endpoint: pci-epf-vntb: missing align and BAR checks in dw_=
edma_collect()
--

commit 4d1b8b7b5e0ea9addaa11899a4e93158d8021399
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR

This commit allows the DMA BAR in pci-epf-vntb to share a BAR with a memory
window by placing DMA subrange mappings after the configured MW prefix. It
also adds a fallback mode for older hosts that do not advertise MW/DMA
boundary support on link up, exposing the whole shared BAR as an MW.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index ac83af54122f7..2f41a37a2e9d9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -371,10 +390,31 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *=
ntb,
>  	if (!is_power_of_2(align))
>  		return -EINVAL;
> =20
> -	if (epf_ntb_is_bar_used(ntb, barno) ||
> -	    pci_epc_get_next_free_bar(features, barno) !=3D barno)
> +	if (barno =3D=3D ntb->epf_ntb_bar[BAR_CONFIG] ||
> +	    barno =3D=3D ntb->epf_ntb_bar[BAR_DB])
>  		return -EINVAL;
> =20
> +	offset =3D epf_ntb_dma_bar_offset(ntb, barno);
> +	if (!offset &&
> +	    (epf_ntb_is_bar_used(ntb, barno) ||
> +	     pci_epc_get_next_free_bar(features, barno) !=3D barno))
> +		return -EINVAL;
> +	if (offset > U32_MAX)
> +		return -EOVERFLOW;
> +	if (offset && !is_power_of_2(offset))
> +		return -EINVAL;
> +	dma->ctrl.submap.offset =3D offset;
> +	next =3D offset;
> +	if (next) {
> +		/*
> +		 * submap[0] covers the MW prefix. Keep its temporary
> +		 * target at address 0 until the MW translation is
> +		 * installed.
> +		 */
> +		dma->submap[0].size =3D next;
> +		dma->num_submap =3D 1;
> +	}

[Severity: Medium]
In drivers/pci/endpoint/functions/pci-epf-vntb.c, could
epf_ntb_dw_edma_collect() accept a shared BAR configuration that later fails
at runtime or uses a reserved EPC BAR?

First, when offset is non-zero, offset is checked with is_power_of_2(offset=
),
but it is not checked with IS_ALIGNED(offset, align) where align is
features->align ?: 1. If the configured MW size is a power of two smaller
than features->align (for example, 4 KB on a DesignWare EPC with a 64 KB
region_align), epf_ntb_bind() succeeds because epf_ntb_dma_bar_init() sets =
up
the BAR with num_submap =3D=3D 0. However, when epf_ntb_dma_set_bar() or
vntb_epf_mw_set_trans() later installs the submaps, dma->submap[0].size and
all subsequent submap offsets are unaligned to align, so
dw_pcie_ep_validate_submap() rejects the update:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_validate_submap(=
) {
	...
		if (!IS_ALIGNED(size, align) || !IS_ALIGNED(off, align))
			return -EINVAL;
	...
}

Second, because epf_ntb_find_bar() skips BAR numbers that were explicitly
assigned through configfs, sharing a BAR between an MW and BAR_DMA requires
configuring both in configfs. Gating pci_epc_get_next_free_bar(features,
barno) !=3D barno behind !offset here (while epf_ntb_mw_bar_init() also ski=
ps
pci_epc_set_bar() when shared is true) means pci_epc_get_next_free_bar() is
never checked when offset !=3D 0, allowing BAR_RESERVED, BAR_DISABLED, or t=
he
upper half of a 64-bit BAR to bypass validation here.

Should pci_epc_get_next_free_bar(features, barno) !=3D barno be checked
unconditionally, and should offset be checked with IS_ALIGNED(offset, align=
)?

[ ... ]

> @@ -607,23 +649,29 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *n=
tb)
>  	memset(bar, 0, sizeof(*bar));
>  }
> =20
> -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool use_subm=
ap,
> +				      const dma_addr_t *mw_addr)
>  {
> -	struct pci_epf_bar_submap *old_submap;
>  	struct epf_ntb_dma *dma =3D ntb->dma;
> -	unsigned int old_num_submap;
> -	struct pci_epf_bar *bar;
> +	struct pci_epf_bar *bar, old_bar;
> +	dma_addr_t old_mw_addr;
>  	int restore, ret;
> =20
> -	if (!dma)
> -		return 0;
> +	lockdep_assert_held(&dma->lock);
> =20
>  	bar =3D &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> -
> -	old_submap =3D bar->submap;
> -	old_num_submap =3D bar->num_submap;
> -	bar->submap =3D dma->submap;
> -	bar->num_submap =3D dma->num_submap;
> +	old_bar =3D *bar;
> +	old_mw_addr =3D dma->submap[0].phys_addr;
> +	if (use_submap) {
> +		if (mw_addr)
> +			dma->submap[0].phys_addr =3D *mw_addr;
> +		bar->submap =3D dma->submap;
> +		bar->num_submap =3D dma->num_submap;
> +	} else {
> +		bar->submap =3D NULL;
> +		bar->num_submap =3D 0;
> +		bar->phys_addr =3D mw_addr ? *mw_addr : 0;
> +	}
> =20
>  	ret =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
>  			      ntb->epf->vfunc_no, bar);
> @@ -631,8 +679,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  		return 0;
> =20
>  	/* A failed dynamic update may have already removed the old mapping. */
> -	bar->submap =3D old_submap;
> -	bar->num_submap =3D old_num_submap;
> +	dma->submap[0].phys_addr =3D old_mw_addr;
> +	*bar =3D old_bar;
>  	restore =3D pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
>  				  ntb->epf->vfunc_no, bar);
>  	if (restore)
> @@ -642,6 +690,51 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
>  	return ret;
>  }
> =20
> +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> +{
> +	struct epf_ntb_dma *dma =3D ntb->dma;
> +
> +	if (!dma)
> +		return 0;
> +
> +	guard(mutex)(&dma->lock);
> +
> +	return epf_ntb_dma_set_bar_locked(ntb, true, NULL);
> +}
> +
> +static int epf_ntb_dma_link_up(struct epf_ntb *ntb, u32 argument)
> +{
> +	struct epf_ntb_dma *dma =3D ntb->dma;
> +	struct pci_epf_bar *bar;
> +	bool fallback;
> +	int ret;
> +
> +	if (!dma || !dma->ctrl.submap.offset)
> +		return 0;
> +
> +	fallback =3D !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
> +
> +	guard(mutex)(&dma->lock);
> +
> +	if (fallback =3D=3D dma->mw_fallback)
> +		return 0;
> +
> +	if (fallback) {
> +		dev_warn(&ntb->epf->dev,
> +			 "Host does not support MW/DMA BAR sharing, exposing the whole BAR as=
 an MW\n");
> +		/* Replace installed DMA submaps until the MW is set up. */
> +		bar =3D &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> +		if (bar->num_submap) {
> +			ret =3D epf_ntb_dma_set_bar_locked(ntb, false, NULL);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	dma->mw_fallback =3D fallback;
> +
> +	return 0;
> +}

[Severity: High]
How do epf_ntb_dma_set_bar_locked(), epf_ntb_dma_set_bar(),
epf_ntb_dma_link_up(), and vntb_epf_mw_set_trans() keep the BAR state and MW
translation address synchronized across mw_fallback transitions?

In epf_ntb_dma_set_bar_locked(), the MW translation address is stored in two
different places depending on use_submap: when use_submap is true, *mw_addr
updates dma->submap[0].phys_addr, whereas when use_submap is false, *mw_addr
updates bar->phys_addr (and resets bar->phys_addr to 0 when mw_addr is NULL=
).

This appears to cause several state regressions across command orderings:

1. If vntb_epf_mw_set_trans() configures the MW before an older host sends
EPF_NTB_COMMAND_LINK_UP (while dma->mw_fallback is still false), it calls
epf_ntb_dma_set_bar_locked(ntb, true, &addr), storing the MW address in
dma->submap[0].phys_addr while bar->phys_addr remains 0. When the older host
then sends EPF_NTB_COMMAND_LINK_UP without EPF_NTB_LINK_UP_DMA_MW_SUPPORTED,
epf_ntb_dma_link_up() calls:

	ret =3D epf_ntb_dma_set_bar_locked(ntb, false, NULL);

which sets bar->phys_addr =3D 0 and wipes out the already configured MW
translation.

2. In epf_ntb_dma_set_bar() (handling EPF_NTB_COMMAND_SETUP_DMA_BAR),
epf_ntb_dma_set_bar_locked(ntb, true, NULL) is called unconditionally witho=
ut
checking or updating dma->mw_fallback. If dma->mw_fallback became true duri=
ng
an earlier link-up and the host later re-runs EPF_NTB_COMMAND_SETUP_DMA_BAR
followed by EPF_NTB_COMMAND_LINK_UP with fallback =3D=3D true,
epf_ntb_dma_set_bar() reinstalls bar->submap while leaving dma->mw_fallback
set to true. When epf_ntb_dma_link_up() then runs:

	if (fallback =3D=3D dma->mw_fallback)
		return 0;

it returns early without removing the reinstalled DMA submaps. Similarly, if
EPF_NTB_COMMAND_SETUP_DMA_BAR arrives while dma->mw_fallback is true after
vntb_epf_mw_set_trans() configured bar->phys_addr, epf_ntb_dma_set_bar()
overwrites the BAR mapping with dma->submap where dma->submap[0].phys_addr =
is
0 or stale.

3. Conversely, when transitioning from dma->mw_fallback =3D=3D true back to
fallback =3D=3D false, if vntb_epf_mw_set_trans() ran while dma->mw_fallbac=
k was
true, it called epf_ntb_dma_set_bar_locked(ntb, false, &addr) which cleared
bar->submap and stored addr only in bar->phys_addr. When
epf_ntb_dma_link_up() then sees fallback =3D=3D false, it only sets
dma->mw_fallback =3D false without reinstalling dma->submap or migrating
bar->phys_addr into dma->submap[0].phys_addr.

[ ... ]

> @@ -1936,6 +2037,21 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *n=
dev, int pidx, int idx,
>  	dev =3D &ndev->dev;
>  	barno =3D ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar =3D &ntb->epf->bar[barno];
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		guard(mutex)(&ntb->dma->lock);
> +
> +		if (ntb->dma->mw_fallback) {
> +			if (size > epf_bar->size)
> +				return -EINVAL;
> +		} else if (size !=3D ntb->mws_size[idx]) {
> +			/* DMA submaps start after the configured MW size. */
> +			return -EINVAL;
> +		}
> +
> +		return epf_ntb_dma_set_bar_locked(ntb, !ntb->dma->mw_fallback,
> +						  &addr);
> +	}
> +
>  	epf_bar->phys_addr =3D addr;
>  	epf_bar->barno =3D barno;
>  	epf_bar->size =3D size;
> @@ -2134,15 +2250,29 @@ static int vntb_epf_mw_get_align(struct ntb_dev *=
ndev, int pidx, int idx,
>  			resource_size_t *size_max)
>  {
>  	struct epf_ntb *ntb =3D ntb_ndev(ndev);
> +	enum pci_barno barno =3D ntb->epf_ntb_bar[BAR_MW1 + idx];
> +	resource_size_t salign =3D 1;
> +	u64 size =3D ntb->mws_size[idx];
> +
> +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> +		if (ntb->dma->mw_fallback)
> +			size =3D ntb->epf->bar[barno].size;
> +		else
> +			/*
> +			 * DMA submaps start after the configured MW size.
> +			 * Use size_align to require a full-size MW translation.
> +			 */
> +			salign =3D size;
> +	}
> =20
>  	if (addr_align)
>  		*addr_align =3D SZ_4K;
> =20
>  	if (size_align)
> -		*size_align =3D 1;
> +		*size_align =3D salign;
> =20
>  	if (size_max)
> -		*size_max =3D ntb->mws_size[idx];
> +		*size_max =3D size;
> =20
>  	return 0;
>  }

[Severity: High]
What happens in vntb_epf_mw_get_align() and vntb_epf_mw_set_trans() when an
NTB client allocates a memory window buffer smaller than the BAR or MW size
on a shared BAR?

1. In mw_fallback mode (ntb->dma->mw_fallback =3D=3D true),
vntb_epf_mw_get_align() leaves salign =3D 1 and *addr_align =3D SZ_4K, while
vntb_epf_mw_set_trans() accepts any size <=3D epf_bar->size and calls
epf_ntb_dma_set_bar_locked(ntb, false, &addr). Unlike the non-shared path
(which updates epf_bar->size =3D size), epf_ntb_dma_set_bar_locked() keeps
bar->size at the full enumerated BAR size in BAR Match Mode (num_submap =3D=
 0).

In the DesignWare EPC driver, BAR Match Mode validates and maps the full
epf_bar->size:

drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_prog_ep_inbound_atu() {
	...
	if (!IS_ALIGNED(parent_bus_addr, pci->region_align) ||
	    !IS_ALIGNED(parent_bus_addr, size))
		return -EINVAL;
	...
}

When an NTB client (such as ntb_tool, ntb_msi, ntb_perf, or ntb_transport
with max_mw_size) allocates a buffer with size < epf_bar->size, the DMA
address is only aligned to the smaller buffer size or SZ_4K, causing
pci_epc_set_bar() to fail with -EINVAL. If the buffer address happens to be
aligned to epf_bar->size, BAR Match Mode maps the full epf_bar->size window
over the smaller allocation, exposing adjacent unallocated endpoint memory =
to
the host.

2. In normal shared-BAR mode (ntb->dma->mw_fallback =3D=3D false),
vntb_epf_mw_get_align() sets *size_align =3D ntb->mws_size[idx] while leavi=
ng
*addr_align =3D SZ_4K. In drivers/ntb/ntb_transport.c:ntb_set_mw():

	rc =3D ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
			      &xlat_align_size, NULL);
	if (rc)
		return rc;

	xlat_size =3D round_up(size, xlat_align_size);
	buff_size =3D round_up(size, xlat_align);

If the requested size is smaller than ntb->mws_size[idx], ntb_set_mw()
allocates only buff_size (rounded to SZ_4K) but passes xlat_size (rounded up
to ntb->mws_size[idx]) to ntb_mw_set_trans(), mapping the full submap[0].si=
ze
over the smaller buff_size allocation. Also, if features->align > SZ_4K,
reporting *addr_align =3D SZ_4K allows clients to allocate DMA buffers that=
 are
not aligned to features->align, which dw_pcie_ep_validate_submap() rejects
with -EINVAL.

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D6
