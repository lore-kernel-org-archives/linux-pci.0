Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829890;
	b=1T4zX2Apcau3V9bhzCxa4EO//etjdDFl2CkAhLdzSF2xDnsPwsf7Aq7V+wJRtABuC55k
	 45+5Vz+wpxkC9NJ4LgxdfMnNGlG3w/46m5HT5EhO5s3qUvLdjbLCV+4RYK/wsz5gmaWDD
	 G7Gpsr755fQSIbYjVxBU8qIx8ef6vH/N7KMeEi3BO2I3IlziNjjbc8TZnyJlcM7XzjBdW
	 xojvjL4B4affZg0jhxXGmpT8lof6JGox/JX7gBiH9IMyXhsbO2lqSzjWLtyBjVazn2tyy
	 k49Q+APgxVMWLn/TkQbcpiOktwb0/GgMzdd48mMHHUOUw+hD3PRPzJ9Enmqo1TxPhdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829890;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yX+sz12fM9HuC/LGJPohmlA7UTUKk26Dr4ZoDCbUUiU=;
	b=zyq7gr7eg296ap0RbYv7vx56eMrFKSaQamF6UDQpCc2LfDK0zqhlTM1MGZUYzYS9h/0U
	 X3Q2DT4vyQV4XbcTmlocX+HR/sCR/fsSSdtGy83fBMCRkvaAKU2h3c5rsxZykt9/Y+Sjz
	 MYewWfBDb+nubwc/aNHKn9A4BqlScALjOjZHWONRAGvrew0cMzQdH4nDSw8nbZZamqZ8t
	 TxhqI9oemG0XRjnqflnZQoYiZDZrgt3Hz3kwZHi8p4PkOQl5dRuGPAU115zshPqSmnCVf
	 aMxuULdAGvR5KgoC3sqpjUKTZu/lVm1n7Am1GeNOTbsCyR1RzY2IMp6ASgj1fYaNtHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLTlsLRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E1606A328
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLTlsLRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1785A1F000C1;
	Wed,  4 Nov 2026 22:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793829890;
	bh=yX+sz12fM9HuC/LGJPohmlA7UTUKk26Dr4ZoDCbUUiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLTlsLRJKDOqoqj46eTuSFtfAQIf0pm2rJLoWUdR9nzmAx5jmd5BVywEukfm9uBWP
	 ZNXDG4NPTsrOm2AjDnXJhRz0NKAd57A8rep7G/qjVRJ0DdKzLF55irHwd8c5P8Yht9
	 k8xglZR0taCXZ8nwku4BEBSVizippG2Lrih1I+fx/vpNEc1VTNZZczmGFVfo7e5aS/
	 ZchmDSQPaIMgugfpq8A7elk5Vru2yj7vRQ3z9PBGYRabi94wKG/WsJTLBi3Boun+q2
	 uxM465VcExB6Vjc5e3i0V8tDviADvdobDVwRr4LYt/PW4pVoQ9xvzhZ2e/lGK5iyGm
	 S+ikjLjNAtWHQ==
Message-ID: <sashiko-outbox-198195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: rockchip-host: Make the PERST# inactive
 delay configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RW5yaXF1ZSBIZXJuw6FuZGV6IEJlbGxv?= <ehbello@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104215848.2087944-3-ehbello@gmail.com>
References: <20261104215848.2087944-1-ehbello@gmail.com>
 <20261104215848.2087944-3-ehbello@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:04:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> rockchip_pcie_host_init_port() waits T_PVPERL, 100 ms, before releasing
> PERST#. The GPIO is acquired with GPIOD_OUT_LOW early in probe, so PERST#
> is already asserted when that wait starts, and the wait therefore sets the
> reset pulse width as well.
>=20
> That suits a board which powers the slot at the moment it asserts PERST#,
> but endpoints do not agree on what they want. On a ROCK Pi 4C carrying a
> JMB585 SATA controller, a pulse that long stops the endpoint answering
> configuration reads at all. Measured on that board with a single kernel a=
nd
> two module parameters, one sleeping before the GPIO is acquired and one in
> place of the wait, timing the pulse with a ktime delta across the two
> gpiod_set_value() calls:
>=20
>   pre (ms)  post (ms)  pulse      trials  enumerated
>   0         0          1-11 ms    5       5
> [ ... ]
> specification sets, which covers T_PERST and T_PERST-CLK.
>=20
> Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
> Link: https://lore.kernel.org/all/95aeecc0-2794-4cc6-a635-5c042afc1405@ro=
ck-chips.com/
> Signed-off-by: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104215848.2087=
944-1-ehbello@gmail.com?part=3D2

