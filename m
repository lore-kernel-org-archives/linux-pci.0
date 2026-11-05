Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893567;
	b=4ihdNXa9a9xvdWforNzBxdPYWDumT4T39jSuPAIsWmtETW26QG9xesLXk8dLWmsl4ukD
	 ulbChy6FMHQ0tiVPwM8NXDFi66jVtYmQKVZZzo2OsjbVDoh0n2y1oMjiCWco9+BJvbk2Q
	 MWqEdKl3jmHKhWusXMeMOv0CTRD+GfrgPmOI8GK0GF1mbGMIH3tQ5ZamK7cXvmCy+ScXe
	 KG+ruERXQ83RkTRBIhyGj3cGzoyg6oQSxqWYdrYmaPZNYSFEwYdVVlXl3d3TI28fKPpLn
	 BImvcbpZOcXzbYuivM12LVjXVgX919UmmwXJHyf+9KjlE+CfzRKDdsL1hhCmNsV39Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O4vL/163IN+QT8t/TWYrt1ez9GqRc24D0FUm0cb8cyM=;
	b=CLdfeGldI1iS2QGbvOHlJExmpiCs0h2Rqiyg4kw2g0a8e6bY8Ked/WlNMDSci2cmTESb
	 kvADmWVJKndtnUCpKj8myZpqqC60CnsGlo9OIuOo7jg4qoR+UUDycDqF2sY59190Bn+jN
	 Ejf0YxaCEOQidhiuIJO2y2xXT005FEfE9xtNp8p7e3CvBR9/D+CHEPIldGfgOMmx5yI0O
	 /knppKL7QO8FYa1V8SBDvIxV4XUKpWG0Aic1L9+ggXEKQsWlQ0u54WIuPY3eOvaga4p/0
	 0n28A3Yxx1RG93F5K3R/8YMmvioCMiJo/6+dYLnGIEDok+NELXvogR7IAQYCdhM/BMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVWYeEVf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F5606D83D
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVWYeEVf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931F41F000C1;
	Thu,  5 Nov 2026 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893566;
	bh=O4vL/163IN+QT8t/TWYrt1ez9GqRc24D0FUm0cb8cyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVWYeEVfOsqyuPQJJkmTCAbIGtdyFa6WSfE4s65bnvSEaeepJ00BIxrcf6v5YsqDt
	 EUFV6TVEe9HLte7iUbjE4AfogRLlHeCO2Ja74L3fK3/nI71QF9lANPn9fgcw1j2HHp
	 mQ3RsHopgk1eSoAiRLF6wybRiHbeZxYRUxIeVw/x1EFNQlJfMkueI2WhTZ5x/TJ1sf
	 ZkVzxgwERxTB9JOshtiijBwWsao2L8ijOikA8AI9x1CGwX7LhT4zGqP7MLPpijFY9C
	 +Cn0JzY/odOb5m3D3sbKiY7XFY/MGABzKgPXlNYYaneoDezq55MY6I7lnh53O5UlNL
	 eaCSz4bwZ3lgw==
Message-ID: <sashiko-outbox-199340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/10] drivers: core: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-3-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:46:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D2

