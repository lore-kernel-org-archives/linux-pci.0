Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6690384CC6
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224494; cv=none; b=DOXrEhyVi2uF1GjSGfwv3xYh5qreiRqYT8DiVVX9lK5vS+6MV5kbpoWg7VpCZoYY5l8Lp+GVjzTrdpf6w4Ku2b43K4+rWBXJXr8qh9/sIrROwNGMLGvJs0B7yJob1kAScqQ1H8r5RJId+xifiCy+fpEHnhmbh+hb/Y0K9xK+/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224494; c=relaxed/simple;
	bh=oHSfWz4bAD6d1X5YFveX0clVVkEnhXGMsKk1vc/B3Cc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mh0+VQqZyWu83VQlqhjMDI247NL1dvOR/HPQFMMUv/4FzsDYeFLMd603+a2OJnGKrHRVpiDqDOSTc8Akt3znfmuoSra6BaUMwp38nVXj94gORs3T4Q9xjo3JTr+nfiGqGqcT4+GxJLd3qDDlwp9UyeRFWxMMeuwDDLFtQl5MRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsDMDTr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsDMDTr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486151F000E9;
	Tue, 23 Jun 2026 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782224493;
	bh=bLZj5BizWF0HpNLfcbtTWCgpNQii7Vm/IkEqMAKdE0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsDMDTr4X2c9pu0ZkrYCL15KdMKejGcaCYaCHMLj9OxBItY/NO8CN5D8xqpEMoY67
	 f0iBPW+pExIUoRFMGvhQyxzXijN8Cov3u9N4zIAjEaGQAp7WmFex/zCgDdjvaOJzin
	 LDBwqT5z+h2LQP353vHNLtic3b3OM/7W4uWskRsx+LJdWN1NBKvgUrslBsqk9iD+Oc
	 U+WzpwjUu/dlMNdUP8OjTcGAMxUQZZYEk7kJzPvM09c7PR7vc40ggtFqwIZCKy2hJj
	 qlWWwTX0bkDr2jZR+Vd7/VE1ojDXKKOCp0syz2s8HuUnbaYA/38KZZ1xwMuJrACcon
	 50lZ4bgGQfa9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] x86/video: Only fall back to vga_default_device()
 without screen info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623141505.1816786-1-mario.limonciello@amd.com>
References: <20260623141505.1816786-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 14:21:32 +0000
Message-Id: <20260623142133.486151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch unconditionally returns `false` if `screen_info` has mem=
ory resources that do not match any standard PCI BAR, breaking primary devi=
ce detection for systems booting in legacy VGA text modes.
--

commit a8c04b0c2e4edb24a29bd696ebde27323036eb98
Author: Mario Limonciello <mario.limonciello@amd.com>

x86/video: Only fall back to vga_default_device() without screen info

This commit changes the primary video device detection on x86 to rely
exclusively on screen_info if available, and only falls back to
vga_default_device() when no screen info resources are present. This
prevents multiple devices from erroneously claiming the primary
boot_display attribute.

Closes: https://lore.kernel.org/linux-pci/20260618081803.2790848-1-aaron.ma=
@canonical.com/#t

> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
> index e0aeee99bc99e..e5fb3cf885fbd 100644
> --- a/arch/x86/video/video-common.c
> +++ b/arch/x86/video/video-common.c
[ ... ]
> @@ -43,21 +43,26 @@ bool video_is_primary_device(struct device *dev)
>  	if (!pci_is_display(pdev))
>  		return false;
> =20
> -	if (pdev =3D=3D vga_default_device())
> -		return true;
> -
>  #ifdef CONFIG_SCREEN_INFO
>  	numres =3D screen_info_resources(si, res, ARRAY_SIZE(res));
> -	for (i =3D 0; i < numres; ++i) {
> -		if (!(res[i].flags & IORESOURCE_MEM))
> -			continue;
> +	if (numres > 0) {
> +		for (i =3D 0; i < numres; ++i) {
> +			if (!(res[i].flags & IORESOURCE_MEM))
> +				continue;
> +
> +			if (pci_find_resource(pdev, &res[i]))
> +				return true;
> +		}
> =20
> -		if (pci_find_resource(pdev, &res[i]))
> -			return true;
> +		return false;

[Severity: High]
Does this unconditional return break primary display detection for systems
booting via legacy BIOS or VGA text mode?

When booting in legacy VGA text mode, screen_info_resources() populates
resources with legacy memory ranges like 0xa0000 or 0xb8000. Since numres >=
 0,
the code enters this block.

However, legacy VGA windows are implicitly routed and not explicitly
represented as standard PCI BARs. Because of this, pci_find_resource() will
fail to match.

By returning false here, the code completely bypasses the fallback to
vga_default_device() for these legacy systems. Should this fall through to =
the
vga_default_device() check instead of returning false when the resources do
not match any standard PCI BAR?

>  	}
>  #endif
> =20
> -	return false;
> +	/*
> +	 * No framebuffer was set up by the firmware/bootloader, so fall back
> +	 * to the default VGA device.
> +	 */
> +	return pdev =3D=3D vga_default_device();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623141505.1816=
786-1-mario.limonciello@amd.com?part=3D1
