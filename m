Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182280;
	b=czpPfBfJE7yS6Wo28W3Oy5QUypTZFl6AEqpBOwAFjrq2AFLEJFqORygxBvQG/wf38B+w
	 DHuT6jc0+MSiDeCv8hoy8i+A8BH29HgcVOFuQVoaNrX6W7+09G9rhnUc/6kviOhM+Rhh+
	 j6FLmXHlZeBkD/cOoX8ro2+y7ftEkvoEIByjaY83+YYYQ/nJhDUmwfh8CeRKMzOSoGKwZ
	 0HnutyYWKfeRPqPEpQWWHjk9Zq+2TUJlJU8a4XeFNJjlM+WTKCQ3Ji0c+ocqMOfggj1eV
	 snb24uEzMi0WaIoe0eb+56W6TYj3gyFLjLwBgbmedvxOJiXCHu4XQ/vUWlCXZftNx8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182280;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wKAjcb7WscKylN3dM3agjz60NMabSDUoSZkp5VOu6bI=;
	b=InMW4zZAjX0DSPMuD/PP+N3YMogPO0VTj4y6OFR/KQfrvXYqJZ/1G3n6EKN448R3ZZOy
	 PkvkUJKZE6wfO2iuemtM8SKjq/BP98e1zER+84QMm8oqBeLb74kukhuYNHMqx+xGeVcp8
	 pvEtU1QvnjgemsX57aTvfOlroLNwzP8iCGCOUfaLQ4g4HPJrxN2Z2G/+ZstKPIxLlF202
	 pS5qYQckuYVpSTZzoAiLiIeGIQrrS90acw55PEXqPNilwSLgV5q3cS8a6aVmnSULBJXbk
	 fe6QJ//jV08RoOE9MRWVQXxFn26yY9xKm1+FrwDdBw7mlGz436j9TvqLX+7Td0COWuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUt0Cozx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD47606A321
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUt0Cozx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C03D1F01825;
	Wed, 28 Oct 2026 10:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182279;
	bh=wKAjcb7WscKylN3dM3agjz60NMabSDUoSZkp5VOu6bI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fUt0CozxOUvHEOTHKmO4C4dpGO5Df+TZH8Tc26NLczy9Pr+z1NvFSzY3bu8KdCh+X
	 JoIjC62u6DdHwA0+dzZoniE5h7nFbEYDdz1sQtWi1ooVTigCYkX3Lc+M8K1yiGFeev
	 Q8GJc/vrCrUc1Y8lLdWrm1fcXFD2kzkb5fLKpElXxKMbTNmDb9d7ZqwLj5uilQAaYE
	 qBYz6BLMaFC7m/Ao8YvqA/bfT/P4NTmmouphAUHgi90vSusSDCuo0Jo7/2Km6gg5bU
	 2WB1oZrSAQDK84IJ4iPlS/pwljM2rGkR0kc0z84DvNcx4kB+Q9DfubgWYKshwf7Xm4
	 kytzKC2DTuA3w==
Message-ID: <sashiko-outbox-187730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/VGA: Fix boot device detection after framebuffer
 relocation
Reply-To: sashiko-reviews@lists.linux.dev
To: wuqianhai@loongson.cn
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261028094634.766723-1-wuqianhai@loongson.cn>
References: <20261028094634.766723-1-wuqianhai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:11:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI/VGA: premature and duplicate screen_info_apply_fixups() in vga=
_arb_device_init()
- [Medium] PCI/VGA: undefined reference to screen_info_apply_fixups() when =
!SCREEN_INFO
--

commit da40d2d05299ef123ed4789d2ecb58829165fbe3
Author: wuqianhai <wuqianhai@loongson.cn>

PCI/VGA: Fix boot device detection after framebuffer relocation

This commit calls screen_info_apply_fixups() in vga_arb_device_init() so th=
at
screen_info's lfb_base is updated before VGA devices are registered and
checked by vga_is_firmware_default().

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3e58b2c05c854..aca594651f580 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -1527,6 +1527,14 @@ static int __init vga_arb_device_init(void)
>  	int rc;
>  	struct pci_dev *pdev;
> =20
> +	/*
> +	 * PCI resource assignment may have relocated the firmware
> +	 * framebuffer BAR. Update screen_info's lfb_base so that
> +	 * vga_is_firmware_default() can match it against the boot
> +	 * device's relocated resource.
> +	 */
> +	screen_info_apply_fixups();

