Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907036;
	b=n06fRKouFoyULYW26KJIDB0gj/vH6qEvMrVV0eDFkWgQdGm1w98NiZPJ36uqquGXS4o6
	 ilrS6yuSnwSaYUZD88mkbCU8ELRA1FB6iYPNqi9UGBbj7gR1K4NgOhmwy/2TFl3+fT/u9
	 YmUdHZMxI6gBIssYbmHPJdQbRmdWuhPyoPMaHo2hhYYHCQp1ZvCxUcW1fU0Ots/ay5t/N
	 z3NA++TGVBmFKwZkkdmrgELHK6lY2WixavPQrij7+BRystv5OYlV0PvQq4ISDoJPTd5oC
	 TCPUdt1du5ZFAIxWylfPAb0dB75+aGoelzoxvdvfM97dXOcccHtrzJbIQViIkWZDE+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mCn804oSbPAZIaCJd8NrPaiC5vscWB9oRKTsCfdqY7U=;
	b=Zg54avaSS1V6EsdRzOPZYy+x43I5KeqzqnfSTSahAlgHa8zm2YyI6zviHaa2VCAXR9CC
	 BFZrXDdEWdPmYfUKwUomrEKRH8rfk31De5nQFqo/uyk+hSXck7V3phC9ao+VEwdlpMilt
	 LE/pDylM2dqRql6bN/d4VfNsYRwUGEtz0XzDz1ZsX6e0tv/BD3GjCVbXcsxNfAX0MYZx6
	 G758lmhkVJI3EmxouNAUN8VU2koeAF9Y2vw8OQC0j4fbnT1rW8hHtyQ7zEIOKsPKbnjQw
	 jzDSxm7ZsdU4OoE3HtLMhyy+QUeZdBEhKtbYyVfz+xjKgOOA/QFjiAJJzaD81qpjCEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mm/i53RK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353A6083609;
	Thu,  5 Nov 2026 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mm/i53RK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5A21F00A1A;
	Thu,  5 Nov 2026 19:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907035;
	bh=mCn804oSbPAZIaCJd8NrPaiC5vscWB9oRKTsCfdqY7U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mm/i53RKdc7nEAeD36f+eUEuMPFcqL6vkhi5PQdavukMOlVp+Jk4F42iNrsHrun1v
	 i3IwsutJ6s0NZ7T1t/HhD4zJ/afclu7ihGDZ6MBj3XIr8gz9ZrHAfXxCqNeG004vR6
	 S1DJ57nNWGFAXaGM2Ntw1kd4Bkg+/PNgaMDN/iVCsFwEan3kuBoFYWl/nIH9hpM4wr
	 cqizsLZyWD7keR4Q2Dh0KAU4W7GnwnxAMHU+dp1JPqySUfEcN2gUG9V/P1M1nPHa0Z
	 OBeR7MeL2kzVs6ihugUzEtCpBQy1HQBZw8v4APiQOl7aKcKNelAX3PcDivJzcZ9QwZ
	 oNYD1rkmQ1/vA==
Message-ID: <sashiko-outbox-199916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 11/19] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-12-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:30:35 +0000
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
- [High] PCI/CXL: missing all-ones checks when caching HDM and DVSEC contro=
l state
- [High] PCI/CXL: out-of-bounds MMIO read and size underflow in cxl_pci_hdm=
_map_regs()
- [High] PCI/CXL: pci_cxl_hdm_cache_init() runs before BAR survey and bridg=
e enable
- [Medium] cxl/pci: disable_hdm() leaves stale CXL_HDM_DECODER_ENABLE in ca=
ched state
--

commit e053ed26c570120750868c635b177e4dbb11e00d
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Cache endpoint HDM state during PCI enumeration

This commit caches CXL endpoint HDM register locations, decoder settings,
and Device DVSEC state in pci_dev->hdm during PCI enumeration so that reset
paths can restore HDM state without a bound CXL driver.

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5272013548c73..ea5327cd627fc 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -209,22 +209,31 @@ static int cxl_set_mem_enable(struct cxl_dev_state =
*cxlds, u16 val)

[ ... ]

> +	/*
> +	 * Refresh the PCI-core cache from the live register even when
> +	 * MEM_ENABLE already matched: a reset restores the cached value.
> +	 */
> +	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);
> +	return ret;
>  }
> =20
>  static void clear_mem_enable(void *cxlds)

[Severity: Medium]
As reported by Sashiko on v16 [1], when the CXL driver unbinds or unwinds
probe, can disable_hdm() leave a stale CXL_HDM_DECODER_ENABLE bit set in
pdev->hdm->global_ctrl?

