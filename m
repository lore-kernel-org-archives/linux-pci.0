Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F83E7630
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366015; cv=none; b=mRKhXwfojiHk5ozwg0/3bT2Q5Ff6aRlQrGP9ssOzyo16dQ6vg+L3+s4ee4mLHOOKmKjhgtecQf8/tgOylHc9+P6TU0MOUbkN3nr83Vn1NDQpoJlSsh/hoRInIt2//6wDcCqUK+pT3/reUBFXki1z8mshinn+DJ7ZlxXlIaVhXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366015; c=relaxed/simple;
	bh=fWkWAqajJtchAXqZdrqzYk/Qgw5khjQOKxpw1tlqe0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RUkWB8C2L4ynq09zFnAOaeYL73pSmIrUuNybi2qbyLAwIonyzsnpnbMwtwabxQMSq76PslhxJwV5QZuasu7CpjYI3t1klg5QPEDUgBsMbYRDpYWZJS5PXoJ9zDWNLhVZcnnTxBhWeXnvERdx0AdmFa4TV3u/gaAbyy7GMmYH4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhM6xb4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhM6xb4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEF01F000E9;
	Mon, 10 Aug 2026 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366014;
	bh=fWkWAqajJtchAXqZdrqzYk/Qgw5khjQOKxpw1tlqe0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XhM6xb4s9C6Lp1S95qxc1Of9r15sRlPdwb+0AhsBBlbaJaBZ0wuD1SG6b8FuQPCOv
	 kez7glLjRzd8VPN3kQyPMnC90GY6/zez7WRY+l1k6pyYpQmrI9u1tglkcDfjEPm7l2
	 03pTYkdTVuhejktn/VjGO3+jVsA6/p8NQUeemySOmYhTUDPBVaycLpYFR52Qxc/1oY
	 gq0WWuf40ewZTLCDEugpA9ypOgHrVxJ00qqk5FXj5PWNsuAA+9fGLbqxdeES6UiBNr
	 c5DIRLRGxckUiW+uUEPYSIGkGEGqtDb8m7cv+0VwIC75wEQVabJIgmREn/Nt5RR2H6
	 VlwYjyznXTZOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] PCI: Add missing headers transitively included
 by <linux/phy/phy.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260810124315.433448-3-vladimir.oltean@nxp.com>
References: <20260810124315.433448-1-vladimir.oltean@nxp.com>
 <20260810124315.433448-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:46:53 +0000
Message-Id: <20260810124654.4DEF01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The tegra as well as a few dwc PCI controller drivers uses PM runtime
> operations without including the required <linux/pm_runtime.h> header.
>=20
> Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
> controllers use the regulator consumer API without including
> <linux/regulator/consumer.h>.
>=20
> pcie-spacemit-k1.c uses of_get_next_available_child() and of_node_put()
> without including <linux/of.h>.
>=20
> It seems these function prototypes were indirectly provided by
> <linux/phy/phy.h>, mostly by mistake (none of the functions it exports
> need it).
>=20
> Before the PHY header can drop the unnecessary includes, make sure the
> PCI controller drivers include what they use.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124315.4334=
48-1-vladimir.oltean@nxp.com?part=3D2

