Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294980;
	b=rmtQgbGPP477Hf/XvUDmpKi765N5IV8iMPwplkMmKqKQ0uWyW/0eTgSBsXOv1CR3nEde
	 K/Pov6pQte6+mc8XowfcC0PahC4HnISDUcd3vHNUewcFRW26JoQUxRoso57vI6ULSw/qB
	 PmYwefeZAXrAfDV0Hvl/hvTQr2ATp6v1dAYofTMJQoxjGQ7oMlYEE7TF5vCIqiHdqx7Hx
	 9069Bejv+mNExzdtqAU+Qvl/hDOGpGGSPikevKMxpavhCjTUeiJpCSYKW3die1mYPHsZh
	 BMvep8Ns328d3YKWCVI4/deGEx5VgRwLNdv7vRaFIOwQ7Q37IqWp2AB+fbfNR4+vh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294980;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H6i27QviWaVfBFytH+9ADVMGMQmwI4UXD9qv+3d5y90=;
	b=EYIkS6WS2hLD0RUX+cduZcF8sLeM2MgVWkMCyEUYmptbh9D/QFl4jKKVNptdqOKbFbdS
	 USwzGuLDVqrnGm/2D36JNPJNjuimTOjn0Ws7Ji3+dAUlQeQ2YaCMzoqtIcB7rRUDW3gnt
	 k1MHnPCczE01dr6b8UQJkCskA2IsDVnYsQuOfNiVqHqCKtGlyVJmSqJbbo3YQbPAo/jI9
	 4zQU4a9KosaYjJeC3dvdZWBh8NGq6Jeu3ycs/C8RVwfrt6lW2R1RUfHDKTKphgll9Do61
	 o0mxGSTZfVGTyxLHX9aZeFkkpjyC8JwVJAKVQPzC3xzz4qyVzzhLISnT7M8EYEUDmQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdDHbJSD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD6606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdDHbJSD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871D41F0089F;
	Tue, 10 Nov 2026 07:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294979;
	bh=H6i27QviWaVfBFytH+9ADVMGMQmwI4UXD9qv+3d5y90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GdDHbJSD8ndpuVKwW2NLr2hSZ3r7Vf0EljUs3jnUyE0fjvqTAt5B5W9Ip2HiEfHL2
	 paUOhnF92DE733HD9oTZZByDhw2OUOlRun/FyHSileE1PiFp5rNOrEj/frLbwCwdsN
	 YEyfL9URFd70loiI346e/kESEH31EUtjU4tw5CMz7rLynqMIZy42S1XxFYWDs8KPCz
	 03Hvc6c2bbpBdh0AdPEKi1Q46p9QTTahdxY4eTXZjXAJp6Jb6OgQU+NZCwgEsORm0F
	 /zPj7cMaDaZoU58wZw+sfq0Y5ZdmDx4cIVmc97oE+UajMFEQx6Te54FMyszsa6XC4r
	 hetPBRxOU2bbw==
Message-ID: <sashiko-outbox-206470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: j721e: Fix OF node reference leak in
 j721e_enable_acspcie_refclk()
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110070944.996-3-zhaofeng2@cmss.chinamobile.com>
References: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
 <20261110070944.996-3-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:16:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
>=20
> j721e_enable_acspcie_refclk() resolves the "ti,syscon-acspcie-proxy-ctrl"
> phandle with of_parse_phandle_with_fixed_args(), which takes a
> reference on the resolved device node, but the reference is never
> dropped, so the device node is leaked.  This is called from
> j721e_pcie_ctrl_init(), which j721e_pcie_resume_noirq() re-invokes
> on every resume, so the leak repeats on every suspend/resume cycle
> as well.
>=20
> Drop the reference with of_node_put() once the mask argument has been
> consumed.
>=20
> Fixes: 82c4be4168e2 ("PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acs=
pcie-proxy-ctrl" exists")
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110070944.996-=
1-zhaofeng2@cmss.chinamobile.com?part=3D2

