Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613746;
	b=PY6wslM5jHc5bLVm6B1Aft9Nl7F1hm0lzYunYRogVKzGbo/xa0pt3fbdHMHmjl+ayZDd
	 2i9poYzAkDyTQvbxnNMpkKPdmntruaVyGvvl2uCnJrcSK3QlS/aTvrEjlFLw/6le/Cyan
	 fnjxgeiMFQ03G+7wahYQE+C0H+zPs8zqDjg8DvivtUy4oruosdajYRCiSxJOpgpfOWbQH
	 NQn//F4MKqCjKmRBfiY2XDkqhrSsqItB6TYfdoQuusIIIUIlYVtACmVOl9ROo4Bqj/gWd
	 FlyfkE0dnpe7LhqrMfsz4lQDvlxNQsHIdd7bQ9ZFpAL+yed+IyFreL3zhJtboUYjXnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MI1JeXB7CKQMvfjOX7aLjrElRMmwvwQ0npNIxQ6XTUs=;
	b=NOS0dtBp+jZDKi8xfro3cCZexPm3Rki7jf+rgNDHkQI0ko8yvKpcNnRkrSe+mqAqZdQu
	 TYBVKxoBysXcbThOaOL2huZZKHB8kzDGfS5ypapt1u4SOwqzTHPPQuSsQq3Qc0quSyr+Y
	 14tXJDwjnP7V18hvyNMtbdP7KX2JL1IzUb2u+03fBY8pBUU04kx8U4WrC3J6AQiWItlKe
	 OA8X5iarQxLNsaTQs5W6TYCBUvJvMCAa/YeOc5XaOl7iBJH+E3C6acYpaX8o6NNMOLhza
	 yW5GFY6+6StNJZF3c1FTp1+iw4rgBhuYKUGEt6imI0uueY/Vp2CwIIXArZguzNBNz/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9D1AYNp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7B606A336
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i9D1AYNp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87AD1F000D0;
	Wed, 25 Nov 2026 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613745;
	bh=MI1JeXB7CKQMvfjOX7aLjrElRMmwvwQ0npNIxQ6XTUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i9D1AYNph0VEDPm7fb+n234OgucaTDJKTjzmdm/wZM+rmuYu0bYLS9jx0LoH1psvm
	 CPYPwAjN6S4Ew7KhmOwHeRy10GzvwWrcvnsZr0hL2FjZtUbM/vJ/igGLGUrYX2+16b
	 8xSt3GccSsWcQ1Be0RvJJVmtOHvhztc6QmXRRRR4HV48TajUEBX8kCjOFYDhTHy8gL
	 l2K7n8Y7WELRMWsFHOWjN8pAvw/s1dHtPRWG64EZGcH8Q+l/scD3hTdMZr8xwSPcww
	 SfLFvl/K5o8WLEs6dhBQ+v4RnYmv0P5nsTa3cqTUhCSAKiIxWkfv29+5JMURrT0Kgl
	 2VrrsgODudkvg==
Message-ID: <sashiko-outbox-233493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR
 erratum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmoy Das" <nirmoyd@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125131838.1272907-1-nirmoyd@nvidia.com>
References: <20261125131838.1272907-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:35:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] PCI: broken BAR readback check in
  pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror()
- [Medium] PCI: stale firmware BAR mirrored in
  pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror()
--

commit aff9cc8487ab3357c2581d1e1130b4ea710052d7
Author: Nirmoy Das <nirmoyd@nvidia.com>

PCI: Work around Pericom PI7C9X3G606GPC Port 4 BAR erratum

