Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351374;
	b=rSVa9r2mNgf4qifV20bU2vDOoENjaWI/9otB6RAxWTT3kmLAdjDfbNaZvl2Dlt1fcILR
	 2M0cPGKdngjPNC24k2rYTI0YcmGgY/5lQ96kytiSZheGJU9/+bLrYSyUAATMv/t/vnZ39
	 4jr16uvYrKJ2oAflxBxy14FOgmKut//Hx1wtT0t2mSHhD7f9N4JUUU7hvAY53l9XwBz1t
	 htTJztWekXs8Jv40RNrUkqebFKLeoTMTSp3my9/HG8veyIqnzIVTg2ru46k2FwNdn+oeo
	 PfixuMTiR+FDGjFnPXm087r7U9dxjEVk8JGeVjOKuRH6JZQ9K0yGewBuHOpRP0OfTcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jr4dD3V7Ug76yGf93ug44HcXX5SGXGvr38cl6LK8R+w=;
	b=1bFGsX2+tdddlp+K/AmFetTsVUAoWlxsjuKVq4eGtbgKS2K41n3Yi2N4OM8CvHhdi7mF
	 ZoX/hQDI/Lqm49ZHz0oq+HWkWt4TZwKRV8bTW3imciNICbCjwb4ND24bPK1lMYLPknhWT
	 keLvVYRiUOrQPVGIgBv3MnogiQMTb3nue19Z956UD6YLDpPxGssVbeyBC1OD3TyMltef1
	 1SvhQeut6Ta3m+gej4HhVcGocq2i+UdGHP1tsSt15521zYtWADFMbAFun5LLbmxJpdfmE
	 4hnBqO3TGfFldk3t6OkocqgIviNtgnZXB8qWT+gWChOtRI6cRXxYw3noCsKfWVh7eBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTsCWXQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E3606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTsCWXQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB2C1F0093C;
	Tue, 10 Nov 2026 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351373;
	bh=jr4dD3V7Ug76yGf93ug44HcXX5SGXGvr38cl6LK8R+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTsCWXQRWGMLNbKzlK6t5dKB5g/jn24h/JhfivFQ1TKXNmMBxjI1eDuNmMSNXpxXW
	 LqyPxgdeu7q6nlB485Ps0+0NRHwwIGQQVmtBOzuz6HcrOso4+UHc9efH7xLKBQHje0
	 OTHzlpfp0yfIaDhvJKQSxWf+PFACjWqlcPolX2h5Tp+07COBTL0BOmvh7FTIDCpdqN
	 w9+VL/408izoLDhhQVnE2rAXZ32FLuoz64IoWRlwujUSbGMGGzBaBj+J/8d1AGE1qD
	 RSPsSRls3CmsGXANQbfrqWqCH/uovY6r8PNfoouSD2jHXznkAJvbgWn3ps95BPEhW3
	 UblJnGBO8LyjA==
Message-ID: <sashiko-outbox-207853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110-vfct-regression-v5-3-f49fae981bf3@amd.com>
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
 <20261110-vfct-regression-v5-3-f49fae981bf3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:56:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vfct-regre=
ssion-v5-0-f49fae981bf3@amd.com?part=3D3

