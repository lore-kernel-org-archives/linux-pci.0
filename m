Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794136008;
	b=vyenjMtCoPZBSUlFpMOkHNYjvTVFO2kAUxFpfpzUGvtwamD+qcHvAb8ytUPjV1aihkHV
	 gYzsKz5+8WxCRNtwb9TuZ5jY1u/e1/soiICsbg2dNcdZUMCtkyiH2FAnQSj3f6+yggZNz
	 cifUjTMKdjQdcB9zA1Te5BvXaEBCjbryD5xCT0di+CfPORyL5xSWhEJ8V8yHnSX7pTx41
	 yWrBxuNLvj8xBRx79Dr1tkgkhk70MTWhS/tv5luGpWxbHnCyMrAfTd+ovXaOTXIGntDdG
	 RezJFsvUEhRjofiAcoiZaqtQVH9Ex7LamXvYuTeWXCfafIMW2in7tdSnpuGPiuSJ/+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794136008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5y1WGOAziS2Inv8tLcRGxqHWYUed5rA5bprqUEOAF4M=;
	b=LwnOvlBPQvhTH04dXSYV3cbLvvAZIn7yvioe6+VUjCgtXFSmTIKyuWydNhk1t6YP+26q
	 wd9oIQlaczU6Hh2/Fu/lGAqyKsT1Fiu4/5gpiX4S+NhJ5ATHNcclX5eHbSRfVDRzp0qEo
	 x94T+S/zyB2Rwa3oNPRooDyyCF7K8fXupzZfX/3yRVHkrIvaKu/Tywp9EuHNYzdp5ZGeb
	 pTpdRM1t8ZOATYyuWf+eWUSJ7J1AoDO1+NCMfdPLIV/MmV5uvL0E9jnOxtQ2/KEQjlBGn
	 4fL9RiZc7giQ89mY04cDRo+OycMxdDENn/BLAN7GIOsxS3qF15XbgauRdxy18YyOWUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b9BiN+//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB0606A31C
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9BiN+//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825951F0089F;
	Sun,  8 Nov 2026 11:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136007;
	bh=5y1WGOAziS2Inv8tLcRGxqHWYUed5rA5bprqUEOAF4M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=b9BiN+//42/n5oSUBM5ySL6hAlXqt0QDpg3+A0MgGlECE2uJKa4VQvK1PdtoOJ1yB
	 GBTn6tIOg0t3qT9HOp3t49KQkRFijHLMQgYWNIjiYWFpYCIfDVPnAoc06SI2wSUM1q
	 00nUHoQE5Lx9RrLMwpESP8dkdMWFg9Mt7EzK01P6NFKWi/Z9XYFPFrNQ31c4D/mAUl
	 BqX5bbecz/TICwB4CdrA8xmEqISLk5sLufs4JIvjey6drLPR7prYanSbe19oQCROgm
	 fmqfl8ir29W9XamOIOzc2h9OlElhCmgZJn14ghxeAS/8Jrty82VHIYdj5tll+nxU4Y
	 Hxr2+iwaG+aBw==
Message-ID: <sashiko-outbox-203687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: microchip: Fix ECAM config window
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xu" <getshell@seu.edu.cn>, linux-pci@vger.kernel.org
In-Reply-To: <20261108105640.875-3-getshell@seu.edu.cn>
References: <20261108105640.875-1-getshell@seu.edu.cn>
 <20261108105640.875-3-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 11:06:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> mc_host_probe() calls pci_host_common_probe() but has no ->remove, so an
> unbind only runs devres_release_all(): gen_pci_unmap_cfg() ->
> pci_ecam_free() frees the ECAM config window while the bus tree stays
> registered - only pci_remove_bus() unlinks a bus, and only
> pci_host_common_remove() reaches it for a root bus.  The next config acce=
ss
> is a use-after-free in pci_ecam_map_bus(), which reads cfg->ops->bus_shif=
t.
> Trigger: overlay rmdir in configfs, not rmmod (builtin_platform_driver()).
>=20
> Fix: add .remove =3D pci_host_common_remove, as pci-host-generic.c does s=
ince
> commit 01fcb7f777a9 ("PCI: Add support for unbinding the generic PCI host
> controller"), so pci_remove_root_bus() unlinks the bus before devres frees
> cfg.  Scope: the PLDA IRQ domains it creates are not devres managed and
> stay unreleased - a separate, pre-existing issue.
>=20
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe contro=
ller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108105640.875-=
1-getshell@seu.edu.cn?part=3D2

