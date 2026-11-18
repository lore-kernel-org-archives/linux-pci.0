Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999739;
	b=LagvsWrPAn18Td7gy14OgVdMHhYtTJOs0ShLZNl4xe8hZYnRj119tSh6LvTq0W1s4zfq
	 2hFm4F4ZNTbEh0upLyWiJldgUK1VIvmclBsVU3dYspo2hpRzAiqADfMpdwpXovYHLtiV6
	 nS32HwSZvatc7KpfY3zV1bNwHkbUBtlapOr/dSBbenzp9Fk98AhYN2fx9CHdepZplEA2m
	 EKBzdIy8ArOoGFC2XK0DlU3ThqvlqpaH2gkclc6Iak8ZuZRNqQbdfCzyuV6scP0j0TyGl
	 W9UlHXjL5Ggft/yOyzaB0wtadjS5xnxDH0K7GS/Xo9TY7DNT9IQoZQXmscchIajDjyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pF9fOiC62aOaNbSGa1VErU8gG/q4Aqz2QH5enl9qRBU=;
	b=OVu1R6racpUgYoCTU4x5GVOY3NgDDRg82qkvrP6aEkmvOH3hKIuqkw2Tf27e7aJns7Il
	 a8AAkE9w4Ddz5Cmp01U4VP3tGIwa85jU3ZFEt+Hltcy4ONqt6PrePvi/j2B3jks5fFXjg
	 htOgi7LlEtk32LcHEv0+TGxCVcjLixsFeeQMmbRnsLpta62r6FtT+PQwx11PR9TtmRczM
	 MX/kCap267+p7TIAaXi6vzf/oaKDq7ZYwtMs0CqiPOW+tnivzxVvxZnJiSEbk2M5X+Bbg
	 /tCcwEKl1cOnjL1RVjFXIituJV44vKVwCm0FdAF4psbNI2Zi4x/1VrTMwmcJH8AC/Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVGCxJ4Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284FB606A32F
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVGCxJ4Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E181F000C7;
	Wed, 18 Nov 2026 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999738;
	bh=pF9fOiC62aOaNbSGa1VErU8gG/q4Aqz2QH5enl9qRBU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cVGCxJ4QRGI+bKaaJgevrEzrjVWXhczr4viBaTR1jI4N5uEPb6HkHrY5Itg/+mPHX
	 kk1drkzdM3JhZpb935xvvM1IMj5NGvx08XbGUy25I9ezkaRCA6LbQLn0PDKZrrnisC
	 nJ/fclKgxXWfhVAYlwsfNAM38cnwu0TK/K4mKmlbIXWa9Nnqc4aq5SwJVvQekqjP+E
	 BeN678dkS7+4u8UUGGQkU8dPkIyaCaQ2sy+WcOrUKlDCZzV5PatTmf7x8PSll5kLq2
	 +P1V92RZUL6btiJoBIYT3qxi3ld6bvA1wEh9/ogK2+qWPrEKA4BtLVKFw9XHW6312h
	 CdChdZZyET24Q==
Message-ID: <sashiko-outbox-220783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <c16f4a8b76745b03f3e90d6056c5ba6d092c947d.1794997749.git.lukas@wunner.de>
References: <cover.1794997749.git.lukas@wunner.de>
 <c16f4a8b76745b03f3e90d6056c5ba6d092c947d.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:02:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().
>=20
> The call is superfluous because the function is only called from:
>=20
>   aer_probe()
>     cxl_rch_enable_rcec()
>       handles_cxl_errors()
>=20
> ...and aer_probe() is only invoked if an AER port service was instantiated
> in get_port_device_capability(), which is conditional on:
>=20
>   (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC) &&
>   pci_aer_available() &&
>   dev->aer_cap && (pcie_ports_native || host->native_aer))
>=20
> ...and the last line of those conditions is equivalent to
> pcie_aer_is_native().
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794997749.gi=
t.lukas@wunner.de?part=3D5

