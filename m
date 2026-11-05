Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907517;
	b=JrV2q2pt8bT6SCy3BTKx0H6/pUpDJqOPMmzqVtBIh7d5OtOrveTlZv0kYUiBu++/0QAt
	 yC15DUeV3nqPjPO0JVfZSp6tp9TfgES1O37xgnFgFnYkGUx1v2bBeqBNjIDVtqNergHbR
	 PMqAjWbAUDz95qFYEsigHeA7kLpnluZMicVdvNkmDEShiQoAN48JEvKRqUEaKxxS6f4e+
	 WyY9c21vh3H3xAeTm7UBO3uUzV2UltnQgHFzAUcv82YjSVsck+GBLq5OJwF/ZHpqA5CNt
	 BtO2SO9kthmZl6Oy0EhrZ32PuLQK8U/qhR3U1dwNkpoKEtviNHmMqykGrl1ukkLPXOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ail0wxJJaekbARnGqO/Bu3sZ6+e8TGtnnAphFMmqEAo=;
	b=xOdoO3qA5KEVIKo6k+vGYXoOascFZcQ3FzpzXYblTSUrP7m/LkPVsArPDZXgVNB8rNvX
	 56XAr1EfEUA0TlLaEbtg0+sKb69lXgMBAe6Zk4yJD6EjaG5kDv6sc/DnrT0uPfqprlrMW
	 WcQYf83wisPCM18AQpxu4s4/P48IDGMNxBCTeXWRK/Rl9vtDM8rgBrcLFfzHMLRMoAwJG
	 8h7Un06paE4eFcUUJuiDEnLFfI+APj0QmEQgxJIBHYwe2aQKFhpnkssVEbr08He1O0l3A
	 k1etitznqpO85X0zsohFjLIbmZannH8qmYvMG9gPZPYaGcS6Mnb6arAL7kYZ20QfgTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gv/n5AxX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAA606C8BC
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gv/n5AxX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BA81F008A1;
	Thu,  5 Nov 2026 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907516;
	bh=Ail0wxJJaekbARnGqO/Bu3sZ6+e8TGtnnAphFMmqEAo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Gv/n5AxXTxoR24fOELK/r0w7IMCpq2VTaCoxBtlmxt5oAZ8Hio8k0L/rxwt+vSyQj
	 dXVtIpWSrNmBCWRPjgOLhS0rWqKFIiRIwpfBcANX+9jxkCAjHTHJdMWugYgM6OZ84q
	 Of0qV1OKQycLe2mWct1aJsfZ8FdjGok5NZVjJnH1c9EN2fCzljt3zffH/cIzQ4RH0Z
	 k+OdXDrv2nia4Us71+hBwRrYxgp4ckFkSMKCx+6XAQf4ze2dSKc935Ees/l1YTZF2J
	 UnoEuWs/uiqtJcOX6cveGB62Yta5GX3lxKlTz5Fnjf+2MZ1R52PT5OJUJFt3i2u0J+
	 i4mKmLTYPpVVw==
Message-ID: <sashiko-outbox-199960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 19/19] cxl: Add KUnit checks for HDM decoder
 unpacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-20-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-20-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:38:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Test cxl_hdm_unpack_decoder() without a PCI device or HDM MMIO. Cover
> range boundaries and overflow, an all-ones base, zero-size and uncommitted
> decoders, and a locked host-only decoder with 12-way interleave.
>=20
> Run the checks as a KUnit suite rather than during cxl_test module loadin=
g,
> so a failure does not prevent unrelated CXL mock tests from running. An
> uncommitted decoder has no meaningful target type, so do not check it.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D19

