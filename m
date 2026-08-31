Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3A3905F4;
	Mon, 31 Aug 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209578; cv=none; b=VEDr38suB2xwcdFhl0x95fx8qD94LJp4oXwDitY3yauh0/GfL2FGl7TD2otNGXrFZUbPKdrT6/0JKSD7+LgK3+h+Pq+m3q8Qk2svXeUlM0HGF0UQrPIvlFSn2Hib/ubS67Pbnhmxrp2fRaK8JgB1CWh7947n6nMA6KZwbPbo55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209578; c=relaxed/simple;
	bh=YPaQf9ubmiI8Fnpt4s4Iu5TnopWUNKh5LKxGf3USD0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JsUKhtt4nyqNv48/U0MF+oQI3m6E+04Piy2+mw8k0kk6i52g1KBRDnTtD5qPe42pXsU3z3Xu6dEwsDc8Y4ngo/GweO8WvTHtWvGBEsXek3bMfRZUk6IMMNXjKO1Ty8mo01d7h9Q+ihc0oEC99Z/bZYM36PhJEaWNZza/ucvk5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S77PBOGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S77PBOGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001171F000E9;
	Mon, 31 Aug 2026 20:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209577;
	bh=YPaQf9ubmiI8Fnpt4s4Iu5TnopWUNKh5LKxGf3USD0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S77PBOGI6Tm2kMyGJDTfHjuXyF5M5pQpR6CdSCGLmgc+RrVpMz/i7Tl7c/MKEKvbd
	 FFa0BXxKUYucShVDp74Az7V/HkN9dtdvPiv+2v08/VU3q0yVtFQmLSWYbHE8l1r15g
	 3OdOOO0ekqsmAPAWXCRTilMbrtsFErOE6c7qO9Ducs5viBDj5YtZFLEg9AXPE3b/2u
	 602pLTAvuR+tdOy0bsrUHtl3/xtjhUzZe1+KPfFUCzmffzjbTBwEbo5O7ST3KJCd1y
	 JeIeI08+BAckLq0WC6EKLZ+LdAHt6qJckFE2hbbNP9j2g1KEJ3qECHJ1n+dJnGY3WZ
	 o89lrsT3boZHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] PCI: endpoint: pci-epf-vntb: Export endpoint DMA
 channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260831182657.329614-5-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:52:56 +0000
Message-Id: <20260831205257.001171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An RC may use endpoint-local DMA read channels to transfer data directly
> to an endpoint DMA address once both sides agree to use them. Quiescing
> an unrolled eDMA channel disables its whole direction, so reserve the
> complete read direction and route its interrupts to the RC when dma_bar
> is configured.
>=20
> Describe the controller and per-channel descriptor memory in a private
> control-region extension.
>=20
> Add a dma_bar configfs attribute. An explicit BAR selection enables DMA
> export; leaving it unassigned keeps the feature disabled.
>=20
> Keep resources already assigned to a BAR in place, and map the rest
> through the selected dma_bar.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182657.3296=
14-1-den@valinux.co.jp?part=3D4

