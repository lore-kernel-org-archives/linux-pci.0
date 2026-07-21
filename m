Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824834CFD3
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613473; cv=none; b=uDQvp3AYpV3/tJQhgMKD1xfr+ddWPjiNgbKPWohSRil5nxbBaBJeL/+DJVNAwc7gdONMWgxyThJCTqhwFgSP2D4AWEYC8988KXMRp7KobU81nGWUC7RB5hCLbKdD0NYDIfTwN4hxoLJ5k1/PLY3yw3rBVOq1W6a4XCRtCUoVVaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613473; c=relaxed/simple;
	bh=YV3Tzx4CazwL48DRzuruL36327dNScWrxYLEfzMv04s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LT887PpY9k84+qdcgbIuSaySHcMzxZov5r2Jc7k0iLeuvKT1KOH0CMC40Mg9l08hDjAHibVVb6LzOyW+l1IDTEAmimRge6DakCmZyoUqYXs4eoWD+i55fX5agPeio44Qtl4Ekp6Ux7eg7vvcQxcKPlri8fgBw9PGE+Pg4g1WaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVYSRCvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVYSRCvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11A01F000E9;
	Tue, 21 Jul 2026 05:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784613472;
	bh=we5aJvkyFV85XBIBtybB/zZPOPQTZ7vY0pta5TH+WzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVYSRCvDIGJhjy/sYxQEKYN8kXKu9TU+wP3HozLCvze8Qz1I9gkyd+uo0ulHJIqv8
	 qHpSzfA5UU9xIcgVUTJe6+j84hT7zNY/e9e/CwMVat7V4nLRxvNnm8rkQ21u8dlCtA
	 E/6KFooXR/k8RKkPLfOt4kWArTYUxCM5aphltDecXEEXXRgeF91OkKcr26mLrr01VI
	 kO+uIO+DW6+3sQ7GIkx/L678DdCw9HsvcXwt/Mybekn+/6gD01qCPWFhZ2rorcveru
	 JiTPGaGLabmUvDvjNp7IUdu4xZpIOGDynUVMk7dUd3buY6k6FScX2qn/Im683ZWwoL
	 ekU3gTBjpYemw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] treewide: Add a flag to detect the Apple T2 chip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721054506.11871-2-atharvatiwarilinuxdev@gmail.com>
References: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
 <20260721054506.11871-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:57:51 +0000
Message-Id: <20260721055751.F11A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Build failure on non-x86 architectures due to an undeclared identif=
ier in the fallback macro.
- [Low] The `apple_t2_devices` DMI match table wastes memory because it lac=
ks the `__initconst` attribute.
- [Low] Leftover `UEFI_QUIRK_SKIP_CERT` macro is completely unused after re=
moving the DMI table in `load_uefi.c`.
--

--- Patch [1]: [PATCH v2 1/2] treewide: Add a flag to detect the Apple T2 c=
hip ---
commit 7dbd2538a2e2da67cae6a20bc7aa3350603d9016
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

treewide: Add a flag to detect the Apple T2 chip

This commit adds a flag to detect Apple T2 chips on Intel Macs and caches
the result to avoid repeated checks. It introduces a DMI match table in x86
quirks and updates UEFI certificate loading code to use this new cached fla=
g.

> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index a92f18db96100..74b29738d4046 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
[ ... ]
> @@ -664,8 +664,113 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083=
, quirk_intel_purley_xeon_ras
>  bool x86_apple_machine;
>  EXPORT_SYMBOL(x86_apple_machine);
> =20
> +bool has_apple_t2_chip;
> +EXPORT_SYMBOL(has_apple_t2_chip);
> +
> +static const struct dmi_system_id apple_t2_devices[] =3D {

[Severity: Low]
Since apple_t2_devices is only used by early_platform_quirks() which is
marked __init, should this array be marked with __initconst so its memory
can be freed after system initialization?

> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
[ ... ]
> diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/plat=
form_data/x86/apple.h
> index 079e816c3c219..50bbcc5134fcb 100644
> --- a/include/linux/platform_data/x86/apple.h
> +++ b/include/linux/platform_data/x86/apple.h
> @@ -6,8 +6,13 @@
>   * x86_apple_machine - whether the machine is an x86 Apple Macintosh
>   */
>  extern bool x86_apple_machine;
> +/**
> + * has_apple_t2_chip - whether the machine has the Apple T2 chip
> + */
> +extern bool has_apple_t2_chip;
>  #else
>  #define x86_apple_machine false
> +#define has_t2_chip false

[Severity: Low]
Does this fallback macro name cause a build regression on non-x86 architect=
ures?

The macro is named has_t2_chip here, but the generic UEFI code in
load_uefi_certs() expects has_apple_t2_chip. When CONFIG_LOAD_UEFI_KEYS is
enabled on other architectures, could this result in an undeclared identifi=
er
error since has_apple_t2_chip would not be defined?

>  #endif
> =20
>  #endif
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/int=
egrity/platform_certs/load_uefi.c
> index c0d6948446c30..b4096d4c828d4 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
[ ... ]
> -/*
> - * On T2 Macs reading the db and dbx efi variables to load UEFI Secure B=
oot
> - * certificates causes occurrence of a page fault in Apple's firmware and
> - * a crash disabling EFI runtime services. The following quirk skips rea=
ding
> - * these variables.
> - */
> -static const struct dmi_system_id uefi_skip_cert[] =3D {
> -	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,1") },

[Severity: Low]
With the removal of the uefi_skip_cert array, the UEFI_QUIRK_SKIP_CERT
macro defined in security/integrity/platform_certs/keyring_handler.h
appears to be completely unused.

Should that macro definition be cleaned up as well to prevent leftover code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721054506.1187=
1-1-atharvatiwarilinuxdev@gmail.com?part=3D1
