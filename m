Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304866;
	b=MZJqqV+8sfTl8T9zLC6FWuoxIO1WDKvXLhBrpBZJrXS+yR1ZuFaXKYPgAQjwIpg1iiDs
	 IopmnxZRnDkQTvm3kJfyxY9jTL3AbgFbkfFrQp0ZtICsG77sjoarHqmh6OAvloePzkTtm
	 ew/i2nmL/33AWgKylwUOnh35ZlKVHoEriq0d39j43A7q9RVVU8CgaPg+vYBGIM/kEe0oG
	 YZ6TrPvij0IXA9PtQZciTlU7+v20cMG5dJhevjZqDqVv27F2Lk4amEz8/HIQrDwnpelsI
	 MfNJY5r4jVh0lFWusDkHQKc7lWM361KWrNcIlcQ3mWPiRIUc6Lz+urxV0Dxi1IS2Z7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304866;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=InjrUa8PtgxebaoPU5gAdUxBP+Q7iA9KZue8Z0bePJ0=;
	b=O/KO1sXBwXfJDnUQoPt/nz0ekgXk2DGYxDwT1npWpT/S3hcS2uMtoCekrhQ5noMWS3zu
	 MP/9YgBlEwiEm9iSbSHEtulvWF2U7VrDRCkJvYRWCOeMTqA1MilTBqIBmG0e5q1NZ0B52
	 50PikXl8WRCrGOpIhriFHjgZA4vG8hnRtth8OJYmhcmSInqlANnLmtd6clEUJj9NClacs
	 aDPDg22h/mjTC+o21PMF6ODHQr6QJe5Nt0aawkIO8E+lqLfgZdG3vtryGyHBBcNRjwAUk
	 8hON00zjCp9hireZMevRfZ04OiCIFz+EEBbACt3srGX7l/WfbmhasMaMiP2+1BGcAWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUjpfFlH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211C606A321
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUjpfFlH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34221F008A5
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794304865;
	bh=InjrUa8PtgxebaoPU5gAdUxBP+Q7iA9KZue8Z0bePJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nUjpfFlHyCY/IP2PCtp9uRTFXBZvN6bXGwXrkT2bhrd00hypGd5elGI4sD3IYpMf3
	 GSwnz2alv6Rt7YM+RlG3LhGYkEgR6KdYCeJzCk7HcGIH8FjAZ+b/nNi75PmSN/MCW/
	 aBtFZt+8/3cTiP1SOdXgdLZB8IqQaW+XXarD3/BX+hzbkxbLoAxGTbxkVppzLbCQbe
	 pzq+4An5D75mBd0kdfN84l15TLuCe3cphh+4WB7xcZOVVB9vdB3cUzrXjlQ9109RIe
	 c4eCxynaNH6jTWR6NYZ7ecUUwK/SRXY5wwXVCX9PupaJBNHA0C5TRRZOOpo5qWl4X1
	 rscKUlt5Z2reQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c3fd91337baso319069366b.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 02:01:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF6yucfHaaWyKLHaxR3IMgos/2uX2xSiABSXJ2yULj46HncYcsXhTxXZ9OnXnoENQDfYyCZEWvdIy0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2IzaDf+CrmAKaccRRkb8dJqV0BMA+vgzo96T9Blc/vPzvEZ2l
	jLFgwmojcrOoztXlHVFQhUwJ4+Uew3GZRvTiG5CSZlpI3Y2rmNmHBwj8pH5n35mbIKs67NmvM/f
	iuy1VcVhey65d0Wbcqx2bYintNPAyqfg=
X-Received: by 2002:a17:907:ea89:b0:c4d:31cd:9dec with SMTP id
 a640c23a62f3a-c50495a3646mr156885666b.30.1794304864528; Tue, 10 Nov 2026
 02:01:04 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033440.973077-1-wuqianhai@loongson.cn> <20261110090203.2631481-1-wuqianhai@loongson.cn>
In-Reply-To: <20261110090203.2631481-1-wuqianhai@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 10 Nov 2026 18:00:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=7SbhLpzWOYFxi9MaM5f2BHfJXjWjQW-uBeLCKMHPVw@mail.gmail.com>
X-Gm-Features: AclHuK-9P_C8nOOOdEbmYQVc8OO7W71bMN2RKSel305MdnvrCGkGtc7VDw_SrUo
Message-ID: <CAAhV-H6=7SbhLpzWOYFxi9MaM5f2BHfJXjWjQW-uBeLCKMHPVw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] LoongArch: Identify the firmware/boot display device
To: wuqianhai@loongson.cn
Cc: kernel@xen0n.name, tzimmermann@suse.de, deller@gmx.de, bhelgaas@google.com, 
	ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com, 
	loongarch@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qianhai,

