Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821367;
	b=AD+0819BUES4U/BOhPaE+w4ThhoiHv+8POrZGH89tiaszRR6XEq/JIX89JQgZ3ug6hMd
	 NDlozl3AbPCBs6n9kx6dHqWiWfGe3JE5HbUGozXxWLgF1lX4SkzpgnUhuQM2P359M+TnG
	 Yua06575B1g02AnQR8/ewLotQBlJWW1F4Xc3eSyGFnzG2d9agQlJj0kYiIYoi4jk99pC6
	 FBHfwnPlo4Jb4i3pKuqgZBVjWEdHImm9Gao6I2Vg2EO9b7eHLVPDXc5KNUMLzufuiveiE
	 z3dAlB7G81EvVpbQ8NFYmlNRqzph0l4+9JPPMHJJqNAhDh1aZgEuDbwW9DdYks5helA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821367;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FNMRZJIkIwe4KWycNZr+veQeYIQs7uDOaOwwq73o4Q8=;
	b=AlCn/35FYWE4B0I0YkHkjSZAyz9mC3zX5JtiH6e9qq3WyDdxuimXrTgedEt5U4Lib8YA
	 05hxPP1XEOIWc0hXiqIgNc81VKf/LvUkDiin5DQ1nBkgCIqmP6VXA4f6xEubBJPQedk1y
	 T8S/GAZkEDoBypf2Lo0FxAKmtMM9sdWKsFxccqIfzRbCNWkwXAeleVT++Vi5q1Ap9JWMh
	 XXN/Ts5LwTlx8Dbx9tmBTMfL93nIpYh7AyoRY+atI5Tp904VcDG0Dyx1thLKtaIzAlBd5
	 NX10JrqJ8ZR64mhFhuDaU6GNOLil/xyt4ExzVz24T5lrzRvkGXgrtCSxHnVkxwERuqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHqHBGOC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD96072FA3
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHqHBGOC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23E41F00A18;
	Wed,  4 Nov 2026 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821366;
	bh=FNMRZJIkIwe4KWycNZr+veQeYIQs7uDOaOwwq73o4Q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHqHBGOC4smNkOu1yAJ/cyYI7wmVSGpmn+JoTN7FnyYV3O0mnJv7Jz4XLGZPnyFih
	 i1BWhaHB3aOPfYO/qM7n5nMu9OMokpS5qM/MZIggDm0tQOb0lebSHaRWkQSYL21lEZ
	 XU9jNpxu7LAEYgdB61KdHybXCxdnsjpEtdWdutLA4RGu72C7xK/NfeIQxuCMWnjzB0
	 mX9gZLxVEEaD4ItayPNLKZoQuoBMR+Yd3p4RR09K6QnevUKbXhuY/kuq90H2HbTsTE
	 jsKbzhsnO9JSzfUfjDsbY/ffpXJtUrkIYK/oqrZwgRCxCkNYJnX3My/S160SwIkMXq
	 an/2ibtuZez1A==
Message-ID: <sashiko-outbox-197975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/10] PCI: dw-rockchip: Set broken L1SS resume flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-8-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-8-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:42:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> During system suspend, the Rockchip RC driver effectively powers off the
> controller. If the link is in L1SS and the endpoint asserts CLKREQ# to
> exit L1SS, the time required to wake the system and restore the
> PHY/REFCLK may exceed the L1SS exit timing (L10_REFCLK_ON +
> T_COMMONMODE), resulting in Link Down (LDn) and a reset of the endpoint.
> Set broken_l1ss_resume flag to indicate this limitation to the PCIe
> framework. This results in pci_suspend_retains_context() returning false
> and PCIe client can avoid relying on device state being preserved
> during system suspend.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D8

