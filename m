Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441377;
	b=miy8FMaxNWba3XhLQ8bWRusGPbEuyPVNZODWtSdtAJGiFWIgx4jcwXjKU5D0KpDK6nnW
	 OQu99lzMj3ryWLgGiS6dQBfr4yXxYyJUFwvQ8J1HxQFxs2RSDRSdE5B/aAapX73mZXk0V
	 CUxckiOIDUZ/x6ytrgEhf2tnkTBiWeeqRtGQRejFoVzfpLCQ8beTEsgCpjzZTH5h/+Fhg
	 LqoohI3oKZ/3Ze47VvrfcIPKtt1324Y1kn0ES1pXWl5pbJts9ymo3UqeurgLNh4KT9ojw
	 ajsYzwVHMn2C7+pR8WSbgCP08mcM3JrltlH+BJAF0ErwzLXa/55jTW3080LkQAcj+pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441377;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uu1yAjvoO+IjoLp96CVLcyj/7BjwOca5VvgXKrCJ6OA=;
	b=gQrz/9I4BjC2H23szDyRWtu/+5dAyLpqaQ648Fvnk72h2KvnlntJ5Kk++GEQHrTnyD/U
	 ZNJennRMICDbITgxFO3IKHhsml1bcSSbdIUSeVR2xjtydvSUizbTbErwglYVKfCXSPj58
	 BGaNOt1mZOGdxJjnxOwR3pzFytZHUZ9YrcTtbZSgkArpTBef1/J81p+fDC5xxUUh7gRjF
	 FjGMmAS0QNdQv+UxHAavcsxQTeSUoMkqAhHhuCKT7fjs6seb7hHyQ4ltaBXtO7bIqYWUn
	 Tgwxj1M7G3uzV33+0XD0kgrvLOyhYemRgS+HArT+PixtC8fziDPOINHJhy9hQMHskRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YD4v6Qrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AF606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YD4v6Qrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D9E1F00A09;
	Wed, 11 Nov 2026 23:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441376;
	bh=uu1yAjvoO+IjoLp96CVLcyj/7BjwOca5VvgXKrCJ6OA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YD4v6Qrdkd5TZYa4d5G5SsZ3p9497drRvt5ihNfr1V6WGqRptpuFMUQNGq0KUoxYJ
	 sXY2eSsc++fScrEqq8DJjEuwgxzah2Kflql6bh9yZXt7WNc/yoNseSZ411fZ00dku6
	 EpyjCnxXfADBPrULmmt3eKPOTfr1wVJGW6C7F1j5sGgl+nbA3JQgQIX9Ob7Ua3lOVk
	 rAIcTdyRPWpTlzH4T68hWIpxxJoqGsHky5p1Wqgw0UuE+foHMVLcPwzldpZMeYlaqw
	 1km11pRuXglX8eJTmEaQU/wEBk5OF8paFGIsp+lgD6QgnGJ/lwH7m+8afZqmf73Plj
	 Pk2m3/pen5k2g==
Message-ID: <sashiko-outbox-209871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/11] rust: pci: drop driver data before remove
 returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-7-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-7-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:56:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhi Wang <zhiw@nvidia.com>
>=20
> A Rust PCI driver's private data is currently dropped by
> driver::Registration::post_unbind_callback(). The driver core calls it
> from device_unbind_cleanup(), after the PCI bus remove callback,
> pci_device_remove(), has returned.
>=20
> VF drivers will store a vfio::pci::Registration in their private data,
> which calls vfio_pci_core_register_device() when created and
> vfio_pci_core_unregister_device() when destroyed.
>=20
> vfio_pci_core_unregister_device() expects to be called from
> pci_device_remove(), and hence can't be deferred beyond it. This also
> makes it incompatible with devres, i.e. a
> devm_vfio_pci_core_register_device() helper wouldn't work either, since
> devres_release_all() also runs from device_unbind_cleanup().
>=20
> Hence, drop the private data in pci::Adapter::remove_callback(), so it
> is dropped before pci_device_remove() returns.
>=20
> This is a special case for VFIO-PCI. In general, a driver's private
> data must not rely on being dropped from the bus remove callback; any
> point after the driver's remove callback and before devres_release_all()
> in device_unbind_cleanup() is sufficient.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D6

