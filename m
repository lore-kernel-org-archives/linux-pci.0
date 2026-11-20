Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183161;
	b=FXWlw/igyFMp+KEEppu0pqLgHIE05qW06j1bfPiKQmZGIJd6wTrW3wpD6WTMLwDVh5U8
	 QMp+8xiUAuf4W2mcoLm+5j5yZDpmp+wJfoA1+2PKDnpMU5CIcwlEWm6AfwTQDlie3NTJV
	 4z6zpnR6qK7/2QcHyDARBzTwo+2myKbhTQmLTMZ5S1b5bCZG4Ja6mdl1WaGD507pduMWp
	 P+abGMRnehnK2kNH/VtLt0rkNoVz9kuL6zR1Lk2/nAaL8x1qoD23/lrl7x95mfVhxZq5W
	 2EbYr6y7W1LaqolS5WMIFQDK98Iq8aA+udBI6159yLfw9cfc6tQSYqUS0lS+KdjFc/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OIOOQBRX33qUs+gvYhkDk3XhXlIOvbhOoMcjG+TOpkc=;
	b=fRF3eh5hqmbio+3dThuoIRGvX0Ta+xXfDu+UH/NlIylg1xmZv1+e5NimGlUKt3x2vgPo
	 wUueZS45qtOA7f8Dgl8VRimdE92tpGw67YEsZ4uVLbr6yh22dBF9/VQZcw8LZcFcSHZ9U
	 YTd2fFbPFoLye0nu9FgaXlNGAXO6VT7o9xI4TIjNCUb2pYzgxy7ffADeQB3zHDwxcwrY0
	 1+/Rw9GgAgC1nfE+6OT0OqjSqpvl4VOL+3MZzvsdRIs+/dvSJxtMukO99Xx0bPq5LUdxg
	 9UW4m6c9PjWnL6aQVWBBF/prAFCxlU3X8MgwrByklZ6sig3KJAYDkK5V0Pw7BOXqSGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIE1J5nP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EEF606A331
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIE1J5nP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EC61F000D2;
	Fri, 20 Nov 2026 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795183161;
	bh=OIOOQBRX33qUs+gvYhkDk3XhXlIOvbhOoMcjG+TOpkc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gIE1J5nPQj2bd62YfMwb+VIcCtBMpANGo15h1kDa7GlXBTu1XI4Ms5PXp41EABNLA
	 oa4e7KqLAWep7XjHYNw3RjbtMm6EhRIpctYLLhaXZslqCAPWU3KBitzp8AQp2sGZ9c
	 gmVZYEoQeFyXQxyyJudmldiHPyKRpyC636gLsNAVR6FN9ck3cg8HWmz8nngHReMPNg
	 UHl3r5aBKNXeRqCaUK2kBbyzBUv8uQ85BrZmjpCqsqoLjQkuCNp2fNbBOKi6+CDQ2i
	 PZuAoIpP5mKCrGQFnL93JRkzlIC0+oLhiPqEikuZu3QyX+00yMpCDW/pzoG435otUY
	 Nb325sHLUT3dA==
Message-ID: <sashiko-outbox-225310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/16] parisc/PCI: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-13-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:59:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Dino PCI bus driver assigns resources using
> pci_bus_assign_resources(). That function makes bridge window sizing
> disjoint from the assignment phase and is going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be a no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D12

