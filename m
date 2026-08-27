Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B594078E3
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824012; cv=none; b=qus2rD0lzCF/48D0J8eP0nE0Rs+qeDeG+YWwNXyFtirppqUZZE5hEoFGVefBJ8eHOgWQk0WAry6cFelDst68e4bY9roCROgNljWKrUeelo4FrenOqR1Jx4ypbiaOjgQxom+IfZypfRdCdUp8rhIhm0yJrNAsYyzGfiwzd4aqjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824012; c=relaxed/simple;
	bh=TCgenlfXxDKOUO8IL0QSKjCL7DrJZrNTmQ9ZKplxjNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OJqtjzhUXoMcONyp38GuTggxQSnDa+9lTFNi8DsRmJUW4mxmG7puqF6YMXBG5b/bYlWSZ5LmScAIFIw/soj4zhrJC4l4Sey9AKNXXukzXPFopYMDU53gVpQjvBFtQ83Bpr4H71W//p5zHQDz0twJLawnEu5o2/OFw0TdZK2yFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIvwAXX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIvwAXX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678761F000E9;
	Thu, 27 Aug 2026 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787824008;
	bh=cxCVSAFJ7EEH9/yhtlWKsFAR++BD/G94xAGqTPxEVcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SIvwAXX2shng9y9lN6Eb7bEJ0g/g3U7POnxTdUyqdA2RgmXL63krJKCyrWPcMLlOf
	 cYf0mIopf1RcCiSmX/lmvmT0yRPfSQGB+0idnzjL0Z3Z0bRLZH06REkerX38wk2LNM
	 Ee/aSBigoWlDbkH6c4klsSAYkCvQ36KTd97B0GubKscafN+cYdAdA8/uitwYyMtA7K
	 otmbhu/Abbpav7yqWp+LflOyqlCrfRf3ix3U0fYFIbUg14U57SkMrq5xX5wel8d/z1
	 oFCPrdriT4AS0Tlj62te51hH5lm96cEBVWeAkI2R8mpYSjyi5/kiUdcWTf2ViUlQTa
	 2sfO3S2pyN27Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260827093919.2825467-1-lilinmao@kylinos.cn>
References: <20260827093919.2825467-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 09:46:48 +0000
Message-Id: <20260827094648.678761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCI Express Link Capabilities and Link Status registers are at offsets
> 0x0c and 0x12 from the capability header, respectively.  Since the driver
> uses 0x5a for Link Status, Link Capabilities starts at 0x54, not 0x56.
>=20
> Reading a 16-bit value at 0x56 returns the upper half of the Link
> Capabilities register.  When a hotplug-capable port has no link during
> probe, tegra264_pcie_icc_set() consequently derives the maximum speed and
> width from unrelated bits and requests the wrong interconnect bandwidth.
>=20
> Use the correct Link Capabilities offset.
>=20
> Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827093919.2825=
467-1-lilinmao@kylinos.cn?part=3D1

