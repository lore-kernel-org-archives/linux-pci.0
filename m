Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287791;
	b=4aNGijO5DPPnZchGIwWH96yRlra3UyOzeOBEXO4HMou0M5D0oVQrx2k5zcawwDBxltCf
	 5IRXZE/dRd0wyPF2p+OXeWwGnjDFVp7Rpbc9uXpFX66QFC3OSPVMBe/fTjCazhPGw0o0W
	 jNmAciP7/3/v8DNBEaFxLVU3eEgq8UNt2QFL6zu4jil2WxOs+TsAtXM3KZKETWckUsZdE
	 e+uFhMVsRZ1K0q/OYpJ11YWfycItOsmvxTPa/w+uwJCCakOH1SYkLy801zMI57RkmP5ki
	 CrqsB1DBzYWid4VE2ACpRwy1URuQ61tJ9kFrkZ9zq2ktGBQVME6c2Ov7qeFntqjg/Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OO7TkYUjjpVmmmdlvA5Uy4POtQ6D3oUqzw1Nn5yMXKs=;
	b=UR3ghpeNzcU2BfjWZVA8ji8RjDINEQ+cttisMg+FqQIuSEzZRiyRFiJAZWhxg56UJpaz
	 oaiKdczSecBzBgehIOSWl40l/DrYTvXo6sw475J/V+RJ18PO0bpN5htuYLXm0vjBHcMuM
	 nT0dQit+x6izrdP1v78yDWbvl35mHs8+pwEXf6z7J2OAiZ/ig3ZMCpvDLAPJsMNFfuTyk
	 /uQK+RiYkmUUylBFyM/Xh/E/+dUN8EZLzJeHRKVc5CgS8F7dnez5ItnDd/pkbcpwCdDFN
	 cIWMInRD57aKFmCLfWDGB6sP+nbfHvEtey9f9sAP2huvLTqMzmmEGJO+xPWbpKNViEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAR6fYgO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECF606A31F;
	Thu, 29 Oct 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAR6fYgO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5031F01447;
	Thu, 29 Oct 2026 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793287790;
	bh=OO7TkYUjjpVmmmdlvA5Uy4POtQ6D3oUqzw1Nn5yMXKs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LAR6fYgOpeBqG0FPrUqTeFsSTlfuuYIIbf2HsJuQCMLiR7tS8R+glzDHbQWg02XCV
	 KbRRJ8qR5AXtYSeWIIDKD48Jbat2J8ZiX1kY7NtndDGwpI6gPuBFsmZvFtTFiJOipf
	 AsJN/isq2pByG5Al29tmNdP8FSVa4VOXK64xNq8VSwLHqFLS/esgi3OjQcCNdH3sZz
	 rPAacKSzKSta07jcN9F9Z2blgNLvRBEez8yZzquUbuuojmq47n0nYbMMJywCrInhMS
	 p7BB1j2Qksvm7ZlRNkBaExQdn67CGj5/o7nV/VIgvTHn1V1MHdX5OdnJzF+70n2Uw+
	 fk6C5l05izmYw==
Message-ID: <sashiko-outbox-189606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 11/18] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-12-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:29:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] PCI/CXL: out-of-bounds MMIO read in cxl_pci_hdm_map_regs() before =
bounds check
- [High] PCI/CXL: pci_cxl_hdm_cache_init() runs before BAR assignment and b=
ridge enable
- [Medium] cxl/pci: unchecked PCI_POSSIBLE_ERROR() in cxl_set_mem_enable() =
corrupts cached dvsec_ctrl
- [Medium] cxl/pci: disable_hdm() leaves stale CXL_HDM_DECODER_ENABLE in ca=
ched global_ctrl
--

commit a7ebc7643586c3c5e8b6adb597a5c7e1384802d3
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Cache endpoint HDM state during PCI enumeration

