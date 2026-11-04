Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836464;
	b=lUFia5wKtbVgK+QwP90deOIGabC1lS9XjXjKIyAGNepi1FMmyJCdNdlDkN7Ct0ozECWb
	 tZxpesHktw75lb6e2/Cvgn94AeOIfFrmUn7SO2ASqx2lPQ6+li4BMwuCtJk5dL96I/goQ
	 1j0uZwgKezYSEhRG7ISh+47+EmKyt5IR3D2KTZG23FwwpzCYtv1SoJp7OO9CK2xTNC8dt
	 t+KgUi1v8lp3BgG9Z9KPhagWdWCV8EOI/G4JV7ef2wwzTb3Pstbydmv1sApVIOStQqMRb
	 KFGkX8wmYMcophHTE6lXGN2JSX1wF3WkhltCt7YG8zQr1xjyVz903mWoZUBWobtvOmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836464;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ozQMldu3aYfjyln1LmjpkD9qtr/aMoVVdo4TlXw1p3c=;
	b=QWyXNQ0O1WhTV8F7x/ERYveS9HkhT79Tdw9o00uJ4EseWLaGGf1sWCfqLzajEBGK5psl
	 Vp/DVlwOR4kUcPwUczmmHQWQGbpLkVwiN4ktJXfMR/8ZRLEmg5ckLVav2kkmr/CKH/vzw
	 KDoJgw+2BXGEJw0m9H9xDEfbXS0tiOpdEEQsHtgupM4bwtKZ1hAKp1XdMV+SNpeGmcNtk
	 YdYYm+mf2smaTPDbSaa4OCLxZtyVOjK9QbD6SeRQqDxhCLjTYLQL9lkcIAwJWtaqPotlL
	 gvtNMJ5JotG4/q6I4Exml7bnW7BW2MPPFQ6buacD6UNLk93t9j59cqsRU/ATcGZLgyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZVz1wM+/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52780606A328
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVz1wM+/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D061F000C1;
	Wed,  4 Nov 2026 23:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836463;
	bh=ozQMldu3aYfjyln1LmjpkD9qtr/aMoVVdo4TlXw1p3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVz1wM+/LhNnI78F3QZo/lKFi8KX38S8HkSr+ht+1p4T/PskgaQmkF1TIC3MgKkWC
	 shgjbu1zkQjHPPNCix7AP5ryC1dgSsD/TFC40s88qLo49zxcbXdDt7dVbuj7z6o0P1
	 j24gmr6yRl2pLMLC50Hv802Im2iVfQkmFAlDn4PgWeMcDp2tQuUbRStR7TYJRitX+Y
	 yfEKxp9kzGdLtHWt2tvK0ToJreMzhce/6L9RYmMBV/Z6TUS48rPR+m/2yjdghCXUWc
	 yQgeir0HE2ZendcpXg9/x/TUayX5Oxvzg+gngnS+BX8pIEl0jcBUj0xI+RO9MDWoLx
	 OfCAeL4w9GESw==
Message-ID: <sashiko-outbox-198316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/9] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-2-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-2-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:54:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> This reverts commit c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator
> setup with devm_regulator_get_enable_optional()"), which nicely cleaned
> up the code.
>=20
> The vpcie3v3 regulator handle is needed to disable the regulator during
> system suspend (to be added in its own patch).
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D2

