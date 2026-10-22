Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658685;
	b=fk/aqb4bU1LW8cZNSqhh9ZHZcdB1sGLr+MfKLZWhGiJVbM/+huoMyx8VWbVYLHaUX1Hq
	 iwFIP9DjY0h486WM3R1FAvhQ2X8k/tOH7nB8q8slAjBDN8IVRMCuNOd7OE1IBXIDnS8tR
	 gPb5mbQbv+XNqHE8/ks4rwIchpSwRnNzPE/H051k5qXWpDvFRUsjyKzudK5sPLVieOXWM
	 jv4IN8/Chrx7lR2XdasnXOzlO4+JjrBO/KkS2ZSkpE6ci9S/7AkaLDZw/j8YkTkXGz+Fj
	 UgSSLjDVzoDdjaV2zhAoOxPoT6AzMKzD8mJNeE3KDTm8LrTagUAxhr8o0lBazolMYaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YvghlgLVhFEyQJ7e7FcAx6/7P66pGQEiSZJdj+xvX6s=;
	b=SIguG4rdykVnjR020GGXC8UqZSd0X9Qu1+dq6mjpvQUB8FAXIbsXFoyara4dSgPsUuq8
	 u2Yj4tuh7D/zVc6pgDWdqJMZG+ECYxO890FNZMT6WL+3o/wOVZ1QFphscGBrt1IV5F/k7
	 +aFFtydkcXA6q9tLGCQKxwig4B7idPyrCHzrhiTtvihpOOiA4wXgepZN7sEwD/IK7ip5o
	 JE743CHbxorqxcyr+HBL/JtvL3aUQvDF6jiLuWNAuuHTMQTUkGahpxoW//xkDPbMOzakk
	 8zHoXrEhu6z3D6GXuzhYK4zyL60PgFzp8Kj514OL0aAQeveEwfEJjDOA3fkHGTgcPLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZlF59dC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A2606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZlF59dC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2D31F000C1;
	Thu, 22 Oct 2026 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792658684;
	bh=YvghlgLVhFEyQJ7e7FcAx6/7P66pGQEiSZJdj+xvX6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZlF59dCXS9QeNhGMKSYEln/HUnYwdzl0RQJSWKOFqSi/xwq8YOqDRZ4k868c3qCo
	 289u9hKnWw2nu3TAjCK8g2v685SR63wJD46kIoy7ayu72GAoH6NME7jHwfXC598/yh
	 9vZknowpj0C/kXzZbqfU5jUmZYRJMhIf7ImGsjfMqG1ohhXSaIpSrvngsWoDRyFrso
	 SrCuhujjdjjNypX12WaoNgJO/Iqu6MAwVw1hJG6LPnzGnJzlJBNy70J3KN8IQoYGiP
	 sLaFVvdYXpi6lspNb3effGMXQj9TZf/JYXHO2Fso5P3gYRTIUM0ir20Fk1iZH1Zmd2
	 14m2mfNA/rRPg==
Message-ID: <sashiko-outbox-181200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/10] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022082230.3164834-10-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:44:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A vNTB PCI function can now expose endpoint-local DMA channels to its
> host. Decode the extension and register the advertised channels before
> the NTB device, so clients of that NTB device can use the DMA
> functionality in the same PCI function. Endpoints without the extension,
> or hosts without support for its DMA type or with no DMA IRQ available,
> continue without DMA.
>=20
> Only DW eDMA is supported for now. Dispatch on the advertised DMA type
> and keep type-specific setup in local helpers. Support for another
> implementation can add a new case and its own helpers.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D9

