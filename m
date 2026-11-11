Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425897;
	b=B96nFDkvivOejubOdLgkWCJ7xK3kzPwOmQpxsUrZ/WTUSDwnkrS/IcnxkOJoOAk33qOo
	 k70FzTf9lVINyOcE829q8h4FOsI1Y462wRfEjE0xaVpUY/NtkkU0xgUbTC48hgNF+oY81
	 QUVMBVVsy4Oe6ABIZiHPU55kA7Xbo6d8Wu9r24GF0hJK2HXTKriwOubWnsKb5ETt8cRCg
	 hMufFClouS/2MhvU63bVaY9ZHaHM+5KlAN+l4DyB6Flki3/+H0q/dIAXLSNJXmQh67uHX
	 5N8nXnf+IFP8NWjXnYVgmkeW5TM0uUPXUeKUMuTzcBjcERjTbdPxqi5ehAC6XwmdjuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425897;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mDXg5TEQgN0wpY1CEsh+sUw1JNR0/e3Uh5Dl6UUauNM=;
	b=q/Jz8VnfzRRzWEg7KB98K6uBKQyDI5Gc7xuy8quwVG/837xDQPd08mqny3mRydyrdUm4
	 X7CyU816ZApAxL4QOH+gUHuv93U29QmgWA2rvRsoeQYm8XIB50Mi9BgnAYg/w35wG89No
	 Vp+ssuBbu3yNQhFNhk43cHK/bzuTrRflXcDxVw8nX47Lsx+QLXwY3NL3DLhG+EHR+cP4T
	 lhxyXZ58z/C2FLA2LOG1j5/Sn/wfEZZk88FHfvmaLw6ak7H2n4DBoezQV5pbqijNT4WsL
	 tSIu50ZMOf6rrrUnsc1lEJNWevs8M59TR+mEJM7TaKsE/BxvCW0EfYr0VR13DJRtn1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0BEJCcG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1996606A333
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0BEJCcG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5175C1F00A09;
	Wed, 11 Nov 2026 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425897;
	bh=mDXg5TEQgN0wpY1CEsh+sUw1JNR0/e3Uh5Dl6UUauNM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=E0BEJCcGWytb/TTXMrC/ldepDo6B2Xdf25udLYh3azGUgu1+V9NW6vav+rVVpv5L+
	 q5LPJ4D5yqAWQXh+KKt0UdgMmPYgBaQLiQOonvz52YDa89C73XHQDTg295yMojof6I
	 r6WePpQfZPYOhEFb6z9yZbZDJLDpPYpvIaWPgToMrMQTkzFjO5mtDYeyjE4BXYoHME
	 8pvZMriTPPJJIk6PVBdDdbbLVSF2gK8QzYZYWxapbkSOPNXPj6F8MNjfhCjJmtJY7b
	 9JMOiuI2hUql98ZeqtaZ437qvfPbqWbZPQP2+tWucjPivMo/4RHs8XyQy36INZ8Qav
	 nfHXkpC/Xif0Q==
Message-ID: <sashiko-outbox-209577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/7] vfio: selftests: Allow multiple BDFs in
 VFIO_SELFTESTS_BDF
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111192411.4133780-4-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:38:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Parse whitespace-separated PCI BDFs from VFIO_SELFTESTS_BDF in
> vfio_selftests_get_bdfs() instead of requiring a single BDF.
>=20
> Multi-device tests such as P2P DMA tests need two or more devices even
> when invoked through run_kselftest.sh without command-line arguments.
> Single-device callers using vfio_selftests_get_bdf() continue to receive
> the first BDF.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D3

