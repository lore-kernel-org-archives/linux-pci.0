Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299492;
	b=4UuzxVPMn4Z26pNwkQJimpGTRi7AB/PF7aEUS4yop33viQmiJTKYykUhhXBhrNzwkQ2s
	 5DbZ1nrMYd+C43cTrmLJALuUxqBAyOeqNQjdnCa/S/9jVBhj7tGtQWi1kCgr86EZZ79j+
	 ACoF0fkYU6tPrxtOjNzuKTVfxubIZUVgCuCDWbhE+vvlfmihqiK99O+d0F7Rntr7uKKeq
	 fnUpF1vDFicNb410+hx6oeRVKAMYlKYIG+N8XqhM7/PO+n8GWhHpAorRr7fc0F6iHNUrl
	 el7OqIxV2kPgPUffeTrQqYBO4z7BfbWHmH5kiYEddAj+ONbPMxZv0VS3ZP+LM+qSr8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299492;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=koupU3tit+8u2T1tsbL7T8GEJ4iiBtsgvKHwkTsb+Ag=;
	b=OIXU8xQNcaE4pliRYNtN+3Z7y1cqB8wScPXcW1AV+ezfKkUv1HYCq0OcbVv3fZPUuWpW
	 OIsASFwz2YQBDrtz3YNKOq6pqBE/rPnSpJX0rR9MYPlOnqqPVmuanXPclSiKG2uaC7ALi
	 f7OxL1RaBRvoACXiqsZo/1Gbm3b/klk6SUPfZk8XkyFvH4zse+SPp5gY92QP3sTG3TahS
	 9dxmZca7ujNbul9zNM3RY91KwQcGmVhoU3FhlAbNhthWEXVxBQ7GClVv3cYqV1E8uKxQK
	 HPrNlelj6r8wPMdV8qU7cKPNnMCkENvH0U3yn8ztptV6qdZmi0OI+LbWNzPpCECNcaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mNCHJ42/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913CE606D024
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNCHJ42/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0020B1F00903;
	Tue, 10 Nov 2026 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794299492;
	bh=koupU3tit+8u2T1tsbL7T8GEJ4iiBtsgvKHwkTsb+Ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNCHJ42/Wg9HtopMbMM1SBvzxyoZbJdqUwHd6FmF5GXR/BeSoHpT+2QayWvjXqEkW
	 8b43RZjRaTMZGdx3kCZkfVk4FUXzroPq2EVRXl4zlyxJQP3j4p/pyKuKt23jvT903Y
	 TUiXTnvA0GZuha1xs9qU6QWCn3NBjrWeNt+y3Of9SHoanK2xdUGfYISfUfePk0nTJI
	 UHgkJQbsDGBd3hqjDq1njk9YFoUaFOdBTRYsrMRILwM0c6AD1SkKfRCqF1Nd6AOKso
	 C2i80zZ/Z8TG1MJRI/HE/obQJNYICKJssJnYVM/bzUIcu2npuT+hNa102N2OQfyTAo
	 z3ojecsRLm+ow==
Message-ID: <sashiko-outbox-206625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 03/10] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-4-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:31:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D3

