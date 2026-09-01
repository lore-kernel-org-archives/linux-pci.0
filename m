Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407C3515CE
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252012; cv=none; b=ZFJvDcjdQf7ZfC9OiSeoGEXMbXArieZmUWo8H8InO4FQABUBTyF8NFtOXYuNQTigH+6TVUboegDqtTVXEzFXnfH13jOjqo8J8vgTwFhE5uO4TvDSbZU1ZCl2aCQMo7G110r+b0I5TTuqfZRlKoe7NnSD/bPBGwA1pkBwXsH8io0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252012; c=relaxed/simple;
	bh=k98153yVIIH00Ut3lrtGXoKaFZqzWtasfrnA3DhapRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pCPxYLd/b/XQYx8SXi5eDIxVT2p29kssXyQpZi0ydvDa+ZPPwTkR7bSTQ+uPDpcyp3QzrglvVw8xH07MlIpvbyWUC2hInqfhhI2XVATAEv1kHEzd10Gtgcktge0wknFz4MqY9ctaVW8zMKVgP/jTzsYIPFVK366EK5M/YvqXtcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpBULAi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpBULAi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD9B1F000E9;
	Tue,  1 Sep 2026 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252011;
	bh=k98153yVIIH00Ut3lrtGXoKaFZqzWtasfrnA3DhapRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NpBULAi/DLuNCVkW+ikcZDDjR3rDO7CL2PZbCCGQkfh5IYzA1z+/HGG0vlLqsSyQ0
	 NGr3YstNDPkOHvg4oUCuSnG2D+M4tBdvSNrv8NAkwKlzbpnenePzDyvl7ITU3KwV3k
	 ljQCkvt2cPo+faEcFyea2+InN6HZILi0pt+HoWyc1hjFg0zy6XK18Jy6hnQnT2+fmd
	 gOpTmK/XEq5hy5/gTzND3hQSIbP36YPwXZ3TDWSy0+AjjFmFqOho07iaYiJuTmzlP8
	 bjXOtS+SbyS86NYlKqUR6OwSxisSbtdjERxQQuFS5N8zk0TSQQB4xYf2V5/6e8Acp5
	 zZyvfWpNsrueg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Zhaoxin host bridges to whitelist
Reply-To: sashiko-reviews@lists.linux.dev
To: LeoLiu-oc <leoliu-oc@zhaoxin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260901083653.48890-1-leoliu-oc@zhaoxin.com>
References: <20260901083653.48890-1-leoliu-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:40:10 +0000
Message-Id: <20260901084010.CAD9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Zhaoxin host bridges support peer-to-peer DMA. Add their device IDs
> (0x1003, 0x1005-0x1008) to the whitelist so that p2pdma works on these
> platforms.
>=20
> The entries cover the KX-6000, KH-40000, KX-6000G, KX-7000 and KH-50000
> families.
>=20
> The KX-6000/KH-40000/KX-6000G/KX-7000 entries are marked
> REQ_SAME_HOST_BRIDGE because P2P requests crossing different host bridges
> are not supported on these parts. The KH-50000 entry is whitelisted
> without this restriction.
>=20
> Signed-off-by: LeoLiu-oc <leoliu-oc@zhaoxin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901083653.4889=
0-1-leoliu-oc@zhaoxin.com?part=3D1

