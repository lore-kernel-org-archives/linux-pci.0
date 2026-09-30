Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48648B38A
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764664; cv=none; b=gNMDCMCzJOCE+PvlKjNKZWQpfFNCte/NJyVi5IcIXz9PJViBohiyGBN7dtdpUXT5VcD7P9DALlNlwuvyhb3S2IP9xLC4X1xnU1S5Hk276yp4B++Lm7hsp80e9fjGrrwIeAG7+JoJd/IJ3PTAxWjzbFGRCJ98U8J++jhj3Zymw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764664; c=relaxed/simple;
	bh=8DX4iw+UDlTFPu2L0ISphP0oNJ2E+tWU9Arllhdez28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=poEOGD3GdUNPxjb79HPFwrpem1P5eQ1HbO68mQXjssUzH8+y0aSytg2wWoE1cc5xIuVvsFU1q1cSeCOebJRfKeAQtEr66Vj8vfJsBTg165elkDy6hX4o18k/VLZUY3yzWsS429ur82gh/BkuqRyktX2WgqJDAg+SIM6z7QLCno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKhfxTp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKhfxTp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76CB1F00898;
	Wed, 30 Sep 2026 10:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764662;
	bh=bIkPgQkFOZ7NJNEmZKCaJYilPN6oD+/sh8RsKaKOdLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKhfxTp1hFaS2I3hxLOoH9dZ11FLQV1u4QpTrGk/ducZBUbz0ySBf0xwmu5qii7P/
	 B9mecQkU9jN7CWukfVzTqxtl0+saCvt5ra5zuxRKd275Mg+mbaK164CAoIwCCUMa/z
	 ZwcGM+eSWkWEQEKEqpUq2q37PW0eKLqu8gvobQcdEYA2fTOqNNpJuZeNOdAz2iGmQz
	 0NBFYHAbHg1g5Q79iuiOnqtdBppQTA1XucMqQ5r+RxqSkhBwSQcaXvgZjogoMjWJ0t
	 38gkKK+C9gR+a3c51g0pFFCZzoX5o8TnIcP0hnf927a5k+avjSIkMKKOSlT9+04J6z
	 /GaYqYu27DRww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] PCI: Allow 64-bit non-prefetchable BARs in
 prefetchable windows
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930103036.248989-6-ardb+git@google.com>
References: <20260930103036.248989-4-ardb+git@google.com>
 <20260930103036.248989-6-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:37:42 +0000
Message-Id: <20260930103742.C76CB1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Ard Biesheuvel <ardb@kernel.org>
>=20
> The non-prefetchable memory window of a PCI-to-PCI bridge can only
> decode 32-bit addresses, and so non-prefetchable BARs of devices below a
> bridge can only be allocated from the part of the host bridge memory
> space below 4 GB. This is the case even for 64-bit BARs, which could
> easily be placed above 4 GB if there was a bridge window to put them in,
> and on many platforms, 32-bit addressable MMIO space is scarce.
>=20
> The PCIe spec addresses this in the implementation note "Additional
> Guidance on the Prefetchable Bit in Memory Space BARs" (PCIe r7.0, sec
> 7.5.1.2.1): on PCIe, setting the Prefetchable bit of a BAR still permits
> correct operation even if the range has read side effects or cannot
> tolerate write merging, as long as the entire path from the host to the
> device is PCIe, given that PCIe Memory Reads always carry an explicit
> [ ... ]
>     IORESOURCE_PREFETCH on the BAR), and this change does not modify the
>     flags of any BAR.)
>=20
> Assisted-by: LLM
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930103036.2489=
89-4-ardb+git@google.com?part=3D2

