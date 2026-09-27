Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150841DEDA
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533583; cv=none; b=Y6o0B0qF42jrh723w3X353Iwqz9dHqOE9d5HfnCP8dm4MfPwpH1aD7/bic/qhkIK3UG3KeACRlV6KVAY0Pn/abAnaHfVcaIXb9We9Mwx3INwz66F3jEg4jeY/cf77ZQl9USW9wt4YjPIoZzeKw/K/px6AAwIj09uL5lvV0NH8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533583; c=relaxed/simple;
	bh=zYK4gVfp1/s2a8eVtD6a/RiYkjdRfD1Smmz5m7zuX5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oVUcCH9QRSO60xjySq3W5MK4ifOaLOsMOFI8b+qPDyJn9ivUODXJaxI1J0UPblyvm7JAf+UwYSt3teFQs5pWPPJPoOzGIJhNPh2Nel2Ce5aUEEQQOWDGyuqhrlJJgDRV87PoSA2hD77TryZyk2mUQI8hgj82Hgx/4qiswcvrs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0YH2fjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0YH2fjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79B51F000FF;
	Sun, 27 Sep 2026 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533581;
	bh=A/EeBbnXEiueAF1wnfFQovDP1x6Hv/94v9j/3X2YL68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0YH2fjJimfCYPgwkd0P/Qj8l8PyOvdXag1WWQz59pX5O1rtcgGFG5sz8kzj1Oc1V
	 oktsO57ZrAbwYbY2i/qbc4rU3NApLmXXvc+Ic609fOxBAu+OkEWGudD+jDaXtDnIn6
	 6Wsz9uMxe15eILPotG+oQBWeuS9/hlTpYosdVSA2sGhsE1gg4Wfs3q7swxk66PBPrQ
	 SHItGU/tJIik4zx02uqqI91Y1AmqJC9r6lmbeDdFjbcz+AK4CoO32m1mxhDKB1Wwqx
	 3/IAYWHtenzFuyEZLTJ9x1lnJxOBI6LHtHaxkhVCjyqUSQ6Pwaln+QQvSIxc4NW+kX
	 er5ey3oSp5jaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:26:21 +0000
Message-Id: <20260927182621.B79B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().
>=20
> The call is superfluous because the function is only called from:
>=20
>   aer_probe()
>     cxl_rch_enable_rcec()
>       handles_cxl_errors()
>=20
> ...and aer_probe() is only invoked if an AER port service was instantiated
> in get_port_device_capability(), which is conditional on:
>=20
>   (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC) &&
>   pci_aer_available() &&
>   dev->aer_cap && (pcie_ports_native || host->native_aer))
>=20
> ...and the last line of those conditions is equivalent to
> pcie_aer_is_native().
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790531238.gi=
t.lukas@wunner.de?part=3D4

