Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836383;
	b=U64DCAVZMzU4KUpOayQ2q2dXKGKDuafeBU9oIl+35X/5sncnm3CiwREHi7fm8QyLmipS
	 EkwHkDikq7VczbQ/OAtBGitQTwRYNV5VxWLVJo54SHgw6Zaa4xT857eI6RzSZf3xoqIWF
	 SSaAb6WS9zwNhXYfoj2FwfiyRKKwsXcLw5gybLnz+ZVX6ENNaXKa02m7P0ExQvplC/cO7
	 NUfwehjyXxUkBwiTKAJUwQ0hcjdp1kdt4GNgbFFW4JUwJ1bjJlu/f7iMrTJUmA7ODpYtW
	 Xbt23TSFVALH12ikZ6+WzJwqR8r0RsGYtHhwZKdNkuuwtK1HJbkKQoqnCGfmrXDuA4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5J0cgVg55nHbSg76nIBx6z7M9LtcILKPiN/ACUZgQn0=;
	b=sJLrlG0wZHP4iDDPdJCJnxxirFrv+gzdSqqXXrsHnG6p1QD9oshl5JykaBKeL4CV+hdX
	 wqhK6KczG7aGuQq/s8aT0joALMSEQGLRU35YLUkPAXJ3hiAexD0nRuL6WxNq/nG55cpym
	 LZ65KaWLxcEZFV88yKN+m+C/oaUcJg+TcmPg4ZiDxBCt0fFWlnq448hY1LnvxdUrynZcN
	 dXIy+CueLTIFjVNDTqAF981s9laDciNK+hsvYIhW7k6l3I25/ujdXDcKkSm17/RpkTPq4
	 31/Wobt4PZppN7VRhMY+ITfA7+XHg6HRXAdqPs9DL/4WzS0lw9Va+Lfu3RLjGFbrlHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw3mT24P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FB0606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw3mT24P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1284F1F000C1;
	Wed,  4 Nov 2026 23:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836383;
	bh=5J0cgVg55nHbSg76nIBx6z7M9LtcILKPiN/ACUZgQn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cw3mT24PUfdvmadHDNXHv0PR8buiHAQ1La4DrFq+QYJXAq3H6qHyqXnnIDP27AyV/
	 N/+o6vwXcUJuoj5nzCHpO9pRjF81vOSrlFW7xnKAcTl2GlxfXQTJYrWboSiI+LxyKz
	 Fw1duBo3a3rmir1WWsT08Ft1pz6G58JG8yTOoi5jt1k0nUd1bHrKAVyoaoAa7m9zSw
	 9p4rLCe1p5pYCM/DeMB17w6nb3UQuKtoVeJrJSF9+DmNt5nWr1fSo4//ohsUwomtxE
	 +qJJtJw+O5140yrUUAAHGRC/987cCJ7+r79WhvdF2sPUGgBDlza7yueu7Yz/SMTuaL
	 cHnP0XLhYrcDQ==
Message-ID: <sashiko-outbox-198315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/9] PCI: dw-rockchip: Fix LTSSM set functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-1-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-1-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:53:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Before the Rockchip PCIe driver has been switched over to the
> FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
> PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc =3D 0b1100,
> which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
> with bit 3 being handled by a separate define named
> PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
> of this new macros resulting in the third bit not being set.
>=20
> Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro")
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D1

