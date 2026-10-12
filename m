Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116B34F24E;
	Mon, 12 Oct 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816178; cv=none; b=c4MskNz7Y5LtAcLAv4maWkjU9N6sheMBplfsBKEGRQllTFWlq08Jw1NO+j49vvxYkRuUCStwG2fAptn/uGN+eUUsgEoubuT1T6ma+GAV0XKBAydiKjOvAryryxiz41jUfoUqyYDStDQQf6S/WWTiEuhUqpIfSwiob33Jqlq0Teo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816178; c=relaxed/simple;
	bh=uIw2/nYIL5h9gV0BUNh6m/qmH++OLFfRQZypSauPEnk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TF+4QbonWvJ5Ly+vgptNzf7GnxMh+XYtYd+Mvz2Fz8P8lxuXJG+1ee1upA9qf2kCeh1+/sRG8vVYVPfoeAObN0AQ9+bFBEdXpW2sUgDUlVWl3+J4dDa9BHSk3B8c5bxwCnrcgXBWuVgqIhH9G8MAlauGLU3fg8yMfb9gapdFaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8+NE61s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8+NE61s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505091F0089C;
	Mon, 12 Oct 2026 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816177;
	bh=tfQui7MmNdg7F1M89hDAOxepZhPPNEMrebr8WuEPalI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8+NE61spG14BMJEcp2Fzyiptd/gfKHey7E0JYG3VYqrgpHzLSIDuPhI9sIpkCwFk
	 ssaETYa9Lyitjre1Gy5rBxmmRvuc7vs+URiL/gdupt1I09hfvdhKN/B00sGwxRGVGS
	 gmwb7ufebTL+oP9Gp6/xUPdPNt/+4Odge/2OZ9MMb7fs8ITLWYkzDCagsUChKcjIi+
	 m4hlv91yJsm5AMPL2Ps/f2yGwmYrKRCrU67GIJ8+V+Cj3m93DT0KDCIGnW9zpg4TXt
	 g/AhPhXrA+JOnCA4ACcolSLJQsplUNNTYqkPAIPfYGHQB+0pLS3NNxITEXP9Bk6SrG
	 sl92gsNJCoWgw==
Message-ID: <sashiko-outbox-168278@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/10] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261012142826.159178-10-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-10-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:42:56 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the instantiation of devices described by a device-tree overlay
> applied on a PCI device, devlink displays the following kind of debug
> messages instead of creating the expected links:
>    'Not linking xxxx - might never become dev'
>=20
> Without those expected links, the device removal order cannot be
> correct.
>=20
> Those debug traces are printed by fw_devlink_create_devlink(). In our
> use case, they are all printed because the supplier of the link has at
> least one of its ancestor with its fwnode flag FWNODE_FLAG_INITIALIZED
> set.
>=20
> The culprit ancestor is the PCI root bridge.
>=20
> [ ... ]
> are correctly created.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D9

