Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F68384CF1
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336781; cv=none; b=dwfl+czT4K0ux75bu6O16TckRExF8BuRT9AQJho3ckjwo9SA1b0RTTPp6uHnn/r8s3Z1quS4eRGIEn6hE1ttvmnHtp0eveEs1zDY1gBMyvem8GLvoCiWGxHrYFotPV8wj+VENQyVoHTt12hNLzvo395+wKOuMa+piMuub9Eil6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336781; c=relaxed/simple;
	bh=rGDDBTlu8QdvQNxHUWncAsO50zvhzk1DiooXz+vCCE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=moQf0APNbsN6PihnU5tdU99njxmVO68+UwruMcOuugS0iLaJ9NBJRl+O6iy/TvNXc7K0uhV8Ub6J3cWoD43v99FCZRP00LvMWd7wL5/os5CXR/PeZuoXrVrfN9f0NBobmm9lx/2apuOkaC4cltxBgQE2MaYVrtpGFoAbcGRRXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh12eD24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh12eD24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1127C1F000E9;
	Thu, 21 May 2026 04:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336780;
	bh=BrOYLMI31nK3kIgWZxLX89G9bMC5pICPYKzHyy9Y+yM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lh12eD24uC778+ht1IxEs7BgYm1RTxgdKQ1UcG+BgygpR9J6N5PIT4WQujagERzZE
	 HxyCdzQzydirYjE9+E0UfZDYlMhSXufFE/H2DJ0j4LFehakKZPr45qfDIey5MoNmWi
	 mQ/NayUeNcyFkjEUAhihIRwCdcBu5gCpN3wA3D5no3JqjTCR/UBI/ToZ4MGjKI1ql3
	 nTJclQCqlm7B0uFxnCL7Q087cW2QVnOyZAwPkuDOo3DdlSPI6TAViYiN7SQQ45B5sN
	 rKCMMfKBVJiv8A5mi3qNl82vJwkxKfKkhoJO78pgO1InfIzhgKbWSlohvXIzLjwh4r
	 nOsEOLNxMR3iA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC Patch] pci: add power management for rtl8116af
Reply-To: sashiko-reviews@lists.linux.dev
To: javen <javen_xu@realsil.com.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521033827.502-1-javen_xu@realsil.com.cn>
References: <20260521033827.502-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 04:12:59 +0000
Message-Id: <20260521041300.1127C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Read-modify-write operations on 32-bit PCI configuration registers=
 inadvertently clear Write-1-to-Clear (W1C) status bits.
- [High] The PCI fixup silently aborts without applying power management se=
ttings if memory decoding is not enabled.
- [High] Lockless accesses to shared indirect hardware registers race with =
concurrent quirk executions and the r8169 network driver.
- [Low] Introduction of unused #define constants for ERI registers.
--

commit c906289c8fdc6bf2fd98830ac376147e18168f4a
Author: Javen Xu <javen_xu@realsil.com.cn>

pci: add power management for rtl8116af

This commit adds power management for the RTL8116af multi-function card by
configuring functions 2 to 7 to enter D3 and enabling ASPM. It skips the
reserved functions 5 and 6.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..e6538edcdff40 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -6381,3 +6382,121 @@ static void pci_mask_replay_timer_timeout(struct =
pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer=
_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer=
_timeout);
>  #endif
> +
> +#define RTL_TX_CONFIG			0x40
> +#define RTL_CSIDR			0x64
> +#define RTL_CSIAR			0x68
> +#define RTL_ERIDR			0x70
> +#define RTL_ERIAR			0x74
> +#define RTL_OCPDR			0xb0
> +
> +#define CSIAR_FLAG			0x80000000
> +#define CSIAR_WRITE_CMD			0x80000000
> +#define CSIAR_BYTE_ENABLE		0x0000f000
> +#define CSIAR_ADDR_MASK			0x00000fff
> +
> +#define ERIAR_READ_CMD			0x80000000
> +#define ERIAR_MASK_1111			0x0f000000
> +#define ERIAR_EXGMAC			0
> +#define ERIAR_FLAG			0x80000000