When the CXL driver binds and platform firmware did not pre-enable HDM,
devm_cxl_endpoint_decoders_setup() runs:

  cxl_hdm_decode_init()
    devm_cxl_enable_hdm()      /* sets CXL_HDM_DECODER_ENABLE in MMIO */
    devm_cxl_enable_mem()
      cxl_set_mem_enable()     /* updates pdev->hdm->dvsec_ctrl */
  devm_cxl_enumerate_decoders()
    cxl_hdm_refresh_decoder()
      cxl_hdm_cache_refresh_decoder()
        info->global_ctrl =3D readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);

which latches CXL_HDM_DECODER_ENABLE into pdev->hdm->global_ctrl.

On driver unbind or probe failure, devres runs clear_mem_enable(), which
clears PCI_DVSEC_CXL_MEM_ENABLE in both hardware and pdev->hdm->dvsec_ctrl,
and then runs disable_hdm():

  static void disable_hdm(void *_cxlhdm)
  {
          u32 global_ctrl;
          struct cxl_hdm *cxlhdm =3D _cxlhdm;
          void __iomem *hdm =3D cxlhdm->regs.hdm_decoder;

          global_ctrl =3D readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
          writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
                 hdm + CXL_HDM_DECODER_CTRL_OFFSET);
  }

Because disable_hdm() clears CXL_HDM_DECODER_ENABLE in hardware without
updating pdev->hdm->global_ctrl, a subsequent reset while unbound will
restore CXL_HDM_DECODER_ENABLE in hardware while PCI_DVSEC_CXL_MEM_ENABLE
remains disabled, and a later driver re-bind in cxl_hdm_decode_init() will
see global_ctrl & CXL_HDM_DECODER_ENABLE set and assume firmware enabled it.

Should disable_hdm() (or devm_cxl_enable_hdm()) also update the cached
global_ctrl in pdev->hdm?

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
As reported by Sashiko on v16 [2], does calling pci_cxl_hdm_cache_init() in
pci_bus_add_device() run too early during boot and miss upstream bridge
enablement?

On x86 ACPI boot, subsys_initcall(acpi_init) calls:

  acpi_pci_root_add()
    pci_bus_add_devices()
      pci_bus_add_device()
        pci_cxl_hdm_cache_init()

before subsys_initcall(pci_subsys_init) runs pcibios_resource_survey() and
before fs_initcall(pcibios_assign_resources) runs
pci_assign_unassigned_resources().

In addition, cxl_pci_bar_assigned() in drivers/pci/cxl.c checks only
res->start and res->end without verifying res->parent, and
cxl_pci_hdm_read_info() sets PCI_COMMAND_MEMORY only on the endpoint pdev
without ensuring upstream PCI-to-PCI bridges have memory decoding enabled.

Can this cause cxl_pci_hdm_read_info() to enable PCI_COMMAND_MEMORY on an
unclaimed or conflicting BIOS BAR address before pcibios_resource_survey()
validates it, or fail to populate pdev->hdm permanently when BARs or bridge
windows are assigned later or upstream bridges do not yet have
PCI_COMMAND_MEMORY enabled?

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> new file mode 100644
> index 0000000000000..a0d20f4210a52
> --- /dev/null
> +++ b/drivers/pci/cxl.c
> @@ -0,0 +1,225 @@

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
> +	if (check_add_overflow(map->bar_offset,
> +			       (resource_size_t)hdm_map->offset, hdm_offset))
> +		return ERR_PTR(-EOVERFLOW);
> +
> +	hdm =3D ioremap(map->resource + hdm_map->offset, hdm_map->size);
> +	if (!hdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*decoder_count =3D cxl_hdm_decoder_count_mapped(&pdev->dev, hdm,
> +						      hdm_map->size);

[Severity: High]
As reported by Sashiko on v16 [3], can cxl_pci_hdm_map_regs() perform
out-of-bounds MMIO reads inside cxl_setup_regs() before the map->max_size
bounds check runs, and underflow hdm_map->size when the HDM capability
header has an invalid decoder count?

In __pci_cxl_hdm_cache_init(), cxl_find_regblock() populates map via
cxl_decode_regblock(), which only checks offset <=3D pci_resource_len(pdev,=
 bar)
and sets map->max_size =3D pci_resource_len(pdev, bar) - offset.

When cxl_pci_hdm_map_regs() calls cxl_setup_regs(map):

  cxl_setup_regs()
    cxl_map_regblock()         /* ioremap(map->resource, map->max_size) */
    cxl_probe_regs()
      cxl_probe_component_regs()

cxl_probe_component_regs() immediately reads from map->base + CXL_CM_OFFSET
and map->base + CXL_CM_OFFSET + offset before cxl_pci_hdm_map_regs() checks
hdm_map->offset > map->max_size. If map->max_size is smaller than those
offsets, the read can fault past the ioremap() window.

Furthermore, in cxl_probe_component_regs():

  case CXL_CM_CAP_CAP_ID_HDM: {
          int decoder_cnt;

          decoder_cnt =3D cxl_hdm_decoder_count(hdr);
          length =3D 0x20 * decoder_cnt + 0x10;
          rmap =3D &map->hdm_decoder;
          break;
  }

If hdr contains a reserved decoder count encoding (such as 0xffffffff from a
failed MMIO read), cxl_hdm_decoder_count() returns -ENXIO (-6), underflowing
u32 length to 0xffffff50 (~4 GiB) while still marking hdm_map->valid =3D tr=
ue.
If the BAR has at least 4 GiB remaining, cxl_pci_hdm_map_regs() passes
hdm_map->size (0xffffff50) to ioremap() before cxl_hdm_decoder_count_mapped=
()
checks the decoder count.

> +	if (*decoder_count < 0) {
> +		iounmap(hdm);
> +		return ERR_PTR(*decoder_count);
> +	}
> +
> +	return hdm;
> +}
> +
> +static struct cxl_hdm_info *__cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						    struct cxl_register_map *map,
> +						    int dvsec)
> +{
> +	struct cxl_reg_map *hdm_map =3D &map->component_map.hdm_decoder;
> +	struct cxl_hdm_info *info;
> +	resource_size_t hdm_offset;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	u16 dvsec_ctrl;
> +	int rc;
> +
> +	hdm =3D cxl_pci_hdm_map_regs(pdev, map, &hdm_offset, &decoder_count);
> +	if (IS_ERR(hdm))
> +		return ERR_CAST(hdm);
> +
> +	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &dvsec_ctrl);
> +	if (rc) {
> +		rc =3D pcibios_err_to_errno(rc);
> +		goto out_unmap;
> +	}

