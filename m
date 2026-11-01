Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517174;
	b=dkokFbEoCvekxnXYgs6PZLGy+EySC+7pJBttkICEKd5xgYlMJZDdha0PetC5IhG8B8ED
	 iaJNU4mmsEnS6oF6FqEmqsFj8Q9QX+ZmaUnK9E0gO+wGm3z8cuk2odHXqGwWjetGA687X
	 OKBmjzjkaGV2qWB0PrcaVwN11df8aJ+gE9i8TKCcaNUbYbPvEBQiDfyYfgCSRKOBGvutm
	 f7XXmntoM+YPjhNjqrGEbjVBoiytBza/gOhZtRxMaAXnk54QtOXDfzMB9vbOMcqey88mT
	 voiumdOERL9/ptZ2NCy3RlDr1+Z12JzVFNsMlH+8UkNiLCr8dFWWKdmjU5Xcc520PCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zpo7qeiNSExYHaMW1rsjxbkWAretaUHZWc8ch0QvYJo=;
	b=M17ZZutNyRZhmFrp3A/I4C9XVv5FbWwUxmeR8Id586dS+nFGA71Czw7gQtlbCAgED6zZ
	 l9gYJyrecbgReou/eaYxVRPHS1l/yqVeY2+ZBbSIa6v8+gJghgmGmhjQaq+BECRfu8Hsa
	 zvHBPYcoDjgMoJn4cN/xORyqYMNXJ3+0HvfJzgSiF/xJ5GsnlBCuB+gPDtS2VSEcgUdJd
	 49aH2YGShYAVNo0w2yyrGTXR9EBi1flxfReymMGlaY6bNSafBo3LqO7J+a/jHFlnKAaex
	 yxTioUL8Bhy5C6iSBek/s+3Sw8GiZLsOG1Rg+nBmLZyTvplw6IDtp5Jqm3xF/IJl7Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2uTnmiP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B63606A324
	for <linux-pci@vger.kernel.org>; Sun,  1 Nov 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2uTnmiP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A01F000C1;
	Sun,  1 Nov 2026 07:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793517174;
	bh=zpo7qeiNSExYHaMW1rsjxbkWAretaUHZWc8ch0QvYJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d2uTnmiPbIqMXwzxknQPt7ENLd0MB4tZ/MljE0DHVb5yCmV/0KV2QkmW5A65u/23s
	 ywRDmjgu4qFDXfdljxEIyJUr2Y65uGnfODzU+DwZV/OvKi9E8uHejUWCBX4RL9lRqV
	 goZcnnji4jP5XzgiPcLQCsMx9q8IxjbfleTnR46I+50DG2OSjjOFjMbeZExFaH0azG
	 W+hVXGpw/YtMz21sxtjtOWRABrASlzMkq7gm6XJu2xCOOW6ELCPpMc27SREC+b2+DR
	 uZBqmhXvXgMif2fAhJP9q4ej2C0o23+v/nPR/OFiLuKeA99atADH2VJw1hGeJqIIdK
	 Y98vzMjNKYC0g==
Message-ID: <sashiko-outbox-192300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mt7621: Fix reset control leak on PHY
 initialization failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261101070121.2714-1-sreekuttan2156239@gmail.com>
References: <20261101070121.2714-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 07:12:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCIe port initialization code acquires a reset control handle using
> of_reset_control_get_exclusive(). However, when PHY initialization or
> power-on fails, the port is removed from the PCIe port list without
> releasing the acquired reset control handle.
>=20
> Since the reset control cleanup iterates over the remaining ports in
> the list, the removed port's reset control handle is never released.
>=20
> Call reset_control_put() before removing the failed port from the list
> to ensure that the reset control resource is properly released.
>=20
> Fixes a resource leak on PCIe PHY initialization failure.
>=20
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101070121.2714=
-1-sreekuttan2156239@gmail.com?part=3D1

