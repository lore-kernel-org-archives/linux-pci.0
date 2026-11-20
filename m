Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150405;
	b=iU1rXOSiem1taL/LOIh1PI01JNckoJR5v6ekDEFn71Reup84Z8pOjN3vXtPnzxJ+dAZc
	 4v5e/Bg5fxiENkd+zDnYHtlpIEkwV2Bm3ICIX2IQS3g8x4glJeznFgjJbbiJrjOFir4Gw
	 Gh2iwKiTkvmWDFxWqLuzgwI85hmvLfUSLyKtgOxIL1JyiCcRSmoay8/eVkJ6R/JPDs8QM
	 f9OZqBsekJe4vBtkaGanpWlgMotZWOaccA2+zRxDyIbONNejKaYyRkgmgLyGmvJwGKSan
	 Yhnmpolh/YpEwDWdZA26LRKYq/MOrk6G6zuUVQ49yC/lUHo+v2/jl5ny1vK9/ohID0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150405;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h39OQF9x5IXSy3tbAEAfKJ5cJaCfcQizSifb4osjMaI=;
	b=ZgHaL6WTF6yLuDYOzI520sejDpAE80eWZHptJ1rreZBdcc+cXJu16JjzLlKkMsy+WZ+r
	 0nAF1v+FWCrIJuyrWUdh/3uvjP74fF7wUOxjDPPQUbMmngtphmd5d6PDx4E0bVUIg+X5d
	 RD7a1gy61RL0/BmKp1N8o2GvN0Fe3qpDplVbwzETUlmVoguxQVZ2+JDIuMMnibd3geEzT
	 eyqe+qBjACjREBi52ixS8/4HGg/DJxsiAbNPFM1RjAiVZnNZxs5cNA4UV/uOPq/1Hury6
	 cSHy99QCrSQUxqskbxLYnMqgkOy7rkvDlMVtDFhHnMvRMbyQVWep+Sp1aBpAzyrQr5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSNb2uhn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F5606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSNb2uhn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9209B1F000C6;
	Fri, 20 Nov 2026 04:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150404;
	bh=h39OQF9x5IXSy3tbAEAfKJ5cJaCfcQizSifb4osjMaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSNb2uhnpqCEgFbQkeKjSzvEYptzeVaZnIhHhr4A/e9Xpiz850xOlhQ6FbuvqjdX1
	 PYp/KA/yHN6YObCAcMCWGLL1NszChqP2RhJ51OMKmywXYpMeQtb+tjKUxDVM9UBFvE
	 2NokvpM6FFvW0tRwvGyflgZm2xqCLLq748FxCC9Yq+qCm5ULHiHp5DTFvammXV/sqi
	 lLeXN26F3aM1GJ+BDIVxsx0IpqJEyFmt5OQfxWZ8SEKK3KSYYtY9mPpdMUJhY0NRZc
	 WiwKl2VprE9RRQmw05uuVNgop969y+hNvbtpFbAIc0ztt/s4AEbvkbNENDZqYwuEvY
	 R8mRFGIT+t6/Q==
Message-ID: <sashiko-outbox-224480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] gpu: nova-core: falcon: select the BAR2 engine ID
 for framebuffer DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-7-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-7-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:53:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When Open RM loads a binary from the framebuffer into a falcon by DMA,
> it selects BAR2 as the MMU engine ID of the transfer, in the falcon's
> FBIF_TRANSCFG register. Nova-core's definition of the register has no
> field for the engine ID, so the DMA transfer code has no way to select
> one.
>=20
> Add the field, and select the BAR2 engine ID for a DMA transfer whose
> source is the framebuffer.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D6