[ ... ]

> +static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						  struct cxl_register_map *map,
> +						  int dvsec)
> +{
> +	struct cxl_hdm_info *info;
> +	u16 command;
> +	int rc;
> +
> +	rc =3D pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return ERR_PTR(pcibios_err_to_errno(rc));
> +
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc =3D pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return ERR_PTR(pcibios_err_to_errno(rc));
> +	}

[Severity: High]
Can all-ones config and MMIO error responses (0xffff / 0xffffffff) corrupt
the cached state or bypass enabling PCI_COMMAND_MEMORY here?

In cxl_set_mem_enable() and cxl_pci_device_dvsec(), pci_read_config_word()
is followed by a PCI_POSSIBLE_ERROR() check because PCI config reads to a
non-responding device typically return PCIBIOS_SUCCESSFUL with an all-ones
value.

However, in several paths here, all-ones reads are not checked:

1. In __cxl_pci_hdm_read_info(), pci_read_config_word(pdev,
dvsec + PCI_DVSEC_CXL_CTRL, &dvsec_ctrl) does not check
PCI_POSSIBLE_ERROR(dvsec_ctrl) before storing info->dvsec_ctrl =3D dvsec_ct=
rl
and info->dvsec_ctrl_valid =3D true. Per CXL r4.0 sec 8.1.3.2, bits 15, 13:=
12,
and 6:3 of DVSEC CXL Control are RsvdP, so 0xffff is never valid, and cachi=
ng
it would cause reset recovery to write 0xffff back to PCI_DVSEC_CXL_CTRL.

2. In cxl_pci_hdm_read_info(), pci_read_config_word(pdev, PCI_COMMAND,
&command) does not check PCI_POSSIBLE_ERROR(command). Because 0xffff has
PCI_COMMAND_MEMORY set, an all-ones read is treated as memory space already
being enabled and proceeds directly to MMIO reads.

3. In cxl_hdm_read_state() in drivers/cxl/core/hdm_regs.c:

  info->global_ctrl =3D readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);

global_ctrl is stored without checking for U32_MAX, unlike
cxl_hdm_cache_refresh_decoder() in drivers/cxl/core/hdm_state.c which checks
global_ctrl !=3D U32_MAX, and settings->skip in cxl_hdm_read_decoder_settin=
gs()
is not checked for U64_MAX (unlike base and size in
cxl_hdm_unpack_decoder()).

Should these reads also reject all-ones values before caching them or using
command to gate PCI_COMMAND_MEMORY?

[1] https://lore.kernel.org/r/20261029145703.2185231-12-smadhavan@nvidia.com
[2] https://lore.kernel.org/r/20261029145703.2185231-12-smadhavan@nvidia.com
[3] https://lore.kernel.org/r/20261029145703.2185231-12-smadhavan@nvidia.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D11
