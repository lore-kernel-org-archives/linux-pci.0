Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676031;
	b=dFJt12quHEX+/fK5BlDbObTPTTAfL051RNfHRRJ6ReiFjE12+33RisPf6rNRVkEWNFHc
	 YCpLDdZKUt3MxPaxyYsXehemj7mkb7rHUStoaZmhDdsIkmzGG69bi6G99AMOlkpS9SNkk
	 m9iihC0FQ2JTtbE+IqXnte50go34uaueIQpkfDVF9yiKT9FQNuivaPtZrneM854/beFsD
	 2mHAZchAV70EwJNY5z7k05XrB5+XKIbPpVA73vGyu2LS977RKwKUxqVtHPbVTsVmfdCDy
	 w+KjC1Tj0xBdjSOud90oOvaVgcgp6y5ONpkobWAT/Kx9EDVpYcCUq07z3uMMzIv/EYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676031;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G8TQ8siTZK/PbwriCaxgBegQJcnrBWgnSai2Le5t0Zo=;
	b=IhxDqpKlg+KAaVHann+n1h5w4bKChRlFor8+uFq5WWsV0owFVgkko5DzBDwNAm2pt42G
	 zc2oEDZsn59nRYwkHSNnJQsRhcsp0wH8lCSaMr8jWKu1YkusVoSoy7qw5WIPmUMuzx09G
	 LBV9jM0W8K9fHdAsCy3OKOY2ONjhlpy1hHdLh7KLVtOkLrvv94gYnL9Dex6qFAiI0QVAt
	 gB9nwtkvy3/mvZL7W+CCsHZ5nnaZ2Jv5npd9pQQlm0rG7lLyJfptCMl3+aVHy7Ft+0tBq
	 cFSOE+4x1OQ2uby2TpRHoEwW3GbK9s+9Hng/ysF6jTVVZd9VP4frpmTDRXSF3pHCeHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAAOpvol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBC606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAAOpvol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9E41F000C1;
	Tue,  3 Nov 2026 03:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676030;
	bh=G8TQ8siTZK/PbwriCaxgBegQJcnrBWgnSai2Le5t0Zo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JAAOpvolRp2P6ldkcClxfa7ogLjRBDm524idIJ+mBKlcUHqQB5lp1VnI1IF2n49fV
	 3NyyYAR+xs5rXS8q6TeIrJRYHrGgrnrN2+tJOj0aNOREsG7O503t3I7zYBlTHl5d87
	 4B1FU0rmD9dmDclMmGIROKijy653puXklYF9v3NqFvuis1Oe0VDHDl+61Fe5DeukyO
	 QSaQ2XzM5D5HQ+gdZWsBI8b1YqX+sPf2BGJvix+R9o9aOCHMzqIUdHACBPCphURp5q
	 v/haAhihO1nTVjJA69snehQwMHHsbQHlmjgXF/j0LfgrE0w3ghGoc0By5Tpw2IvzTs
	 w0tjTLWPCR9PQ==
Message-ID: <sashiko-outbox-194506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] x86/video: Preserve the default VGA fallback for
 legacy modes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hengyu Liang" <hengyul@cs.unc.edu>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103031630.2085194-1-hengyul@cs.unc.edu>
References: <20261103031630.2085194-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:20:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Commit 596b3678326d ("x86/video: Only fall back to vga_default_device()
> without screen info") made video_is_primary_device() rely exclusively
> on screen_info resources whenever any are available.
>=20
> However, screen_info_resources() also returns legacy I/O and memory
> ranges for VGA text modes. These ranges are not PCI BARs, so
> pci_find_resource() does not find them and the default VGA fallback is
> skipped. As a result, no device is primary in VGA text mode.
>=20
> On a SeaBIOS QEMU guest with bochs and VKMS, the boot VGA (bochs) loses
> its DRM boot_display attribute. VKMS registers fb0 and bochs registers
> fb1. VKMS is not a PCI device, so it is not primary either. With no
> primary device, fbcon keeps the console on fb0 and never remaps it to
> bochs. This can be checked with:
>=20
> [ ... ]
> Fixes: 596b3678326d ("x86/video: Only fall back to vga_default_device() w=
ithout screen info")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103031630.2085=
194-1-hengyul@cs.unc.edu?part=3D1

