Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462932D1303;
	Mon, 20 Jul 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560919; cv=none; b=t5DopjepWf89GrrX1za10B9SVLlDirYjaOTaK8KLTFJUoNdklEh3LdoMw2MRDDTsjjfr7LlqM6l83UIc4b9hcBEmzm/0xLQ0r9HzbQwocg/pQj4Iku+4/r00x52gcGVr4WEOd4f3KY3FbKl4SFt8CTDR7Bhg3lxPCGxLj/04ZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560919; c=relaxed/simple;
	bh=tIWSOJuud4mOe2zBn2p4Rcs9m/lQpjtCMQSQKkGLNqQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ETsC6st2aJePCT2/BFGXbnVwXAjsl1Su1FKVLwvQdalSgJYSyZfMsdQXSYd/+TvUd3Y7GAIcWY7Op7a78p58CnwZsEmCrc4EzVaGxr6ksOK7Y1TCc6pZxp7pNEBE3yFJeyOrujMz+oYBJkzjBEwP6mnBitnOMoIyiEkoVTc93ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtIh+C2P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtIh+C2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96841F000E9;
	Mon, 20 Jul 2026 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560918;
	bh=YChtaX19+kgFy4ZpVJQmWFihRTswaG95DOHlZhj6lX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtIh+C2P0vqsXgtgljiwhNAmeLMtdfjWC6YaqG3Bi4V4wa7qnYR3jpBUNr9quk9yp
	 9EYO//MBHPLrWk2e9fDoAkdR/yvQ/21idNQXygjuLu7MiZsn5gHdgZv3uYw9yxnifQ
	 GTFzHgYgVss+ud/tag3/oZ3EMC5Tn/5gQDDmg+uWrf2nA2uz65sZdPxKV1+0Dj5110
	 odtsbnez79Ebod+OQozldfysxkkKmhj3bDqqhWp0ZFdAclnf74PajINtYPhof1oUrG
	 /fyVX41shCTsqMPRZg9HCY63lKvOI4gsjltCs3gNn/OJdEPtMZSlyWIn+6JAdq0eXl
	 zZo0BrEK20kRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/16] PCI: dwc: rockchip: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, neil.armstrong@linaro.org, Frank.Li@kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260720150619.24733-7-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:21:57 +0000
Message-Id: <20260720152157.D96841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The DWC core code unconditionally uses `pci->pcie_cap` without che=
cking if it is zero, leading to silent PCI configuration space corruption, =
particularly in endpoint (EP) mode where it remains uninitialized for many =
drivers.
- [Low] An unused variable and redundant DBI read were left behind in `dw_p=
cie_link_get_max_link_width()` during the `pci->pcie_cap` refactoring.

Pre-existing issues:
- [High] Missing cleanup of chained IRQ handler and IRQ domain on probe fai=
lure causes Use-After-Free.
--

--- Patch [6]: [PATCH v3 06/16] PCI: dwc: rockchip: Use cached PCIe capabil=
ity offset ---
commit 66fc930727ddec47d08c4dc09e796cb0d73aa5a9
Author: Hans Zhang <18255117159@163.com>

    PCI: dwc: rockchip: Use cached PCIe capability offset
   =20
    dw_pcie_host_init() calls .init before caching the offset. So inside
    .init we call dw_pcie_get_pcie_cap() to trigger caching. The helper will
    perform the DBI read (hardware is already enabled) and cache the result.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 731d93663ccae..be8b6187913df 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -369,7 +369,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *=
pci)
>  	u32 cap, lnkcap;
> =20
>  	/* Enable L0S capability for all SoCs */
> -	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	cap =3D dw_pcie_get_pcie_cap(pci);
>  	if (cap) {
>  		lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
>  		lnkcap |=3D PCI_EXP_LNKCAP_ASPM_L0S;

[Severity: High]
This is a pre-existing issue, but does this code leave a dangling pointer a=
nd
cause a use-after-free on probe failure?

drivers/pci/controller/dwc/pcie-dw-rockchip.c:
rockchip_pcie_host_init() {
    ...
	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
					 rockchip);
    ...
}

The chained handler is registered with the rockchip devres-managed structur=
e.
If dw_pcie_host_init() fails later in the probe process (for example, while
waiting for the link to come up), the devres framework frees the rockchip
structure.

Since rockchip_pcie_host_ops lacks a .deinit callback to unregister the
chained handler and free the domain, will the handler dereference the freed
rockchip struct if the legacy IRQ fires afterward?

[Severity: High]
Can this corrupt the PCI configuration space if pci->pcie_cap is 0?

drivers/pci/controller/dwc/pcie-designware-ep.c:
dw_pcie_ep_init_non_sticky_registers() {
    ...
	dw_pcie_setup(pci);
    ...
}

drivers/pci/controller/dwc/pcie-designware.c:
dw_pcie_link_set_max_speed() {
    ...
	u8 offset =3D pci->pcie_cap;

	cap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
    ...
}

If an EP driver does not call dw_pcie_get_pcie_cap() during its .init
callback, pci->pcie_cap remains 0. The dw_pcie_ep_init_non_sticky_registers=
()
function unconditionally calls dw_pcie_setup() without verifying if
pci->pcie_cap was initialized.

Does this blindly use offset 0 instead of the PCIe capability structure,
permanently corrupting critical PCI config registers (like Cache Line Size,
Latency Timer, Header Type, or BIST) when offset 0 is accessed?

This also seems contrary to the commit message's claim that a warning would
be printed and the operation skipped, as the DWC core code uses the offset
unconditionally.

[Severity: Low]
Is an unused variable left behind, causing a redundant DBI read?

drivers/pci/controller/dwc/pcie-designware.c:
dw_pcie_link_get_max_link_width() {
	u8 cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
	u32 lnkcap =3D dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
    ...
}

The cap variable is initialized via dw_pcie_find_capability() but is never
used, while the function proceeds to use pci->pcie_cap.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D6
