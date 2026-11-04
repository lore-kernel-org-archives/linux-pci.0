Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761225;
	b=r0i0fD/zsOLs0hj2kKOKmGbR561ZQYmD9SvaSG6qhYwotOPfMzGX+kT0jz9lSwAajDs8
	 8qB866+5H27udIHgIgpas24Z+5ZLhnyZ+ZLBX/JOTqjzxFLJn8AsFf3BRUDMz7iWxBi4C
	 nROc28KcFTDmPC+CR632yv/o8th+drwpLhBvYdD9xWLbA+UxDCbqitgq069JLJt3W0NcY
	 0CfMUViexc5jTlTbiUrwnNfjPDRbNzSvjnmCKLDC/k8Ai05w5ymYgS6QwAcR/zt/SJSX3
	 rnO87xtM3753ioDcr5ps24UfwQ8L+a097+zl9tF3uhPQe/yVtdSCyEWldk5YH+1FfRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761225;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bin8983MhxOsP+maoGOFG+UYYUSRGkGxM9UXEYHwP/w=;
	b=r+Lgr7GraPm2TYA/JyRmsZE57JxdYyRx3Rxo4uyP8ObPN3Vn5gyEKyyrm5mhyVlh70Xe
	 3W7jvUDVqtWQ+9Qf3U3Wn8tB4YYb8mHhf2pl/S5VLSlv//36PrR8sHYQ2yOtD0ivtqP++
	 fAmpwiDMEpmjGAAb+D8qaosw9j2HA3ER5VulreqDBwP7kgydr2x0UQ4TWb9LGNuUGGOaR
	 43JLXMhgfAFKQ07wtR074+OhukOTeoZU0vmVtjYUMGTItDHzkyMo4fQYEdKHTSp2L/c7J
	 kDht94XoY4fK3IqUMR2oEXtVzNZbKPzjyWbUeNpMAebmKqvnBqayqNS48Okbt7DbpLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LWtB/PvL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDF606A328
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWtB/PvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917EC1F000C1;
	Wed,  4 Nov 2026 03:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761224;
	bh=bin8983MhxOsP+maoGOFG+UYYUSRGkGxM9UXEYHwP/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWtB/PvLhE1gCSYJF3YkN63fCVV1ypOTC/8PSs4cKRTtfohZLLWzDh83LB246Oj6z
	 s24dHaCpAb6AuzXLacwXrkfIaSERA+LE9H4o6/cvJupV89WO9TpA7hQc4pWAUZ/Ofj
	 eZZDvMZG9j74ex6/kEr1EerF51KjRuk7xoEPg84crI9vLJojU77v7YHFgLDQc51ycK
	 ucEowJqjMLfs1TQNeK2geTtyKUsUA1KIboW0gyu9Z1XGBLObuqbmnbw/jj4LFLrphg
	 ci8IpI0yQLbkLZnuVhxMq2PCmqNfs33O6iwHdT4A1xR0pXzqTIo+gSO1pxw61UGtAN
	 viokbYQOfmWGw==
Message-ID: <sashiko-outbox-196558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/25] dmaengine: sdxi: Add unit tests for completion
 pool ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-17-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-17-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:00:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Add hardware-independent KUnit coverage for completion-pool exhaustion
> across a bitmap word boundary, arbitrary release and reuse, reinitializat=
ion
> of reused status blocks. Verify that a claimed block remains unavailable
> until explicitly released, including after a simulated late device comple=
tion.
> Also cover release of an unpublished claim.
>=20
> Provide test allocation helpers and KUnit-only exports so the tests exerc=
ise
> the production claim and release paths without a coherent-DMA device.
>=20
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D17

