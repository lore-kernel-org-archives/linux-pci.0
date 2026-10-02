Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B823747533D
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940191; cv=none; b=i/YD3oU7SZg+Tt62sHBEw7W11a+LYSwvtVMUtw+0Pvib4N5JxHmh4vmfDsaHcVSjAnSd0m1CTVW3baUgS19RhpddXFbuj7PszR3ZExzynbA9onov8sojmFfnb5DXtqjaImZDyVfUhaIfVSmkQky/RUdK2saet3geUStSB9a4o7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940191; c=relaxed/simple;
	bh=/uZ3Rny5M0CF4qoNTjYR4HXW00l2P8pyFuygvP2A9Mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dtidXLDfN26445duckJWYH27+ly81MkuBwRMEykJw7TkXqOCO1gjGU/+7YRpDZ9D5DO/E/MOZKbODxEfU0x++/4ld/RTp1+uGH04oCXQxSdROmt1fOHfqZnUJjONcoyvHpD5VLMFs1DTAmqoQj791TEGhCzd+HwwlpaEQzKWVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFMnD86c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFMnD86c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724CA1F00893;
	Fri,  2 Oct 2026 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940190;
	bh=/uZ3Rny5M0CF4qoNTjYR4HXW00l2P8pyFuygvP2A9Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFMnD86c/5XU9elR9m9iVUWs3WF82KG/ELCXsPNrlJbA52FgfnSVwGAK0CEBMXaz0
	 AU/Ht62TxwC7M+s15c9mHYPvLmhWAxd3dgl1vhiVhKtb/jtG6FqxGGNnXiDUfnx7gm
	 fn9qCM0/65l8jK3wac/Bu7gG/a9/sxl0GK+69WMYAL99KV4OePlAESPIX7O2duKDGB
	 PgM2TTnnKvo8zjQLJ3vDglFUG0dPFWvB9IdPDbRR6nU0cExLLGytL3FokmcJIIuIFm
	 FsyhWoOJlEcmYaphcpgr931v3QPIx7RpCvxO591BYeG5wOs3dyvkE6gyXourAYgfCo
	 BQ3Q55Lfuz0kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] PCI: rzg3s-host: Follow hardware manual
 clock/reset initialization order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261002110935.2004349-2-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-2-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:23:09 +0000
Message-Id: <20261002112310.724CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The RZ/G3S PCIe hardware manual specifies that the clocks must be enabled
> before the reset signals are deasserted during initialization.
>=20
> Follow this sequence in the probe(), suspend(), and resume() paths to
> match the hardware requirements and avoid potential issues.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D1

