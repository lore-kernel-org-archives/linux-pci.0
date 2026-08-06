Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14230471252
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016346; cv=none; b=PL0oKSyr1rzod6jDKUvONoQw/aCd6IvqO1iRBXXEEXRo+z/Gv7M7Qm99rTA7vhhwy9lik1hp3YJKffImL0b9z+m6fDIPoAcWlr10rqwn2pQijN6IlsXuOo4hdzT9TEGfYnHBPGjet2yyBMbnN/0MT7463EWkOqKOHJTqnegEx8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016346; c=relaxed/simple;
	bh=Y91U8/6JE4Ix0j169aC4C9RIw0XELUlXVk0Or+emyiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=frnX4WjIXEi6S0HFFeNN0kUa3Ynljq2vccG9gxtGJy64uSVOSXhfe0lSNETuTVkBqXxHPpcIo9uXmU3o5kV8KWsTazxP//QDMlMdIso3TkAOA21UZoL4Bmyw1txzPa+Crnu1EoxrDK5vJPMQ6rdvcP8rKRhFYLd3iOARAa05CVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+nvLqnt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+nvLqnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7220F1F000E9;
	Thu,  6 Aug 2026 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016342;
	bh=Y91U8/6JE4Ix0j169aC4C9RIw0XELUlXVk0Or+emyiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+nvLqntMSpGx1KrmN5xIO/eRLqJWasFgk4UGOIGLjU3nmhAz41vkqc1Tss30Th0L
	 TM7uMysWMQDyR+RoFouKUoaQSF+A+3OeUnvw7IeR0zxtPHKdpGJ58a6Tmsi2fByime
	 gnmQDCFp6kR/6QbQjTCfwA4DfIBvLYB9MMaNr3+BGN+ZX2qea04io3Um5c65sq16qH
	 tLorJX2PJx5RFU/U0CppsJ6LrQLSrgJTuS5BipSi9ELpJzx37WK6nM3iAejuRZd2oO
	 vXwPTgVtnbPQYrBwZ+dDGh91Q1zHP5bsL7qB3E8mYwdxASmBZYj0l2p1FGvQUqaXnn
	 BrUgHEz1Rhoog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] PCI: Add ACS egress control vector accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-5-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-5-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:39:01 +0000
Message-Id: <20260806113902.7220F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Whether ACS P2P Egress Control routes, redirects, or blocks a peer-to-peer
> request depends on the Egress Control Vector bit for the target port, not
> on the enable bit alone (PCIe r7.0, sec 6.12.3).
>=20
> Provide a helper to read that bit for a peer Root or Switch Downstream
> Port. Report an unreadable or uncovered vector as an error rather than as
> a clear bit, so callers do not mistake it for permission to route
> directly.
>=20
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D5

