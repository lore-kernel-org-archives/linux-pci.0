Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836609;
	b=fm24PTq7+S02PL/GuKKw00a4fCwTcr5vGGt8agXLSsnBFg/tw7p18/D09D3OtuHbspvU
	 VtFCSr+cxNr5JyoKaO67cnytH5Vj36HGV1YnY3IkusC2ns6UVwFJ1mWqlMWXFxpNNzDlU
	 eAeVWA7s53P46cVP0Aumg9tF+C4E1yKOfvUbYzt/tFmiYo1O0cC0Z7pOiMhHM8IN1XwDe
	 HOyHTJ5l5/ivuDW4yascp60iVDLulIVyoNjinKju1t3y9NvpTXabqWTjrRTXvsDx8tXEr
	 9K8KIYkG039oLaj5aIuP7AxnhSim6y02qOju9wIEVRaqPvz7OLqmw0vjvcRA6qrM/Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X3TLor0t8ib1KKB/jCgYggwdiGBnvYsKZ7hIqGIt7zM=;
	b=NsWkU48y/OHDFk0HneEGybgHYc09233C+7cYD8rKLsJZoFivam6tX5Bfx3KY1uvFOcd4
	 V5i3sbX6SpqiXq32GpPNVnrDgekeHnCdCG3nBdfdijGkx1TgF9oDp5n8CoPLqQkErUDwu
	 k5iE30iKWOn06eJ2mdCNoNKW0FhPkI5mFjgO1Cb/xKq0JzvNLSi7CsdPMur1OXbrJc9c2
	 c8Du2kGbkSxlGaAz0dzF2v5OSD6Iup0juCxhcCV+t7sWNI7YCWFqKI7UjEDSVIBuKo+/A
	 6VrgoMnAfYLG895lx7x6Kx7Cl5EfaX2Du9oMbBwuI/9UI/aM0YWoNVkVmFa39zha2NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5QExgzv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA598606A328
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5QExgzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816E91F000C1;
	Wed,  4 Nov 2026 23:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836608;
	bh=X3TLor0t8ib1KKB/jCgYggwdiGBnvYsKZ7hIqGIt7zM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W5QExgzvy3mUsu8xb6osRiIMcz0U+brfFJJuJ4CGunupiMWP2CFt0bj9MVUJ44S8H
	 t5NM26sDA0zYvNJ3xlvh0cB0XIONa+NqQgLkhHO1IdhX55wovBKk4xHqtfhFJwkZIz
	 CsYgQQTC4JrwpGOR9enqmoiEtK+/oZXHllGOwiCR6XquBxAYZe7+tPH+ui4iyLzsfq
	 0a97yKiCWBxtaDzSHIU7xikYMxNwtxwnQID+OI8S8c4CqsqDx2jjEdAhhtsgor9wnP
	 Cs2SYrTB1diYdwv2gDaUNuRgYmGMPKYXiuHzKj7jD0hnW2PUkfgJf98QTWl9BQpjcn
	 FnVlDCDWU5s6Q==
Message-ID: <sashiko-outbox-198324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/9] PCI: dw-rockchip: Add pme_turn_off support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-7-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-7-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:56:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Prepare Rockchip PCIe controller for system suspend support by
> adding the PME turn off operation.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D7