This commit caches endpoint HDM decoder and Device DVSEC state in
pci_dev->hdm during PCI enumeration so that CXL reset paths can restore
hardware state without a bound CXL driver. It also hooks DVSEC control
updates in the CXL core to keep the cached DVSEC control value synchronized.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e2034a2179b48..44fa9d5d1a052 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -209,22 +209,24 @@ static int cxl_set_mem_enable(struct cxl_dev_state =
*cxlds, u16 val)
>  	struct pci_dev *pdev =3D to_pci_dev(cxlds->dev);
>  	int d =3D cxlds->cxl_dvsec;
>  	u16 ctrl;
> -	int rc;
> +	int rc, ret =3D 1;
> =20
>  	rc =3D pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
> =20
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) =3D=3D val)
> -		return 1;
> -	ctrl &=3D ~PCI_DVSEC_CXL_MEM_ENABLE;
> -	ctrl |=3D val;
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) !=3D val) {
> +		ctrl &=3D ~PCI_DVSEC_CXL_MEM_ENABLE;
> +		ctrl |=3D val;
> =20
> -	rc =3D pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> -	if (rc)
> -		return pcibios_err_to_errno(rc);
> +		rc =3D pci_write_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, ctrl);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		ret =3D 0;
> +	}
> =20
> -	return 0;
> +	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);

[Severity: Medium]
What happens in cxl_set_mem_enable() if the device is undergoing a reset or
the link is down when pci_read_config_word() reads PCI_DVSEC_CXL_CTRL?

On root complexes where config reads to an unresponsive device return
PCIBIOS_SUCCESSFUL with ctrl =3D=3D 0xffff, cxl_set_mem_enable() does not c=
heck
PCI_POSSIBLE_ERROR(ctrl). When called from clear_mem_enable() during endpoi=
nt
port teardown (which is not serialized by pci_dev_lock(pdev)) or from
devm_cxl_enable_mem(), ctrl (0xffff) is masked to 0xfffb (or kept as 0xffff=
),
written back to PCI_DVSEC_CXL_CTRL (including RW1C Viral_Status,
Viral_Enable, Cache_Enable, and reserved bits), and then stored into
pdev->hdm->dvsec_ctrl via cxl_hdm_cache_set_dvsec_ctrl().

Unlike cxl_hdm_cache_refresh_decoder(), which checks global_ctrl !=3D U32_M=
AX
to preserve the last good value when the device does not respond,
cxl_hdm_cache_set_dvsec_ctrl() unconditionally overwrites
pdev->hdm->dvsec_ctrl, permanently clobbering the cached DVSEC control state
for subsequent resets. Should cxl_set_mem_enable() check
PCI_POSSIBLE_ERROR(ctrl) before modifying and caching ctrl?

[Severity: Medium]
Also, while cxl_set_mem_enable() and clear_mem_enable() keep
pdev->hdm->dvsec_ctrl updated on both enable and teardown, does disable_hdm=
()
leave a stale CXL_HDM_DECODER_ENABLE bit in pdev->hdm->global_ctrl?

When the CXL driver binds and sets up endpoint decoders:

  devm_cxl_endpoint_decoders_setup()
    cxl_hdm_decode_init()
      devm_cxl_enable_hdm()
      devm_cxl_enable_mem()
        cxl_set_mem_enable()
          cxl_hdm_cache_set_dvsec_ctrl()
    devm_cxl_enumerate_decoders()
      cxl_hdm_refresh_decoder()
        cxl_hdm_cache_refresh_decoder()
          info->global_ctrl =3D readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);

cxl_hdm_cache_refresh_decoder() latches CXL_HDM_DECODER_ENABLE into
pdev->hdm->global_ctrl. When the endpoint port driver later unbinds (or fai=
ls
probe after refreshing a decoder), devres runs clear_mem_enable(), which
clears PCI_DVSEC_CXL_MEM_ENABLE in pdev->hdm->dvsec_ctrl, and then runs
disable_hdm():

drivers/cxl/core/pci.c:disable_hdm() {
	global_ctrl =3D readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
	writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
}

Because disable_hdm() does not update pdev->hdm->global_ctrl, a subsequent
reset while unbound will restore CXL_HDM_DECODER_ENABLE in hardware while
PCI_DVSEC_CXL_MEM_ENABLE is disabled, and a later CXL driver re-bind in
cxl_hdm_decode_init() will see CXL_HDM_DECODER_ENABLE already set and skip
devm_cxl_enable_hdm(). Should disable_hdm() (and devm_cxl_enable_hdm()) also
update pdev->hdm->global_ctrl?

[ ... ]

> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3e..aad567fb7c560 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -359,6 +359,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> =20
>  	/* Save config space for error recoverability */
>  	pci_save_state(dev);
> +	pci_cxl_hdm_cache_init(dev);

