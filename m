Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F92F7EE4;
	Fri, 17 Jul 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308108; cv=none; b=VhLmZPL2xSGQ02omC15IrKJpRiJF5986dr7YIXHVS6uhBor6XM/Ye3hfsBGThZcHYOkhyTDzwdw9Kx1R3c/fLiYOZ/PCjDIXfWZYTQsR/8sexv4HAqeXeSOUWgz8OogEkEKQqO6C/kN6FqfRPJovsSf1JiWO2y6Wr5TjOxla2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308108; c=relaxed/simple;
	bh=LWTa0N9zI+WlpfHp5wwjE4sSSTbeeWltjSywixwG+eE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e22Bm0j1H0vcyfR6q5I80re6dXdNy7KQBl8Gh0IV7K53Z77i7TteKjSKGUpoveJX2USSHsKu7mceXFMkrDFgjedXkEzsVTCKHx7UdBvyucSdeDyT8lxu/jXV3PVlhwwEtk5EHTo0eiQzFBycMg8M7Sm5lbGPt5t+TU880EEgbco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT3mFXlA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT3mFXlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02361F000E9;
	Fri, 17 Jul 2026 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784308106;
	bh=pNLGrFix6W248z666S+Ykq+P+PkJT+5J5ewxlxte0Tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QT3mFXlARDGeE5fJR0O7/YcYRL4XUYDTY4JfE5qW78UTR8YazDmW7eNCC107QLzec
	 dwPrMw3S6Kyb5LgT+7K2goIYM4rZgf+fBl4LDX043Q0t4jpFQbkQNeOEdKksBtJScM
	 HtmAz40JVBHpraJXOf6HbVL6xZz9PYn/PUf3wQ+5bIvtLr+J2gqa13E+xDbkUynFbZ
	 oOKuqUJK3sNMAHTE+L91RMQUIM1m0WTeME8qmhBgara/gOKRkgETpMU9ho9/bRwtgh
	 GxMEENAZlH3BH2SHFkXvpCuaxS2jvODSRqQtqD+P/rL66cmZs3FtJM7fGTrnZq0kor
	 SypXjrZ+vV4jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/10] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717145147.823749-10-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-10-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:08:26 +0000
Message-Id: <20260717170826.B02361F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D9