[Severity: Medium]
Will calling screen_info_apply_fixups() unconditionally in
vga_arb_device_init() fail to link when CONFIG_PCI=3Dy, CONFIG_VGA_ARB=3Dy,=
 and
CONFIG_SCREEN_INFO=3Dn?

In drivers/pci/Kconfig, VGA_ARB only selects SCREEN_INFO on x86:

drivers/pci/Kconfig:
	config VGA_ARB
		bool "VGA Arbitration" if EXPERT
		default y
		depends on !S390
		select SCREEN_INFO if X86

which matches the CONFIG_X86 guard in vga_is_firmware_default():

drivers/pci/vgaarb.c:vga_is_firmware_default() {
#if defined CONFIG_X86
	return pdev =3D=3D screen_info_pci_dev(&sysfb_primary_display.screen);
#else
	return false;
#endif
}

However, include/linux/screen_info.h declares screen_info_apply_fixups() as=
 an
external function whenever CONFIG_PCI is enabled, while
drivers/video/Makefile only builds screen_info_pci.o when CONFIG_SCREEN_INFO
is enabled:

include/linux/screen_info.h:
#if defined(CONFIG_PCI)
void screen_info_apply_fixups(void);
struct pci_dev *screen_info_pci_dev(const struct screen_info *si);
#else
static inline void screen_info_apply_fixups(void)
{ }

drivers/video/Makefile:
obj-$(CONFIG_SCREEN_INFO)         +=3D screen_info.o
...
screen_info-$(CONFIG_PCI)         +=3D screen_info_pci.o

On non-x86 architectures with CONFIG_PCI=3Dy, CONFIG_VGA_ARB=3Dy, and
CONFIG_SCREEN_INFO=3Dn, doesn't this result in an undefined reference to
screen_info_apply_fixups()?

[Severity: High]
Also, is subsys_initcall_sync(vga_arb_device_init) the right place in the
initcall sequence to call screen_info_apply_fixups()?

Upstream vga_is_firmware_default() in drivers/pci/vgaarb.c only calls
screen_info_pci_dev() under CONFIG_X86. On x86, subsys_initcall(pci_subsys_=
init)
runs pcibios_resource_survey() -> pcibios_allocate_dev_resources(). When the
firmware framebuffer BAR has a resource conflict and awaits reassignment,
pcibios_allocate_dev_resources() saves the firmware address and resets
r->start to 0 while keeping resource_size(r) intact:

arch/x86/pci/i386.c:pcibios_allocate_dev_resources() {
	...
	/* We'll assign a new address later */
	pcibios_save_fw_addr(dev, idx, r->start);
	r->end -=3D r->start;
	r->start =3D 0;
	...
}

The new BAR address on x86 is not assigned until
fs_initcall(pcibios_assign_resources) -> pci_assign_unassigned_resources(),
which runs after subsys_initcall_sync(vga_arb_device_init).

When screen_info_apply_fixups() runs at subsys_initcall_sync while a
conflicting BAR has pr->start =3D=3D 0, pr->start !=3D screen_info_lfb_res_=
start is
true and __screen_info_relocation_is_valid(si, pr) succeeds because
resource_size(pr) is unchanged:

drivers/video/screen_info_pci.c:screen_info_apply_fixups() {
	if (screen_info_lfb_pdev) {
		struct resource *pr =3D &screen_info_lfb_pdev->resource[screen_info_lfb_b=
ar];

		if (pr->start !=3D screen_info_lfb_res_start) {
			if (__screen_info_relocation_is_valid(si, pr)) {
				__screen_info_set_lfb_base(si, pr->start + screen_info_lfb_offset);
				pr_info("Relocating firmware framebuffer to offset %pa[d] within %pr\n",
					&screen_info_lfb_offset, pr);
			}
			...
		}
	}
}

Wouldn't this clobber si->lfb_base to 0 + screen_info_lfb_offset with a
[mem 0x00000000-...] message before fs_initcall(pcibios_assign_resources)
assigns the actual BAR address, while still failing to match in
vga_is_firmware_default()?

Similarly, for PCI host bridges probed at device_initcall via
pci_host_probe(), vga_arb_device_init() runs before the PCI bus is scanned
and before VGA devices are added via pci_notify().

Finally, since screen_info_apply_fixups() does not update
screen_info_lfb_res_start or clear screen_info_lfb_pdev after applying the
fixup, won't calling it in both vga_arb_device_init() and
device_initcall(sysfb_init) in drivers/firmware/sysfb.c cause the relocation
and log messages to run twice?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094634.7667=
23-1-wuqianhai@loongson.cn?part=3D1
