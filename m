Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427052;
	b=f8et7NX7NtxgNaLs5NV5L2TPvptcmM5gCdAnRRSXeazdmIQBidRuT8Tm7EEqjj+Etfiv
	 9iRgwcDc8ShEpI116gvLNadlrW1KSCMOWcYU54Xa5H5gGZrg30326O/g6k8rGs5OEbJFi
	 5P5v5YYci9tXebxLPcb7PSxQMY/xDeZL8V+exifW4jQ/EnLdKOxxm1Qg+yL0CF9u33Xie
	 yRpVa58b3vOaHvckBzhkLY3lIe09tEpACEpMTlBQaFZnrA2Fzli/hEOlfoog38+RRVEXS
	 emKddJCHd0lw3pBh46THAStR0xzxThy64stR/otYlFKdYrcvJw5z+WHW/B7Z2MQvF9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=odoD+BUVjYcB+vo7M5tYecGp9hOd0kXPzvDY3iLDlEE=;
	b=QwiL05K9axG0n2DlxTDBVREIDCsVbvQyHd4PSK+zvc4sFyXsUpUT7yAC8TNGWTwBP1dM
	 eKaWOE72XvXlupDNsKNMRDsU/3lC60OFLxxr/fVsm4NRV5q0lMfnM2O+77f1iRNO5d4u+
	 5o8eChQDS1pH9Z/fDg3sEoVwHuy60jS/YMFBTR9wqc2bPZnvYJGn50TtciQzJ84VsfOeK
	 YI4G0/S8dcZLVdH7F9fBBMRjCyMfXtwikRfyhdjL9/rmoUvWmPCp6wvb3wkZjmKbyowqQ
	 h6MPw3jGi1pU2wAuiS+tKpd8D053nAauL4vJNo6wKdhGHC2CpSZbgKfWHtg+H7O36Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx3XJR6N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E3606A319
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dx3XJR6N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C551F000C4;
	Mon, 19 Oct 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792427052;
	bh=odoD+BUVjYcB+vo7M5tYecGp9hOd0kXPzvDY3iLDlEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dx3XJR6NBkrt1yxR+48de1/Gya06XGUW3ceh4xNacJM/EoScomARMi+c8VolDez13
	 VLF0qjaR7n8c23qpPJdj4F94GU6SpZ8VT8qx2AAwLDq/tDVyckBTf7ZaVMGknsbRpu
	 TqxpqrYqGmPog18dllhSSRQ4gAO4iB+4m4FmjRXX4HuYEWeVX3PuCsqAxX2tth728W
	 85TXS5VIk/46UM3Xeyp6toPTT9RNDwNvHIbyt1CBah1ZkJml4/hgyYjLkqRcgr2jwe
	 us3i2dBlAt3wpH/59xrC8PnjLhqNtWfSzDZOLQLbvQnsB554W9lhVxvuy6GSEUonMs
	 Y9BoIrswi6N8Q==
Message-ID: <sashiko-outbox-177881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix host bridge double put in
 pci_register_host_bridge()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmoy Das" <nirmoyd@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019161636.2540334-1-nirmoyd@nvidia.com>
References: <20261019161636.2540334-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:24:11 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When device_register() fails for the root bus, the unregister path in
> pci_register_host_bridge() drops a bridge reference with put_device()
> and then releases the bus with put_device(&bus->dev). The bus release
> callback, release_pcibus_dev(), also drops bus->bridge, so the bridge
> loses two references for the one taken when the bus was set up.
>=20
> This frees the host bridge before pci_register_host_bridge() returns.
> The caller then drops its own reference on freed memory, either in
> pci_create_root_bus() or in the devres action of
> devm_pci_alloc_host_bridge().
>=20
> KASAN reports the use after free in pci_host_probe() when the bus device
> registration fails:
>=20
>   BUG: KASAN: slab-use-after-free in pci_host_probe+0x17c/0x180
> [ ... ]
>=20
> Fixes: 804443c1f278 ("PCI: Fix reference leak in pci_register_host_bridge=
()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019161636.2540=
334-1-nirmoyd@nvidia.com?part=3D1