This commit adds final and early-resume PCI fixups to mirror the upstream
port's BAR 0 (and BAR 1 if 64-bit) into Port 4 on Pericom PI7C9X3G606GPC
switches when CDEP is disabled.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee41..2d3f677d0d4d2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6443,6 +6443,95 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x=
2608,
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
>  			 pci_fixup_pericom_acs_store_forward);
> =20
> +#define PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC	0xc008
> +
> +/*
> + * With CDEP disabled, Port 4 exposes no BAR or MSI-X capability, but its
> + * internal MSI-X Table/PBA address check remains active. Mirror the
> + * upstream BAR 0 to keep these addresses in MMIO space assigned to the
> + * switch.
> + *
> + * Port 4 is device 4, function 0 below the upstream port. Its BAR 0
> + * accepts writes but reads as zero, so BAR sizing clears the mirror.
> + * Reapply it after resource assignment and during early resume, after
> + * PCI state restoration.
> + */
> +static void pci_fixup_pericom_pi7c9x3g606gpc_bar0_mirror(struct pci_dev =
*pdev)
> +{
> +	struct pci_dev *upstream;
> +	bool bar0_64, disable_mem;
> +	u16 cmd =3D 0;
> +	u32 bar =3D 0, bar1 =3D 0, upstream_bar =3D 0, upstream_bar1 =3D 0;
> +
> +	if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> +		return;
> +
> +	if (PCI_SLOT(pdev->devfn) !=3D 4 || PCI_FUNC(pdev->devfn))
> +		return;
> +
> +	upstream =3D pci_upstream_bridge(pdev);
> +	if (!upstream || upstream->vendor !=3D PCI_VENDOR_ID_PERICOM ||
> +	    upstream->device !=3D PCI_DEVICE_ID_PERICOM_PI7C9X3G606GPC ||
> +	    pci_pcie_type(upstream) !=3D PCI_EXP_TYPE_UPSTREAM)
> +		return;
> +
> +	pci_read_config_dword(upstream, PCI_BASE_ADDRESS_0, &upstream_bar);
> +	if (upstream_bar & PCI_BASE_ADDRESS_SPACE_IO)
> +		return;
> +
> +	bar0_64 =3D (upstream_bar & PCI_BASE_ADDRESS_MEM_TYPE_MASK) =3D=3D
> +		  PCI_BASE_ADDRESS_MEM_TYPE_64;
> +	if (bar0_64)
> +		pci_read_config_dword(upstream, PCI_BASE_ADDRESS_1,
> +				      &upstream_bar1);
> +
> +	if (!(upstream_bar & PCI_BASE_ADDRESS_MEM_MASK) &&
> +	    (!bar0_64 || !upstream_bar1)) {
> +		pci_warn(pdev, "skipping PI7C9X3G606GPC BAR 0 mirror workaround becaus=
e upstream BAR 0 is unassigned\n");
> +		return;
> +	}

[Severity: Medium]
Can this check miss an unassigned upstream BAR 0 when firmware left a stale
address in PCI_BASE_ADDRESS_0?

During BAR sizing, __pci_size_bars() saves and restores the firmware value =
in
PCI_BASE_ADDRESS_0.  If claiming or reassigning upstream->resource[0] fails,
the resource is marked IORESOURCE_UNSET or cleared by reset_resource(), and
pci_std_update_resource() never writes to config space:

drivers/pci/setup-res.c:pci_std_update_resource() {
	...
	if (!res->flags)
		return;

	if (res->flags & IORESOURCE_UNSET)
		return;
	...
}

Because PCI_BASE_ADDRESS_0 still holds the firmware address, this check pas=
ses
and mirrors the stale address into Port 4.  If Linux assigned that MMIO ran=
ge
to a bridge window for downstream devices, Port 4's BAR 0 + 0x7f000 and
BAR 0 + 0x7f080 address check will reject accesses to those addresses with
Unsupported Request completions.  Checking upstream->resource[0].flags for
IORESOURCE_MEM and !IORESOURCE_UNSET would ensure the upstream BAR is actua=
lly
assigned.

> +
> +	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &bar);
> +	if (bar0_64) {
> +		pci_read_config_dword(pdev, PCI_BASE_ADDRESS_1, &bar1);
> +		if (bar =3D=3D upstream_bar && bar1 =3D=3D upstream_bar1)
> +			return;
> +	} else {
> +		if (bar =3D=3D upstream_bar)
> +			return;
> +	}

[Severity: Medium]
What is this readback check intended to guard against?

As the comment above notes, Port 4 BAR 0 always reads back as zero when CDEP
is disabled, while the check just before this guarantees upstream_bar (or
upstream_bar1) is non-zero.  As a result, bar =3D=3D upstream_bar is always=
 false
when CDEP is disabled, so every pci_fixup_resume_early call (including runt=
ime
resume) will toggle PCI_COMMAND_MEMORY for 64-bit BARs, rewrite BAR 0/1, and
log a pci_info() message.  Conversely, if Port 4 ever exposes a valid non-z=
ero
BAR of its own, bar !=3D upstream_bar will not bail out and the fixup will
overwrite Port 4's BAR with upstream_bar.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125131838.1272=
907-1-nirmoyd@nvidia.com?part=3D1
