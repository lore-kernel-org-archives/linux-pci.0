Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505565;
	b=mmPLDvvhFuq0C1SOnA8871MaqITtvDqO2T+35TwPTTZLTsfMVzZsDkIRYzKGl2bFTLKk
	 JA7+9NSuxSTWr45hX3RtEGuniAWUZCeRsodjOTaXxCPzUtwhBp0X5r3qgPctok/OJpjSB
	 xVixHryRmQMz9e99ob5zc1HR9/KPlsp/rNvCGMyiVt8oY7pvVnDf7hiY7valu2GKmS4jP
	 LIa5uN43dcbBAXuD7ZD8qhnVdWFfCSH+TxtVcodCE0U7hG8SHUsJchIVXV2C/2k3EfsrC
	 ywj9oX5k9fEhp2hhhtkJBiFec8O2vcdvpT9nKIQ+QMqD533HC1S4BmQHnXrRaDdO7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZalRytLdPzaN2CwtcFE2wm94B+wEIl+cN8x2XZElQyE=;
	b=drXpN27qRFu/uSbTev5XPZacWcFJMGSJxGaMl0GpPhKA63O0XoSA0T/HyL3Jba9a/5vl
	 d++2AS1ccjDrlIGTGUNa3AI2X7DUaEGBoZuniyC4z09tf1DL1ln+J0XhYIHlbG2JyMkyS
	 XKCRp+G7HhReBLSIlKd+kuGlLHxFlnhtmuV0hbJ6eTjxMAVtCUrpIimqejMfbcrjdgr6X
	 9D9tvGxoV239cS4DNC0Ey3KmcHZuGjaX8crNvFlUNDzoaPk0SPexD5bbNJtZWD51xrh3q
	 QvymJWMddrclXqtvWx80oGyk2FMnFtuQt+KG4ImnDW0HZFVGnaqWBgLpC9TlrdcaEWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiHrVuUS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B1606A332
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiHrVuUS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F222F1F000C5;
	Tue, 20 Oct 2026 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505565;
	bh=ZalRytLdPzaN2CwtcFE2wm94B+wEIl+cN8x2XZElQyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiHrVuUSn3KDQw5oC2ge5JX+g6uNN8yq3qjkyVNQcYQiTWoW17gDWuLdQHAnCMSlB
	 NZSbgRBxVH1aZ5NwjIc7UwZU4qK3RPoafhvwpjDAVYyMyK1C+rC9Yw2UXlQMYWcW1Q
	 D5Tom9Z00BQpfYTgl1QlDAvwTSItmXnOjW7Kot0ETt0ZJGbObaMNU8uY5chhswVukI
	 XXQrjg2UHJTeCxVUv8zYoSyWFF+0RCRPAludCg+BFfYlVpFWsMKkHRiczmRmnaUXRB
	 736RcaO8Ee7jkdmuUa26R6O5OTjMoxQB4S42VDofl0qCVIOess/2EjX7YrBZAPE/3X
	 aoUWhKLb6GlUQ==
Message-ID: <sashiko-outbox-179093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020-vfct-regression-v2-3-d2394d11450a@amd.com>
References: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
 <20261020-vfct-regression-v2-3-d2394d11450a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:12:38 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vfct-regre=
ssion-v2-0-d2394d11450a@amd.com?part=3D3

