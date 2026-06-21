Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B49199931
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782064899; cv=none; b=TkwhzZCzWsbjJXrPqxwdwmvYVjJAJkDZFHP7oLR0uq9yr82smgNAHDoWw5P8XGfBB14iWWQgrVtCuqVRxIb1+X0g1jd5pdAMkdwZZxa/dzCz1w128fAIbqRZesjW6abb3p12E30g4HPcWHF+siMYjR7MklQ33KebWcqWVrNCmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782064899; c=relaxed/simple;
	bh=7zpTAF6YANkjHLzxnav3MSs8Qo3eZ6TeqBS9aIkKAKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mMV1DWvDZzoSED31hKPqY+k0/4KSKwIBq29MqlQ8oLcvn8CP/zw0AVyUqTOOvO4hpSE25pIrjLW8cEdyHRTpNcuOFznJEnndnqKNIJOEGdFCEQhYPy61Jj9ZSFxyrtC8lc/cNr0hIT6v/H2MiEUNjCjKa2kCYdGrEgTnX+1KDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlxbIwhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlxbIwhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011DC1F000E9;
	Sun, 21 Jun 2026 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782064898;
	bh=zzYLi5Fk5HyU6aYpsvQij4oO5/sDEJhCbe6T1nNvoCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hlxbIwhljJw8XkChdwB+B+yQtMvS4acxq5r71ZHr5Lk7GVS2aKOep/1cvLmtGyAQ6
	 f3IJQbPq6E/KKnOKLOHUt2E9xfwcueytPfq/vV8TrObQHTY9+dtIalunhGNJmqD4XG
	 4Fr7McQG+bP0L02ocbTOxFCWTPer1Bl6ZwjbBhHN9F4Rsb0Ve1clYVzfGvlL5ikkr8
	 XZkKOGYFmFZNHBIKohsyPymEHIpnkVqnI+hsrd1zPyThlCWnGd98/KsJBCq3z6YXmo
	 8Elm3wXEi/mzkMyWi0m1Ith77bW2+5IgwBclfWLwYQAq2GISTH9+lUIbeSBretOpLT
	 IKbZiRkLZVwNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbcon: Drop vga_default_device() check from
 video_is_primary_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260621175230.1453114-1-mario.limonciello@amd.com>
References: <20260621175230.1453114-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 18:01:37 +0000
Message-Id: <20260621180138.011DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `vga_default_device()` fallback breaks primary device=
 detection for systems booting in legacy VGA modes (e.g., BIOS/CSM).
--

commit ae22bd27658973af445cda4ac9c68bb0a550097b
Author: Mario Limonciello <mario.limonciello@amd.com>

fbcon: Drop vga_default_device() check from video_is_primary_device()

This commit removes the vga_default_device() fallback from
video_is_primary_device() to prevent multiple devices from erroneously
showing the boot_display attribute on multi-GPU systems. It updates the
function to rely entirely on screen info to find the primary display device.

Link: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma@c=
anonical.com/#t

> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
> index e0aeee99bc99e..eb584d9e55f1c 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
> @@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
>  	if (!pci_is_display(pdev))
>  		return false;
> =20
> -	if (pdev =3D=3D vga_default_device())
> -		return true;
> -

[Severity: High]
Does removing this fallback break primary device detection for systems
booting in legacy VGA modes?

When a system boots in legacy VGA mode (e.g., BIOS/CSM text mode),
screen_info_resources() provides memory resources representing the legacy
VGA window (such as 0xa0000 or 0xb8000). The subsequent code relies on
pci_find_resource() to match this resource against the device's PCI BARs.

However, legacy VGA memory is implicitly decoded by the hardware and enabled
via the PCI command register and bridge controls. It is never explicitly
represented as a standard PCI Base Address Register (BAR).

Since pci_find_resource() only iterates over the standard BARs, won't it
always return NULL for these legacy VGA resources? This appears like it
would cause video_is_primary_device() to unconditionally return false and
break the boot_display attribute for legacy boot systems.

>  #ifdef CONFIG_SCREEN_INFO
>  	numres =3D screen_info_resources(si, res, ARRAY_SIZE(res));
>  	for (i =3D 0; i < numres; ++i) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621175230.1453=
114-1-mario.limonciello@amd.com?part=3D1
