Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B4477E53;
	Wed,  8 Jul 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520481; cv=none; b=Odz17pCn69czG7R1pSXO0FCZZCyXBSRbzpC1JfZmnW9F0+NizaI4OCziXztSp/OR4LQlNuJe/dX3pQmdoycM6nmMeMfAzJeoCysj5hRksvRIivtmIZ0PzFgtbS0PKqy9s+/4tY+v/oQZWAcE7ReonXffVimR0Ke5XKvrLwPQDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520481; c=relaxed/simple;
	bh=eptoqU3kcoiZ2MPYXhf+3yYOkpZj8bF8iCd83eySl6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GQ7irYtfGsU6wFVhy7vNC+2SgkNtBHnKuDTEPlB4ycf6AOPwuFHT1d5zUhBQnyhpu0gq18PshPLbDlEVT1pWROig9t/CVWuAUKX1Lazcyc5S4aIIZNC93kJjOAdWHpLMVO2mgIt1kwyfPDsWY/ovWHccfLEN4R1XIxCDWtuu4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVC0Li+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVC0Li+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311B21F00A3A;
	Wed,  8 Jul 2026 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520480;
	bh=EwqgsRzc4TDNJUcYjGgk9JH6x1MFE3isguoRJhDocHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVC0Li+xN/1ij1SL2KPvng+w2Q7MpryAem5TDTXRqLvsSUXG4Mxfr0bV7QSPFYc2f
	 qzJQL1NnYBPCMtDPzDaJ5H5iFP/zE3IiivkAjYwSimIRug66Xz8RoZyvK7pv0x/wAn
	 kq8TOYhfbz5ma+3zBhH5AxIenj4LC4w23xTrP4mQlYTa4wa4uF7NQeYaGMYea6sMrH
	 NaS6rOQJ3RxJHqAiLAnIzyTCM89+kR9ejDrnWjUwOFVBOBAqDcM5iGg427f43CZbvH
	 e1h80rV0X0Bz60w2cTztSrIGmSTEh1TLfGZp8MaoIVYs2erkozflUdyMpkH1gxBwLf
	 edldXfOZZb3JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] ACPI: APEI: introduce GHES helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-7-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-7-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:21:19 +0000
Message-Id: <20260708142120.311B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The decoupled `GHES_CPER_HELPERS` config relies on symbols defin=
ed in `ghes.o`, causing linker errors if enabled independently of `ACPI_APE=
I_GHES`.
- [Medium] `GHES_CPER_HELPERS` lacks dependencies on `ACPI_APEI` and archit=
ectural support, causing implicit declarations and linker errors if enabled=
 independently.
--

--- Patch [7]: [PATCH v7 07/10] ACPI: APEI: introduce GHES helper ---
commit 0f74f9098911a0c1e3d2f8f68c8908787e6ae1b7
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: introduce GHES helper
   =20
This commit introduces a new GHES_CPER_HELPERS Kconfig entry so the shared
helper code can be built even when ACPI_APEI_GHES is disabled. It updates
the build glue and headers to depend on the new symbol.

> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f165d14cf61a3..13ef0e99f840b 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -6,6 +6,10 @@
>  config ARCH_SUPPORTS_ACPI
>  	bool
> =20
> +config GHES_CPER_HELPERS
> +	bool
> +	select UEFI_CPER
> +

[Severity: Medium]
Since the commit message indicates this config is meant to be built even
when ACPI_APEI_GHES is disabled, should this have a depends on ACPI_APEI
rule?

If a future config selects GHES_CPER_HELPERS without ACPI_APEI, it looks
like ghes_cper.c will fail to compile. For example, ghes_map() calls
arch_apei_get_mem_attribute(), which lacks a fallback stub in
arch/x86/include/asm/acpi.h when CONFIG_ACPI_APEI is disabled.

Similarly, ghes_ack_error() calls apei_read(), which is only compiled
when CONFIG_ACPI_APEI is enabled.

>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>  	depends on ARCH_SUPPORTS_ACPI

[ ... ]

> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 8d7e5caef3f18..2ffab36b61541 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -83,15 +83,17 @@ int devm_ghes_register_vendor_record_notifier(struct =
device *dev,
>  					      struct notifier_block *nb);
> =20
>  struct list_head *ghes_get_devices(void);
> -
> -void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
>  #else
>  static inline struct list_head *ghes_get_devices(void) { return NULL; }
> -
> -static inline void ghes_estatus_pool_region_free(unsigned long addr, u32=
 size) { return; }
>  #endif
> =20
> +#ifdef CONFIG_GHES_CPER_HELPERS
>  int ghes_estatus_pool_init(unsigned int num_ghes);
> +void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
> +#else
> +static inline int ghes_estatus_pool_init(unsigned int num_ghes) { return=
 -ENODEV; }
> +static inline void ghes_estatus_pool_region_free(unsigned long addr, u32=
 size) { }
> +#endif

[Severity: Medium]
If GHES_CPER_HELPERS is enabled but ACPI_APEI_GHES is disabled, will this
cause linker errors?

It appears ghes_defer_non_standard_event() in drivers/acpi/apei/ghes_cper.c
allocates from ghes_estatus_pool:

drivers/acpi/apei/ghes_cper.c:ghes_defer_non_standard_event() {
    ...
    entry =3D (void *)gen_pool_alloc(ghes_estatus_pool, len);
    ...
}

However, ghes_estatus_pool is defined in drivers/acpi/apei/ghes.c, which is
entirely omitted when ACPI_APEI_GHES is disabled.

Additionally, exposing the prototype here for ghes_estatus_pool_init()
disables the inline stub, which could cause link errors for callers like
hest.c if ghes.o is missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D7
