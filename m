Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468108;
	b=HNFSuogqtx+3fBoX2S0zRI88rgMsJMlmAuVg799edAsjaclgIZmxH4an6Q69ot4m3Ulp
	 hyVP6O6bYRxN8CR0azlJXKNtoyHiqZ+ZYKKvPCD6ljrgIwCt54rTAJWlNv/HaMtR0tvOE
	 4felhCDFme2rSSmWkn9l1hJrY+KGWJq/4/2ZtUNrEc27I/6CQ4yCWmNOL6yvZvZ02HQXj
	 TT6+Dmq8iwbz0r7z+EBBKgZLReWP6kbBgubAethwkvE9+TA6VftSEvYHomUsvqjJZdtyA
	 UWTlBD8gCc7Yx3N7QcJ0wp87u0RuWq0KPxt02nAnevCKSS2bYu8KSAO5cJxBzzI9EOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468108;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q3qyb8WUYvmAmmpfmWMghvfYNdQtRy0dRBo+qCvKSrc=;
	b=2CJfzH94ZrJwxXJ8G6bJfERud+AjO42vx8PQT8BKMTleeBCufJBo8ep0R86aefcZJ4O2
	 YeLVKSQRLQTeczF8ZHe2k5zfdcmSSElrpyD7b7ZPul4uwv+MeMh87z0BGVplIy7hZLBSW
	 nk/8JylCrasw/ecLAKGk59+F3aDsD/egDiwwDLLP/NHBOioM4WAkXPDXQae7Qjiwq5w3d
	 Agp81YKoUTeQNqIE2gE2dQDfmjNQX7SIoQxoXf3rx9kzVC18cjOv1zYLi/uZ7uAguGhQz
	 YCD4b4Re3K7KSAI5Oth8lcRigEgXlhILkEwSpQrHzLgXfjX595HSbEtffXu86deGVHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHi4Lzfn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B2606A333
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHi4Lzfn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0F21F00A06;
	Thu, 12 Nov 2026 07:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794468108;
	bh=q3qyb8WUYvmAmmpfmWMghvfYNdQtRy0dRBo+qCvKSrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bHi4LzfnsVZJPCfrXXmX+dwS1aB7N7nsQfSK16XQ6fucW4Hvg1EI2+P6cDSTl1Vj1
	 7Dtq07OBAkdzPdq+NzbxGbzefxT1OTP4WhwqvLGxGZ2jonMNzLvhFV4etlmUfmFblN
	 PyWYfd+F9GrPZJedJyXiBO5Tc/JQVIDNuFLrwjEevBdAze3jpVGSIwbWxjSksN46l/
	 d/TmV/f/bV/BLpYCCGJ1tsb1hlFtRcGE7Grskawqxh959HvBwWC1mJ+fAUVVebUs3U
	 vcRpJhT4uEutrxbZFD7AM2AjNaBCdvM25zU7s+/en+zWPsluZ1XqbtjikE2cWPXPNr
	 91vybhhSXnTAQ==
Message-ID: <sashiko-outbox-210592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: cpqhp: Release the device reference on config read
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112071718.154545-1-zhujun2@cmss.chinamobile.com>
References: <20261112071718.154545-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:21:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> cpqhp_save_config() obtains a PCI device reference before saving its
> configuration space. If a configuration read fails, the function
> returns before reaching the matching pci_dev_put().
>=20
> Drop the lookup reference on that error path as well as on success.
>=20
> Fixes: 12a9da0fcb14 ("PCI Hotplug: cpqphp: don't use pci_find_slot()")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112071718.1545=
45-1-zhujun2@cmss.chinamobile.com?part=3D1