On Tue, Nov 10, 2026 at 5:04=E2=80=AFPM <wuqianhai@loongson.cn> wrote:
>
> From: wuqianhai <wuqianhai@loongson.cn>
>
> On LoongArch the kernel cannot reliably identify the display device that
> was set up by the firmware and used for the boot console.  Two code paths
> need this information and currently get it wrong:
>
>   * The PCI VGA arbiter: vga_is_firmware_default() is compiled only on
>     x86, so on LoongArch vga_default_device() may select the wrong GPU
>     when several are present (for example an integrated display
>     controller and a discrete card).
>
>   * The framebuffer console: LoongArch does not implement
>     video_is_primary_device(), so with
>     CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy the console falls back =
to
>     the generic stub that always returns false and binds to the first
>     registered framebuffer instead of the boot display.
>
> This series fixes both by publishing the firmware framebuffer information
> through screen_info on LoongArch and consuming it the same way x86 does.
>
> Patch 1 always defines and initializes sysfb_primary_display, and always
> provides its EFI stub alias, instead of guarding them behind
> SYSFB/EFI_EARLYCON.
>
> Patch 2 refreshes screen_info from the PCI resource-assignment path after
> the root-bus resources are assigned, so the framebuffer address is final
> before the VGA arbiter and sysfb_init() consume it.  The call is placed
> in the LoongArch PCI scan path because only LoongArch has this ordering:
> acpi_init() relocates the BAR before vga_arb_device_init() runs.  On x86
> the screen_info address is still accurate at that point.  If you would
> rather have the helper called from the generic
> pci_assign_unassigned_root_bus_resources() path so that all architectures
> share it, that can be done instead.
>
> Patch 3 removes pci_fixup_vgadev(), which overrides the VGA default
> device to a discrete card after the arbiter has already selected the
> firmware framebuffer device, so vga_default_device() consistently
> reflects the boot display.
>
> Patch 4 implements video_is_primary_device() for LoongArch by reusing the
> VGA default device selected by the arbiter.
>
> Patch 5 lets the EFI stub link directly to sysfb_primary_display on
> LoongArch, so the firmware framebuffer information is always populated.
>
> Patch 6 lets the VGA arbiter use CONFIG_SCREEN_INFO instead of an
> architecture check and makes VGA_ARB select SCREEN_INFO on LoongArch.
>
> Patches 1-4 are LoongArch-specific.  Patches 5 and 6 touch generic code
> (the EFI stub and the PCI VGA arbiter) and are placed last so they can be
> reviewed and merged separately.  Patches 3 and 4 depend on patch 6 taking
> effect, but are ordered ahead of it only to group the LoongArch changes
> together.
>
> Changes since v2:
>   - Split the screen_info refresh out of vga_arb_device_init() into the
>     LoongArch PCI resource-assignment path (patch 2), following Thomas'
>     suggestion to decouple it from sysfb_init().
>   - Drop the per-architecture check in vgaarb.c and the select of SYSFB
>     in favour of CONFIG_SCREEN_INFO and select SCREEN_INFO (patch 6).
>   - Always define and initialize sysfb_primary_display, and let the EFI
>     stub link to it directly (patches 1 and 5), instead of guarding them
>     behind SYSFB/EFI_EARLYCON.
>   - Remove the vga_default_device() override (patch 3) so the arbiter's
>     firmware-framebuffer selection takes effect.
>   - Implement video_is_primary_device() (patch 4) by reusing the arbiter'=
s
>     default device, so FRAMEBUFFER_CONSOLE_DETECT_PRIMARY works.
>
> Build-tested on loongarch64 with GCC 8.3.0.
>
> wuqianhai (6):
>   LoongArch: efi: Provide sysfb_primary_display for screen_info users
>   LoongArch/PCI: Refresh screen_info after resource assignment
>   LoongArch/PCI: Remove vga default device override
>   LoongArch: video: Implement primary framebuffer device detection
>   efi/libstub: Enable direct sysfb_primary_display access on LoongArch
Please fold this patch to the first one.

And your signature should be:
Qianhai Wu <wuqianhai@loongson.cn>

Huacai

>   PCI/VGA: Enable firmware default device detection on LoongArch
>
>  arch/loongarch/Makefile                       |  3 ++
>  arch/loongarch/include/asm/video.h            |  7 +++++
>  arch/loongarch/kernel/efi.c                   |  5 +---
>  arch/loongarch/kernel/image-vars.h            |  2 --
>  arch/loongarch/pci/acpi.c                     |  4 +++
>  arch/loongarch/pci/pci.c                      | 18 ------------
>  arch/loongarch/video/Makefile                 |  3 ++
>  arch/loongarch/video/video-common.c           | 29 +++++++++++++++++++
>  drivers/firmware/efi/libstub/efi-stub-entry.c |  1 +
>  drivers/pci/Kconfig                           |  2 +-
>  drivers/pci/vgaarb.c                          |  2 +-
>  11 files changed, 50 insertions(+), 26 deletions(-)
>  create mode 100644 arch/loongarch/video/Makefile
>  create mode 100644 arch/loongarch/video/video-common.c
>
> --
> 2.34.1
>