[Severity: Low]
Are these RTL_ERIDR, RTL_ERIAR, and ERIAR_* constants used anywhere in this
patch? It looks like they might be unused dead code.

> +static u32 quirk_rtl_csi_read(void __iomem *base, u8 multi_fun_sel_bit, =
int addr)
> +{
> +	u32 cmd =3D (addr & CSIAR_ADDR_MASK) | (multi_fun_sel_bit << 16) | CSIA=
R_BYTE_ENABLE;
> +	u32 val;
> +
> +	writel(cmd, base + RTL_CSIAR);
> +	if (readl_poll_timeout(base + RTL_CSIAR, val, val & CSIAR_FLAG, 10, 100=
0))
> +		return ~0;
> +	return readl(base + RTL_CSIDR);
> +}
> +
> +static void quirk_rtl_csi_write(void __iomem *base, u8 multi_fun_sel_bit=
, int addr, int value)
> +{
> +	u32 cmd =3D CSIAR_WRITE_CMD | (addr & CSIAR_ADDR_MASK) |
> +		  CSIAR_BYTE_ENABLE | (multi_fun_sel_bit << 16);
> +	u32 val;
> +
> +	writel(value, base + RTL_CSIDR);
> +	writel(cmd, base + RTL_CSIAR);
> +	readl_poll_timeout(base + RTL_CSIAR, val, !(val & CSIAR_FLAG), 10, 1000=
);
> +}

[Severity: High]
Can these lockless accesses to the shared RTL_CSIAR and RTL_CSIDR registers
race with other operations?

Because the RTL8116af is a multi-function device and this quirk runs for all
exposed functions (0 and 1), concurrent quirk executions during system or
runtime resume could corrupt the two-step indirect register accesses.

Additionally, the r8169 network driver independently uses these exact same
registers. Could a runtime resume of one function trigger the quirk and
interleave with the active network driver on the other function, leading to
hardware configuration corruption?

[ ... ]
> +static void quirk_rtl8168_clear_and_set_csi(void __iomem *base, u8 multi=
_fun_sel_bit,
> +					    u32 addr, u32 clearmask, u32 setmask)
> +{
> +	u32 val =3D quirk_rtl_csi_read(base, multi_fun_sel_bit, addr);
> +
> +	if (val !=3D ~0) {
> +		val &=3D ~clearmask;
> +		val |=3D setmask;
> +		quirk_rtl_csi_write(base, multi_fun_sel_bit, addr, val);
> +	}
> +}

[Severity: High]
Does this read-modify-write operation inadvertently clear Write-1-to-Clear
status bits?

By reading the entire 32-bit register and writing it back, any
Write-1-to-Clear bits that are currently set to 1 will be written back as 1=
s,
which clears them in hardware.

For RTL8168-based devices, the registers at offsets 0x80 (PCIe Link Control
and Link Status) and 0x44 (PMCSR) contain Write-1-to-Clear bits such as Link
Bandwidth Management Status and PME_Status. This could destroy pending PME
wake events or PCIe link events.

[ ... ]
> +static void quirk_rtl8168_set_aspm_clkreq(struct pci_dev *pdev)
> +{
> +	void __iomem *base;
> +	u16 pci_command;
> +	int mmio_bar;
> +	u32 txconfig, xid;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> +	if (!(pci_command & PCI_COMMAND_MEMORY))
> +		return;

[Severity: High]
Will this silently abort without applying power management settings if memo=
ry
decoding is not enabled?

Since this quirk is registered using DECLARE_PCI_FIXUP_FINAL, it executes
during device enumeration, before the device driver is bound and calls
pci_enable_device().

If system firmware or BIOS leaves PCIe functions with memory decoding
disabled, the fixup will return here, meaning functions 2-7 are never put
into D3hot and ASPM is not configured.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521033827.502-=
1-javen_xu@realsil.com.cn?part=3D1