[Severity: High]
Can pci_cxl_hdm_cache_init() run here before BAR resources are validated and
assigned, or while upstream bridges still have memory decoding disabled?

On x86 ACPI boot, acpi_init() (subsys_initcall) enumerates the root bus and
calls pci_bus_add_devices() -> pci_bus_add_device() before pci_subsys_init()
runs pcibios_resource_survey() and before pcibios_assign_resources()
(fs_initcall) assigns unassigned resources:

  acpi_init()
    acpi_pci_root_add()
      pci_bus_add_devices()
        pci_bus_add_device()
          pci_cxl_hdm_cache_init()

In drivers/pci/cxl.c, cxl_pci_bar_assigned() checks res->start and res->end
without checking res->parent:

drivers/pci/cxl.c:cxl_pci_bar_assigned() {
	struct resource *res =3D &pdev->resource[bar];

	return pci_resource_len(pdev, bar) &&
	       !(res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) &&
	       resource_type(res) =3D=3D IORESOURCE_MEM && res->start && res->end;
}

And cxl_pci_hdm_read_info() temporarily sets PCI_COMMAND_MEMORY directly on
pdev without enabling upstream bridges:

drivers/pci/cxl.c:cxl_pci_hdm_read_info() {
	if (!(command & PCI_COMMAND_MEMORY)) {
		rc =3D pci_write_config_word(pdev, PCI_COMMAND,
					   command | PCI_COMMAND_MEMORY);
		...
	}
}

This appears to have two consequences:
1. If a disabled device has an unclaimed BIOS BAR address that conflicts wi=
th
   another resource, enabling PCI_COMMAND_MEMORY before
   pcibios_resource_survey() claims and validates resources can activate the
   conflicting BAR decoding.
2. If the endpoint BAR or an upstream bridge window is assigned later during
   pcibios_assign_resources(), or if an upstream PCI-to-PCI bridge does not
   have PCI_COMMAND_MEMORY enabled yet, pci_cxl_hdm_cache_init() fails and
   leaves pdev->hdm permanently NULL.

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> new file mode 100644
> index 0000000000000..b992f71d964a8
> --- /dev/null
> +++ b/drivers/pci/cxl.c
[ ... ]
> +static void __iomem *cxl_pci_hdm_map_regs(struct pci_dev *pdev,
> +					  struct cxl_register_map *map,
> +					  resource_size_t *hdm_offset,
> +					  int *decoder_count)
> +{
> +	struct cxl_reg_map *hdm_map =3D &map->component_map.hdm_decoder;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	/* cxl_setup_regs() populates hdm_map, including its valid bit. */
> +	rc =3D cxl_setup_regs(map);
> +	if (rc)
> +		return ERR_PTR(rc);
> +	if (!hdm_map->valid)
> +		return ERR_PTR(-ENODEV);
> +	if (hdm_map->offset > map->max_size ||
> +	    hdm_map->size > map->max_size - hdm_map->offset)
> +		return ERR_PTR(-ENXIO);

[Severity: High]
Does cxl_setup_regs(map) perform MMIO reads past map->max_size before the
bounds check in cxl_pci_hdm_map_regs() is reached?

In __pci_cxl_hdm_cache_init(), cxl_find_regblock() populates map via
cxl_decode_regblock(), which only checks offset > pci_resource_len(pdev, ba=
r)
and sets map->max_size =3D pci_resource_len(pdev, bar) - offset.

When cxl_pci_hdm_map_regs() calls cxl_setup_regs(map):

  cxl_pci_hdm_map_regs()
    cxl_setup_regs()
      cxl_map_regblock()
        map->base =3D ioremap(map->resource, map->max_size);
      cxl_probe_regs()
        cxl_probe_component_regs()

cxl_probe_component_regs() unconditionally adds CXL_CM_OFFSET (0x1000) to
map->base, reads CXL_CM_CAP_HDR_OFFSET, and then reads each capability head=
er
at base + offset (which is map->base + hdm_map->offset) without checking
map->max_size.

If a device's remaining BAR length (map->max_size) is smaller than
CXL_CM_OFFSET + sizeof(u32) or smaller than hdm_map->offset + sizeof(u32),
won't cxl_probe_component_regs() fault on the unmapped ioremap guard page
before cxl_pci_hdm_map_regs() checks hdm_map->offset against map->max_size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D11
