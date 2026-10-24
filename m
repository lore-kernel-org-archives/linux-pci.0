Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792804066;
	b=O26rc1R4ud1PXa/6jcxRtvKIkFrSLek6yx2xUG7HWGESF4pdwK245HKNOKP6qn5P/2B0
	 O8xxjLVLHsNZBNrY/6yQrYGng7ONCIn3EfkEfJby9rUnLeUERxIFZ8D3xC871qU1Z0Shf
	 hvfCRNRrEuFRrOfo6DT98E063JQfsNfqwXpBEkuCsKAAWOYqZKPNOHv3Dw2COeQZtCYsU
	 fHKLqVJG+DBPeTH0TX/JwzQTMvOIXAgtG7qxmgLF5wCeUh2Bqg2Vn51iKEtxvmNgLbl6P
	 jhzJ8qG/Yk/3z3ym6ynXbVKBuCLko2ntMwuMsi1I3RGGTBwcSx9fJKR9g+CJf/QWQoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H/Teh/K+eS2K3KHXif98xTmJa7x9xbSh6kJOnFn0YLs=;
	b=YwiRdZUF/5RcSKqfEAaXLBrUqKhN5znLNZqcxIghpDDnblGsILg9sGjG0M680HNQwiwm
	 9dmtyHV8J2ncvZlZqaCBgoh0roxFUmvffgKolKYvenBJC1qWAYUe2DVxrOOZEqje8LahB
	 FSrIX7GAHgVXJ6eIbS7eU3dIieOl5R/qBnlEUtj1e/tcIaCPF9mFCWzUDTg3cjxD4ERgj
	 fSiNZFWlPkRxTywGo6/bFvS723LzQnaebm4DqW62kd28HJKRsovPPwIbr5QnjYoujWCOf
	 J/I5fIgqlE+SLwYivCRg2ly9V6e1S2Ff7TkPiLLZfP31MwlT+Nly919jdpSLy0ouNQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlxcBBbA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59EA606A31A
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlxcBBbA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBF51F01825;
	Sat, 24 Oct 2026 01:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792804065;
	bh=H/Teh/K+eS2K3KHXif98xTmJa7x9xbSh6kJOnFn0YLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VlxcBBbA8LndnODe0Z9Gu4cUr0lt1W0PD69zPzSPNzYJuTmIKIHN7PNR16ucQhgHF
	 iTwalxzZygr6dsF0z6WB/jAy9ySVr7eRqTQZopCSP8SIKY3SqkHMq5VxPiJwph1Mhg
	 GRmt6k/G0UMkNkrakOXa7Z6UdZ3lmNpgsM3wrODqtf3sJB1tUy/fYCl792n+U5toqj
	 YgNO5AyZgdxjFMMdzCAPOdWO5u9WoM9A/Iv/PVUS/7fuNmmoq2mBCXoEBCJ15TrxnR
	 IaSbbfpfo6XmwqCpn/oGxC9LFvIeVTdSe/GgKs9M2lrjt3i+D97WLKYQYu/c/uIMBq
	 3/hem1jEBXy+w==
Message-ID: <sashiko-outbox-183483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] PCI: rockchip-host: Retry link training that
 times out
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261024-rockchip-pcie-resume-v1-1-58e54a5cf5f1@iav.lv>
References: <20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv>
 <20261024-rockchip-pcie-resume-v1-1-58e54a5cf5f1@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 01:07:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> On a Kobol Helios64 the JMB585 SATA controller sometimes does not train
> the link on resume from s2idle. The 500 ms poll times out and
> resume_noirq() returns -ETIMEDOUT. On v7.3-rc7 with the mainline DT
> this happened in the 14th of 14 cycles, and the system did not resume.
>=20
> When training times out, bring the port up again, at most twice. Each
> attempt initializes the PHYs again and, where PERST# is wired, holds it
> low for at least 100 ms. Without an endpoint, probe now gives up after
> three attempts, in about 2.1 s instead of 0.7 s.
>=20
> Print the LTSSM state with the timeout message.
>=20
> With the patch, one such timeout showed LTSSM 0x10, and the first retry
> trained the link.
>=20
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-rockchip-p=
cie-resume-v1-0-58e54a5cf5f1@iav.lv?part=3D1

