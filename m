Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889559;
	b=twLVCX5B8RyETpFfcyIfgWsql/mWkRSHwYCeXivKDRRbmtdKufsxVzYV07r3Nt7EucGE
	 MKL9prGouzI3AP70ulVoEYnnjbG2ZaS4acdraDsDr4qGohOzKUzah9hDBX68ifo6x57jV
	 vZ6njjwY2o7EQ4N/xZyc78+3aIU47o/yYNYfeoK1j9RTBO5ZNj58dM7WOLhXtFDhlLost
	 MN83iL5549PmsvfLAHfd1pQtC9DDfN+73il6EX7DL3ig3ifvr2xKecwukaNcumhfH2QZB
	 MYkBLNduxrV5pZdjYUyvJcGVWdQvTfOEyfm68AuWtyEAhzXNfgxaAwV9d/jWCvG693A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pMFbACmqlHeDLBxOxnLs25pj/TfUX4D95QeCQ9DXK24=;
	b=0rrzLVUqDaBHaObrHE8p4VpsS15PQgD10a/nP4laBO9l1uIjPaxNJZXsVUAP8hbDWZpo
	 zNlzoHNWzSYbm3OKKAE/NuKEINrpah7VaHVCqCeu0DDLoA8pM/WQuy17Vo7v3kgn4ZUIa
	 3ClfLEYj9KRRmMebM9a0iGUz9UrW1RMsz30/m/4Dguvdfm4ZDDtsMHeR0V2KtwFRB+Rt9
	 ERHBIsKIznq1f4hPiHlMxwpF8LedwdSnYeXv9N5YLnnOP9SsT/aHsVI8yOz0Eudw6CYtO
	 Q4gdQbZ+9I0E2u3s1WpI7TCktdyyxneSsoZGCAXoDNAR0xDP1MXxeg4XNy/D4biF54A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6IMqDqJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946B606A31D
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6IMqDqJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBB51F01828;
	Sun, 25 Oct 2026 00:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889558;
	bh=pMFbACmqlHeDLBxOxnLs25pj/TfUX4D95QeCQ9DXK24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O6IMqDqJuEfWg9zKJoHaQ+3nkNqLoQQSDqG8T+1Ma53aRpctulicAo1AmE3BQqAVv
	 HjZ9M6q1rbO4QJaOMeQDCAAYJlYT50eAbaDz89/fNKPNed9sqvR2wyj0CN11n7lvNv
	 koZHecr2WtGvxo7OWN2VKvb7gD/y3Xjlerhe6T2a6nlMkIK1RBo2PorswazAsURRST
	 1f7c6xsLso/4fZpe+xeYscz7h69WnZNcBOu+Srn16+Wa+2VNALWmXbstQurbA20d/A
	 E6w13V4DoAwE+siLC84VlhwXvVnknO61448yhodiMXAbyxmLsfzNyd4Q4ng8TGpIrX
	 98X2H4HUq1OQA==
Message-ID: <sashiko-outbox-183959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] PCI/sysfs: Use user config accessors for bus number
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261025000836.58294-3-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-3-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:52:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> secondary_bus_number and subordinate_bus_number read config space with
> pci_read_config_byte(). The kernel config accessors don't check
> block_cfg_access, so a read that races with a reset goes to the device
> mid-reset and can fail or return a bogus bus number.
>=20
> Use pci_user_read_config_byte() instead, as the "config" attribute does,
> so the read waits for any pci_cfg_access_lock() holder (e.g.
> pci_reset_function()) to finish.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025000836.5829=
4-1-thepacketgeek@gmail.com?part=3D2

